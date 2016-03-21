//
//  PostViewController.swift
//  Instagram
//
//  Created by aga yosuke on 2016/03/15.
//  Copyright © 2016年 yosuke.aga. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    var image: UIImage!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func handlePostButton(sender: UIButton) {
    }
    
    @IBAction func handleCancelButton(sender: AnyObject) {
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
