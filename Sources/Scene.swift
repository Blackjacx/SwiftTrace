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
    private var objects: [Object] = []

    /**
     * Returns a Scene from a json object
     */
    public init(json: [String: Any]) throws {
        guard
            let camera = json["camera"] as? [String: Any],
            let eye = camera["center"] as? [String: Any],
            let lights = json["lights"] as? [[String: Any]],
            let objects = json["objects"] as? [[String: Any]] else {
                throw JSONError.decodingError(self.dynamicType, json)
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

    public mutating func addObject(obj: Object) {
        objects.append(obj)
    }

    public func object(at index: Int) -> Object {
        return objects[index]
    }

    public func objectCount() -> Int {
        return objects.count
    }

    public mutating func addLight(light: Light) {
        lights.append(light)
    }

    public func light(at index: Int) -> Light {
        return lights[index]
    }

    public func lightCount() -> Int {
        return lights.count
    }
}
