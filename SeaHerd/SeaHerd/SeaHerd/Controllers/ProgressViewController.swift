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
        
        self.rewardButton.layer.cornerRadius = 8
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        cell.layer.cornerRadius = 12
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.size.width / 2 - 20), height: (self.collectionView.frame.size.height / 2 - 20))
    }
}
