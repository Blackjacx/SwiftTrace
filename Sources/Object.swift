//
//  Object.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

public protocol Object: JSONSerializable {
    var material: Material {get set}

    func intersect(ray: Ray3, t: inout Double) -> Bool
    func normal(hit: Point3) -> Vector3
}
