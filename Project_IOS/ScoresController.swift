//
//  ScoresController.swift
//  Project_IOS
//
//  Created by pascal launay on 08/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit
import GoogleMaps

class ScoresController : UIViewController, UICollectionViewDataSource, UITextFieldDelegate, GMSMapViewDelegate, DBTrous, DBScore {
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var InfoDistance: UILabel!
    @IBOutlet var InfoTrou: UILabel!
    @IBOutlet var InfoParcours: UILabel!
    @IBOutlet var InfoJoueur: UILabel!
    @IBOutlet var grass: UIImageView!
    @IBOutlet var flowlayout : UICollectionViewFlowLayout!
    @IBOutlet var spinWheel : UIActivityIndicatorView!
    @IBOutlet var button : UIButton!
    @IBOutlet var error : UILabel!
    
    @IBOutlet weak var mavue : GMSMapView!
    
    
    
   
    var monclubsel = ""
    var monUser : User = User()
    var textfield = ""
    let dbController = Traitement()
    var date = Date()
    var info_list = [0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, "", "", ""] as [Any]
    
    var monscore = Score()

    
    
    fileprivate var textFieldsTexts = [IndexPath:String]()
    
    func dataLoadedTrous(datas: [Score]?)
    {
        ViewController.load()
    }
    
    
    func dataLoadedTrous(datas: [Trous]?)
    {
        collectionView?.reloadData()
    }
    
    func dataLoadedScore(datas: [Score]?) {
       ViewController.load()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let tap = UITapGestureRecognizer(target : self, action : #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        */
        
        
        InfoParcours?.text = monclubsel
        monscore.parcours = monclubsel
        
        InfoJoueur?.text = "\(Singleton.shared.monUser.login) , \(Singleton.shared.monUser.classement)"
        monscore.nom_joueur = Singleton.shared.monUser.login
        
        grass?.image = UIImage(named:"bckscore.jpg")
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.allowsMultipleSelection = true
        
        spinWheel.isHidden = true
        error.isHidden = true
        
        print(Singleton.shared.ParcoursToClub)
       
        
        
        dbController.delegateTrous = self
        dbController.loadTrous(letrou: monclubsel)
        
        dbController.delegateScore = self
        
        mavue.camera = GMSCameraPosition.camera(withLatitude: -33.8683, longitude: 151.2086, zoom: 18)
        mavue.mapType = .satellite
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
    
        return dbController.tabtrous.count * 3
    }
    

    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScoresCell" , for: indexPath) as! ScoresCell
            
        for n in 0..<dbController.tabtrous.count 
        {
            
        if(indexPath.row == 3 * n)
        {

            cell.TextScore.isHidden = true
            cell.displaytext(title: "\(dbController.tabtrous[n].numero_trou)")
        }
            
        if (indexPath.row == 1 + 3 * n)
        {
        cell.TextScore.isHidden = true
        cell.displaytext(title:"Par \(dbController.tabtrous[n].par)")
            
        }
        if (indexPath.row == 2 + 3 * n)
        {
        cell.TextScore.isHidden = false
        cell.TextScore.placeholder = "\(n+1)"
        cell.delegate = self
        }
     
        }
        return cell
        }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        error.isHidden = true
        for n in 0..<dbController.tabtrous.count
        {
        if(indexPath.item == 3 * n)
        {
        self.InfoTrou?.text = "Trou n°\(dbController.tabtrous[n].numero_trou)"
        self.InfoDistance?.text = "\(dbController.tabtrous[n].distance) m"
        //self.InfoSup?.text = "Coordonnées : \(dbController.tabtrous[n].origine) , \(dbController.tabtrous[n].arrivee)"
            
        //var location = GMSCameraPosition.camera(withLatitude: -30.8683, longitude: 129.2086, zoom: 18)
        //mavue.animate(to: location)
        mavue.camera = GMSCameraPosition.camera(withLatitude: dbController.tabtrous[n].lattitude, longitude: dbController.tabtrous[n].longitude, zoom: 18)
            
        }
        }
    }
    
  
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    
 
    func validInfo() -> Bool
    {
        //view.endEditing(true)
        spinWheel.isHidden = false
        spinWheel.startAnimating()
        
       
        for n in 0..<dbController.tabtrous.count
        {
            
            if monscore.score[n] > 0 && monscore.score[n] < 9
            {
             print("ok")
            }
            else
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1)
                {
                    self.spinWheel.stopAnimating()
                }
                
            error.isHidden = false
            spinWheel.isHidden = true
            return false
                
            }
            
            
        }
       
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
            {
                self.spinWheel.stopAnimating()
                
                let date = Date()
                let calendar = Calendar.current
                let jour = calendar.component(.day, from: date)
                let month = calendar.component(.month, from: date)
                let year = calendar.component(.year, from: date)
                let info = "\(year)-\(month)-\(jour)"
                
                self.info_list[0] = self.monscore.score[0]
                self.info_list[1] = self.monscore.score[1]
                self.info_list[2] = self.monscore.score[2]
                self.info_list[3] = self.monscore.score[3]
                self.info_list[4] = self.monscore.score[4]
                self.info_list[5] = self.monscore.score[5]
                self.info_list[6] = self.monscore.score[6]
                self.info_list[7] = self.monscore.score[7]
                self.info_list[8] = self.monscore.score[8]
                self.info_list[9] = self.monscore.score[9]
                self.info_list[10] = self.monscore.score[10]
                self.info_list[11] = self.monscore.score[11]
                self.info_list[12] = self.monscore.score[12]
                self.info_list[13] = self.monscore.score[13]
                self.info_list[14] = self.monscore.score[14]
                self.info_list[15] = self.monscore.score[15]
                self.info_list[16] = self.monscore.score[16]
                self.info_list[17] = self.monscore.score[17]
                self.info_list[18] = info
                self.info_list[19] = Singleton.shared.monUser.login
                self.info_list[20] = self.monscore.parcours
                
                print("Voici \(self.info_list)")
                
                self.dbController.PostScores(tab: self.info_list)
                
            }
           spinWheel.isHidden = true
            return true
        
    }
    

  
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if sender is ScoresController && validInfo() == true
        {
         //self.performSegue(withIdentifier: "score", sender: self)
        }
    }
    */
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        return validInfo()
        
    }
    

    
    

 

}

extension ScoresController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! ScoresCell
        cell.TextScore.text = textFieldsTexts[indexPath]
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension ScoresController: CellDelegate {
    
    func collectionViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: ScoresCell) {
        if let indexPath = collectionView.indexPath(for: cell), let text = textField.text {
            textFieldsTexts[indexPath] = text
            
            for n in 0..<dbController.tabtrous.count
            {
                if indexPath.row == 2 + n * 3
                {
                    if let variable:Int = Int(cell.TextScore.text!)
                    {
                    monscore.score[n] = variable
                    }
                }
            }
            
            
        }
    }
    
    func collectionViewCell(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, delegatedFrom cell: ScoresCell)  -> Bool {
        print("\(String(describing: collectionView.indexPath(for: cell)))")
        return true
}

}
