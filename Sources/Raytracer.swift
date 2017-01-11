//
//  Raytracer.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

import Foundation

struct Constants {
    static let RAD_2_DEG: Double = 180.0 / Double.pi
    static let DEG_2_RAD: Double = Double.pi / 180.0
}

class Raytracer {
    private(set) var scene: Scene
    private(set) var glassnerH: Vector3 = Vector3.zero
    private(set) var glassnerV: Vector3 = Vector3.zero
    private(set) var glassnerMidPoint: Point3 = Point3.zero

    public init(filePath: String) throws {
        guard let fileData = FileManager.default.contents(atPath: filePath) else {
            throw FileError.fileNotFound(filePath)
        }
        let json = try JSONSerialization.jsonObject(with: fileData, options: []) as! [String:AnyObject]
        scene = try Scene(json: json)

        setupSimpleViewingGeometry(forWidth: scene.width, height: scene.height)
    }

    /**
     * Calculates the color for an infividual ray.
     */
    private func trace(ray: Ray3) -> Color {
        var t: Double = 0.0
        var min_t: Double = 0.0
        var object: Object?

        // Find hit object and distance
        for obj in scene.objects {
            if obj.intersect(ray: ray, t: &t) != 0 && (object == nil || t < min_t) {
                min_t = t
                object = obj
            }
        }

        guard let hitObject = object else {
            return Color(gray: 0)
        }

        let hit = ray.at(t: min_t)                  // the hit point
        let V = -ray.direction                      // the view vector

        return phongColor(for: hitObject, hit: hit, V: V)
    }

    /**
     * Traces the scene into an image.
     */
    public func trace() -> Image {
        let W = scene.width
        let H = scene.height
        let image = Image(width: W, height: H)

        /*
         * Approach Concurrent
         */

        let queue = DispatchQueue(label: "com.dispatchQueue.concurrent", attributes: .concurrent)
        let group = DispatchGroup()
        let taskCount: UInt = 4 // Must be >= 4 and a power of 2 - best results achieved when == number of cores
        let X: UInt = UInt(sqrt(Float(taskCount))) // tasks for one row or column
        let HX = H / X
        let WX = W / X

        for i in 0..<X {
            for j in 0..<X {
                // Create a task per square of pixels
                queue.async(group: group) {
                    for y in (i*HX)..<((i+1)*HX) {
                        for x in (j*WX)..<((j+1)*WX) {
                            image[x, y] = self.computeColorAt(x: x, y: y, W: W, H: H)
                        }
                    }
                }
            }
        }
        group.wait()


        /*
         * Approach: Stupid
         */

//        for y in 0..<H {
//            for x in 0..<W {
//                image[x, y] = self.computeColorAt(x: x, y: y, W: W, H: H)
//            }
//        }

        return image
    }

    func computeColorAt(x: UInt, y: UInt, W: UInt, H: UInt) -> Color {
        let pixel = self.getGlassnerPixel(x: x, y: H-y-1)
        let ray = Ray3(p1: self.scene.eye, p2: pixel)

        var color = self.trace(ray: ray)
        color.clamp()
        return color
    }


    /**
     * Glassner's Simple Viewing Geometry (https://graphics.stanford.edu/courses/cs348b-98/gg/viewgeom.html)
     */

    private func setupSimpleViewingGeometry(forWidth width: UInt, height: UInt) {
        let aspect = Double(scene.width) / Double(scene.height)
        let A = scene.gaze.cross(scene.up)
        let B = A.cross(scene.gaze)
        let phiRad = scene.phi * 0.5 * Constants.DEG_2_RAD
        let thetaRad = atan( tan(phiRad) / aspect)
        glassnerH = A.normalized() * scene.gaze.length() * tan(phiRad)
        glassnerV = B.normalized() * scene.gaze.length() * tan(thetaRad)
        glassnerMidPoint = scene.eye + scene.gaze
    }

    private func getGlassnerPixel(x: UInt, y: UInt) -> Point3 {
        let sx = Double(x) / Double(scene.width-1)
        let sy = Double(y) / Double(scene.height-1)
        let point = glassnerMidPoint + (2.0*sx - 1.0)*glassnerH + (2.0*sy - 1.0)*glassnerV
        return point
    }

    /**
     * Returns a color using the Phong Reflection Model
     */
    private func phongColor(for hitObject: Object, hit: Point3, V: Vector3) -> Color {
        let material = hitObject.material           // the hit objects material
        let ka = material.ambient                   // ambient factor
        let kd = material.diffuse                   // diffuse factor
        let ks = material.specular                  // specular factor
        let phong = material.phong                  // shiny exponent

        let N = hitObject.normal(P: hit)            // the normal

        var color = material.color * ka             // ambient component

        for light in scene.lights {
            let L = (light.center - hit).normalized()                   // hit -> light vector
            let LN = L.dot(N)
            let R = 2.0 * N * LN - L                                    // reflection vector
            let VR = V.dot(R)

            color += light.color * material.color * kd * max(0.0, LN)   // diffuse component
            color += light.color * ks * pow(max(0.0, VR), phong)        // specular component
        }
        return color
    }
}
