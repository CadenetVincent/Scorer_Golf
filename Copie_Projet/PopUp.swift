//
//  PopUp.swift
//  Project_IOS
//
//  Created by pascal launay on 08/04/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit

class PopUp: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
       self.preferredContentSize = CGSize(width: 200, height: 100)
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: Selector(("dismiss:")))
        print("heello popup")
    }
  
}
