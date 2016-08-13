//
//  Ray3.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

public struct Ray3: Equatable {
    public var origin: Point3
    public var direction: Vector3

    /**
     * Returns a ray from origin and direction
     */
    init(origin: Point3, direction: Vector3) {
        self.origin = origin
        self.direction = direction
    }

    /**
     * Returns a ray from p1 to p2
     */
    init(p1: Point3, p2: Point3) {
        self.origin = p1
        self.direction = (p2 - p1).normalized()
    }

    /**
     * Returns a ray from a json object
     */
    public init(json: [String : AnyObject]) {
        self.origin = Point3(json: json["origin"] as! [String:AnyObject])
        self.direction = Vector3(json: json["direction"] as! [String:AnyObject])
    }

    /**
     * Gives the point on the ray in the distance t from its origin
     */
    public func at(t: Double) -> Point3 {
        return origin + direction*t
    }
}

/**
 * Returns true if two rays have the same element values.
 */
public func == (r1: Ray3, r2: Ray3) -> Bool {
    return (r1.origin == r2.origin) && (r1.direction == r2.direction)
}
