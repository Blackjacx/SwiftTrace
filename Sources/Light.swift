//
//  Light.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

public struct Light: JSONSerializable {
    public var color: Color
    public var center: Point3

    /**
     * Returns a light from a json object
     */
    public init(json: [String: AnyObject]) throws {
        guard
            let color = json["color"] as? [String: AnyObject],
            let center = json["center"] as? [String: AnyObject] else {
                throw JSONError.decodingError(type(of: self), json)
        }
        self.color = try Color(json: color)
        self.center = try Point3(json: center)
    }

    /**
     * Returns a light from its components
     */
    public init(center: Point3, color: Color) {
        self.color = color
        self.center = center
    }
}
