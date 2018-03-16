//
//  ScoresController.swift
//  Project_IOS
//
//  Created by pascal launay on 08/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit

class ScoresController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var InfoDistance: UILabel!
    @IBOutlet var InfoTrou: UILabel!
    @IBOutlet var InfoParcours: UILabel!
    @IBOutlet var InfoJoueur: UILabel!
    @IBOutlet var grass: UIImageView!
    @IBOutlet var InfoSup: UILabel!
    
    var monclubsel = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        InfoParcours.text = monclubsel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        grass.image = UIImage(named:"greengrass.jpg")
        InfoJoueur?.text = "JoueurName + Index"
    
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 54
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScoresCell" , for: indexPath) as! ScoresCell
            

        for n in 0..<18
        {
            
        if(indexPath.item == 3 * n)
        {

            cell.TextScore.isHidden = true
            cell.displaytext(title: "\(n + 1)")
        }
            
        else if (indexPath.item == 1 + 3 * n)
        {
        cell.TextScore.isHidden = true
        cell.displaytext(title:"Par")
            
        }else if (indexPath.item == 2 + 3 * n)
        {
        cell.TextScore.isHidden = false
        }
        }
        
        return cell
        }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        for n in 0..<18
        {
        if(indexPath.item == 3 * n)
        {
        self.InfoTrou?.text = "InfoTrou \(n + 1)"
        self.InfoDistance?.text = "InfoDistance \(n + 1)"
        self.InfoSup?.text = "InfoSup \(n + 1)"
        }
        }
    }
 
    /*
    func selectItem(at indexPath: IndexPath?,
                    animated: Bool,
                    scrollPosition: UICollectionViewScrollPosition)
    {
        TestInfo.text = "okokok"
    }
    */


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
    }
    
    

 

}
