//
//  GolfModel.swift
//  Project_IOS
//
//  Created by pascal launay on 16/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit

class GolfModel: NSObject
{

var nom_club = ""
var adresse = ""
var id_club = 0
var id_parcours = 0

}

class Parcours : NSObject{
    
var nom_parcours = ""
var nbr_trous = 0
var id_parcours = 0
var id_trou = 0
var nom_club = ""
    
}

class Trous : NSObject {
    
var id_trou = 0
var par = 0
var numero_trou = 0
var distance = 0
var origine = 0
var arrivee = 0
var nom_parcours = ""
    
}
