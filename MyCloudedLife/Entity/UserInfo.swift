//
//  UserInfo.swift
//  MyCloudedLife
//
//  Created by Dinesh on 24/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import Foundation
import ObjectMapper

class UserInfo: Mappable {
    
    var id: Int?
    var gender: String?
    var name: String?
    var dob: String?
    var facebook: String?
    var twitter: String?
    var googleplus: String?
    var instagram: String?
    var linkedin: String?
    var image_url: String?
    var role: String?
    var parent_id: Int?
    var login_user_id: Int?
    var family_role: String?
    var created_at: String?
    var updated_at: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        gender <- map["gender"]
        name <- map["name"]
        dob <- map["dob"]
        facebook <- map["facebook"]
        twitter <- map["twitter"]
        googleplus <- map["googleplus"]
        instagram <- map["instagram"]
        linkedin <- map["linkedin"]
        image_url <- map["image_url"]
        role <- map["role"]
        parent_id <- map["parent_id"]
        login_user_id <- map["login_user_id"]
        family_role <- map["family_role"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
    
}
