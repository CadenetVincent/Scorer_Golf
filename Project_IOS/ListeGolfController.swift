//
//  ListeGolfController.swift
//  Project_IOS
//
//  Created by pascal launay on 08/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit


class ListeGolfController: UITableViewController {
    
    
    
    var text = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 250
        
    

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
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 2 {
            return 2
        }else
        {
           return 1
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
        if(indexPath.section == 0)
        {
        cell.MonParcours?.text = "Clément Ader"
        cell.MonNbrTrou?.text = "18 trous"
        }else if(indexPath.section == 1){
        cell.MonParcours?.text = "Guerville"
        cell.MonNbrTrou?.text = "18 trous"
        }else
        {
        if(indexPath.row == 0)
        {
        cell.MonParcours?.text = "Les Etangs"
        cell.MonNbrTrou?.text = "18 trous"
        }
        if(indexPath.row == 1)
        {
        cell.MonParcours?.text = "Le Vexin"
        cell.MonNbrTrou?.text = "9 trous"
        }
            
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Clément Ader"
        }
        else if section == 1 {
            return "Guerville"
        }
        else{
            return "Le Golf club d'Ableiges"
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 0.5, green: 0.85, blue: 0.5, alpha: 1.00)
        
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 30, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 25)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
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
                print("Hello"+text)
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
