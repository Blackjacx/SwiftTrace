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
    public init(json: [String : AnyObject]) {
        self.color = Color(json: json["color"] as! [String:AnyObject])
        self.center = Point3(json: json["center"] as! [String:AnyObject])
    }
}
