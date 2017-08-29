//
//  DialogView.swift
//  swift_stub_alomafire
//
//  Created by Laptop-OBS-50 on 29/03/17.
//  Copyright © 2017 Optisol. All rights reserved.
//

import UIKit

class DialogView: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var imgTitle: UIImageView!
    @IBOutlet weak var viewBg: UIView!
    
    //MARK: - Variable
    var strTitle : String = ""
    var strMsg : String = ""
    var strImg : String = ""
    var strViewBg : String = ""
    
    //MARK: - Class
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = strTitle
        lblMessage.text = strMsg
        imgTitle.image = UIImage(named: strImg)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.viewBg.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        self.viewBg.layer.mask = maskLayer
        self.viewBg.backgroundColor = UIColor.init(hex: strViewBg)
    }
    
}
