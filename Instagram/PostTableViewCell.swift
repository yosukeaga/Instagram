//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by aga yosuke on 2016/03/22.
//  Copyright © 2016年 yosuke.aga. All rights reserved.
//

import UIKit


class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var commentButton: UIButton!
   
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var postData: PostData?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        
         //postData!等の！の意味が分からない
        
        commentLabel.text = ""
        for var a = 0; a < postData!.comment.count; a++    {
            if a > 0 {
                commentLabel.text = commentLabel.text! + "\n"
            }
            commentLabel.text! = commentLabel.text! + "\(postData!.name1[a]): \(postData!.comment[a])"
        }
        
        
        
        
        postImageView.image = postData!.image
        captionLabel.text = "\(postData!.name!):\(postData!.caption!)"
        
        let likeNumber = postData!.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString: String = formatter.stringFromDate(postData!.date!)
        dateLabel.text = dateString
        
        
        
        
        
        if postData!.isLiked{
        
            let buttonImage = UIImage(named: "like_exist")
            likeButton.setImage(buttonImage, forState: UIControlState.Normal)
        }else{
            let buttonImage = UIImage(named: "like_none")
            likeButton.setImage(buttonImage, forState: UIControlState.Normal)
        }
        
        
        super.layoutSubviews()
    }
    
   
    
}
