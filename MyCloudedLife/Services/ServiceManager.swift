//
//  ServiceManager.swift
//  MyCloudedLife
//
//  Created by Dinesh on 14/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

enum ResponseCode: Int {
    
    // Requested api returns expected response
    case sucess                 = 200
    
    // User display or read permission missing
    case permissionDisAllow     = 230
    
    // The HTTP request is incomplete or malformed.
    case badRequest             = 400
    
    // Authorization is required to use the service
    case unAuthorization        = 401
    
    // User do not have permission to access the database.
    case forbidden              = 403
    
    // The named database is not running on the server, or the named web service does not exist.
    case notFound               = 404
    
    // The maximum connection idle time was exceeded while receiving the request
    case timeOut                = 408
    
    // An internal error occurred. The request could not be processed.
    case serviceUnavailable     = 500
    
    // No internet
    case noNetwork              = -1
}

class ServiceManager: BaseViewController {
    class var sharedInstance: ServiceManager {
        struct Static {
            static let instance = ServiceManager()
        }
        return Static.instance
    }
    
    // MARK: - Api Methods
    
    /**
     Call Webservice with single model
     
     - Parameter type:                   Mappable model for this API Call
     - parameter endPointURL:            EndPoint URL for this API. Default: empty string.
     - parameter Params:                 Parameters for this API. Default: nil
     - parameter headers:                headers for this Api.  Default: nil
     - Completion:                       Return model response to the handler
     */
    
    func sendRequestToApi<T: Mappable>(type: T.Type,with endPointURL: String,
                          params: Parameters? = nil,
                          headers:HTTPHeaders? = nil,
                          encode: ParameterEncoding? = JSONEncoding.default, showLoader: Bool,
                          completion: @escaping(_ result: DataResponse<T>?, _ statusCode: ResponseCode) -> Void) {
        
        if let topController = UIApplication.topViewController() {
            if showLoader {
                Lib.sharedInstance.showLoader(view: topController.view, message: Constant().kLoading)
            }
        }
        
        let url = URLConstants().kBaseURL + endPointURL
        let urlMethod = ApiInfo().apiMethods[endPointURL]
        var httpHeader:HTTPHeaders = [:]
        
        if(headers == nil) {
            httpHeader = [
                Constant().kAuthorization: "Basic c29jOnNvYw==",
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        } else {
            httpHeader = headers!
        }
        
        debugPrint("URL Request Info: \(url)")
        
        Alamofire.request(url, method: urlMethod!, parameters: params, encoding:encode!,headers: httpHeader).validate().responseObject {
            (response: DataResponse<T>) in

            Lib.sharedInstance.hideLoader()
            
            if let alamoError = response.result.error {
                print(alamoError.localizedDescription)
                
                if let err = alamoError as? URLError, err.code  == URLError.Code.notConnectedToInternet {
                    // No internet
                    if let topController = UIApplication.topViewController() {
                        AppUtils.sharedInstance.simpleAlert(view: topController, title: "", message: Constant().KNoInterNetMSG)
//                        Lib.sharedInstance.showDialog(title: Constant().kFailure , msg: Constant().KNoInterNet, imageStr: Constant().kCross, transition: .zoomIn, gesture: true, btnTitle: Constant().kTryAgain, bgColor: Constant().kFailureBgClr, btnBgColor: UIColor.init(hex: Constant().kFailureBtnClr), vc: topController)
                    }
                } else {
                    // Other errors
                    if response.response?.statusCode == nil{
                        completion(response,self.statusCodeForResponseCode(alamoError._code))
                    }else{
                        completion(response, self.statusCodeForResponseCode((response.response?.statusCode)!))
                    }
                    
                }
            } else { //no errors
                completion(response, self.statusCodeForResponseCode((response.response?.statusCode)!))
            }
        }
    }
    
    /**
     Call Webservice with Array of model
     
     - Parameter withArrayType:          Mappable model for this API Call
     - parameter endPointURL:            EndPoint URL for this API. Default: empty string.
     - parameter Params:                 Parameters for this API. Default: nil
     - parameter headers:                headers for this Api.  Default: nil
     - Completion:                       Return array response to the handler
     */
    
    func sendRequestToApi<T: Mappable>(withArrayType type: T.Type,with endPointURL: String,
                          params: Parameters? = nil,
                          headers:HTTPHeaders? = nil,
                          encode: ParameterEncoding? = JSONEncoding.default,
                          completion: @escaping(_ result: DataResponse<[T]>?, _ statusCode: ResponseCode) -> Void) {
        
        if let topController = UIApplication.topViewController() {
            Lib.sharedInstance.showLoader(view: topController.view, message: Constant().kLoading)
        }
        
        let url = URLConstants().kBaseURL + endPointURL
        let urlMethod = ApiInfo().apiMethods[endPointURL]
        var httpHeader:HTTPHeaders = [:]
        
        if(headers == nil) {
            httpHeader = [
                "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
                "Accept": "application/json"
            ]
        } else {
            httpHeader = headers!
        }
        
        
        Alamofire.request(url, method: urlMethod!, parameters: params, encoding:encode!,headers: httpHeader).validate().responseArray {
            (response: DataResponse<[T]>) in
            
            Lib.sharedInstance.hideLoader()
            
            if let alamoError = response.result.error {
                print(alamoError.localizedDescription)
                
                if let err = alamoError as? URLError, err.code  == URLError.Code.notConnectedToInternet
                {
                    // No internet
                    if let topController = UIApplication.topViewController() {
                        AppUtils.sharedInstance.simpleAlert(view: topController, title: "", message: Constant().KNoInterNetMSG)
//                        Lib.sharedInstance.showDialog(title: Constant().kFailure , msg: Constant().KNoInterNet, imageStr: Constant().kCross, transition: .zoomIn, gesture: true, btnTitle: Constant().kTryAgain, bgColor: Constant().kFailureBgClr, btnBgColor: UIColor.init(hex: Constant().kFailureBtnClr), vc: topController)
                    }
                }
                else
                {
                    // Other errors
                    if response.response?.statusCode == nil{
                        completion(response,self.statusCodeForResponseCode(alamoError._code))
                    }else{
                        completion(response, self.statusCodeForResponseCode((response.response?.statusCode)!))
                    }
                    
                }
            } else { //no errors
                completion(response, self.statusCodeForResponseCode((response.response?.statusCode)!))
            }
            
            
        }
    }
    
    // Response code handler
    func statusCodeForResponseCode(_ statusCode:Int) -> ResponseCode {
        switch statusCode {
        case 200:
            return .sucess
        case 230:
            return .permissionDisAllow
        case 400:
            return .badRequest
        case 401:
            return .unAuthorization
        case 403:
            return .forbidden
        case 404:
            return .badRequest
        case 408:
            return .timeOut
        case 500:
            return .serviceUnavailable
        default:
            return .timeOut
        }
        
    }
    
    // MARK: Alamofire POST method MAPPABLE with URLEncoding and response call of type Object
    public func executePostUrlEncodingObjectURL<T: Mappable>(type: T.Type, url: String, params: Parameters, headers: HTTPHeaders ,view: UIView, showLoader: Bool, completion: @escaping(_ result: DataResponse<T>?)-> Void) {
        print(url)
        print(params)
        if showLoader {
            Lib.sharedInstance.showLoader(view: view, message: "")
            AppUtils.sharedInstance.disableUser()
        } else {
            Lib.sharedInstance.hideLoader()
            AppUtils.sharedInstance.enableUser()
        }
        
        if(Lib.sharedInstance.isHasConnection()) {
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).validate().responseObject {
                (response: DataResponse<T>) in
                completion(response)
                Lib.sharedInstance.hideLoader()
                AppUtils.sharedInstance.enableUser()
            }
        } else{
            
            //Hide Loader
            Lib.sharedInstance.hideLoader()
            AppUtils.sharedInstance.enableUser()
            Lib.sharedInstance.showLoader(view: view, message: "No internet connection")
        }
    }
    
    // MARK: Alamofire POST method MAPPABLE response call of type Object
    public func executePostObjectURL<T: Mappable>(type: T.Type, url: String, params: Parameters, headers: HTTPHeaders ,view: UIView, showLoader: Bool, completion: @escaping(_ result: DataResponse<T>?)-> Void) {
        
        print("MCL: \(type) \(url)")
        print(params)
        
        if(Lib.sharedInstance.isHasConnection()) {
            if showLoader {
                Lib.sharedInstance.showLoader(view: view, message: "")
                AppUtils.sharedInstance.disableUser()
            } else {
                Lib.sharedInstance.hideLoader()
                AppUtils.sharedInstance.enableUser()
            }
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseObject {
                (response: DataResponse<T>) in
                
                completion(response)
                print("MCL: executePostObjectURL return")
                Lib.sharedInstance.hideLoader()
                AppUtils.sharedInstance.enableUser()
            }
        } else{
            
            //Hide Loader
            Lib.sharedInstance.hideLoader()
            AppUtils.sharedInstance.enableUser()
            Lib.sharedInstance.showLoader(view: view, message: "No internet connection")
        }
        
    }
    
}

extension UIApplication {
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
