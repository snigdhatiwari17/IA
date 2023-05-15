//
//  DetailViewController.swift
//  IA
//
//  Created by Snigdha Tiwari  on 26/04/23.
//


import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var petNameTextField: UITextField!
    
    @IBOutlet weak var microchipIDTextField: UITextField!
    
    var clients: Results<PetOwner>?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func signInPressed(_ sender: Any) {
        
        do {
            try self.realm.write {
                let newOwner = PetOwner()
                newOwner.name = "\(firstNameTextField.text) \(lastNameTextField.text)"
                newOwner.phone = phoneNumberTextField.text ?? "Not Provided"
                newOwner.address = ""
                newOwner.petType = ""
                newOwner.petName = petNameTextField.text ?? "Not Provided"
                newOwner.dateCreated = Date()
                
                
            }
        } catch {
            print("Error saving new items, \(error)")
        }
        
    }
    
    
    
}

