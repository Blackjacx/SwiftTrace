//
//  Sphere.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

public struct Sphere: Object {
    public var material: Material
    public var C: Point3
    public var r: Double

    /**
     * Returns a sphere from a json object
     */
    public init(json: [String: AnyObject]) throws {
        guard
            let material = json["material"] as? [String: AnyObject],
            let center = json["center"] as? [String: AnyObject],
            let radius = json["radius"] as? Double else {
                throw JSONError.decodingError(type(of: self), json)
        }
        self.material = try Material(json: material)
        self.C = try Point3(json: center)
        self.r = radius
    }


    /**
     * Returns a sphere from its components
     */
    public init(center: Point3, radius: Double, material: Material) {
        self.material = material
        self.C = center
        self.r = radius
    }

    public func intersect(ray: Ray3, t: inout Double) -> Bool {
        /****************************************************
         * RT1.1: INTERSECTION CALCULATION
         *
         * Given: ray, C, r
         * Sought: intersects? if true: *t
         *
         * Insert calculation of ray/sphere intersection here.
         *
         * You have the sphere's center (C) and radius (r) as well as
         * the ray's origin (ray.O) and direction (ray.D).
         *
         * If the ray does not intersect the sphere, return false.
         * Otherwise, return true and place the distance of the
         * intersection point from the ray origin in *t (see example).
         ****************************************************/

        // place holder for actual intersection calculation

        let OC = (C - ray.origin).normalized()
        if OC.dot(v: ray.direction) > 0.999 {
            t = 1000
            return true
        }
        return false
    }

    public func normal(P: Point3) -> Vector3 {
        /****************************************************
         * RT1.2: NORMAL CALCULATION
         *
         * Given: P, C, r
         * Sought: N
         *
         * Insert calculation of the sphere's normal at point P here.
         ****************************************************/
        
        let N = (P-C) / r
        
        return N
    }
}
