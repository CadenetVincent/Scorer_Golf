//
//  Scorebook.swift
//  Project_IOS
//
//  Created by pascal launay on 08/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import Foundation

struct Scorebook {
    
    let score : Int
    let par : Int
    let name : String
    let distance : Int
    
    init(dictionnary : ScoreBookJSON) {
        self.name = dictionnary["name"] as! String
        self.par = dictionnary["par"] as! Int
        self.score = dictionnary["score"] as! Int
        self.distance = dictionnary["distance"] as! Int
    }
    
}
