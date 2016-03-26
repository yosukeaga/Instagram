//
//  PostData.swift
//  Instagram
//
//  Created by aga yosuke on 2016/03/22.
//  Copyright © 2016年 yosuke.aga. All rights reserved.
//

import UIKit
import Firebase

class PostData: NSObject {
    
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: NSDate?
    var likes: [String] = []
    var isLiked: Bool = false
    
    var name1: [String] = []
    var comment: [String] = []
    
    init(snapshot: FDataSnapshot, myId: String) {
     id = snapshot.key
    
     imageString = snapshot.value.objectForKey("image") as? String
     image = UIImage(data: NSData(base64EncodedString: imageString!, options: .IgnoreUnknownCharacters)!)
    
     name = snapshot.value.objectForKey("name") as? String
     caption = snapshot.value.objectForKey("caption") as? String
        
    
    
     if let likes = snapshot.value.objectForKey("likes") as? [String] {
        self.likes = likes
        
     }
     if let comment = snapshot.value.objectForKey("coment") as? [String] {
        self.comment = comment
     }
     if let name1 = snapshot.value.objectForKey("name1") as? [String] {
        self.name1 = name1     }

    
     for likeId in likes {
         if likeId == myId {
               isLiked = true
                     break
        }
      }
    
    self.date = NSDate(timeIntervalSinceReferenceDate: snapshot.value.objectForKey("time") as! NSTimeInterval)
    }


}
