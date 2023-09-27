//
//  AthletesCollectionViewCell.swift
//  test
//
//  Created by Logeshwaran  on 25/09/23.
//

import UIKit
import SDWebImage
class AthletesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLable: UILabel!
    
    override func prepareForReuse() {
        // invoke superclass implementation
        super.prepareForReuse()
        self.userNameLable.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        self.userNameLable.textColor = .white
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    func setCell(data:ModelAthlete?){
        if let d = data{
            let imgUrl = NetworkManager.shared.k_BaseURL + NetworkManager.shared.k_Photo.replacingOccurrences(of: "{id}", with: d.athlete_id ?? "")
            self.userImageView.contentMode = .scaleAspectFill
            self.userImageView.sd_setImage(with: URL(string:imgUrl), placeholderImage: UIImage(named: "placeholder"))
            self.userNameLable.text = d.name ?? ""
        }
        
    }

}
