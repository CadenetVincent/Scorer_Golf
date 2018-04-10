//
//  Singleton.swift
//  Project_IOS
//
//  Created by pascal launay on 21/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit

final class Singleton: NSObject
{
    
    static let shared = Singleton()
    
    private override init(){}
    
    var monUser : User = User()
    var ParcoursToClub = [[String : String]]()
    
    
}
