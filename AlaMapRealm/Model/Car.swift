//
//  Color.swift
//  AlaMapRealm
//
//  Created by Dima Shvets on 9/7/17.
//  Copyright © 2017 Dima Shvets. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

protocol Generics {
    static func url() -> String
}

class Car: Object, Mappable, Generics {
    dynamic var car = ""
    dynamic var model = ""
    dynamic var image = ""
    
    override static func primaryKey() -> String? {
        return "car"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        car <- map["car"]
        model <- map["model"]
        image <- map["image"]
    }
    
    static func url() -> String {
        let path = Bundle.main.url(forResource: "cars", withExtension: "json")
        return (path?.absoluteString)!
    }
}
