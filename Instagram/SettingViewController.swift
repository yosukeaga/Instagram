//
//  SettingViewController.swift
//  Instagram
//
//  Created by aga yosuke on 2016/03/15.
//  Copyright © 2016年 yosuke.aga. All rights reserved.
//

import UIKit
import Firebase
import ESTabBarController
import SVProgressHUD

class SettingViewController: UIViewController {

    @IBOutlet weak var displayNameTextField: UITextField!
    
    @IBAction func handleChangeButton(sender: AnyObject) {
        
        if let name = displayNameTextField.text{
        
            if name.characters.isEmpty{
            
                SVProgressHUD.showErrorWithStatus("表示名を入力して下さい")
                return
                
            }else{
            
                let userRef = Firebase(url: CommonConst.FirebaseURL).childByAppendingPath(CommonConst.UsersPATH)
                let data = ["name": name]
                userRef.childByAppendingPath("/\(userRef.authData.uid)").setValue(data)
                
                let ud = NSUserDefaults.standardUserDefaults()
                ud.setValue(name, forKey: CommonConst.DisplayNameKey)
                ud.synchronize()
                
                SVProgressHUD.showErrorWithStatus("表示名を変更しました")
                
                view.endEditing(true)
            
            }
        
        
        }
    }
    
    @IBAction func handleLogoutButton(sender: AnyObject) {
        
        let firebaseRef = Firebase(url: CommonConst.FirebaseURL)
        firebaseRef.unauth()
        
        let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Login")
        self.presentViewController(loginViewController!, animated: true, completion: nil)
        
        let tabBarController = parentViewController as! ESTabBarController
        tabBarController.setSelectedIndex(0, animated: false)
        
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let ud = NSUserDefaults.standardUserDefaults()
        let name = ud.objectForKey(CommonConst.DisplayNameKey)as! String
        displayNameTextField.text = name
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
