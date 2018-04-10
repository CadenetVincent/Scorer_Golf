//
//  emergencyInfo.swift
//  Project_IOS
//
//  Created by pascal launay on 25/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit

class emergencyInfo: UIView {
    
    @IBOutlet var labelInfo : UILabel?
    @IBOutlet var imageInfo : UIImageView?
    @IBOutlet var listInfo : UITableView?
    
    
    override init(frame: CGRect) {
     super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
    /*
    private func commonInit()
    {
        Bundle.main.loadNibNamed("emergencyInfo.xib", owner: self, options: nil)
        addSubview(contentView!)
        contentView?.frame = self.bounds
        contentView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    */
    
    class func loadViewFromNib() -> emergencyInfo
    {
        return UINib(nibName: "emergencyInfo", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! emergencyInfo
    }

}
