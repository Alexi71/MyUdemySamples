//
//  SnapViewController.swift
//  FreakySnap
//
//  Created by Alexander Kotik on 09.08.17.
//  Copyright © 2017 Alexander Kotik. All rights reserved.
//

import UIKit

class SnapViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var imagePicker : UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func openImageTapped(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let gotImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageItem.image = gotImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openCameraTapped(_ sender: UIBarButtonItem) {
        
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
