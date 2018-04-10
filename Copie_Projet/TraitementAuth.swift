//
//  TraitementAuth.swift
//  Project_IOS
//
//  Created by pascal launay on 18/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit

protocol DBAuth
{
    func dataLoadedUser(datas : User?)
}

class TraitementAuth: NSObject {
    
    var delegateUser : DBAuth? = nil
    var monUser = User()
    
    
    func loadUser(monlogin: String)
    {
      
        let escapedString = monlogin.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        let urltest = "\(escapedString!)"
        
        
        let monurl = "http://www.my-event-manager.com/golf/api/app.php/utilisateur/\(urltest)"
        print(monurl)
        
        if let url = URL(string : monurl)
        {
            URLSession.shared.dataTask(with : url)
            { (data, response, error) in
                
                guard let data = data , error == nil else
                {
                    print("Error")
                    return
                }
                
                
                do
                {
                    let root = try JSONSerialization.jsonObject(with: data,options : JSONSerialization.ReadingOptions.allowFragments)
                    //try JSONSerialization.jsonObject(with: data,options :JSONSerialization.ReadingOptions.allowFragments)
                    
                    
                    
                    if let mesvaleurs = root as? [[String : Any]]
                    {
                        for valeur in mesvaleurs
                        {
                        
                        if let login = valeur["login"] as? String
                        {
                            self.monUser.login = login
                        }
                        
                        if let email = valeur["email"] as? String
                        {
                            self.monUser.email = email
                        }
                        
                        if let mot_de_passe = valeur["mot_de_passe"] as? String
                        {
                            self.monUser.mot_de_passe = mot_de_passe
                        }
                        
                        if let classement = valeur["classement"] as? Double
                        {
                            self.monUser.classement = classement
                        }
                        
                        if let id_utilisateur = valeur["id"] as? Int
                        {
                           self.monUser.id_utilisateur = id_utilisateur
                        }
                            
                    }
                        
                    
                    }
                    
                    DispatchQueue.main.async
                        {
                            self.delegateUser!.dataLoadedUser(datas: self.monUser)
                    }
                    
                    
                }
                catch let error as NSError {
                    print("Details of JSON parsing error:\n \(error)")
                }
                
                
                
                
                }.resume()
        }
        else
        {
            // Handle URL error
        }
        
    }
 

}
