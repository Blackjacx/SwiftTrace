//
//  Ray3.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

public struct Ray3: Equatable {
    public var o: Point3 = Point3()
    public var v: Vector3 = Vector3()

    init(p1: Point3, p2: Point3) {
        o = p1
        v = (p2 - p1).normalized()
    }

    public func at(t: Double) -> Point3 {
        return o + v*t
    }
}

/**
 * Returns true if two rays have the same element values.
 */
public func == (r1: Ray3, r2: Ray3) -> Bool {
    return (r1.o == r2.o) && (r1.v == r2.v)
}
