//
//  Raytracer.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

import Foundation

struct Constants {
    static let RAD_2_GRAD: Double = 57.295779513082320876798154814105
    static let GRAD_2_RAD: Double = 0.017453292519943295769236907684886
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
            return Color(gray: 0)
        }

        let material = hitObject.material           //the hit objects material
        let hit = ray.at(t: min_t)                  //the hit point
        let N = hitObject.normal(P: hit)            //the normal
        let V = -ray.direction                      //the view vector


        /****************************************************
         * RT1.3: LIGHTING CALCULATION
         *
         * Insert calculation of color here (PHONG model).
         *
         * Given: material, hit, N, V, lights[]
         * Sought: color
         *
         * Hints: (see vector.h)
         *        Vector*Vector      dot product
         *        Vector+Vector      vector sum
         *        Vector-Vector      vector difference
         *        Point-Point        yields vector
         *        Vector.normalize() normalizes vector, returns length
         *        float*Color        scales each color component (r,g,b)
         *        Color*Color        dito
         *        pow(a,b)           a to the power of b
         ****************************************************/

        let color = material.color                  // place holder
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
        let aspect = 1.0 * Double(scene.width) / Double(self.scene.height)
        let A = scene.gaze.cross(v: scene.up)
        let B = A.cross(v: scene.gaze)
        let phi = scene.phi * 0.5 * Constants.GRAD_2_RAD
        let theta = atan( tan(phi) / aspect)
        glassnerH = A.normalized() * scene.gaze.length() * tan(phi)
        glassnerV = B.normalized() * scene.gaze.length() * tan(theta)
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
