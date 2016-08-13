//
//  Ray3.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

public struct Ray3: Equatable {
    public var origin: Point3 = Point3()
    public var direction: Vector3 = Vector3()

    init(p1: Point3, p2: Point3) {
        origin = p1
        direction = (p2 - p1).normalized()
    }

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
