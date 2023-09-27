//
//  AthletesTableViewCell.swift
//  test
//
//  Created by Logeshwaran  on 26/09/23.
//

import UIKit

class AthletesTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
