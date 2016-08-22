//
//  Sphere.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

import Foundation


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
//        let OC = (C - ray.origin).normalized()
//        if OC.dot(v: ray.direction) > 0.999 {
//            t = 1000
//            return true
//        }
//        return false
//

        let CO = ray.origin - C                 // vector from center to origin
        let p = 2.0 * CO.dot(v: ray.direction)  // part I for quadratic equation
        let q = CO.dot(v: CO) - r*r             // part II for quadratic equation
        let D = pow(p*0.5, 2.0) - q             // discriminant

        if D < 0.0 {
            return false                        // 0 solutions
        }

        // distance calculation
        let t1 = (-p * 0.5) - sqrt(D)

        if t1 > DBL_EPSILON {                   // surely outside sphere (smallest ISP lies in ray direction)
            t = t1
            return true
        }

        let t2 = (-p*0.5) + sqrt(D)

        if t2 > DBL_EPSILON {                   // surely inside sphere (second ISP lies in ray direction AND first ISP lies against ray direction)
            t = t2
            return true
        }  
        return false
    }
    
    public func

        normal(P: Point3) -> Vector3 {
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
