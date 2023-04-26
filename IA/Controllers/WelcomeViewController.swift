//
//  ViewController.swift
//  IA
//
//  Created by Snigdha Tiwari  on 25/04/23.
//

import UIKit

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        titleLabel.text = K.appName
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerPressed(_ sender: Any) {
        self.performSegue(withIdentifier: K.toRegisterSegue, sender: self)
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        self.performSegue(withIdentifier: K.toLogInSegue, sender: self)
    }
}

