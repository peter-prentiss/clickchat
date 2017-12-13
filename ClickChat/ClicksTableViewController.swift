//
//  ClicksTableViewController.swift
//  ClickChat
//
//  Created by admin on 12/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ClicksTableViewController: UITableViewController {
    
    var clicks : [DataSnapshot] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let uid = Auth.auth().currentUser?.uid {
            Database.database().reference().child("users").child(uid).child("snaps").observe(.childAdded) { (snapshot) in
                
                    
                    self.clicks.append(snapshot)
                    self.tableView.reloadData()
                    /*
                 if let clickDictionary = snapshot.value as? NSDictionary {
                    if let from = clickDictionary["from"] as? String {
                        if let imageName = clickDictionary["imageName"] as? String {
                            if let imageURL = clickDictionary["imageURL"] as? String {
                                if let message = clickDictionary["message"] as? String {
                                    
                                }
                            }
                        }
                    }
                 }
                 */
            }
        }
    }

    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func plusTapped(_ sender: Any) {
    }
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clicks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier2", for: indexPath)

        let click = clicks[indexPath.row]
        
        if let clickDictionary = click.value as? NSDictionary {
            if let from = clickDictionary["from"] as? String {
                cell.textLabel?.text = from
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "clicksToView", sender: nil)
    }
}
