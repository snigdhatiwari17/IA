//
//  MedicineEditViewController.swift
//  IA
//
//  Created by Snigdha Tiwari  on 18/05/23.
//

import UIKit
import RealmSwift

class MedicineEditViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var medicines: Results<Medicines>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return medicines?.count ?? 1
        // nil coalescing operator
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineCell", for: indexPath)
        
        cell.textLabel?.text = medicines?[indexPath.row].commonName ?? "No categories added yet"
        
        return cell
        
    }
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(medicine: Medicines) {
        do {
            try realm.write {
                if let safeMedicines = medicines {
                    realm.add(safeMedicines)
                }
                
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {
         medicines = realm.objects(Medicines.self)
        tableView.reloadData()
    }
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Medicine", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newMedicine = Medicines()
            newMedicine.commonName = textField.text!
            newMedicine.medicineName = textField.text!
            newMedicine.petSpecies = textField.text!
            
            self.save(medicine: newMedicine)
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new medicine"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    

    
    
    
    
}
