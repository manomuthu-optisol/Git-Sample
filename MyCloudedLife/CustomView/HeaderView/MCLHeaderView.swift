//
//  MCLHeaderView.swift
//  MyCloudedLife
//
//  Created by Dinesh on 18/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import UIKit

@objc protocol MCLHeaderViewDelegate: class {
    
    // left button action
    @objc optional func leftButtonAction()
    
    // right button action
    @objc optional func rightButtonAction()
}

class MCLHeaderView: UIView {

    // MARK: Outlets
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var btnLeft: UIButton!
    @IBOutlet var btnRight: UIButton!
    
    // MARK: Delegate
    weak var delegate: MCLHeaderViewDelegate?
    
    // MARK: IBAction methods
    @IBAction func leftButtonAction(_ sender: UIButton) {
        delegate?.leftButtonAction!()
    }
    
    @IBAction func rightButtonAction(_ sender: UIButton) {
        delegate?.rightButtonAction!()
    }

}
