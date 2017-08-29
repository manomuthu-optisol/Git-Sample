//
//  CreateProfileVC.swift
//  MyCloudedLife
//
//  Created by Dinesh on 23/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import UIKit
import Alamofire

class CreateProfileVC: BaseViewController, UITextFieldDelegate {

    @IBOutlet var userImg: UIImageView!
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var DOBTF: UITextField!
    @IBOutlet var GenderTF: UITextField!
    
    
    var genderPicker: UIPickerView = UIPickerView()
    var genderArray = ["Male", "Female"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setting required delegate
        nameTF.delegate = self
        DOBTF.delegate = self
        GenderTF.delegate = self
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
        // Circle user image
        userImg.layer.borderWidth = 1
        userImg.layer.masksToBounds = false
        userImg.layer.borderColor = UIColor.clear.cgColor
        userImg.layer.cornerRadius = userImg.frame.height/2
        userImg.clipsToBounds = true
        
        // Setting default text for GenderTF
        GenderTF.text = genderArray[0]
        GenderTF.inputView = genderPicker
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - User methods
    func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        DOBTF.text = formatter.string(from: sender.date)
    }
    
    func getUserInfo() {
        
        let param: Parameters = ["": ""]
        let header: HTTPHeaders = ["": ""]
        UserAPIDataManager.sharedInstance.getUserInfo(viewController: self, showLoader: true, completion: {
            response in
            
            if let name = response.name {
                self.nameTF.text = name
            }
            
            if let dob = response.dob {
                self.DOBTF.text = dob
            }
            
            if let gender = response.gender {
                self.GenderTF.text = gender
            }
            
        })
    }
    
    // MARK: - IBAction methods
    
    @IBAction func genderTFAction(_ sender: UITextField) {
        sender.inputView = genderPicker
        
        if (sender.text?.isEmpty)! {
            sender.text = genderArray[0]
        }
    }
    
    // MARK: - TextField Delegate method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 20 // Bool
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == DOBTF {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            
            datePicker.maximumDate = NSDate() as Date
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
        }
    }

}

extension CreateProfileVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var returnInt = 0
        
        if pickerView == genderPicker {
            returnInt = genderArray.count
        }
        
        return returnInt
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderPicker {
            GenderTF.text = genderArray[row]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
