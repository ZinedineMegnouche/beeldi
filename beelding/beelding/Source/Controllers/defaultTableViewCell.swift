//
//  defaultTableViewCell.swift
//  beelding
//
//  Created by Zinedine Megnouche on 03/07/2022.
//  Copyright © 2022 Beeldi. All rights reserved.
//

import UIKit

class defaultTableViewCell: UITableViewCell {

    @IBOutlet weak var defaultImg: UIImageView!
    @IBOutlet weak var faultLbl: UILabel!
    
    @IBOutlet weak var isDefaultLbl: UILabel!
    @IBOutlet weak var defaultView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var recommandationLbl: UILabel!
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
        defaultImg.layer.cornerRadius = 10
        defaultView.layer.shadowRadius = 5
        defaultView.layer.shadowOpacity = 0.30
        defaultView.layer.cornerRadius = 16
    }
    
}
