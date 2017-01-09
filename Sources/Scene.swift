//
//  Scene.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

import Foundation

public struct Scene {
    fileprivate(set) var width: UInt
    fileprivate(set) var height: UInt
    fileprivate(set) var eye: Point3
    fileprivate(set) var up: Vector3
    fileprivate(set) var gaze: Vector3
    fileprivate(set) var phi: Double

    fileprivate(set) var lights: [Light] = []
    fileprivate(set) var objects: [Object] = []
}

extension Scene: JSONSerializable {
    /**
     * Returns a Scene from a json object
     */
    public init(json: [String: AnyObject]) throws {
        guard
            let width = json["width"] as? UInt,
            let height = json["height"] as? UInt,
            let camera = json["camera"] as? [String: AnyObject],
            let eye = camera["eye"] as? [String: AnyObject],
            let up = camera["up"] as? [String: AnyObject],
            let gaze = camera["gaze"] as? [String: AnyObject],
            let phi = camera["phi"] as? Double,
            let lights = json["lights"] as? [[String: AnyObject]],
            let objects = json["objects"] as? [[String: AnyObject]] else {
                throw JSONError.decodingError(type(of: self), json)
        }
        for lightDict in lights {
            self.lights.append(try Light(json: lightDict))
        }
        for objectDict in objects {
            let type = objectDict["type"] as! String
            if type == "sphere" {
                self.objects.append(try Sphere(json: objectDict))
            }
        }
        self.width = width
        self.height = height
        self.eye = try Point3(json: eye)
        self.up = try Vector3(json: up)
        self.gaze = try Vector3(json: gaze)
        self.phi = phi
    }
}
