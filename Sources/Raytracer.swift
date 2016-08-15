//
//  Raytracer.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

class Raytracer {
    var scene: Scene

    public init(filePath: String) throws {
        let json: [String: Any] = [:]
        scene = try Scene(json: json)
    }

    /**
     * Calculates the color for an infividual ray.
     */
    public func trace(ray: Ray3) -> Color {
        return Color(gray: 1.0)
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
                image.setColor(color: color, x: x, y: y)
            }
        }
    }
}
