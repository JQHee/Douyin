//
//  Visitor.swift
//  Douyin
//
//  Created by midland on 2019/1/11.
//

import Foundation
class Visitor: BaseModel {
    var uid: String?
    var udid: String?

    static func write(visitor: Visitor) {
        let dic = visitor.toJSON()
        let defaults = UserDefaults.standard
        defaults.set(dic, forKey: "visitor")
        defaults.synchronize()
    }
    
    static func read() -> Visitor {
        let defaults = UserDefaults.standard
        let dic = defaults.object(forKey: "visitor") as! [String:Any]
        let visitor = Visitor.deserialize(from: dic)
        return visitor!
    }
}
