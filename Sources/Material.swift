//
//  Material.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

public struct Material: JSONSerializable {
    public var color: Color         // Base color
    public var ambient: Double      // Ambient intensity
    public var diffuse: Double      // Diffuse intensity
    public var specular: Double     // Specular intensity
    public var phong: Double        // Exponent for specular highlight size

    /**
     * Returns a material from a json object
     */
    public init(json: [String: AnyObject]) throws {
        guard
            let color = json["color"] as? [String: AnyObject],
            let ambient = json["ambient"] as? Double,
            let diffuse = json["diffuse"] as? Double,
            let specular = json["specular"] as? Double,
            let phong = json["phong"] as? Double else {
                throw JSONError.decodingError(type(of: self), json)
        }
        self.color = try Color(json: color)
        self.ambient = ambient
        self.diffuse = diffuse
        self.specular = specular
        self.phong = phong
    }

    /**
     * Returns a material from its components
     */
    public init(color: Color, ambient: Double, diffuse: Double, specular: Double, phong: Double) {
        self.color = color
        self.ambient = ambient
        self.diffuse = diffuse
        self.specular = specular
        self.phong = phong
    }
}
