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
    private var scene: Scene
    private var glassnerH: Vector3 = Vector3.zero
    private var glassnerV: Vector3 = Vector3.zero
    private var glassnerMidPoint: Point3 = Point3.zero

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
    private func trace(ray: Ray3, width: UInt, height: UInt) -> Color {
        var t: Double = 0.0
        var min_t: Double = 0.0
        var object: Object?

        // Find hit object and distance
        for obj in scene.objects {
            if obj.intersect(ray: ray, t: &t) && (object == nil || t < min_t) {
                min_t = t
                object = obj
            }
        }

        guard let hitObject = object else {
            return Color(gray: 1)
        }
        let material = hitObject.material           // the hit objects material
        let matColor = material.color               // material color
        let ka = material.ambient                   // phong: ambient factor
        let kd = material.diffuse                   // phong: diffuse factor
        let ks = material.specular                  // phong: specular factor
        let phong = material.phong                  // phong: shiny exponent

        let hit = ray.at(t: min_t)                  // the hit point
        let N = hitObject.normal(P: hit)            // the normal
        let V = -ray.direction                      // the view vector

        var color = matColor                        // initially use the material color

        /*
         * Phong Lighting Model
         */

        color *= ka                                                 // ambient component

        for light in scene.lights {
            let L = (light.center - hit).normalized()               // vector from the hit point to the light
            let R = (2.0 * N * L * N) - L                           // reflection vector for phong model

            color += light.color * matColor * kd * max(0.0, L.dot(v: N)) // phong: diffuse component
            color += light.color * ks * pow(max(0.0, V.dot(v: R)), phong) // phong: specular component
        }
        return color
    }

    /**
     * Traces the scene into an image.
     */
    public func trace() -> Image {
        let width = scene.width
        let height = scene.height
        let image = Image(width: width, height: height)

        for y in 0..<height {
            for x in 0..<width {
                let pixel = getGlassnerPixel(x: Double(x), y: Double(height-1-y))
                let ray = Ray3(p1: scene.eye, p2: pixel)
                var color = trace(ray: ray, width: width, height: height)
                color.clamp()
                image[x, y] = color
            }
        }
        return image
    }

    /**
     * Setup Glassner's Simple Viewing Geometry (https://graphics.stanford.edu/courses/cs348b-98/gg/viewgeom.html)
     */

    private func setupSimpleViewingGeometry(forWidth width: UInt, height: UInt) {
        let aspect = Double(scene.width) / Double(scene.height)
        let A = scene.gaze.cross(v: scene.up)
        let B = A.cross(v: scene.gaze)
        let phiRad = scene.phi * 0.5 * Constants.DEG_2_RAD
        let thetaRad = atan( tan(phiRad) / aspect)
        glassnerH = A.normalized() * scene.gaze.length() * tan(phiRad)
        glassnerV = B.normalized() * scene.gaze.length() * tan(thetaRad)
        glassnerMidPoint = scene.eye + scene.gaze
    }

    /**
     * Getting Glassner Pixel
     */

    private func getGlassnerPixel(x: Double, y: Double) -> Point3 {
        let sx = x / Double(scene.width-1)
        let sy = y / Double(scene.height-1)
        let point = glassnerMidPoint + (2.0*sx - 1.0)*glassnerH + (2.0*sy - 1.0)*glassnerV
        return point
    }
}
