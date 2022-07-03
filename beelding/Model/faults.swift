//
//  faults.swift
//  beelding
//
//  Created by Zinedine Megnouche on 30/06/2022.
//  Copyright © 2022 Beeldi. All rights reserved.
//

import Foundation
import UIKit

struct Fault{
    var fault:String
    var name: String
    var recommandation: String
    var photo: String
    
    init(fault:String,name:String,recommandation:String,photo:String){
        self.fault = fault
        self.name = name
        self.recommandation = recommandation
        self.photo = photo
    }
}
