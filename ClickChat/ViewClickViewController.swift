//
//  ViewClickViewController.swift
//  ClickChat
//
//  Created by admin on 12/12/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage
import FirebaseAuth
import FirebaseStorage

class ViewClickViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var clickshot: DataSnapshot?
    
    var imageName = ""
    var clickID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let clickshot = clickshot {
            if let clickDictionary = clickshot.value as? NSDictionary {
                if let imageName = clickDictionary["imageName"] as? String {
                    if let imageURL = clickDictionary["imageURL"] as? String {
                        if let message = clickDictionary["message"] as? String {
                            messageLabel.text = message
                            
                            if let url = URL(string: imageURL) {
                                imageView.sd_setImage(with: url)
                            }
                            
                            self.imageName = imageName
                            
                            clickID = clickshot.key
                        }
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let uid = Auth.auth().currentUser?.uid {
            Database.database().reference().child("users").child(uid).child("snaps").child(clickID).removeValue()
            
            Storage.storage().reference().child("images").child(imageName).delete(completion: nil)
        }
    }
}
