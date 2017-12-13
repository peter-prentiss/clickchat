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
    
    var imageName = "\(NSUUID().uuidString).jpeg"
    var imageURL = ""
    
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
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = selectedImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        let imageFolder = Storage.storage().reference().child("images")
        
        if let image = imageView.image {
            if let imageData = UIImageJPEGRepresentation(image, 0.1) {
                imageFolder.child(imageName).putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if let error = error {
                        print(error)
                    } else {
                        if let imageURL = metadata?.downloadURL()?.absoluteString {
                            self.imageURL = imageURL
                            self.performSegue(withIdentifier: "addImageToSelectUser", sender: nil)
                        }
                        
                    }
                })
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectTVC = segue.destination as? SelectUserTableViewController {
            selectTVC.imageURL = imageURL
            selectTVC.imageName = imageName
            if let message = descriptionTextField.text {
                selectTVC.message = message
            }
            
        }
    }
}
