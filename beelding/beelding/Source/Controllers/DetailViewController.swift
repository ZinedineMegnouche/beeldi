//
//  DetailViewController.swift
//  beelding
//
//  Created by Zinedine Megnouche on 30/06/2022.
//  Copyright © 2022 Beeldi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedEquipement: Equipement!
    var faultList: [Fault] = []

    @IBOutlet weak var equipementImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var domaineLbl: UILabel!
    @IBOutlet weak var statutLbl: UILabel!
    @IBOutlet weak var niveauLbl: UILabel!
    @IBOutlet weak var buildingLbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var numSerieLbl: UILabel!
    @IBOutlet weak var localLbl: UILabel!
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var defaultTableTiew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setupVC()
    }
    override func viewDidAppear(_ animated: Bool) {
        defaultTableTiew.reloadData()
       // setupVC()
    }
    public class func newInstance(equipement: Equipement) -> DetailViewController{
        let cvc = DetailViewController()
        cvc.selectedEquipement = equipement
        return cvc
    }
    
    func loadData(){
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        EquipmentDataFetcher.fetchCheckpoints { (dict, error) in
            if let dict = dict {
                dict.map { (key: Any, value: Any) in
                    let val = value as! NSDictionary
                    let id = val.value(forKey: "equipmentKey") as! String
                    if(id == self.selectedEquipement.id){
                        let theFault = (val.value(forKey: "fault") ?? "") as! String
                        let nameFault = (val.value(forKey: "name") ?? "") as! String
                        let recom = (val.value(forKey: "recommandation") ?? "") as! String
                        let photo = (val.value(forKey: "photo") ?? "") as! String
                        self.faultList.append(Fault(fault: theFault, name: nameFault, recommandation: recom,photo: photo))
                    }
                }
            }
            dispatchGroup.leave()
        }
    }
    
    func setupVC(){
        defaultTableTiew.layer.cornerRadius = 16
        defaultTableTiew.delegate = self
        defaultTableTiew.delegate = self
        defaultTableTiew.dataSource = self
        defaultTableTiew.separatorStyle = .none
        defaultTableTiew.showsVerticalScrollIndicator = false
        defaultTableTiew.register(UINib(nibName: "defaultTableViewCell", bundle: nil), forCellReuseIdentifier: "defaultCell")
        titlelbl.text = selectedEquipement.name
        domaineLbl.text = selectedEquipement.domain
        equipementImg.loadFrom(URLAddress: selectedEquipement.photo)
        localLbl.text = selectedEquipement.local
        brandLbl.text = selectedEquipement.brand
        numSerieLbl.text = selectedEquipement.serialNumber
        modelLbl.text = selectedEquipement.model
        buildingLbl.text = selectedEquipement.building
        niveauLbl.text = selectedEquipement.niveau
        statutLbl.text = selectedEquipement.status
    }

}
extension DetailViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = defaultTableTiew.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as? defaultTableViewCell{
            let fault = faultList[indexPath.row]
            if (fault.name != ""){
                cell.nameLbl.text = fault.name
            }else{
                cell.nameLbl.text = "SANS NOM"
            }
            cell.recommandationLbl.text = fault.recommandation
            if (fault.fault != ""){
                cell.faultLbl.text = fault.fault
            }else{
                cell.faultLbl.text = "PAS DE NOM "
            }
            if(fault.recommandation == ""){
                cell.isDefaultLbl.isHidden = true
            }else{
                cell.isDefaultLbl.isHidden = false
            }
            cell.isUserInteractionEnabled = false
            return cell
        }
        return UITableViewCell()
    }
}


extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
