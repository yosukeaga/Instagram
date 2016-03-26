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
    
    var post: PostData!
    
   
    @IBAction func PostCommentingButton(sender: AnyObject) {
        
        let postData = self.post
        postData.comment.append(postComentTextField.text!)
        let name = postData.name
        let imageString = postData.imageString
        let caption = postData.caption
        let time = (postData.date?.timeIntervalSinceReferenceDate)! as NSTimeInterval
        let likes = postData.likes
        let comment = postData.comment
        var name1 = postData.name1
        
        let ud = NSUserDefaults.standardUserDefaults()
        let userName = ud.objectForKey(CommonConst.DisplayNameKey) as! String
        
        name1.append(userName)
        

        
        let post = ["caption": caption!, "image": imageString!, "name": name!, "time": time, "likes": likes, "coment": comment,"name1": name1]
        let postRef = Firebase(url: CommonConst.FirebaseURL).childByAppendingPath(CommonConst.PostPATH)
        postRef.childByAppendingPath(postData.id).setValue(post)
        
        
        
        
        
        SVProgressHUD.showSuccessWithStatus("投稿しました")
        
        UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func PostCancelingButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)

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
