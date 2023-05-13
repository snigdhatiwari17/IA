//
//  EMRViewController.swift
//  IA
//
//  Created by Snigdha Tiwari  on 27/04/23.
//

import UIKit

class EMRViewController: UITableViewController {
    
    
    
    let petDetailTitles = ["Height","Width","Age", "Weight", "Current Prescriptions", "Treatment History", "Visit logs"]
    

    let petDetails = [ "200cm","500cm","7 years","30 Kg"]
    
    override func viewDidLoad() {
        

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.largeContentTitle = "pet name"
    }
    
    
        // MARK: - Table View Data Source Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petDetailTitles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.resusableEMRcell, for: indexPath)
        
        cell.textLabel?.text = String(petDetailTitles[indexPath.row])
        cell.textLabel?.font = .boldSystemFont(ofSize: 17)
        
        
        if  indexPath.row <= 3 {
            cell.accessoryView?.isHidden = true
            cell.detailTextLabel?.text = String(petDetails[indexPath.row])
        }
        return cell
    }
}
