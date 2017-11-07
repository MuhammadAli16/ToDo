//
//  ToDoTableViewCell.swift
//  ToDos
//
//  Created by Muhammad Ali on 14/03/2017.
//  Copyright © 2017 Muhammad Ali. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
