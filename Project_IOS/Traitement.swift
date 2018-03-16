//
//  Traitement.swift
//  Meteo
//
//  Created by pascal launay on 10/02/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit

protocol DBDelegate
{
    func dataLoaded(datas : GolfModel?)
}


class Traitement: NSObject {
    //
    //  ViewController.swift
    //  MeteoIOS
    //
    //  Created by pascal launay on 29/01/2018.
    //  Copyright © 2018 pascal launay. All rights reserved.
    //
    
    var delegate : DBDelegate? = nil//optionnel si nil on l'envoie
    
    var golfmodel = GolfModel()
    
    
    func loadClub()
    {
        
        
        if let url = URL(string : "http://www.my-event-manager.com/golf/api/app.php/clubs")
        {
            URLSession.shared.dataTask(with : url)
            { (data, response, error) in
                
                guard let data = data , error == nil else
                {
                    print("Error")
                    return
                }
                print("ok")
                
                
                
                do
                {
                    let root = try JSONSerialization.jsonObject(with: data,options : JSONSerialization.ReadingOptions.allowFragments)
                    
                    
                    if let mesvaleurs = root as? [String : Any]
                    {
                    
                    for key in mesvaleurs
                    {
                        
                      /*  "nom_club": "Cl\u00e9ment Ader",
                        "adresse": "7 Avenue Charles de Gaulle, 77220 Gretz-Armainvilliers",
                        "id_club": 0,
                        "id_parcours": 0 */
                        
                        if let mavaleur = mesvaleurs[""] as? String
                        {
                            
                        }
                            
                    
                    
                        
                    
                    }
                    }
                    
                    
                    
                }
                catch
                {
                    
                }
                
                
                }.resume()
        }
        else
        {
            // Handle URL error
        }
        
    }
    
    
    func load() -> Bool
    {
        print("load")
        
        return false
    }
    
}






