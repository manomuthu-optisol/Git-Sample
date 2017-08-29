//
//  Lib.swift
//  MyCloudedLife
//
//  Created by Dinesh on 17/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import Foundation
import ReachabilitySwift
import MBProgressHUD

class Lib: NSObject {
    
    var loadingNotification = MBProgressHUD()
    
    class var sharedInstance: Lib {
        struct Static {
            static let instance = Lib()
        }
        return Static.instance
    }
    
    public func isHasConnection () -> Bool {
        let reachability = Reachability();
        if(reachability?.currentReachabilityStatus == Reachability.NetworkStatus.notReachable){
            return false;
        }
        return true;
    }
    
    //MARK: - ProgressHUD
    public func showLoader(view: UIView, message: String){
        loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = message
    }
    
    public func hideLoader(){
        loadingNotification.hide(animated: true)
    }
    
    //MARK: - Dialog
    func showDialog(title : String, msg : String, imageStr : String, transition : PopupDialogTransitionStyle, gesture : Bool, btnTitle : String, bgColor : String, btnBgColor : UIColor, vc : UIViewController) {
        // Create a custom view controller
        let dialog = DialogView(nibName: Constant().kDialogView, bundle: nil)
        
        dialog.strMsg = msg
        dialog.strViewBg = bgColor
        dialog.strImg = imageStr
        
        // Create the dialog
        let popup = PopupDialog(viewController: dialog, buttonAlignment: .horizontal, transitionStyle: transition, gestureDismissal: gesture)
        
        popup.view.backgroundColor = UIColor.clear
        // Create confirm button
        let buttonConfirm = DefaultButton(title: btnTitle, height: 50) {
            
        }
        buttonConfirm.backgroundColor = btnBgColor
        buttonConfirm.titleColor = UIColor.white
        buttonConfirm.titleFont = UIFont(name: "CircularStd-Bold", size: 20)
        
        // Add buttons to dialog
        popup.addButtons([buttonConfirm])
        
        // Present dialog
        vc.present(popup, animated: true, completion: nil)
    }
}

//Hex color to UIColor
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1) {
        assert(hex[hex.startIndex] == "#", "Expected hex string of format #RRGGBB")
        
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1  // skip #
        
        var rgb: UInt32 = 0
        scanner.scanHexInt32(&rgb)
        
        self.init(
            red:   CGFloat((rgb & 0xFF0000) >> 16)/255.0,
            green: CGFloat((rgb &   0xFF00) >>  8)/255.0,
            blue:  CGFloat((rgb &     0xFF)      )/255.0,
            alpha: alpha)
    }
}

//String Partial Bold and normal
extension NSMutableAttributedString {
    func bold(_ text:String) -> NSMutableAttributedString {
        let attrs:[String:AnyObject] = [NSFontAttributeName : UIFont(name: "CircularStd-Bold", size: 12)!]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func normal(_ text:String)->NSMutableAttributedString {
        let attrs:[String:AnyObject] = [NSFontAttributeName : UIFont(name: "CircularStd-Bold", size: 15)!]
        let normal = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(normal)
        return self
    }
    
    func orangeColor(_ text:String)->NSMutableAttributedString {
        let attrs:[String:AnyObject] = [NSFontAttributeName : UIFont(name: "CircularStd-Bold", size: 15)!]
        let color = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        let range = (text as NSString).range(of: text)
        let attribute = NSMutableAttributedString.init(string: text)
        attribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.orange , range: range)
        self.append(color)
        return self
    }
}

//String Split by range
extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}

//Load image from URL
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

//Load UIView from nib
extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}

extension UIView {
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

//Button selected background color
extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
}

//String Equal
extension String {
    func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
    }
}

//Int to String
extension Int {
    var stringValue:String {
        return "\(self)"
    }
}

//Split by length
extension String {
    func splitByLength(_ length: Int) -> [String] {
        var result = [String]()
        var collectedCharacters = [Character]()
        collectedCharacters.reserveCapacity(length)
        var count = 0
        
        for character in self.characters {
            collectedCharacters.append(character)
            count += 1
            if (count == length) {
                // Reached the desired length
                count = 0
                result.append(String(collectedCharacters))
                collectedCharacters.removeAll(keepingCapacity: true)
            }
        }
        
        // Append the remainder
        if !collectedCharacters.isEmpty {
            result.append(String(collectedCharacters))
        }
        
        return result
    }
}

//Check int
extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

//Scroll To Top
extension UIScrollView {
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
}

//View Shadow
extension UIView {
    func dropShadow(scale: Bool = true, color: CGColor, radius: Int) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = CGFloat(radius)
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension UIView {
    func addDashedBorder() {
        let color = UIColor.init(hex: Constant().kThemeBlue).cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}

extension UINavigationController {
    
    func backToViewController(viewController: Swift.AnyClass) {
        
        for element in viewControllers as Array {
            if element.isKind(of: viewController) {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
}
