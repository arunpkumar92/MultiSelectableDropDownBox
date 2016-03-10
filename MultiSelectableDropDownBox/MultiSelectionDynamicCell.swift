//
//  MultiSelectionDynamicCell.swift
//  MultiSelectableDropDownBox
//
//  Created by Arun Kumar.P on 3/10/16.
//  Copyright © 2016 ArunKumar.P. All rights reserved.
//

import UIKit

class MultiSelectionDynamicCell: UITableViewCell {

    @IBOutlet weak var dynamicTitleLabel: UILabel!
    @IBOutlet weak var selectionImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
