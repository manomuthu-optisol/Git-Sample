//
//  CreateNotesVC.swift
//  MyCloudedLife
//
//  Created by Mac-OBS-6 on 28/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import UIKit

class CreateNotesVC: BaseViewController ,MCLHeaderViewDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addHeader(currentView: self, title: Constant().kCreateNotes, showLeftBtn: true, showRightButton: false, leftImage: Constant().kBackArrowIMG, rightImage: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Header delegate
    func leftButtonAction(){
        self.navigationController?.backToViewController(viewController: CreateNotesVC.self)
    }
    
}
