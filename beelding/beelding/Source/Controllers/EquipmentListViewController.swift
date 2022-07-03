//
//  ViewController.swift
//  beelding
//
//  Created by AdrienGreiner on 16/10/2019.
//  Copyright © 2019 Beeldi. All rights reserved.
//

import UIKit

final class EquipmentListViewController: UIViewController,UISearchBarDelegate {
    
    @IBOutlet weak var searchEquipement: UISearchBar!
    var equipements: [Equipement] = []
    var filtredEquipement:[Equipement] = []
    @IBOutlet weak var equipementTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText != ""){
        filtredEquipement = []
            for equipement in equipements {
                if(equipement.name.uppercased().contains(searchText.uppercased()) || equipement.domain.uppercased().contains(searchText.uppercased())){
                    filtredEquipement.append(equipement)
                }
                self.equipementTableView.reloadData()
            }
        }
        else {
            filtredEquipement = equipements
            self.equipementTableView.reloadData()
        }
    }
    func setupVC(){
        equipementTableView.layer.cornerRadius = 16
        searchEquipement.delegate = self
        self.loadData()
        filtredEquipement = equipements
        equipementTableView.delegate = self
        equipementTableView.dataSource = self
        equipementTableView.separatorStyle = .none
        equipementTableView.showsVerticalScrollIndicator = false
        equipementTableView.register(UINib(nibName: "equipementTableViewCell", bundle: nil), forCellReuseIdentifier: "equipementCell")
        equipementTableView.reloadData()
        
        
    }
}

fileprivate extension EquipmentListViewController {
    
    func loadData() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        EquipmentDataFetcher.fetchEquipments { (dict, error) in
            if let dict = dict {
                
                dict.map { (key: Any, value: Any) in
                    let id = key as! String
                    let equipement = value as! NSDictionary
                    let brand = (equipement.value(forKey: "brand") ?? "" )as! String
                    let building = (equipement.value(forKey: "building") ?? "") as! String
                    let domain = (equipement.value(forKey: "domain") ?? "") as! String
                    let local = (equipement.value(forKey: "local") ?? "") as! String
                    let model = (equipement.value(forKey: "model") ?? "") as! String
                    let name = (equipement.value(forKey: "name") ?? "") as! String
                    let nbFault = (equipement.value(forKey: "nbFaults") ?? 0) as! Int
                    let niveau = (equipement.value(forKey:"niveau") ?? "" )as! String
                    let notes = (equipement.value(forKey: "notes") ?? "") as! String
                    let photo = (equipement.value(forKey: "photo")  ?? "" )as! String
                    let serialNumber = (equipement.value(forKey: "serialNumber") ?? "") as! String
                    let status = (equipement.value(forKey: "status") ?? "" )as! String
                    
                    self.equipements.append(Equipement(id: id,brand: brand, building: building, domain: domain, local: local, model: model, name: name, nbFaults: nbFault, niveau: niveau, notes: notes, photo: photo, quantity: 0, serialNumber: serialNumber, status: status))
                }
                DispatchQueue.main.async {
                    self.filtredEquipement = self.equipements
                    self.equipementTableView.reloadData()
                }
                dict.value(forKey: "brand")
            }
            dispatchGroup.leave()
            
        }
        dispatchGroup.enter()
        EquipmentDataFetcher.fetchCheckpoints { (dict, error) in
            if let dict = dict {
                print("Checkpoints: \(dict)")
            }
            dispatchGroup.leave()
        }
        
    }
}
extension EquipmentListViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.filtredEquipement.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = equipementTableView.dequeueReusableCell(withIdentifier: "equipementCell", for: indexPath) as? equipementTableViewCell{
            let equipement = filtredEquipement[indexPath.row]
            
            cell.nameLbl.text = equipement.name
            cell.nbDefaultLbl.text = "\(equipement.nbFaults)"
            cell.domaineLbl.text = equipement.domain
            cell.equipementImg.loadFrom(URLAddress: equipement.photo)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEquipement = filtredEquipement[indexPath.row]
        let nextController = DetailViewController.newInstance(equipement: selectedEquipement)
        self.present(nextController, animated: true)
    }
    
    
}



