//
//  ProgressViewController.swift
//  SeaHerd
//
//  Created by Pasquale Vittoriosi on 26/10/2019.
//  Copyright © 2019 spaceapp. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sinceLabel: UILabel!
    @IBOutlet weak var rewardButton: UIButton!
    @IBOutlet weak var barProgressView: UIProgressView!
    @IBOutlet weak var rewardLabel: UILabel!
    
    private var items = ["Plastic Bottles","Plastic Bags","Plastic Glasses","Plastic Plates"]
    private var itemsNumber = ["12","40","19","16"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
        //get the date
        let date = Date()
        let formatter = DateFormatter()
        // formatting the date
        formatter.dateFormat = "dd/MM/yyyy"
        //Get the result string:
        let result = formatter.string(from: date)
        sinceLabel.text = "since \(result)"
        
        rewardButton.layer.cornerRadius = 8
        switch barProgressView.progress {
        case 0..<0.2:
            rewardLabel.text = "Need to clean some more..."
            rewardButton.backgroundColor = UIColor(hexFromString: "#BBBBBB")
            rewardButton.isEnabled = false
        case 0.2..<0.5:
            rewardLabel.text = "Doing great we are near to the half!"
            rewardButton.backgroundColor = UIColor(hexFromString: "#BBBBBB")
            rewardButton.isEnabled = false
        case 0.5..<0.75:
            rewardLabel.text = "Great job, almost there!"
            rewardButton.backgroundColor = UIColor(hexFromString: "#BBBBBB")
            rewardButton.isEnabled = false
        case 0.75..<1.0:
            rewardLabel.text = "Reward almost Unlocked!"
            rewardButton.backgroundColor = UIColor(hexFromString: "#BBBBBB")
            rewardButton.isEnabled = false
        case 1.0:
            rewardLabel.text = "Reward Unlocked!"
            rewardButton.backgroundColor = UIColor(hexFromString: "#003D61")
            rewardButton.isEnabled = true
        default:
            rewardLabel.text = "To unlock the reword adopt a JellyBot!"
            rewardButton.backgroundColor = UIColor(hexFromString: "#BBBBBB")
            rewardButton.isEnabled = false
        }
    }
}

extension ProgressViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCollectionViewCell
        cell.itemLabel.text = items[indexPath.row]
        cell.itemImageView.image = UIImage(named: items[indexPath.row])
        cell.itemNumberLabel.text = itemsNumber[indexPath.row]
        if (indexPath.row == 0) {
            cell.roundCorners(corners: [.topLeft], radius: 8)
        } else if (indexPath.row == 1) {
            cell.roundCorners(corners: [.topRight], radius: 8)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.size.width / 2), height: (self.collectionView.frame.size.height / 2))
    }
}
