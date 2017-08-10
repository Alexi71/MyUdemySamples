//
//  AuthViewController.swift
//  FreakySnap
//
//  Created by Alexander Kotik on 09.08.17.
//  Copyright © 2017 Alexander Kotik. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var loginMode = true
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func topTapped(_ sender: UIButton) {
        if loginMode {
            if let email  = emailTextField.text {
                if let password = passwordtextField.text {
                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print (error?.localizedDescription ?? "undefined error")
                        }
                        else {
                            if let user = user {
                                if let email = user.email {
                                    print ("Sign in was sucessfully: user \(email)")
                                }
                                
                            }
                            self.performSegue(withIdentifier: "AuthToSnaps", sender: nil)
                        }
                        
                    })
                }
            }
        }
        else {
            if let email  = emailTextField.text {
                if let password = passwordtextField.text {
                    Auth.auth().createUser(withEmail: email, password: password, completion: {(user,error) in
                        if error != nil {
                            print (error?.localizedDescription ?? "undefined error")
                        }
                        else {
                            if let user = user {
                                if let email = user.email {
                                    print ("registratin was sucessfully: user \(email)")
                                    Database.database().reference().child("users").child(user.uid).child("email").setValue(email)
                                }
                            }
                            self.performSegue(withIdentifier: "AuthToSnaps", sender: nil)
                        }
                        
                    })
                }
            }
        }
        
    }
    
    
    @IBAction func bottomTapped(_ sender: UIButton) {
        if loginMode {
            topButton.setTitle("Register", for: .normal)
            topButton.backgroundColor = UIColor(displayP3Red: 139.0/255.0, green: 3.0/255.0, blue: 63.0/255.0, alpha: 1)
            bottomButton.setTitle("Switch to Login", for: .normal)
             bottomButton.setTitleColor(UIColor(displayP3Red: 139.0/255.0, green: 3.0/255.0, blue: 63.0/255.0, alpha: 1), for: .normal)
            loginMode = false
        }
        else {
             topButton.backgroundColor = UIColor(displayP3Red: 162.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 1)
            topButton.setTitle("Login", for: .normal)
            bottomButton.setTitle("Switch to Register", for: .normal)
             bottomButton.setTitleColor(UIColor(displayP3Red: 162.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 1), for: .normal)
            loginMode = true
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
