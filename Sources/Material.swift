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
    public init(json: [String : AnyObject]) {
        self.color = Color(json: json["color"] as! [String:AnyObject])
        self.ambient = json["ambient"] as! Double
        self.diffuse = json["diffuse"] as! Double
        self.specular = json["specular"] as! Double
        self.phong = json["phong"] as! Double
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
