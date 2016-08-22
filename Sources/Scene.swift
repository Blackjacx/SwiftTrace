//
//  Scene.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

public struct Scene: JSONSerializable {
    private(set) var eye: Point3
    private(set) var lights: [Light] = []
    private(set) var objects: [Object] = []

    /**
     * Returns a Scene from a json object
     */
    public init(json: [String: AnyObject]) throws {
        guard
            let camera = json["camera"] as? [String: AnyObject],
            let eye = camera["center"] as? [String: AnyObject],
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
        self.eye = try Point3(json: eye)
    }

    /**
     * Returns a Scene from its comoponents
     */
    public init(eye: Point3, lights: [Light], objects: [Object]) {
        self.eye = eye
        self.objects = objects
        self.lights = lights
    }
}
