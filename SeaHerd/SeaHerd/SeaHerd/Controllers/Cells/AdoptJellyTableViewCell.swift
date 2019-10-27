//
//  AdoptJellyTableViewCell.swift
//  SeaHerd
//
//  Created by Carlo Baruffini on 26/10/2019.
//  Copyright © 2019 spaceapp. All rights reserved.
//

import UIKit

class AdoptJellyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.adoptButton.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func adoptButtonDidPress(_ sender: Any) {
        // Informs the delegate that a JellyBot has been adopted
    }
    
    @IBOutlet weak var adoptButton: UIButton!
}
