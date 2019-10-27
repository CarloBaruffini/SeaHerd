//
//  JellyActionTableViewCell.swift
//  SeaHerd
//
//  Created by Carlo Baruffini on 26/10/2019.
//  Copyright © 2019 spaceapp. All rights reserved.
//

import UIKit
import CoreLocation

class JellyActionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var jellyImageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
}
