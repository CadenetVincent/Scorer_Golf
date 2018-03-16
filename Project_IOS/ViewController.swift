//
//  ViewController.swift
//  Project_IOS
//
//  Created by pascal launay on 08/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var ImageBck : UIImageView!
    @IBOutlet var BalleGolf : UIImageView!
    @IBOutlet var monlogin : UITextField!
    @IBOutlet var monmdp : UITextField!
    @IBOutlet var ButtonValidation : UIButton!
    @IBOutlet var spinWheel : UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        ImageBck.image = UIImage(named:"golflogin.jpg")
        BalleGolf.image = UIImage(named:"GolfBall.png")
        
        let tap = UITapGestureRecognizer(target : self, action : #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        //let  swipe = UISwipeGestureRecognizer
        
        
        
       
    }
    
    @objc func dismissKeyboard()
    {
       view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func validateInfos (userName : String , passs : String) -> Bool
    {
        let reg = "\\A\\w{4,18}\\Z"
        let test = NSPredicate(format: "SELF MATCHES %@", reg)
        return test.evaluate(with: monlogin.text!) && passs.isEmpty == false
    }
    
    //enabled storyboard
    @IBAction func userTextChanged()
    {
    if(validateInfos(userName: monlogin.text!, passs: monmdp.text!))
    {
    ButtonValidation.isEnabled = true
    }else
    {
    ButtonValidation.isEnabled = false
    }
    }
    
    func performAuth()
    {
        //view.endEditing(true)
        spinWheel.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
        {
        //URLSession.shared.dataTask(with: <#T##URL#>)
        self.spinWheel.stopAnimating()
        self.performSegue(withIdentifier: "login", sender: self)
        
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if sender is ViewController
        {
            return true
        }
        
        else if identifier == "login"
        {
            /* URL request ... */
            performAuth()
        }
        
        return false
    }
    


}

