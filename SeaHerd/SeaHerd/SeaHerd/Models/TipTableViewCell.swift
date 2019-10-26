//
//  TipTableViewCell.swift
//  SeaHerd
//
//  Created by Giulio Uzzi on 26/10/2019.
//  Copyright © 2019 spaceapp. All rights reserved.
//

import UIKit

class TipTableViewCell: UITableViewCell {

    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var textTip: UILabel!
    @IBOutlet weak var imageTip: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
