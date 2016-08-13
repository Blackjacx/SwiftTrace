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
    public init(json: [String : AnyObject]) {
        let camera = json["camera"] as! [String:AnyObject]
        let lights = json["lights"] as! [[String:AnyObject]]
        let objects = json["objects"] as! [[String:AnyObject]]
        for lightDict in lights {
            self.lights.append(Light(json: lightDict))
        }
        for objectDict in objects {
            let type = objectDict["type"] as! String
            if type == "sphere" {
                self.objects.append(Sphere(json: objectDict))
            }
        }
        self.eye = Point3(json: camera["eye"] as! [String:AnyObject])
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
