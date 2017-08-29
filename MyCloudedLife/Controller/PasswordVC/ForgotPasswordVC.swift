//
//  ForgotPasswordVC.swift
//  MyCloudedLife
//
//  Created by Dinesh on 21/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import UIKit
import Alamofire

class ForgotPasswordVC: UIViewController {

    @IBOutlet var emailTf: UITextField!
    @IBOutlet var okBtn: UIButton!
    @IBOutlet var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        screenConfig() // Custom screen appearance method
    }
    
    // MARK: User Methods
    func screenConfig() {
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        okBtn.layer.cornerRadius = 5 // ok button appearance
    }
    
    func forgetPswdSuccess() {
        
    }
    
    // MARK: IBAction Methods
    @IBAction func okBtnAction(_ sender: UIButton) {
        let email = emailTf.text!
        
        if email.characters.count == 0 {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kEmptyEmailMSG)
            return
        }
        
        if AppUtils.sharedInstance.isValidEmail(emailStr: email) {
            
            let param: Parameters = ["email": email]
            
            UserAPIDataManager.sharedInstance.forgotPassword(viewController: self, param: param, showLoader: true, completion: {
                response in
                
                let alert = UIAlertController.init(title: "Email Sent", message: Constant().kEmailSentMSG, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction.init(title: "Okay", style: .default, handler: {
                    alert in
                    let resetPswdVC = Constant().kStoryBoard.instantiateViewController(withIdentifier: Constant().kResetPswdSBID) as! ResetPasswordVC
                    self.navigationController?.pushViewController(resetPswdVC, animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                
            })

        } else {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kInValidEmailMSG)
        }
        
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        AppUtils.sharedInstance.popViewController(viewController: self)
    }

}
