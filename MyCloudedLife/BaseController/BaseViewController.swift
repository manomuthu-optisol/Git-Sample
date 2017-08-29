//
//  BaseViewController.swift
//  MyCloudedLife
//
//  Created by Dinesh on 14/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import UIKit
import Alamofire

class BaseViewController: UIViewController {

    //MARK: - Variables
    var headerView: MCLHeaderView!
    
    var currentController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initHeaderView(VC: UIViewController ,title: String){
        view.endEditing(true)
        headerView =  UINib(nibName: Constant().kHeaderView, bundle: nil).instantiate(withOwner: nil, options:nil)[0] as! MCLHeaderView
        headerView.delegate = VC as? MCLHeaderViewDelegate
        headerView.frame = CGRect.init(x: 0, y:0, width: self.view.frame.size.width, height:64)
        headerView.lblTitle.text = title
        headerView.btnLeft.isHidden = true
        headerView.btnRight.isHidden = true
    }
    
    func addHeader(currentView: UIViewController, title: String, showLeftBtn: Bool, showRightButton: Bool, leftImage: String?, rightImage: String?){
        initHeaderView(VC: currentView,title: title)
        if showLeftBtn{
            headerView.btnLeft.isHidden = false
            headerView.btnLeft.setImage(UIImage.init(named: leftImage!)!, for: UIControlState.normal)
        }
        if showRightButton{
            headerView.btnRight.isHidden = false
            headerView.btnRight.setImage(UIImage.init(named: rightImage!)!, for: UIControlState.normal)
        }
        
        currentView.view.addSubview(headerView)
        currentController = currentView
        // Show or hide Menu
    }
    
    func addHeaderWithRightButtonTitle(currentView: UIViewController, title: String, showRightButton: Bool, rightButtonTitle: String) {
        initHeaderView(VC: currentView, title: title)
        if showRightButton {
            headerView.btnRight.isHidden = false
            headerView.btnRight.setTitle(rightButtonTitle, for: .normal)
        }
        currentView.view.addSubview(headerView)
        currentController = currentView
    }
    
    func navigateToPreviousScreen(){
        currentController.dismiss(animated: true, completion: nil)
    }

}
