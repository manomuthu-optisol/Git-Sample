//
//  LoginViewController.swift
//  MyCloudedLife
//
//  Created by Dinesh on 16/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Alamofire

class LoginVC: BaseViewController {
    
    @IBOutlet var facebookLoginButton: UIButton!
    @IBOutlet var signInViewButton: UIButton!
    @IBOutlet var signUpViewButton: UIButton!
    @IBOutlet var signInView: UIView!
    @IBOutlet var signUpView: UIView!
    
    // Sign in components
    @IBOutlet var signInUserNameTextField: UITextField!
    @IBOutlet var signInPasswordTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    
    // Sign up components
    @IBOutlet var signUpUserNameTextField: UITextField!
    @IBOutlet var signUpEmailAddressTextField: UITextField!
    @IBOutlet var signUpPasswordTextField: UITextField!
    @IBOutlet var signUpConfirmPasswordTextField: UITextField!
    @IBOutlet var signUpGetStartedButton: UIButton!
    
    // User variables
    let fbLoginManager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //"username":"dineshn19@yopmail.com",
        //"password":"Dineshn19@"
        self.signInUserNameTextField.text = "ganesh"
        self.signInPasswordTextField.text = "ganesh"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = true
        
        facebookLoginButton.layer.cornerRadius = 1
        facebookLoginButton.layer.borderWidth = 2
        facebookLoginButton.layer.borderColor = UIColor.init(red: 0/255, green: 124/255, blue: 240/255, alpha: 0.6).cgColor
        
        self.signUpView.isHidden = true
        self.signUpViewButton.setTitleColor(UIColor.lightGray, for: .normal)
        self.signInViewButton.setTitleColor(UIColor.init(red: 0/255, green: 124/255, blue: 240/255, alpha: 1), for: .normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: User Methods
    
    func isSignInValid() -> Bool {
        
        let isSignInValid = true
        //For testing
        /*
        if (signInUserNameTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kEmptyUserNameMSG)
            return false
        } else {
            if AppUtils.sharedInstance.isValidEmail(emailStr: signInUserNameTextField.text!) {
                // Valid email id given
            } else {
                AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kInValidEmailMSG)
                return false
            }
        }
        
        if (signInPasswordTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kEnterPassCodeMSG)
            return false
        } else {
            if AppUtils.sharedInstance.isValidPassword(password: signInPasswordTextField.text!) {
                // Password satisfies minimum requirement
            } else {
                AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kPwdSuggestionMSG)
                return false
            }
        }*/
        
        return isSignInValid
    }
    
    func isSignUpValid() -> Bool {
        let isSignUpValid = true
        
        if (signUpUserNameTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kEmptyUserNameMSG)
            return false
        }
        
        if (signUpEmailAddressTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kEmptyEmailMSG)
            return false
        } else {
            if AppUtils.sharedInstance.isValidEmail(emailStr: signUpEmailAddressTextField.text!) {
                // valid email entered
            } else {
                AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kInValidEmailMSG)
                return false
            }
        }
        
        if (signUpPasswordTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kEnterPassCodeMSG)
            return false
        }
        
        if (signUpConfirmPasswordTextField.text?.isEmpty)! {
            AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kPwdRequiredMSG)
            return false
        }
        
        if (signUpPasswordTextField.text?.isEmpty == false) && (signUpConfirmPasswordTextField.text?.isEmpty == false) {
            if signUpPasswordTextField.text == signUpConfirmPasswordTextField.text {
                // Password matched
                if AppUtils.sharedInstance.isValidPassword(password: signUpPasswordTextField.text!) {
                    // Password is valid with Length of password should be atleast 8, having One Caps, One Number, and One special character
                    
                } else {
                    AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kPwdSuggestionMSG)
                    return false
                }
            } else {
                AppUtils.sharedInstance.simpleAlert(view: self, title: "", message: Constant().kConfirmPwdInvalidMSG)
                return false
            }
        }
        
        return isSignUpValid
    }
    
    // MARK: IBACTION Methods
    
    @IBAction func facebookLoginAction(_ sender: UIButton) {
        print("MCL: facebook login action.")
        
//        fbLoginManager.logOut()
//        fbLoginManager.logIn([.publicProfile, .userFriends, .email], viewController: self) {
//            facebookResponse in
//            
//            switch facebookResponse {
//            case .failed(let error):
//                print("MCL: Facebook login failuer - \(error)")
//            case .cancelled:
//                print("MCL: Facebook login cancelled")
//            case .success(grantedPermissions: _, declinedPermissions: _, token: let accessToken):
//                let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "email,first_name,last_name,gender,picture,dateofbirth"], accessToken: accessToken, httpMethod: GraphRequestHTTPMethod(rawValue: "GET")!)
//                graphRequest.start({
//                    (connection, result) in
//                    
//                    switch result {
//                    case .failed(let error):
//                        print("MCL: Graph request failure - \(error).")
//                    case .success(let graphResponse):
//                        if let responseDictionary = graphResponse.dictionaryValue {
//                            
//                            var first_name = ""
//                            var last_name = ""
//                            var facebook_id = ""
//                            var gender_fb = ""
//                            var token_fb = ""
//                            
//                            if let firstName = responseDictionary["first_name"] {
//                                first_name = "\(firstName)"
//                            }
//                            
//                            if let lastName = responseDictionary["last_name"] {
//                                last_name = "\(lastName)"
//                            }
//                            
//                            if let facebookID = responseDictionary["id"] {
//                                facebook_id = "\(facebookID)"
//                            }
//                            
//                            if let gender = responseDictionary["gender"] {
//                                gender_fb = "\(gender)"
//                            }
//                            
//                            if let accessToken = graphRequest.accessToken?.authenticationToken {
//                                token_fb = accessToken
//                            }
//                            
//                            print("MCL: first name \(first_name)")
//                            print("MCL: last name \(last_name)")
//                            print("MCL: facebook_id \(facebook_id)")
//                            print("MCL: gender_fb \(gender_fb)")
//                            print("MCL: token_fb \(token_fb)")
//                            
//                        }
//                    }
//                })
//            }
//        }
        
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        let forgotPswdVC = storyboard?.instantiateViewController(withIdentifier: Constant().kForgotPswdSBID) as! ForgotPasswordVC
        forgotPswdVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(forgotPswdVC, animated: true)
    }
    
    @IBAction func signInViewButtonAction(_ sender: UIButton) {
        
        self.signUpView.isHidden = true
        self.signInView.isHidden = false
        
        self.signInViewButton.setTitleColor(UIColor.init(red: 0/255, green: 124/255, blue: 240/255, alpha: 1), for: .normal)
        self.signUpViewButton.setTitleColor(UIColor.init(red: 174/255, green: 173/255, blue: 240/255, alpha: 1), for: .normal)
        
        self.facebookLoginButton.isHidden = false
        
//        self.signInUserNameTextField.text = ""
//        self.signInPasswordTextField.text = ""
    }
    
    @IBAction func signUpViewButtonAction(_ sender: UIButton) {
        
        self.signInView.isHidden = true
        self.signUpView.isHidden = false
        
        self.signInViewButton.setTitleColor(UIColor.init(red: 174/255, green: 173/255, blue: 173/255, alpha: 1), for: .normal)
        self.signUpViewButton.setTitleColor(UIColor.init(red: 0/255, green: 124/255, blue: 240/255, alpha: 1), for: .normal)
        
        self.facebookLoginButton.isHidden = true
        
        self.signUpUserNameTextField.text = ""
        self.signUpEmailAddressTextField.text = ""
        self.signUpPasswordTextField.text = ""
        self.signUpConfirmPasswordTextField.text = ""
        
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        
        if isSignInValid() {
            
            let params: Parameters = [Constant().kUsernameParam: self.signInUserNameTextField.text!, Constant().kPasswordParam: self.signInPasswordTextField.text!]
            
            // Login service call via UserAPIDataManager
            UserAPIDataManager.sharedInstance.UserLogin(param: params, viewController: self, showLoader: true, completion: {
                response in
                if let token = response.token {
                    
                    AppUtils.sharedInstance.addData(value: token, key: Constant().kAccessTokenUD)
                    
                    let MCLTBCnt = self.storyboard?.instantiateViewController(withIdentifier: Constant().kMCLTabBarControllerID) as? MCLTabBarController
//                    self.navigationController?.present(MCLTBCnt!, animated: true, completion: nil)
                    self.navigationController?.pushViewController(MCLTBCnt!, animated: true)
                }
            })
            
        } else {
            print(Constant().kSignInInValidMSG)
        }
        
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        
        if isSignUpValid() {
            
            let param: Parameters = [Constant().kUsernameParam: self.signUpUserNameTextField.text!, Constant().kEmailParam: self.signUpEmailAddressTextField.text!, Constant().kPasswordParam: self.signUpPasswordTextField.text!, Constant().kConfirmPwdParam: self.signUpConfirmPasswordTextField.text!]
            
            // SignUp service call via UserAPIDataManager
            UserAPIDataManager.sharedInstance.UserSignUp(params: param, viewController: self, showLoader: true, completion: {
                response in
                // first time redirect to create profile page
                let MCLTBCnt = self.storyboard?.instantiateViewController(withIdentifier: Constant().kMCLTabBarControllerID) as? MCLTabBarController
                MCLTBCnt?.isSignUPFlag = true
                self.navigationController?.present(MCLTBCnt!, animated: true, completion: nil)
            })
        } else {
            print(Constant().kSignUpInvalidMSG)
        }
    }

}
