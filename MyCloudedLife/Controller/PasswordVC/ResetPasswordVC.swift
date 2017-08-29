//
//  ResetPasswordViewController.swift
//  MyCloudedLife
//
//  Created by Dinesh on 18/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import UIKit
import Alamofire

class ResetPasswordVC: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet var OTPPswdTF: UITextField!
    @IBOutlet var NewPswdTF: UITextField!
    @IBOutlet var ConfPswdTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        OTPPswdTF.delegate = self
        NewPswdTF.delegate = self
        ConfPswdTF.delegate = self
        
        addHeaderWithRightButtonTitle(currentView: self, title: Constant().kResetPswd, showRightButton: true, rightButtonTitle: Constant().kSave)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: User functions
    func isValid() -> Bool {
        
        let isValid = true
        
        if (OTPPswdTF.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kOTPEmptyMSG)
            return false
        } else {
            // need to validate otp before submiting - need to call otp validation service
            let param: Parameters = ["otp_code": OTPPswdTF.text!]
            UserAPIDataManager.sharedInstance.veriftOTP(viewController: self, param: param, showLoader: false, completion: {
                response in
                // response success 
            })
        }
        
        if (NewPswdTF.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kEnterPwdMSG)
            return false
        } else {
            if AppUtils.sharedInstance.isValidPassword(password: NewPswdTF.text!) {
                // password matches our condition
            } else {
                AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kPwdSuggestionMSG)
                return false
            }
        }
        
        if (ConfPswdTF.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kPwdRequiredMSG)
            return false
        } else {
            if NewPswdTF.text != ConfPswdTF.text {
                AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kConfirmPwdInvalidMSG)
                return false
            }
        }
        
        return isValid
    }
    
    // MARK: - TextField Delegate method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 20 // Bool
    }
}

extension ResetPasswordVC: MCLHeaderViewDelegate {
    
    func rightButtonAction() {
        // call reset password service here
        if isValid() {
            let param: Parameters = ["opt_code": OTPPswdTF.text!, "new_password": NewPswdTF.text!, "confirm_password": ConfPswdTF.text!]
            UserAPIDataManager.sharedInstance.resetPassword(viewController: self, param: param, showLoader: true, completion: {
                response in
                let loginVC = Constant().kStoryBoard.instantiateViewController(withIdentifier: Constant().kLoginSBID) as! LoginVC
                self.navigationController?.pushViewController(loginVC, animated: true)
            })
        }
    }
    
}
