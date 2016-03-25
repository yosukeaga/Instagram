//
//  PostCommentViewController.swift
//  Instagram
//
//  Created by aga yosuke on 2016/03/24.
//  Copyright © 2016年 yosuke.aga. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class PostCommentViewController: UIViewController {

    
    @IBOutlet weak var postComentTextField: UITextField!
    
    
    
   
    @IBAction func PostCommentingButton(sender: AnyObject) {
        
        let postRef = Firebase(url: CommonConst.FirebaseURL).childByAppendingPath(CommonConst.PostCommentPATH)
        let ud = NSUserDefaults.standardUserDefaults()
        let name = ud.objectForKey(CommonConst.DisplayNameKey) as! String
        
        let postData = ["comment": postComentTextField.text!, "name": name]
        
        postRef.childByAutoId().setValue(postData)
        
        SVProgressHUD.showSuccessWithStatus("投稿しました")
        
        UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func PostCancelingButton(sender: AnyObject) {
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
