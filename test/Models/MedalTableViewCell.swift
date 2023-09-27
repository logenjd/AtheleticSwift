//
//  MedalTableViewCell.swift
//  test
//
//  Created by Logeshwaran  on 27/09/23.
//

import UIKit

class MedalTableViewCell: UITableViewCell {

    @IBOutlet weak var locationLable: UILabel!
    
    @IBOutlet weak var goldView: UIView!
    @IBOutlet weak var silverView: UIView!
    @IBOutlet weak var bronzeViewe: UIView!
    
    @IBOutlet weak var goldLable: UILabel!
    @IBOutlet weak var silverLable: UILabel!
    @IBOutlet weak var bronzeLable: UILabel!
    
    @IBOutlet weak var goldImg: UIImageView!
    @IBOutlet weak var silverImg: UIImageView!
    @IBOutlet weak var bronzeImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(medel:ModelMedalDetails){
        self.locationLable.text = "\u{2022}  \( medel.city ?? "")"
        self.goldLable.text = "\(medel.gold ?? 0)"
        self.silverLable.text = "\(medel.silver ?? 0)"
        self.bronzeLable.text = "\(medel.bronze ?? 0)"
        
        self.goldView.isHidden = (medel.gold ?? 0) <= 0
        self.silverView.isHidden = (medel.silver ?? 0) <= 0
        self.bronzeViewe.isHidden = (medel.bronze ?? 0) <= 0
        
        let goldImg = UIImage(named: "badge")?.withTintColor(UIColor.yellow, renderingMode: .alwaysTemplate)
        let silverImg = UIImage(named: "badge")?.withTintColor(UIColor.gray, renderingMode: .alwaysTemplate)
        let bronzeImg = UIImage(named: "badge")?.withTintColor(UIColor.cyan, renderingMode: .alwaysTemplate)
        self.goldImg.tintColor = .yellow
        self.silverImg.tintColor = .gray
        self.bronzeImg.tintColor = .cyan
        self.goldImg.image = goldImg
        self.silverImg.image = silverImg
        self.bronzeImg.image = bronzeImg
    }
    
}
