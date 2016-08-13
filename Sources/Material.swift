//
//  Material.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

public struct Material {
    public var color: Color         // Base color
    public var ambient: Double      // Ambient intensity
    public var diffuce: Double      // Diffuse intensity
    public var specular: Double     // Specular intensity
    public var phong: Double        // Exponent for specular highlight size
}
