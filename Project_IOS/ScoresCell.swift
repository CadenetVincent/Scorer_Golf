//
//  ScoresCell.swift
//  Project_IOS
//
//  Created by pascal launay on 08/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit

class ScoresCell: UICollectionViewCell {
    
    @IBOutlet var labelScore : UILabel!
    @IBOutlet var TextScore : UITextField!


    
    func displaytext(title : String)
    {
    labelScore.text = title
    }
    

    
    
}
