//
//  ListeGolfController.swift
//  Project_IOS
//
//  Created by pascal launay on 08/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit
import GoogleMaps


class ListeGolfController: UITableViewController, DBClub, DBParcours, GMSMapViewDelegate {
    
    
    var text = ""
    var counter = 0
    
    var monparcours = Parcours()
    var parcourtest = Parcours()
    
    
    let dbController = Traitement()
    
    
    func dataLoaded(datas : [GolfModel]?)
    {
        tableView.reloadData()//recharger l'interface graphique
    }
    
    func dataLoadedParcours(datas: [Parcours]?)
    {
        tableView.reloadData()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 250
        
        dbController.delegateCLub = self
        dbController.delegateParcours = self
        
        dbController.loadClub()
        dbController.loadParcours()
        
      
        
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dbController.tabgolfmodel.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

          for valeur2 in dbController.tabparcours
          {
            
           if dbController.tabgolfmodel[section].nom_club == valeur2.nom_club
           {
            counter += 1
           }
          }
        
        if(counter == 3)
        {
        counter = 0
        return 3
        }else if(counter == 2)
        {
        counter = 0
        return 2
        }else if (counter == 1)
        {
        counter = 0
        return 1
        }else
        {
        return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let currentCell = tableView.cellForRow(at: indexPath) as! ListeGolfCell
        text = currentCell.MonParcours.text!

        self.performSegue(withIdentifier: "row", sender: self)
        
    }
    


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "MaCellule", for: indexPath) as! ListeGolfCell
        cell.ImageBckCell.image = UIImage(named:"divcard.jpg")
        
        for valeur in dbController.tabparcours
        {
           
            if dbController.tabgolfmodel[indexPath.section].nom_club == valeur.nom_club
            {
                if dbController.tabgolfmodel[indexPath.section].nom_club == valeur.nom_parcours
                {
                    cell.MonParcours?.text = valeur.nom_parcours
                    cell.MonNbrTrou?.text = "\(valeur.nbr_trous) trous"
                    Singleton.shared.ParcoursToClub.append(["\(valeur.nom_parcours)":"\(valeur.nom_club)"])
                }else
                {
                    
                    if(indexPath.row == 0)
                    {
                        parcourtest = valeur
                        cell.MonParcours?.text = valeur.nom_parcours
                        cell.MonNbrTrou?.text = "\(valeur.nbr_trous) trous"
                        Singleton.shared.ParcoursToClub.append(["\(valeur.nom_parcours)":"\(valeur.nom_club)"])
                    }
                    if(indexPath.row == 1)
                    {
                        if(valeur.nom_parcours != parcourtest.nom_parcours)
                        {
                        cell.MonParcours?.text = valeur.nom_parcours
                        cell.MonNbrTrou?.text = "\(valeur.nbr_trous) trous"
                        
                        
                        }
                    }
                    
                }
               
                
            }
        }
     
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return dbController.tabgolfmodel[section].nom_club.uppercased() 
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        headerView.backgroundColor = UIColor(red: 0/255, green: 144/255, blue: 81/255, alpha: 1)
        
        let headerLabel = UILabel(frame: CGRect(x: 15, y: 15, width:
            180, height: 30))
        
        let headeradresse = UILabel(frame: CGRect(x: 15, y: 40, width:
            170, height: 30))
        
        let headeradresse2 = UILabel(frame: CGRect(x: 15, y: 55, width:
            170, height: 30))
        
        let headeradresse3 = UILabel(frame: CGRect(x: 15, y: 70, width:
            170, height: 30))
        
        
        
        let camera = GMSCameraPosition.camera(withLatitude: dbController.tabgolfmodel[section].lattitude,
                                              longitude: dbController.tabgolfmodel[section].longitude,
                                              zoom: 18 , bearing: 0, viewingAngle: 35)
        
        var mapView = GMSMapView.map(withFrame: CGRect(x: 200, y: 10, width:
            160 , height: 100), camera: camera)
        mapView.mapType = .satellite
       
        headerLabel.font = UIFont(name: "Verdana", size: 13)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        
        let adresses = dbController.tabgolfmodel[section].adresse
        let fulladresses = adresses.components(separatedBy: ",")
        
        headeradresse.font = UIFont(name: "Verdana", size: 12)
        headeradresse.textColor = UIColor.white
        headeradresse.text = fulladresses[0];
        
        headeradresse2.font = UIFont(name: "Verdana", size: 12)
        headeradresse2.textColor = UIColor.white
        headeradresse2.text = fulladresses[1]
        
        headeradresse3.font = UIFont(name: "Verdana", size: 12)
        headeradresse3.textColor = UIColor.white
        if fulladresses.count > 2 {
        headeradresse3.text = fulladresses[2]
        }else
        {
        headeradresse3.text = ""
        }
       
        
        headerLabel.sizeToFit()
        headeradresse.sizeToFit()
        
        headerView.addSubview(headerLabel)
        headerView.addSubview(headeradresse)
        headerView.addSubview(headeradresse2)
        headerView.addSubview(headeradresse3)
        
        headerView.addSubview(mapView)
        headerView.isUserInteractionEnabled = false

        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
       if sender is ListeGolfController
       {
       if let destinationVC = segue.destination as? ScoresController
       {
                destinationVC.monclubsel = text
       }
    }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if sender is ListeGolfController
        {
            return true
        }
        
        return false
    }
    

}
