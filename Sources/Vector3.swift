//
//  Vector3.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 05/08/16.
//
//

#if os(OSX) || os(iOS)
    import Darwin.C
#elseif os(Linux)
    import Glibc
#endif


public struct Vector3: Equatable, JSONSerializable {
    public var dx: Double = 0.0
    public var dy: Double = 0.0
    public var dz: Double = 0.0

    static let zero: Vector3 = Vector3(dx: 0, dy: 0, dz: 0)
    
    /**
     * Returns a vector from dx, dy, dz components
     */
    public init(dx: Double, dy: Double, dz: Double) {
        self.dx = dx
        self.dy = dy
        self.dz = dz
    }

    /**
     * Returns a vector from a json object
     */
    public init(json: [String: AnyObject]) throws {
        guard
            let dx = json["dx"] as? Double,
            let dy = json["dy"] as? Double,
            let dz = json["dz"] as? Double else {
                throw JSONError.decodingError(self.dynamicType, json)
        }
        self.dx = dx
        self.dy = dy
        self.dz = dz
    }

    /**
     * Returns the magnitude of the vector.
     */
    public func length() -> Double {
        return sqrt(pow(dx, dx) + pow(dy, dy) + pow(dz, dz))
    }

    /**
     * Normalizes the vector and returns the result as a new vector.
     */
    public func normalized() -> Vector3 {
        let scale = 1.0/length()
        return Vector3(dx: dx * scale, dy: dy * scale, dz: dz * scale)
    }

    /**
     * Normalizes the vector described by this Vector3 object.
     */
    public mutating func normalize() {
        let scale = 1.0/length()
        dx *= scale
        dy *= scale
        dz *= scale
    }

    /**
     * Calculates the dot product with another Vector3.
     */
    public func dot(v: Vector3) -> Double {
        return dx * v.dx + dy * v.dy + dz * v.dz
    }

    /**
     * Calculates the cross product with another Vector3.
     */
    public func cross(v: Vector3) -> Vector3 {
        return Vector3(dx: dy * v.dz - dz * v.dy,
                       dy: dz * v.dx - dx + v.dz,
                       dz: dx * v.dy - dy * v.dx)
    }

    public func asPoint() -> Point3 {
        return Point3(x: dx, y: dy, z: dz)
    }
}

/**
 * Returns true if two vectors have the same element values.
 */
public func == (v1: Vector3, v2: Vector3) -> Bool {
    return v1.dx == v2.dx && v1.dy == v2.dy && v1.dz == v2.dz
}

/**
 * Adds two Vector3 values and returns the result as a new Vector3.
 */
public func + (v1: Vector3, v2: Vector3) -> Vector3 {
    return Vector3(dx: v1.dx + v2.dx, dy: v1.dy + v2.dy, dz: v1.dz + v2.dz)
}

/**
 * Increments a Vector3 with the value of another.
 */
public func += ( v1: inout Vector3, v2: Vector3) {
    v1 = v1 + v2
}

/**
 * Subtracts two Vector3 values and returns the result as a new Vector3.
 */
public func - (v1: Vector3, v2: Vector3) -> Vector3 {
    return Vector3(dx: v1.dx - v2.dx, dy: v1.dy - v2.dy, dz: v1.dz - v2.dz)
}

/**
 * Returns the negative version of the input vector
 */
public prefix func - (v: Vector3) -> Vector3 {
    return Vector3(dx: -v.dx, dy: -v.dy, dz: -v.dz)
}

/**
 * Decrements a Vector3 with the value of another.
 */
public func -= ( v1: inout Vector3, v2: Vector3) {
    v1 = v1 - v2
}

/**
 * Multiplies two Vector3 values and returns the result as a new Vector3.
 */
public func * (v1: Vector3, v2: Vector3) -> Vector3 {
    return Vector3(dx: v1.dx * v2.dx, dy: v1.dy * v2.dy, dz: v1.dz * v2.dz)
}

/**
 * Multiplies a Vector3 with another.
 */
public func *= ( v1: inout Vector3, v2: Vector3) {
    v1 = v1 * v2
}

/**
 * Multiplies the x,y,z fields of a Vector3 with the same scalar value and
 * returns the result as a new Vector3.
 */
public func * (v: Vector3, s: Double) -> Vector3 {
    return Vector3(dx: v.dx * s, dy: v.dy * s, dz: v.dz * s)
}
public func * (s: Double, v: Vector3) -> Vector3 {
    return v * s
}

/**
 * Multiplies the x,y,z fields of a Vector3 with the same scalar value.
 */
public func *= ( v: inout Vector3, s: Double) {
    v = v * s
}

/**
 * Divides two Vector3 values and returns the result as a new Vector3.
 */
public func / (v1: Vector3, v2: Vector3) -> Vector3 {
    return Vector3(dx: v1.dx / v2.dx, dy: v1.dy / v2.dy, dz: v1.dz / v2.dz)
}

/**
 * Divides a Vector3 by another.
 */
public func /= ( v1: inout Vector3, v2: Vector3) {
    v1 = v1 / v2
}

/**
 * Divides the x,y,z fields of a Vector3 by the same scalar value and
 * returns the result as a new Vector3.
 */
public func / (v: Vector3, s: Double) -> Vector3 {
    return Vector3(dx: v.dx / s, dy: v.dy / s, dz: v.dz / s)
}

/**
 * Divides the x,y,z fields of a Vector3 by the same scalar value.
 */
public func /= ( v: inout Vector3, s: Double) {
    v = v / s
}
