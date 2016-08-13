//
//  Sphere.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

public struct Sphere: Object {
    public var material: Material
    public var center: Point3
    public var radius: Double

    func intersect(ray: Ray3, t: inout Double) -> Bool {
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

        let OC = (center - ray.origin).normalized()
        if OC.dot(v: ray.direction) > 0.999 {
            t = 1000
            return true
        }
        return false
    }

    func normal(hit: Point3) -> Vector3 {
        /****************************************************
         * RT1.2: NORMAL CALCULATION
         *
         * Given: P, C, r
         * Sought: N
         *
         * Insert calculation of the sphere's normal at point P here.
         ****************************************************/
        
        let N = Vector3() /* = ... */;
        
        return N
    }
}
