//
//  ScoresCell.swift
//  Project_IOS
//
//  Created by pascal launay on 08/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit

protocol CellDelegate {
    func collectionViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: ScoresCell)
    func collectionViewCell(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, delegatedFrom cell: ScoresCell)  -> Bool
}

class ScoresCell: UICollectionViewCell{
    
    @IBOutlet weak var labelScore : UILabel!
    @IBOutlet weak var TextScore : UITextField!
    var delegate : CellDelegate?
    var score = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        TextScore.delegate = self
    }

    
    @IBAction func TestleScore()
    {
        if let value:Int = Int(TextScore.text!)
        {
        print(value)
        delegate?.collectionViewCell(valueChangedIn: TextScore, delegatedFrom: self)
        }
    }

    
    func displaytext(title : String)
    {
    labelScore.text = title
    }
    
    func displayTxtview(title : String)
    {
    TextScore.text = title
    }
    
}

extension ScoresCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let delegate = delegate {
            return delegate.collectionViewCell(textField: textField, shouldChangeCharactersIn: range, replacementString: string, delegatedFrom: self)
        }
        return true
    }
}
