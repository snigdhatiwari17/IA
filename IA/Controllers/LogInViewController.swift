//
//  LogInViewController.swift
//  IA
//
//  Created by Snigdha Tiwari  on 26/04/23.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func logInPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e)
                } else {
                    self.performSegue(withIdentifier: K.toHomeFromLogInSegue, sender: self)
                }
            }
        }
    }
}

