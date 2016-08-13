//
//  Point3.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 05/08/16.
//
//

public struct Point3: Equatable, JSONSerializable {
    public var x: Double = 0.0
    public var y: Double = 0.0
    public var z: Double = 0.0

    static let zero: Point3 = Point3(x: 0, y: 0, z: 0)
    
    /**
     * Returns a point from x, y, z components
     */
    public init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }

    /**
     * Returns a point from a json object
     */
    public init(json: [String : AnyObject]) {
        self.x = json["x"] as! Double
        self.y = json["y"] as! Double
        self.z = json["z"] as! Double
    }

    /**
     * Returns the point as vector
     */
    public func asVector() -> Vector3 {
        return Vector3(dx: x, dy: y, dz: z)
    }
}

/**
 * Returns true if two points have the same element values.
 */
public func == (p1: Point3, p2: Point3) -> Bool {
    return p1.x == p2.x && p1.y == p2.y && p1.z == p2.z
}

/**
 * Returns a new point by moving the receiver by a positive Vector3.
 */
public func + (p: Point3, v: Vector3) -> Point3 {
    return Point3(x: p.x + v.dx, y: p.y + v.dy, z: p.z + v.dz)
}

/**
 * Moves the receiver by a positive Vector3.
 */
public func += ( p: inout Point3, v: Vector3) {
    p = p + v
}

/**
 * Returns a new Point by moving the receiver by a negative Vector3.
 */
public func - (p: Point3, v: Vector3) -> Point3 {
    return Point3(x: p.x - v.dx, y: p.y - v.dy, z: p.z - v.dz)
}

/**
 * Moves the receiver by a negative Vector3.
 */
public func -= (p: inout Point3, v: Vector3) {
    p = p - v
}

/**
 * Returns a new Vector by subtracting p1 from the receiver.
 */
public func - (p1: Point3, p2: Point3) -> Vector3 {
    return Vector3(dx: p1.x - p2.x, dy: p1.y - p2.y, dz: p1.z - p2.z)
}

/**
 * Returns a new point by adding to points.
 */
public func + (p1: Point3, p2: Point3) -> Point3 {
    return Point3(x: p1.x + p2.x, y: p1.y + p2.y, z: p1.z + p2.z)
}

