//
//  SampleCellTableViewCell.swift
//  MLTemp2
//
//  Created by CHONG LIU on 31/1/19.
//  Copyright © 2019 CHONG LIU. All rights reserved.
//


//  SampleCell used by tableview

import UIKit

class SampleCellTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
