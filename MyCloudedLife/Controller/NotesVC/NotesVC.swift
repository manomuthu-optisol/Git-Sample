//
//  NotesVC.swift
//  MyCloudedLife
//
//  Created by Dinesh on 18/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import UIKit

class NotesVC: BaseViewController, MCLHeaderViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addHeader(currentView: self, title: Constant().kNotes, showLeftBtn: false, showRightButton: true, leftImage: nil, rightImage: Constant().kBackArrowIMG)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Header Delegate
    func rightButtonAction(){
         let storyboard = UIStoryboard(name: Constant().kMainStroyBoard, bundle: nil)
        let createNote = CreateNotesVC(nibName: "CreateNotesVC", bundle: nil)
        let profileVC = storyboard.instantiateViewController(withIdentifier: Constant().kProfileVCID) as! ProfileVC
        self.navigationController?.pushViewController(createNote, animated: true)
    }

}
