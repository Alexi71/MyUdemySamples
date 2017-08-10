//
//  DetailViewController.swift
//  FreakySnap
//
//  Created by Alexander Kotik on 10.08.17.
//  Copyright © 2017 Alexander Kotik. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class DetailViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageItem: UIImageView!
    
    var snapItem :SnapItem = SnapItem()
    var snapId :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(snapItem.from)
        print(snapItem.imageUrl)
        print(snapItem.imageName)
        print(snapItem.message)
        messageLabel.text = snapItem.message
        
        Alamofire.request(snapItem.imageUrl).responseData { (response) in
            debugPrint(response)
            
            print(response.request)
            print(response.response)
            debugPrint(response.result)
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                self.imageItem.image = UIImage(data: image)
            }
        }
        
        
        //imageItem.image = UIImage(
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let uid = Auth.auth().currentUser?.uid {
            Database.database().reference().child("users").child(uid).child("snaps").child(snapItem.key).removeValue()
                Storage.storage().reference().child("images").child(snapItem.imageName).delete(completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
