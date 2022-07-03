//
//  equipementTableViewCell.swift
//  beelding
//
//  Created by Zinedine Megnouche on 30/06/2022.
//  Copyright © 2022 Beeldi. All rights reserved.
//

import UIKit

class equipementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var domaineLbl: UILabel!
    
    @IBOutlet weak var equipementImg: UIImageView!
    @IBOutlet weak var nbDefaultLbl: UILabel!
    @IBOutlet weak var equipementView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupV()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupV(){
        equipementImg.layer.cornerRadius = 10
        equipementView.layer.shadowRadius = 5
        equipementView.layer.shadowOpacity = 0.30
        equipementView.layer.cornerRadius = 16
    }
    
}
