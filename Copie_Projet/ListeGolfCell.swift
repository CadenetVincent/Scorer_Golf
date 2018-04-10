//
//  ListeGolfCell.swift
//  Project_IOS
//
//  Created by pascal launay on 08/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit

class ListeGolfCell: UITableViewCell {
    

    @IBOutlet var MonParcours : UILabel!
    @IBOutlet var MonNbrTrou : UILabel!
    @IBOutlet var ImageBckCell : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
