//
//  Raytracer.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

import Foundation

class Raytracer {
    private var scene: Scene

    public init(filePath: String) throws {
        guard let fileData = FileManager.default.contents(atPath: filePath) else {
            throw FileError.fileNotFound(filePath)
        }
        let json = try JSONSerialization.jsonObject(with: fileData, options: []) as! [String:AnyObject]
        scene = try Scene(json: json)
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
        let N = hitObject.normal(hit: hit)          //the normal
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
    public func trace(image: Image) {
        let width = image.width
        let height = image.height

        for y in 0..<height {
            for x in 0..<width {
                let pixel = Point3(x: Double(x), y: Double(height-1-y), z: 0)
                let ray = Ray3(p1: scene.eye, p2: pixel)
                var color = trace(ray: ray)
                color.clamp()
                image[x, y] = color
            }
        }
    }
}
