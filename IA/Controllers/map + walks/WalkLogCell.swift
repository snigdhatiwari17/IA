//
//  WalkLogCell.swift
//  IA
//
//  Created by Snigdha Tiwari  on 26/07/23.
//

import UIKit

class WalkLogCell: UITableViewCell {
    
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var dateCell: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(walk: Walk){
        
        durationLabel.text = walk.duration.formatTimeDurationToString()
        distanceLabel.text = "Distance: \(String(format: "%.2f", walk.distance))m"
        dateCell.text = walk.date.getDateString()
        
    }
    
}
