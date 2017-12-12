//
//  AddImageViewController.swift
//  ClickChat
//
//  Created by admin on 12/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import FirebaseStorage

class AddImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
    }

    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        } else {
            print("Found nil object")
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        let imageFolder = Storage.storage().reference().child("images")
        
        if let image = imageView.image {
            if let imageData = UIImageJPEGRepresentation(image, 0.1) {
                imageFolder.child("myPic.jpeg").putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("Upload Complete")
                        self.performSegue(withIdentifier: "addImageToSelectUser", sender: nil)
                    }
                })
            }
        }
    }
}
