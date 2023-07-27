//
//  WalkLogViewController.swift
//  IA
//
//  Created by Snigdha Tiwari  on 26/07/23.
//

import Foundation
import UIKit

class WalkLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
             tableView.delegate = self
               tableView.dataSource = self
          tableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(Walk.getAllWalks()?.count ?? 0)
        return Walk.getAllWalks()?.count ?? 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WalkLogCell") as? WalkLogCell {
            guard let walk = Walk.getAllWalks()?[indexPath.row] else {
                return WalkLogCell()
            }
            cell.configure(walk: walk)
            return cell
        } else {
            return WalkLogCell()
        }
        
     
    }
    
    
    
}


