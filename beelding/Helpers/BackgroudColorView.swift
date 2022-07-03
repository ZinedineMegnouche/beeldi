//
//  BackgroudColorView.swift
//  beelding
//
//  Created by Zinedine Megnouche on 30/06/2022.
//  Copyright © 2022 Beeldi. All rights reserved.
//

import Foundation
import UIKit

class BackgroundColorView: UIView{
    let firstColor = UIColor(red: 255/255, green: 187/255, blue: 0, alpha: 255/255).cgColor
    let secondColor = UIColor(red: 252/255, green: 255/255, blue: 255/255, alpha: 255/255).cgColor
    override open class var layerClass: AnyClass {
    return CAGradientLayer.classForCoder()
 }

 required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
     let gradientLayer = layer as! CAGradientLayer
     gradientLayer.colors = [firstColor, secondColor]
 }
}
