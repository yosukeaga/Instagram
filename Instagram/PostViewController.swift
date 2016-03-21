//
//  PostViewController.swift
//  Instagram
//
//  Created by aga yosuke on 2016/03/15.
//  Copyright © 2016年 yosuke.aga. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class PostViewController: UIViewController {

    var image: UIImage!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func handlePostButton(sender: UIButton) {
        
        let postRef = Firebase(url: CommonConst.FirebaseURL).childByAppendingPath(CommonConst.PostPATH)
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.85)
        
        let ud = NSUserDefaults.standardUserDefaults()
        let name = ud.objectForKey(CommonConst.DisplayNameKey) as! String
        
        let time = NSDate.timeIntervalSinceReferenceDate()
        
        let postData = ["caption":textField.text!, "image":imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength), "name": name, "time": time]
        postRef.childByAutoId().setValue(postData)
        
        SVProgressHUD.showSuccessWithStatus("投稿しました")
        
        UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func handleCancelButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.image = image
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
