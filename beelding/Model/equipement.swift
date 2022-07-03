//
//  equipement.swift
//  beelding
//
//  Created by Zinedine Megnouche on 29/06/2022.
//  Copyright © 2022 Beeldi. All rights reserved.
//

import Foundation
import UIKit

struct Equipement :Codable{
    var id:String
    var brand:String
    var building:String
    var domain:String
    var local : String
    var model: String
    var name: String
    var nbFaults:Int
    var niveau: String
    var notes:String
    var photo:String
    var quantity: Int
    var serialNumber:String
    var status:String
    
    init(id:String,brand:String,building:String,domain:String,local : String,model: String,name: String,nbFaults:Int,niveau: String,notes:String,photo:String,quantity: Int,serialNumber:String,status:String){
        self.id = id
        self.brand = brand
        self.building = building
        self.domain = domain
        self.local = local
        self.model = model
        self.name = name
        self.nbFaults = nbFaults
        self.niveau = niveau
        self.notes = notes
        self.photo = photo
        self.quantity = quantity
        self.serialNumber = serialNumber
        self.status = status
    }
    
}

