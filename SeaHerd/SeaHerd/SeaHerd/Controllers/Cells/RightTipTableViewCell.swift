//
//  RightTipTableViewCell.swift
//  SeaHerd
//
//  Created by Carlo Baruffini on 26/10/2019.
//  Copyright © 2019 spaceapp. All rights reserved.
//

import UIKit

class RightTipTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var tipImage: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
}
