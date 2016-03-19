//
//  LoginViewController.swift
//  Instagram
//
//  Created by aga yosuke on 2016/03/15.
//  Copyright © 2016年 yosuke.aga. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    var firebaseRef :Firebase!
    
    @IBAction func handleLoginButton(sender: AnyObject) {
        
        if let address = mailAddressTextField.text, let password = passwordTextField.text{
           
            if address.characters.isEmpty || password.characters.isEmpty {
                return
            }
            
            firebaseRef.authUser(address, password: password, withCompletionBlock: { error, authData in
                if error != nil {
                    
                } else {
                    
                    // Firebaseからログインしたユーザの表示名を取得してNSUserDefaultsに保存する
                    let usersRef = self.firebaseRef.childByAppendingPath(CommonConst.UsersPATH)
                    let uidRef = usersRef.childByAppendingPath(authData.uid)
                    uidRef.observeSingleEventOfType(FEventType.Value, withBlock: { snapshot in
                        
                        if let displayName = snapshot.value.objectForKey("name") as? String {
                            self.setDisplayName(displayName)
                        }
                        
                        // 画面を閉じる
                        self.dismissViewControllerAnimated(true, completion: nil)})
                }
            })
        }
    }
            
    @IBAction func handleCreateAcountButton(sender: AnyObject) {
        
        if let address = mailAddressTextField.text, let password = passwordTextField.text, let displayName = displayNameTextField.text {
            if address.characters.isEmpty || password.characters.isEmpty || displayName.characters.isEmpty{
                return
            }
            
            firebaseRef.createUser(address, password: password, withValueCompletionBlock: { error, result in
                if error != nil {
                    
                } else {
                    // ユーザーを作成できたらそのままログインする
                    self.firebaseRef.authUser(address, password: password, withCompletionBlock:  { error, authData in
                        if error != nil {
                            
                        } else {
                            // Firebaseに表示名を保存する
                            let usersRef = self.firebaseRef.childByAppendingPath(CommonConst.UsersPATH)
                            let data = ["name": displayName]
                            usersRef.childByAppendingPath("/\(authData.uid)").setValue(data)
                            
                            // NSUserDefaultsに表示名を保存する
                            self.setDisplayName(displayName)
                            
                            // 画面を閉じる
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                    })
                }
            })
        
        
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firebaseRef = Firebase(url: CommonConst.FirebaseURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func setDisplayName(name: String){
        
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setValue(name, forKey: CommonConst.DisplayNameKey)
        ud.synchronize()
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
