//
//  Color.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

public struct Color: Equatable, JSONSerializable, CustomStringConvertible {
    public var red: Double = 0.0
    public var green: Double = 0.0
    public var blue: Double = 0.0

    public var description: String {
        return "\(red) \(green) \(blue)"
    }

    /**
     * Returns a gray scale color
     */
    public init(red: Double, green: Double, blue: Double) {
        set(red: red, green: green, blue: blue)
    }

    /**
     * Returns a gray scale color
     */
    public init(gray: Double) {
        set(gray: gray)
    }

    /**
     * Returns a color from an json object
     */
    public init(json: [String: AnyObject]) throws {
        guard
            let red = json["r"] as? Double,
            let green = json["g"] as? Double,
            let blue = json["b"] as? Double else {
                throw JSONError.decodingError(self.dynamicType, json)
        }
        self.red = red
        self.green = green
        self.blue = blue
    }

    /**
     * Clamps the color components between 0 and maxValue
     */
    public mutating func clamp(maxValue: Double = 1.0) {
        red = min(max(0, red), maxValue)
        green = min(max(0, green), maxValue)
        blue = min(max(0, blue), maxValue)
    }

    /**
     * Sets all components to the same value
     */
    public mutating func set(gray: Double) {
        red = gray
        green = gray
        blue = gray
    }

    /**
     * Sets all components to the same value
     */
    public mutating func set(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

/**
 * Returns true if two colors have the same element values.
 */
public func == (c1: Color, c2: Color) -> Bool {
    return c1.red == c2.red && c1.green == c2.green && c1.blue == c2.blue
}

/**
 * Adds c1 and c2
 */
public func + (c1: Color, c2: Color) -> Color {
    return Color(red: c1.red + c2.red, green: c1.green + c2.green, blue: c1.blue + c2.blue)
}

/**
 * Adds c1 and c2  (self modifying)
 */
public func += (c1: inout Color, c2: Color) {
    c1 = c1 + c2
}

/**
 * Multiply c1 and c2 component wise
 */
public func * (c1: Color, c2: Color) -> Color {
    return Color(red: c1.red * c2.red, green: c1.green * c2.green, blue: c1.blue * c2.blue)
}

/**
 * Multiply c1 and c2 component wise  (self modifying)
 */
public func *= (c1: inout Color, c2: Color) {
    c1 = c1 * c2
}

/**
 * Multiply each color component with a scalar
 */
public func * (c: Color, s: Double) -> Color {
    return Color(red: c.red * s, green: c.green * s, blue: c.blue * s)
}
public func * (s: Double, c: Color) -> Color {
    return c * s
}

/**
 * Multiply each color component with a scalar (self modifying)
 */
public func *= (c: inout Color, s: Double) {
    c = c * s
}

/**
 * Divide each color component by a scalar
 */
public func / (c: Color, s: Double) -> Color {
    return Color(red: c.red / s, green: c.green / s, blue: c.blue / s)
}

/**
 * Divide each color component by a scalar (self modifying)
 */
public func /= (c: inout Color, s: Double) {
    c = c / s
}


