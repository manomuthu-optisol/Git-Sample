//
//  UserAPIDataManager.swift
//  MyCloudedLife
//
//  Created by Dinesh on 21/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import Foundation
import Alamofire

class UserAPIDataManager: NSObject {
    
    class var sharedInstance: UserAPIDataManager {
        struct Static {
            static let instance = UserAPIDataManager()
        }
        return Static.instance
    }
    
    let jsonHeader: HTTPHeaders = Constant().kJsonHeader
    
    /*
     Login API DataManager
     Entity used - User
     Lis of VC Method used 
        - LoginVC.swift
     */
    func UserLogin(param: Parameters, viewController: UIViewController, showLoader: Bool, completion: @escaping(User)-> Void) -> Void {
        
        ServiceManager.sharedInstance.sendRequestToApi(type: User.self, with: URLConstants().kLoginURL, params: param, headers: jsonHeader, showLoader: true, completion: { response in
            
            if response.1 == ResponseCode.sucess {
                if let user = response.0?.value {
                    completion(user)
                }
            } else {
                if let responseData = response.0?.data {
                    let value = String(data: responseData, encoding: .utf8)
                    if let value = value {
                        AppUtils.sharedInstance.failureResponseHandler(viewController: viewController, errorMessage: value, responseCode: response.1)
                    }
                }
            }
        })
        
    }
    
    /*
     SignUp API DataManager
     Entity used - User
     Lis of VC Method used 
        - LoginVC.swift
     */
    func UserSignUp(params: Parameters, viewController: UIViewController, showLoader: Bool, completion: @escaping(User)-> Void) -> Void {
        
        ServiceManager.sharedInstance.sendRequestToApi(type: User.self, with: URLConstants().kSignUpURL, params: params, headers: Constant().kJsonHeader, showLoader: true, completion: {
            response in
            
            if response.1 == ResponseCode.sucess {
                if let user = response.0?.value {
                    completion(user)
                }
            } else {
                if let responseData = response.0?.data {
                    let value = String(data: responseData, encoding: .utf8)
                    if let value = value {
                        AppUtils.sharedInstance.failureResponseHandler(viewController: viewController, errorMessage: value, responseCode: response.1)
                    }
                }
            }
        })
        
    }
    
    /*
     ForgotPassword API DataManager
     Entity used - User
     Lis of VC Method used
     - ForgotPasswordVC.swift
     */
    func forgotPassword(viewController: UIViewController, param: Parameters, showLoader: Bool, completion: @escaping(User)-> Void) -> Void {
        
        ServiceManager.sharedInstance.sendRequestToApi(type: User.self, with: URLConstants().kForgotPwdURL, params: param, headers: jsonHeader, encode: URLEncoding.default, showLoader: showLoader, completion: {
            response in
            
            if response.1 == ResponseCode.sucess {
                if let user = response.0?.value {
                    completion(user)
                }
            } else {
                if let responseData = response.0?.data {
                    let value = String(data: responseData, encoding: .utf8)
                    if let value = value {
                        AppUtils.sharedInstance.failureResponseHandler(viewController: viewController, errorMessage: value, responseCode: response.1)
                    }
                }
            }
            
        })
        
    }
    
    /*
     VerifyOTP API Data Manager
     Entity used - User
     List of VC method used
     - ResetPasswordVC
     */
    func veriftOTP(viewController: UIViewController, param: Parameters, showLoader: Bool, completion: @escaping(User)-> Void)-> Void {
        
        ServiceManager.sharedInstance.sendRequestToApi(type: User.self, with: URLConstants().kVeriftOTPURL, params: param, encode: URLEncoding.default, showLoader: showLoader, completion: {
            response in
            
            if response.1 == ResponseCode.sucess {
                if let user = response.0?.value {
                    completion(user)
                }
            } else {
                if let responseData = response.0?.data {
                    let value = String(data: responseData, encoding: .utf8)
                    if let value = value {
                        AppUtils.sharedInstance.failureResponseHandler(viewController: viewController, errorMessage: value, responseCode: response.1)
                    }
                }
            }
        })
        
    }
    
    /*
     ResetPassword API Data Manager
     Entity used - User
     List of VC method used
     - ResetPasswordVC
     */
    func resetPassword(viewController: UIViewController, param: Parameters, showLoader: Bool, completion: @escaping(User)-> Void)-> Void {
        
        ServiceManager.sharedInstance.sendRequestToApi(type: User.self, with: URLConstants().kResetPwdURL, params: param, headers: jsonHeader, showLoader: showLoader, completion: {
            response in
            
            if response.1 == ResponseCode.sucess {
                if let user = response.0?.value {
                    completion(user)
                }
            } else {
                if let responseData = response.0?.data {
                    let value = String(data: responseData, encoding: .utf8)
                    if let value = value {
                        AppUtils.sharedInstance.failureResponseHandler(viewController: viewController, errorMessage: value, responseCode: response.1)
                    }
                }
            }
        })
    }
    
    /*
     GetUserInfo API Data Manager
     Entity used - UserInfo
     List of VC method used
     - CreateProfileVC/editprofile
     */
    func getUserInfo(viewController: UIViewController, showLoader: Bool, completion: @escaping(UserInfo)-> Void)-> Void {
        
        var header: HTTPHeaders = ["": ""]
        
        if let accessToken = UserDefaults.standard.value(forKey: Constant().kAccessTokenUD) {
            header = ["Authorization": "JWT \(accessToken)"]
            
            ServiceManager.sharedInstance.sendRequestToApi(type: UserInfo.self, with: URLConstants().kUserInfoURL, headers: header, showLoader: showLoader, completion: {
                response in
                
                if response.1 == ResponseCode.sucess {
                    if let userInfo = response.0?.value {
                        completion(userInfo)
                    }
                } else {
                    if let responseData = response.0?.data {
                        let value = String(data: responseData, encoding: .utf8)
                        if let value = value {
                            AppUtils.sharedInstance.failureResponseHandler(viewController: viewController, errorMessage: value, responseCode: response.1)
                        }
                    }
                }
            })
        }
    }

}
