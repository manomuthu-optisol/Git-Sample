//
//  ProfileVC.swift
//  MyCloudedLife
//
//  Created by Dinesh on 18/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import UIKit

class ProfileVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addHeader(currentView: self, title: Constant().kCreateNotes, showLeftBtn: true, showRightButton: false, leftImage: Constant().kBackArrowIMG, rightImage: nil)

        view.backgroundColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
