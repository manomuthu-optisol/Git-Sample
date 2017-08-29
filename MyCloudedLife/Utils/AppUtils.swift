//
//  AppUtils.swift
//  MyCloudedLife
//
//  Created by Dinesh on 14/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import Foundation
import UIKit

class AppUtils: NSObject {
    
    class var sharedInstance: AppUtils {
        struct Static {
            static let instance = AppUtils()
        }
        return Static.instance
    }
    
    //Simple Alert view
    public func simpleAlert(view:UIViewController, title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    //Disable UserInteraction
    public func disableUser(){
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    //Enable UserInteraction
    public func enableUser(){
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    // TextField bottom border
    func BottomBorder(txtFld: UITextField, bottomColor: UIColor){
        let border = CALayer()
        border.frame = CGRect(x:0, y:txtFld.frame.size.height - 3,width: txtFld.frame.size.width,height: 1)
        border.backgroundColor = bottomColor.cgColor
        txtFld.layer.addSublayer(border)
    }
    
    // button bottom border
    func btnBottomBorder(btn: UIButton, bottomColor: UIColor){
        let border = CALayer()
        border.frame = CGRect(x:0, y:btn.frame.size.height - 3,width: btn.frame.size.width,height: 1)
        border.backgroundColor = bottomColor.cgColor
        btn.layer.addSublayer(border)
    }
    
    // View Border Color
    func viewBorder(view: UIView, viewColor: UIColor, viewCornerRadius: Int, viewBorderWidth: Int){
        view.layer.cornerRadius = CGFloat(viewCornerRadius)
        view.layer.borderWidth = CGFloat(viewBorderWidth)
        view.layer.borderColor = viewColor.cgColor
    }
    
    // Button Border Color
    func btnBorder(btn: UIButton, viewColor: UIColor, viewCornerRadius: CGFloat, viewBorderWidth: CGFloat){
        btn.layer.cornerRadius = viewCornerRadius
        btn.layer.borderWidth = viewBorderWidth
        btn.layer.borderColor = viewColor.cgColor
    }
    
    //Button Corner Radius
    func btnCornerRadiuse(btn: UIButton, size: CGFloat) {
        btn.layer.cornerRadius = size
    }
    
    //Progress Corner Radius
    func progressCornerRadiuse(progress: UIProgressView, size: CGFloat) {
        progress.layer.cornerRadius = size
    }
    
    //Email Validation
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    }
    
    //Password Validation
    func isValidPassword(password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    //Pop ViewController
    func popViewController(viewController: UIViewController) {
        _ = viewController.navigationController?.popViewController(animated: true)
    }
    
    // Failur response handler
    func failureResponseHandler(viewController: UIViewController, errorMessage: String, responseCode: ResponseCode) {
        switch responseCode {
        case ResponseCode.permissionDisAllow:
                let errorValue = AppUtils.sharedInstance.convertToDictionary(text: errorMessage)
                if let errorMessage = errorValue?["message"] {
                    AppUtils.sharedInstance.simpleAlert(view: viewController, title: "", message: errorMessage as! String)
                }
            break
        case ResponseCode.badRequest:
            let errorValue = AppUtils.sharedInstance.convertToDictionary(text: errorMessage)
            if let errorMessage = errorValue?["message"] {
                AppUtils.sharedInstance.simpleAlert(view: viewController, title: "", message: errorMessage as! String)
            }
            break
        case ResponseCode.unAuthorization:
            let errorValue = AppUtils.sharedInstance.convertToDictionary(text: errorMessage)
            if let errorMessage = errorValue?["message"] {
                AppUtils.sharedInstance.simpleAlert(view: viewController, title: "", message: errorMessage as! String)
            }
            break
        case ResponseCode.forbidden:
            let errorValue = AppUtils.sharedInstance.convertToDictionary(text: errorMessage)
            if let errorMessage = errorValue?["message"] {
                AppUtils.sharedInstance.simpleAlert(view: viewController, title: "", message: errorMessage as! String)
            }
            break
        case ResponseCode.notFound:
            let errorValue = AppUtils.sharedInstance.convertToDictionary(text: errorMessage)
            if let errorMessage = errorValue?["message"] {
                AppUtils.sharedInstance.simpleAlert(view: viewController, title: "", message: errorMessage as! String)
            }
            break
        case ResponseCode.timeOut:
            let errorValue = AppUtils.sharedInstance.convertToDictionary(text: errorMessage)
            if let errorMessage = errorValue?["message"] {
                AppUtils.sharedInstance.simpleAlert(view: viewController, title: "", message: errorMessage as! String)
            }
            break
        case ResponseCode.serviceUnavailable:
            let errorValue = AppUtils.sharedInstance.convertToDictionary(text: errorMessage)
            if let errorMessage = errorValue?["message"] {
                AppUtils.sharedInstance.simpleAlert(view: viewController, title: "", message: errorMessage as! String)
            }
            break
        case ResponseCode.noNetwork:
            let errorValue = AppUtils.sharedInstance.convertToDictionary(text: errorMessage)
            if let errorMessage = errorValue?["message"] {
                AppUtils.sharedInstance.simpleAlert(view: viewController, title: "", message: errorMessage as! String)
            }
            break
        default:
            break
        }
        
    }
    
    // Method to convert JSON String to Dictionary
    public func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print("MCL: \(error.localizedDescription)")
            }
        }
        return nil
    }

    //MARK: - UserDefaults
    public func addData(value: String, key: String){
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    
    public func getData(key: String) ->(String){
        var valueDefault = UserDefaults.standard.value(forKey: key)
        if valueDefault == nil{
            valueDefault = ""
        }
        return valueDefault as! (String)
    }
    
    // UserDefaults - Int
    public func addIntData(value: Int, key: String){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    
    public func getIntData(key: String) ->(Int){
        let valueDefault = UserDefaults.standard.integer(forKey: key)
        return valueDefault
    }
    
    //Check UserDefault exists
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

}
