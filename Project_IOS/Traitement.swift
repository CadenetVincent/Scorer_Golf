//
//  Traitement.swift
//  Meteo
//
//  Created by pascal launay on 10/02/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit

protocol DBClub
{
    func dataLoaded(datas : [GolfModel]?)
}

protocol  DBParcours
{
    func dataLoadedParcours(datas : [Parcours]?)
}

protocol DBTrous {
    func dataLoadedTrous(datas : [Trous]?)
}

protocol DBScore {
    func dataLoadedScore(datas : [Score]?)
}





class Traitement: NSObject {
    //
    //  ViewController.swift
    //  MeteoIOS
    //
    //  Created by pascal launay on 29/01/2018.
    //  Copyright © 2018 pascal launay. All rights reserved.
    //
    
    var delegateCLub : DBClub? = nil//optionnel si nil on l'envoie
    var delegateParcours : DBParcours? = nil
    var delegateTrous : DBTrous? = nil
    var delegateScore : DBScore? = nil
    
    var tabgolfmodel = [GolfModel]()
    var tabparcours = [Parcours]()
    var tabtrous = [Trous]()
    var tabscores = [Score]()
    
    
    func loadParcours()
    {
        if let url = URL(string : "http://www.my-event-manager.com/golf/api/app.php/parcours")
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
                        for key in mesvaleurs
                        {
                            
                           
                            
                            //{"nom_parcours":"Cl\u00e9ment Ader","nbr_trous":18,"id_parcours":0,"id_trou":67,"nom_club":"Cl\u00e9ment Ader"}
                            
                            var parcours = Parcours()
                            
                            if let nom_parcours =  key["nom_parcours"] as? String
                            {
                                parcours.nom_parcours = nom_parcours
                            }
                            
                            if let nbr_trous =  key["nbr_trous"] as? Int
                            {
                                parcours.nbr_trous = nbr_trous
                            }
                            
                            if let id_trou =  key["id_trou"] as? Int
                            {
                                parcours.id_trou = id_trou
                            }
                            
                            if let id_parcours =  key["id_parcours"] as? Int
                            {
                                parcours.id_parcours = id_parcours
                            }
                            
                            if let nom_club =  key["nom_club"] as? String
                            {
                                parcours.nom_club = nom_club
                            }
                            
                            self.tabparcours.append(parcours)
                            
                        }
                    
                    }
                    DispatchQueue.main.async
                    {
                            self.delegateParcours?.dataLoadedParcours(datas: self.tabparcours)
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
                
                
                
                do
                {
                let root = try JSONSerialization.jsonObject(with: data,options : JSONSerialization.ReadingOptions.allowFragments)
                    //try JSONSerialization.jsonObject(with: data,options :JSONSerialization.ReadingOptions.allowFragments)
                    
                    
                
                    if let mesvaleurs = root as? [[String : Any]]
                    {
                  
                        
                    
                    for key in mesvaleurs
                    {
                        
                    
                        
                        var golfmodel = GolfModel()
                        
                            if let nom_club =  key["nom_club"] as? String
                            {
                                golfmodel.nom_club = nom_club
                            }
                            
                            if let adresse =  key["adresse"] as? String
                            {
                                golfmodel.adresse = adresse
                            }
                            
                            if let id_club =  key["id_club"] as? Int
                            {
                                golfmodel.id_club = id_club
                            }
                            
                            if let id_parcours =  key["id_parcours"] as? Int
                            {
                                golfmodel.id_parcours = id_parcours
                            }
                            if let longitude = key["longitude"] as? Double
                            {
                               golfmodel.longitude = longitude
                            }
                            if let lattitude = key["lattitude"] as? Double
                            {
                               golfmodel.lattitude = lattitude
                            }
                        
                        self.tabgolfmodel.append(golfmodel)
                    
                    }
                    }
                    
                    DispatchQueue.main.async
                    {
                            self.delegateCLub!.dataLoaded(datas: self.tabgolfmodel)
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
    
    
    func loadTrous(letrou : String)
    {
        /*
        var letrousep = letrou.components(separatedBy: " ")
        var newtrou = "\(letrousep[0])%20\(letrousep[1])"
        */
        let escapedString = letrou.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        let urltest = "\(escapedString!)"
        
        
        let monurl = "http://www.my-event-manager.com/golf/api/app.php/trous/\(urltest)"
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
                        
                        for key in mesvaleurs
                        {
                            
                            var trousmodel = Trous()
                            
                            if let id_trou = key["id_trou"] as? Int
                            {
                                trousmodel.id_trou = id_trou
                            }
                            
                            if let par = key["par"] as? Int
                            {
                                trousmodel.par = par
                            }
                            
                            if let numero_trou = key["numero_trou"] as? Int
                            {
                                trousmodel.numero_trou = numero_trou
                            }
                            
                            if let distance = key["distance"] as? Int
                            {
                                trousmodel.distance = distance
                            }
                            
                            if let longitude = key["longitude"] as? Double
                            {
                                trousmodel.longitude = longitude
                            }
                            
                            if let lattitude = key["lattitude"] as? Double
                            {
                                trousmodel.lattitude = lattitude
                            }
                            
                            if let nom_parcours = key["nom_parcours"] as? String
                            {
                                trousmodel.nom_parcours = nom_parcours
                            }
                            
                            self.tabtrous.append(trousmodel)
                            
                        }
                    }
                    
                    DispatchQueue.main.async
                    {
                        self.delegateTrous!.dataLoadedTrous(datas: self.tabtrous)
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
    
    func loadAllTrous()
    {

        let monurl = "http://www.my-event-manager.com/golf/api/app.php/trous"
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
                        
                        for key in mesvaleurs
                        {
                            
                            var trousmodel = Trous()
                            
                            if let id_trou = key["id_trou"] as? Int
                            {
                                trousmodel.id_trou = id_trou
                            }
                            
                            if let par = key["par"] as? Int
                            {
                                trousmodel.par = par
                            }
                            
                            if let numero_trou = key["numero_trou"] as? Int
                            {
                                trousmodel.numero_trou = numero_trou
                            }
                            
                            if let distance = key["distance"] as? Int
                            {
                                trousmodel.distance = distance
                            }
                            
                            if let longitude = key["longitude"] as? Double
                            {
                                trousmodel.longitude = longitude
                            }
                            
                            if let lattitude = key["lattitude"] as? Double
                            {
                                trousmodel.lattitude = lattitude
                            }
                            
                            if let nom_parcours = key["nom_parcours"] as? String
                            {
                                trousmodel.nom_parcours = nom_parcours
                            }
                            
                            self.tabtrous.append(trousmodel)
                            
                        }
                    }
                    
                    DispatchQueue.main.async
                        {
                            self.delegateTrous!.dataLoadedTrous(datas: self.tabtrous)
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
    
    func loadUser(leuser: String)
    {
        let escapedString = leuser.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        let urltest = "\(escapedString!)"
        
      
        let monurl = "http://www.my-event-manager.com/golf/api/app.php/scores/\(urltest)"
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
                        
                        for key in mesvaleurs
                        {
                            
                            var scoremodel = Score()
                            
                            if let id_score = key["id_score"] as? Int
                            {
                                scoremodel.id_score = id_score
                            }
                            
                            if let score_1 = key["score_1"] as? Int
                            {
                                scoremodel.score[0] = score_1
                            }
                            
                            if let score_2 = key["score_2"] as? Int
                            {
                                scoremodel.score[1] = score_2
                            }
                            
                            if let score_3 = key["score_3"] as? Int
                            {
                                scoremodel.score[2] = score_3
                            }
                            
                            if let score_4 = key["score_4"] as? Int
                            {
                                scoremodel.score[3] = score_4
                            }
                            
                            if let score_5 = key["score_5"] as? Int
                            {
                                scoremodel.score[4] = score_5
                            }
                            
                            if let score_6 = key["score_6"] as? Int
                            {
                                scoremodel.score[5] = score_6
                            }
                            
                            if let score_7 = key["score_7"] as? Int
                            {
                                scoremodel.score[6] = score_7
                            }
                            
                            if let score_8 = key["score_8"] as? Int
                            {
                                scoremodel.score[7] = score_8
                            }
                            
                            if let score_9 = key["score_9"] as? Int
                            {
                                scoremodel.score[8] = score_9
                            }
                            
                            if let score_10 = key["score_10"] as? Int
                            {
                                scoremodel.score[9] = score_10
                            }
                            
                            if let score_11 = key["score_11"] as? Int
                            {
                                scoremodel.score[10] = score_11
                            }
                            
                            if let score_12 = key["score_12"] as? Int
                            {
                                scoremodel.score[11] = score_12
                            }
                            
                            if let score_13 = key["score_13"] as? Int
                            {
                                scoremodel.score[12] = score_13
                            }
                            
                            if let score_14 = key["score_14"] as? Int
                            {
                                scoremodel.score[13] = score_14
                            }
                            
                            if let score_15 = key["score_15"] as? Int
                            {
                                scoremodel.score[14] = score_15
                            }
                            
                            if let score_16 = key["score_16"] as? Int
                            {
                                scoremodel.score[15] = score_16
                            }
                            
                            if let score_17 = key["score_17"] as? Int
                            {
                                scoremodel.score[16] = score_17
                            }
                            
                            if let score_18 = key["score_18"] as? Int
                            {
                                scoremodel.score[17] = score_18
                            }
                            
                            if let score_1 = key["score_1"] as? Int
                            {
                                scoremodel.score[0] = score_1
                            }
                            
                            if let score_1 = key["score_1"] as? Int
                            {
                                scoremodel.score[0] = score_1
                            }
                            
                            if let score_1 = key["score_1"] as? Int
                            {
                                scoremodel.score[0] = score_1
                            }
                            
                            if let score_1 = key["score_1"] as? Int
                            {
                                scoremodel.score[0] = score_1
                            }
                            
                            if let score_1 = key["score_1"] as? Int
                            {
                                scoremodel.score[0] = score_1
                            }
                            
                            if let date_de_jeu = key["date_de_jeu"] as? String
                            {
                                scoremodel.date_de_jeu = date_de_jeu
                            }
                            
                            if let nom_joueur = key["nom_joueur"] as? String
                            {
                                scoremodel.nom_joueur = nom_joueur
                            }
                            
                            if let parcours = key["parcours"] as? String
                            {
                                scoremodel.parcours = parcours
                            }
                            
                            
                            
                            
                            self.tabscores.append(scoremodel)
                            
                        }
                    }
                    
                    DispatchQueue.main.async
                        {
                            self.delegateScore!.dataLoadedScore(datas: self.tabscores)
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
    
    func PostScores(tab : [Any])
    {
     
        let bodyData = "score_1=\(tab[0])&score_2=\(tab[1])&score_3=\(tab[2])&score_4=\(tab[3])&score_5=\(tab[4])&score_6=\(tab[5])&score_7=\(tab[6])&score_8=\(tab[7])&score_9=\(tab[8])&score_10=\(tab[9])&score_11=\(tab[10])&score_12=\(tab[11])&score_13=\(tab[12])&score_14=\(tab[13])&score_15=\(tab[14])&score_16=\(tab[15])&score_17=\(tab[16])&score_18=\(tab[17])&date_de_jeu=\(tab[18])&nom_joueur=\(tab[19])&parcours=\(tab[20])"
        
        let url = "http://www.my-event-manager.com/golf/api/app.php/scores/new"
        
        let request = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        
        let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) {data, response, error in
            if (error != nil) {
                print(error!.localizedDescription) // On indique dans la console ou est le problème dans la requête
            }
            if let httpStatus = response as? HTTPURLResponse , httpStatus.statusCode != 200 {
                print("statusCode devrait être de 200, mais il est de \(httpStatus.statusCode)")
                print("réponse = \(response)") // On affiche dans la console si le serveur ne nous renvoit pas un code de 200 qui est le code normal
            }
            
            let responseAPI = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseAPI)") // Affiche dans la console la réponse de l'API
            
            if error == nil
            {
               
            }
        }
        requestAPI.resume()
    
}
    
    
    func load() -> Bool
    {
        print("load")
        
        return false
    }
    }


