//
//  ViewController.swift
//  Instagram
//
//  Created by aga yosuke on 2016/03/15.
//  Copyright © 2016年 yosuke.aga. All rights reserved.
//
import Firebase

import UIKit
import ESTabBarController


class ViewController: UIViewController {

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let firebaseRef = Firebase(url: CommonConst.FirebaseURL)
        let authData = firebaseRef.authData
        
        if authData == nil {
            dispatch_async(dispatch_get_main_queue()) {
                let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(loginViewController!, animated: true, completion: nil)
            }
        }else{
        
            setupTab()
        }
        
    
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTab(){
        let tabBarController = ESTabBarController(tabIconNames: ["home","camera","setting"])
        
            tabBarController.selectedColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
            tabBarController.buttonsBackgroundColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        
            addChildViewController(tabBarController)
            view.addSubview(tabBarController.view)
            tabBarController.view.frame = view.bounds
            tabBarController.didMoveToParentViewController(self)
        
        let homeViewController = storyboard?.instantiateViewControllerWithIdentifier("Home")
        let settingViewController = storyboard?.instantiateViewControllerWithIdentifier("Setting")
        
            tabBarController.setViewController(homeViewController, atIndex: 0)
            tabBarController.setViewController(settingViewController, atIndex: 2)
        
            tabBarController.highlightButtonAtIndex(1)
            tabBarController.setAction(AAA, atIndex: 1)
           //{
           // let imageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ImageSelect")
           //self.presentViewController(imageViewController!, animated: true, completion: nil)}, atIndex: 1)
    }

    func  AAA() {
            let imageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ImageSelect")
            self.presentViewController(imageViewController!, animated: true, completion: nil)
    }
    
    
    
    
    
    
    

}

