//
//  MCLTabBarController.swift
//  MyCloudedLife
//
//  Created by Dinesh on 18/08/17.
//  Copyright © 2017 OptisolBusinessSolution. All rights reserved.
//

import UIKit

class MCLTabBarController: UITabBarController {
    
    var isSignUPFlag: Bool!
    var isSignINFlag: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize Controllers
        self.tabBarControllers()
    }
    
    func tabBarControllers(){
        
        let storyboard = UIStoryboard(name: Constant().kMainStroyBoard, bundle: nil)
        
        let photosVC = storyboard.instantiateViewController(withIdentifier: Constant().kPhotosVCID) as! PhotosVC
        photosVC.tabBarItem = UITabBarItem.init(title: nil, image: #imageLiteral(resourceName: "photo-inactive"), selectedImage: #imageLiteral(resourceName: "photo-active"))
        photosVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        photosVC.tabBarItem.tag = 0
        
        let albumsVC = storyboard.instantiateViewController(withIdentifier: Constant().kAlbumsVCID) as! AlbumsVC
        albumsVC.tabBarItem = UITabBarItem.init(title: nil, image: #imageLiteral(resourceName: "album-inactive"), selectedImage: #imageLiteral(resourceName: "album-active"))
        albumsVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        albumsVC.tabBarItem.tag = 1
        
        let notesVC = storyboard.instantiateViewController(withIdentifier: Constant().kNotesVCID) as! NotesVC
        notesVC.tabBarItem = UITabBarItem.init(title: nil, image: #imageLiteral(resourceName: "note-inactive"), selectedImage: #imageLiteral(resourceName: "note-active"))
        notesVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        notesVC.tabBarItem.tag = 2
        
        let profileVC = storyboard.instantiateViewController(withIdentifier: Constant().kProfileVCID) as! ProfileVC
        profileVC.tabBarItem = UITabBarItem.init(title: nil, image: #imageLiteral(resourceName: "profile-inactive"), selectedImage: #imageLiteral(resourceName: "profile-active"))
        profileVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        profileVC.tabBarItem.tag = 3
        
        let viewControlerList = [photosVC, albumsVC, notesVC, profileVC]
        viewControllers = viewControlerList
        
        if let isSignUPFlag = self.isSignUPFlag {
            if isSignUPFlag {
                let createProfileVC = storyboard.instantiateViewController(withIdentifier: Constant().kCreateProfileSBID) as! CreateProfileVC
                createProfileVC.tabBarItem = UITabBarItem.init(title: nil, image: #imageLiteral(resourceName: "profile-inactive"), selectedImage: #imageLiteral(resourceName: "profile-active"))
                createProfileVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
                createProfileVC.tabBarItem.tag = 3
                let viewControlerList = [photosVC, albumsVC, notesVC, createProfileVC]
                viewControllers = viewControlerList
                selectedIndex = 3
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
