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
    public init(json: [String: Any]) throws {
        guard
            let color = json["color"] as? [String: Any],
            let center = json["center"] as? [String: Any] else {
                throw JSONError.decodingError(self.dynamicType, json)
        }
        self.color = try Color(json: color)
        self.center = try Point3(json: center)
    }
}
