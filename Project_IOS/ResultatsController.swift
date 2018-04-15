//
//  ResultatsController.swift
//  Project_IOS
//
//  Created by pascal launay on 11/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps



class ResultatsController: UIViewController, DBClub, DBParcours, GMSMapViewDelegate, DBScore, DBTrous, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UIPopoverPresentationControllerDelegate{
 
    

    
    
    
    @IBOutlet var monlabel : UILabel!
    
    @IBOutlet weak var mavue : GMSMapView!
    
    var CollectionView : [UICollectionView] = []
    
    let dbController = Traitement()
    
    var arraymarker = [GMSMarker]()
    
    var ThatScore = [Score]()
    var ThatTrous : [[Trous]] = []

    
    
    func dataLoaded(datas : [GolfModel]?)
    {
        ResultatsController.load()
    }
    
    func dataLoadedParcours(datas: [Parcours]?)
    {
        ResultatsController.load()
    }
    
    func dataLoadedScore(datas: [Score]?) {
        ResultatsController.load()
    }
    
    func dataLoadedTrous(datas: [Trous]?) {
     for valeur in CollectionView
     {
      valeur.reloadData()
     }
    
    }
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbController.delegateCLub = self
        dbController.delegateParcours = self
        dbController.delegateScore = self
        dbController.delegateTrous = self
        
        dbController.loadClub()
        dbController.loadParcours()
        dbController.loadUser(leuser: Singleton.shared.monUser.login)
        dbController.loadAllTrous()
        
        start()
        
        monlabel?.text = "Nom : \(Singleton.shared.monUser.login)  Classement : \(Singleton.shared.monUser.classement)"
        
        mavue.camera = GMSCameraPosition.camera(withLatitude: 46.358940 , longitude: 2.460723, zoom: 5)
        mavue.mapType = .satellite
        mavue.delegate = self
        
  
        
    }
    
   override func viewDidAppear(_ animated: Bool) {

      start()
    
    }
    
    func start()
    {
        arraymarker.removeAll()
        
        for n in 0..<dbController.tabgolfmodel.count
        {
            let position = CLLocationCoordinate2D(latitude: dbController.tabgolfmodel[n].lattitude, longitude: dbController.tabgolfmodel[n].longitude)
            let marker = GMSMarker(position: position)
            marker.icon = UIImage(named: "tee.png")
            // marker.snippet = "\(monscore.score)"
            marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
            marker.map = mavue
            arraymarker.append(marker)
        }
    }

    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("ok")
        mapView.selectedMarker = marker
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        //print("lol")
          start()
    }

    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        //self.showPopover(base: self.view)
        //self.performSegue(withIdentifier: "popmoi", sender: self)
    
    }
    
    func showPopover(base: UIView)
    {
        /*
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "PopUp") as? PopUp {
            
            let navController = UINavigationController(rootViewController: viewController)
            navController.modalPresentationStyle = .popover
            
            if let pctrl = navController.popoverPresentationController {
                pctrl.delegate = self
                
                pctrl.sourceView = self.view
                pctrl.sourceRect = self.view.bounds
                
                self.present(navController, animated: true, completion: nil)
            }
        }
 */
        
    }
    
    
    /* handles Info Window long press */
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        print("didLongPressInfoWindowOf")
    }
    
    func getTheTrueScore(marker: GMSMarker) -> [String : [Score]]
    {
        var getTabScore = [String : [Score]]()
        var lesScores = [Score]()
        var leclub = String()
        
        
            for monclub in dbController.tabgolfmodel
            {
                for traitement in Singleton.shared.ParcoursToClub
                {
                   for (cle,valeur) in traitement
                   {
                    for monscore in dbController.tabscores
                    {
                        if cle == monscore.parcours
                        {
     
                            if monclub.nom_club == valeur && monclub.lattitude == marker.position.latitude && monclub.longitude == marker.position.longitude
                            {
                                
                                leclub = monclub.nom_club
                                lesScores.append(monscore)
                                
                         
                                print("ON test")
                                print(monscore.score)
                                print(monscore.date_de_jeu)
                                print(monscore.parcours)
                                print(monscore.id_score)
                                print(" ")
                                print(" ")

                         
                                
                                
                            }
                        }
                    }
                }
            }
        }
        
     
        getTabScore = [ leclub : lesScores ]
        
        return getTabScore
    }
    
    /* set a custom Info Window */
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        var view = UIView()
        var view2 = UIView()
        
        var HeightFixe = 50
        
        var Size = 50
       
        let ScoreAffiche = getTheTrueScore(marker: marker)
        //var view = UIView()
        
        for (cle,valeur) in ScoreAffiche
        {
      
     
        for SizeWindow in valeur
        {
            for LesParcours in dbController.tabparcours
            {
                if LesParcours.nom_parcours == SizeWindow.parcours
                {
                    if LesParcours.nbr_trous == 9
                    {
                    Size = Size + 220
                    }else if LesParcours.nbr_trous == 18
                    {
                    Size = Size + 310
                    }
                }
            }
        }

        view = UIView(frame: CGRect.init(x: 0, y: 0, width: 360, height: Size))
        view.backgroundColor = UIColor(red: 0/255, green: 144/255, blue: 81/255, alpha: 0)
        view.layer.cornerRadius = 6
            
        let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.size.width - 16, height: 15))
        lbl1.text = "\(cle)"
        lbl1.textColor = UIColor(red: 0/255, green: 144/255, blue: 81/255, alpha: 1)
        view.addSubview(lbl1)
            
        CollectionView.removeAll()
        ThatScore.removeAll()
        ThatTrous.removeAll()
            
        for ScoreAff in valeur
        {
            let index = valeur.index(of: ScoreAff)!
            var RecupTrous = [Trous]()
            ThatScore.append(ScoreAff)
            
            print(valeur.count)
            
            for LesTrous in dbController.tabtrous
            {
            if ThatScore[index].parcours == LesTrous.nom_parcours
            {
            RecupTrous.append(LesTrous)
            }
            }
            
            ThatTrous.append(RecupTrous)
            RecupTrous.removeAll()
            
            print(index)
            
            if(index != 0)
            {
                if ThatTrous[index-1].count == 9
                {
                    HeightFixe = HeightFixe + 205
                }else
                {
                    HeightFixe = HeightFixe + 295
                }
            }
            
            //let view2 = emergencyInfo.loadViewFromNib() as? emergencyInfo
            //view2?.bounds = CGRect.init(x: 0, y: 0, width: 200, height: 150 * index)
            //view2?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
            //view2?.labelInfo?.text = "\(ScoreAff.parcours)"
            //view.addSubview(view2!)
            
            let lbl2 = UILabel(frame: CGRect.init(x: 6, y:  45, width: Int(view.frame.size.width - 10), height: 15))
            lbl2.text = "Date : \(ScoreAff.date_de_jeu)"
            lbl2.font = UIFont.systemFont(ofSize: 14, weight: .light)
            lbl2.textColor = UIColor.white
            
            let lbl3 = UILabel(frame: CGRect.init(x: 6, y:  65, width: Int(view.frame.size.width - 10), height: 15))
            lbl3.text = "Parcours : \(ScoreAff.parcours)"
            lbl3.font = UIFont.systemFont(ofSize: 14, weight: .light)
            lbl3.textColor = UIColor.white
            
            let lbl4 = UILabel(frame: CGRect.init(x: 6, y:  85, width: Int(view.frame.size.width - 10), height: 15))
            lbl4.text = "Score :"
            lbl4.font = UIFont.systemFont(ofSize: 14, weight: .light)
            lbl4.textColor = UIColor.white
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            
            var collectionView : UICollectionView
            
            
            if ThatTrous[index].count == 18
            {
             view2 = UIView(frame: CGRect.init(x: 4, y: HeightFixe + 15, width: 352, height: 290))
             collectionView = UICollectionView(frame: CGRect.init(x: 6, y:  105, width: 340, height: 180), collectionViewLayout: flowLayout)
            }else
            {
            view2 = UIView(frame: CGRect.init(x: 4, y: HeightFixe + 15 , width: 352, height: 200))
            collectionView = UICollectionView(frame: CGRect.init(x: 6, y:  105, width: 340, height: 90), collectionViewLayout: flowLayout)
            }
            
            view2.backgroundColor = UIColor(red: 0/255, green: 144/255, blue: 81/255, alpha: 1)
            view2.layer.cornerRadius = 10
            
            collectionView.register(ResCell.self, forCellWithReuseIdentifier: "ResCell")
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor.white
            
            CollectionView.append(collectionView)
            
            view2.addSubview(CollectionView[index])
            view2.addSubview(lbl2)
            view2.addSubview(lbl3)
            view2.addSubview(lbl4)

            view.addSubview(view2)
           
        }
            
        }
        
        
        
        return view
    }
    

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
      
        
        if ThatTrous[CollectionView.index(of: collectionView)!].count == 9
        {
        return 30
        }
        else
        {
        return 60
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResCell", for: indexPath as IndexPath) as! ResCell
        cell.backgroundColor = UIColor.white
         
        
        if ThatTrous[CollectionView.index(of: collectionView)!].count == 9
        {
            for n in 0..<ThatTrous[CollectionView.index(of: collectionView)!].count
            {
                if(indexPath.item == n+1)
                {
                    cell.InfoLabel.text = "\(n+1)"
                }
                if(indexPath.item == n+11)
                {
                    cell.InfoLabel.text = "\(ThatTrous[CollectionView.index(of: collectionView)!][n].par)"
                }
                if(indexPath.item == n+21)
                {
                    cell.InfoLabel.text = "\(ThatScore[CollectionView.index(of: collectionView)!].score[n])"
                }
                
            }
            
            if(indexPath.item == 0 || indexPath.item == 30)
            {
                cell.InfoLabel.text = "Trou"
            }
            
            if(indexPath.item == 10 || indexPath.item == 40)
            {
                cell.InfoLabel.text = "Par"
            }
            
            if(indexPath.item == 20 || indexPath.item == 50)
            {
                cell.InfoLabel.text = "Score"
            }
            
        }
        
        if ThatTrous[CollectionView.index(of: collectionView)!].count == 18
        {
            for n in 0..<ThatTrous[CollectionView.index(of: collectionView)!].count-9
            {
                if(indexPath.item == n+1)
                {
                    cell.InfoLabel.text = "\(n+1)"
                }
                if(indexPath.item == n+11)
                {
                    cell.InfoLabel.text = "\(ThatTrous[CollectionView.index(of: collectionView)!][n].par)"
                }
                if(indexPath.item == n+21)
                {
                    cell.InfoLabel.text = "\(ThatScore[CollectionView.index(of: collectionView)!].score[n])"
                }
            }
            for n in 9..<ThatTrous[CollectionView.index(of: collectionView)!].count
            {
                if(indexPath.item == n+22)
                {
                    cell.InfoLabel.text = "\(n+1)"
                }
                if(indexPath.item == n+32)
                {
                    cell.InfoLabel.text = "\(ThatTrous[CollectionView.index(of: collectionView)!][n].par)"
                }
                if(indexPath.item == n+42)
                {
                    cell.InfoLabel.text = "\(ThatScore[CollectionView.index(of: collectionView)!].score[n])"
                }
            }
            
            if(indexPath.item == 0 || indexPath.item == 30)
            {
                cell.InfoLabel.text = "Trou"
            }
            
            if(indexPath.item == 10 || indexPath.item == 40)
            {
                cell.InfoLabel.text = "Par"
            }
            
            if(indexPath.item == 20 || indexPath.item == 50)
            {
                cell.InfoLabel.text = "Score"
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        switch indexPath.item {
        case 0  :
        return CGSize(width: 70, height: 30)

        case 10  :
        return CGSize(width: 70, height: 30)
          
        case 20  :
        return CGSize(width: 70, height: 30)
      
        case 30 :
        return CGSize(width: 70, height: 30)
        
        case 40 :
        return CGSize(width: 70, height: 30)
            
        case 50 :
        return CGSize(width: 70, height: 30)
            
        default:
        return CGSize(width: 30, height: 30)
        }
       
    }
 /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    */
    
  
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    
    class ResCell: UICollectionViewCell
    {
    
        var InfoLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor(red: 0/255, green: 144/255, blue: 81/255, alpha: 1)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addViews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func addViews()
        {
         addSubview(InfoLabel)
         InfoLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
         InfoLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        }
        
    }
    
}


