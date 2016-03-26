//
//  HomeViewController.swift
//  Instagram
//
//  Created by aga yosuke on 2016/03/15.
//  Copyright © 2016年 yosuke.aga. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var firebaseRef: Firebase!
    var postArray: [PostData] = []
    var i = 0
    
     //DataSourceプロトコル
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
     //DataSourceプロトコル
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell" , forIndexPath: indexPath) as! PostTableViewCell
        cell.postData = postArray[indexPath.row]
        
        cell.likeButton.addTarget(self, action:"handleButton:event:", forControlEvents:  UIControlEvents.TouchUpInside)
        cell.commentButton.addTarget(self, action:"handleCommentButton:event:", forControlEvents:  UIControlEvents.TouchUpInside)
        
        
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // Auto Layoutを使ってセルの高さを動的に変更する
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // セルをタップされたら何もせずに選択状態を解除する
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func handleCommentButton(sender: UIButton, event:UIEvent){
    
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        i = indexPath!.row
        
        
        
       let postcommentviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("PostComment") as! PostCommentViewController
        
        postcommentviewcontroller.post = postArray[i]
        
        presentViewController(postcommentviewcontroller, animated: true, completion: nil)
        
        
    }
    
    func handleButton(sender: UIButton, event:UIEvent) {
        
        // タップされたセルのインデックスを求める
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        
        // 配列からタップされたインデックスのデータを取り出す
        let postData = postArray[indexPath!.row]
        
        // Firebaseに保存するデータの準備
        let uid = firebaseRef.authData.uid
        
        if postData.isLiked {
            // すでにいいねをしていた場合はいいねを解除するためIDを取り除く
            var index = -1
            for likeId in postData.likes {
                if likeId == uid {
                    // 削除するためにインデックスを保持しておく
                    index = postData.likes.indexOf(likeId)!
                    break
                }
            }
            postData.likes.removeAtIndex(index)
        } else {
            postData.likes.append(uid)
        }
        
        let imageString = postData.imageString
        let name = postData.name
        let caption = postData.caption
        let time = (postData.date?.timeIntervalSinceReferenceDate)! as NSTimeInterval
        let likes = postData.likes
        
        // 辞書を作成してFirebaseに保存する
        let post = ["caption": caption!, "image": imageString!, "name": name!, "time": time, "likes": likes]
        let postRef = Firebase(url: CommonConst.FirebaseURL).childByAppendingPath(CommonConst.PostPATH)
        postRef.childByAppendingPath(postData.id).setValue(post)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        print(postArray.count)
        
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        
        firebaseRef = Firebase(url: CommonConst.FirebaseURL)
        
        firebaseRef.childByAppendingPath(CommonConst.PostPATH).observeEventType(FEventType.ChildAdded, withBlock: { snapshot in
            
            let postData = PostData(snapshot: snapshot, myId: self.firebaseRef.authData.uid)
            self.postArray.insert(postData, atIndex: 0)
        
            self.tableView.reloadData()
        })
        
        firebaseRef.childByAppendingPath(CommonConst.PostPATH).observeEventType(FEventType.ChildChanged, withBlock: { snapshot in
         
            let postData = PostData(snapshot: snapshot, myId: self.firebaseRef.authData.uid)
            
            var index: Int = 0
            for post in self.postArray {
            
                if post.id == postData.id{
                
                    index = self.postArray.indexOf(post)!
                    break
                }
            }
            
            self.postArray.removeAtIndex(index)
            self.postArray.insert(postData, atIndex: index)
           
            //self.tableView.reloadData()
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        })
    
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
