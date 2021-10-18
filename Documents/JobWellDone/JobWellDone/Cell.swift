//
//  Cell.swift
//  JobWellDone
//
//  Created by Radhika Chilukuri on 18/10/21.
//

import UIKit

class Cell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        designCell()
    }
    
    var cell = Cell()
    
    func designCell() {
        cell.backgroundColor = .orange
        cell.textLabel?.textColor = .black
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
