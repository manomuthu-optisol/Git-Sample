//
//  URLConstants.swift
//  MyCloudedLife
//
//  Created by Dinesh on 21/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import Foundation
import Alamofire

struct URLConstants{
    
    //MARK: - Service
    
    // DOMAIN NAME
    public let kBaseURL = "http://52.45.171.205:9009/api"
    
    // API ENDPOINT EXTENDED:
    public let kLoginURL = "/auth/login"
    public let kForgotPwdURL = "/auth/forgot-password"
    public let kSignUpURL = "/auth/registration"
    public let kGetUserDetailsURL = "/users"
    public let kNotesURL = "/notes"
    public let kResetPwdURL = "/auth/reset-password"
    public let kVeriftOTPURL = "/auth/verify-otp"
    public let kUserInfoURL = "/users"
    
}

struct ApiInfo{
    
    // API Methods:
    let apiMethods:[String:HTTPMethod] = [URLConstants().kLoginURL:.post,
                                          URLConstants().kForgotPwdURL:.get,
                                          URLConstants().kSignUpURL:.post,
                                          URLConstants().kResetPwdURL:.post,
                                          URLConstants().kVeriftOTPURL:.get,
                                          URLConstants().kUserInfoURL:.get]
}
