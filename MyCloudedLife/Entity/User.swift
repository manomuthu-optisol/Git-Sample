//
//  User.swift
//  MyCloudedLife
//
//  Created by Dinesh on 21/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var token: String?
    var message: String?
    var userId: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        token <- map["token"]
        message <- map["message"]
        userId <- map["userId"]
    }
    
}
