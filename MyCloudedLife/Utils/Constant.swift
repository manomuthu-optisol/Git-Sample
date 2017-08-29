//
//  Constant.swift
//  MyCloudedLife
//
//  Created by Dinesh on 14/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import Foundation

public struct Constant{
    
    //MARK: - App title
    
    public let kTitle = "MyCloudedLife"
    
    public let kStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
    
    //MARK: - Controller title
    
    public let kCreateNotes = "Create Notes"
    public let kResetPswd = "Reset Password"
    public let kNotes = "Notes"
    
    //MARK: - String
    
    public let kAuthorization : String = "Authorization"
    public let kBearer : String = "bearer "
    public let kOk : String = "Ok"
    public let kTryAgain : String = "TRY AGAIN"
    public let kFailureBgClr : String = "#fde3e3"
    public let kFailureBtnClr : String = "#0093a4"
    public let kSuccessBgClr : String = "#d5f9e5"
    public let kSuccessBtnClr : String = "#0093a4"
    public let kContinue : String = "CONTINUE"
    public let kAgree : String = "AGREE"
    public let kThemeBlue : String = "#9bd9e0"
    public let kMainStroyBoard : String = "Main"
    
    public let kSave: String = "Save"
    
    // MARK: Header
    
    public let kJsonHeader = ["Content-Type": "application/json"]
    
    //MARK: - Params
    
    public let kUsernameParam : String = "username"
    public let kUsername1 : String = "username"
    public let kPasswordParam : String = "password"
    public let kConfirmPwdParam : String = "confirm_password"
    public let kPhoneNo : String = "phone"
    public let kTypeId : String = "typeId"
    public let kGrantType : String = "grant_type"
    
    public let kUrlEncoded : String = "application/x-www-form-urlencoded"
    public let kEmailParam : String = "email"
    public let kPassCode : String = "passCode"
    public let kOrigin : String = "origin"
    public let kLoading : String = "Loading..."
    
    public let kContentTypeParam : String = "Content-Type"
    public let kjsonParam: String = "application/json"
    public let kAuthorizationParam: String = "Authorization"
    public let kemailParam: String = "email"
    public let kuserIdParam: String = "userId"
    public let kpageParam: String = "page"
    public let kpageSizeParam: String = "pageSize"
    
    //MARK: - Messages
    
    public let kSuccessMSG : String = "SUCCESS"
    public let kFailureMSG : String = "OOPS"
    public let kEmptyUserNameMSG : String = "Please enter the username."
    public let kEnterPwdMSG : String = "Please enter your password."
    public let kEnterPassCodeMSG : String = "Please enter your passcode."
    public let kInvalidLoginMSG : String = "Please enter valid email and password."
    public let kConfirmPwdInvalidMSG : String = "Password and Confirm Password are not same."
    public let kPwdSuggestionMSG: String = "Length of password should be atleast 8, having One Caps, One Number, and One special character"
    public let kPwdRequiredMSG : String = "Password and Confirm Password are required."
    public let kEmailexistMSG : String = "Email already exist!"
    public let kInValidEmailMSG : String = "Enter valid email id."
    public let kInValidPasscodeMSG : String = "Enter valid passcode."
    public let kEmptyEmailMSG : String = "Email field should not be blank."
    public let kPhoneNoExistMSG : String = "Phone number already exist."
    public let kForgotPwdMSG : String = "One time passcode has been sent to your email."
    public let KNoInterNetMSG : String = "Please Check your internet connection."
    public let kPwdStrenghMSG : String = "Password strength does not satisfied minimum requirement."
    public let kAgreeAgrementMSG : String = "Please accept user agreement."
    public let kRegisterSuccessMSG : String = "Registered Successfully."
    public let kInvalidUserMSG : String = "Invalid User."
    public let kRequestTimeMSG : String = "Request time out."
    public let kEmailSentMSG: String = "We have sent your password to your mail please check it and come back to log in again"
    public let kSignInInValidMSG: String = "MCL: sign in invalid"
    public let kSignUpInvalidMSG: String = "MCL: sign up invalid"
    public let kOTPEmptyMSG: String = "Enter OTP."
    
    // UserAPIDataManager messages
    public let kUserLoginNullRespMSG = "MCL: UserAPIDataManger-UserLogin-NULL response"
    public let kUserLoginNon200RespMSG = "MCL: UserAPIDataManger-UserLogin-Non 200 response"
    public let kUserLoginFailureMSG = "MCL: UserAPIDataManger-UserLogin-Failure response with status code"
    
    // MARK: Table view cell identifiers
    public let klabelAndTextFieldCell = "labelAndTextFieldCell"
    
    // MARK: StoryBoard ID
    public let kForgotPswdSBID = "forgotPswdVC"
    public let kResetPswdSBID = "resetPswdSBID"
    public let kPhotosVCID = "PhotosVCID"
    public let kAlbumsVCID = "AlbumsVCID"
    public let kNotesVCID = "NotesVCID"
    public let kProfileVCID = "ProfileVCID"
    public let kMCLTabBarControllerID = "MCLTabBarControllerID"
    public let kLoginSBID = "loginVC"
    public let kCreateProfileSBID = "createProfileSBID"
    public let kCreateNotesVC = "CreateNotesVC"
    
    // MARK: XIB Names
    public let kDialogView = "DialogView"
    public let kHeaderView = "MCLHeaderView"
    
    // MARK: Image Resource Names
    public let kBackArrowIMG : String = "back-arrow"
    
    // MARK: UserDefaults
    public let kAccessTokenUD: String = "accessToken"
    
}
