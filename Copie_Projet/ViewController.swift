//
//  ViewController.swift
//  Project_IOS
//
//  Created by pascal launay on 08/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit


class ViewController: UIViewController, DBAuth {
    
    
    @IBOutlet var ImageBck : UIImageView!
    @IBOutlet var BalleGolf : UIImageView!
    @IBOutlet var monlogin : UITextField!
    @IBOutlet var monmdp : UITextField!
    @IBOutlet var ButtonValidation : UIButton!
    @IBOutlet var spinWheel : UIActivityIndicatorView!
    @IBOutlet var ErrorLogin : UILabel!
    @IBOutlet var ErrorMdp : UILabel!
    
    
    let dbController = TraitementAuth()
    
    func dataLoadedUser(datas: User?)
    {
        ViewController.load()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        ImageBck.image = UIImage(named:"golflogin.jpg")
        BalleGolf.image = UIImage(named:"GolfBall.png")
        
        ErrorMdp.isHidden = true
        ErrorLogin.isHidden = true
        
        dbController.delegateUser = self
        

   

    
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
    
    
    func validateLogin (userName : String) -> Bool
    {
        let reg = "\\A\\w{4,18}\\Z"
        let test = NSPredicate(format: "SELF MATCHES %@", reg)
        return test.evaluate(with: monlogin.text!) == false
    }
    
    func validateMdp (pass : String) -> Bool
    {
        return pass.isEmpty == true
    }
    
    //enabled storyboard
    @IBAction func userLoginChanged()
    {
        
    if(validateLogin(userName: monlogin.text!))
    {
    ErrorLogin.isHidden = false
    ErrorLogin.text = "Votre login n'est pas conforme."
    }
    else
    {
    ErrorLogin.isHidden = true
    dbController.loadUser(monlogin: self.monlogin.text!)
    }
    
    if(validateLogin(userName: monlogin.text!) == false && validateMdp(pass: monmdp.text!) == false)
    {
    ButtonValidation.isEnabled = true
    }else
    {
    ButtonValidation.isEnabled = false
    }
    }
    
    @IBAction func userPassChanged()
    {
        if(validateMdp(pass: monmdp.text!))
        {
            ErrorMdp.isHidden = false
            ErrorMdp.text = "Votre mot de passe est vide."
        }
        else
        {
            ErrorMdp.isHidden = true
        }
        
        if(validateLogin(userName: monlogin.text!) == false && validateMdp(pass: monmdp.text!) == false)
        {
            ButtonValidation.isEnabled = true
        }else
        {
            ButtonValidation.isEnabled = false
        }
    }
    
    
    func validInfo() -> Bool
    {
        //view.endEditing(true)
        spinWheel.startAnimating()
        
        if self.dbController.monUser.mot_de_passe == self.monmdp.text!
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
            {
                self.spinWheel.stopAnimating()
                Singleton.shared.monUser = self.dbController.monUser
                self.performSegue(withIdentifier: "login", sender: self)
                
            } 
            return false
        }
            
        else
        {
            ErrorMdp.isHidden = false
            ErrorMdp.text = "Compte inexistant"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
            {
                self.spinWheel.stopAnimating()
            }
            return false
        }
        

    }
    


    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        return validInfo()
        
    }

}

