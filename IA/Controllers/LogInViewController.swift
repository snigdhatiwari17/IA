//
//  LogInViewController.swift
//  IA
//
//  Created by Snigdha Tiwari  on 26/04/23.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        errorLabel.text = ""
    }


    @IBAction func logInPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e)
                    self.errorLabel.text = e.localizedDescription
                    
                } else {
                    self.performSegue(withIdentifier: K.toHomeFromLogInSegue, sender: self)
                }
                
            }
            if email == "admin" {
                self.performSegue(withIdentifier: K.toAdminFromLogInSegue, sender: self)
            }
        }
        
    }
}

