//
//  ViewController.swift
//  BelajarLocal
//
//  Created by Oey King Ming on 05/07/19.
//  Copyright © 2019 Oey King Ming. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var users =  [User]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetch/retrive from userDefaultData
//        myLabel.text = UserDefaults.standard.string(forKey: "name")
//        // Do any additional setup after loading the view.
        
        //fetch / retreive data using CoreData
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        do {
            users = try managedContext.fetch(User.fetchRequest())
            for user in users {
                let username = user.username
                let password = user.password
                
                //print/show do label
                //kenapa ! karena unwrape agar tidak ada optional nya
                myLabel.text = "\(username!), \(password!)"
            }
            
        } catch  {
            print("Error")
        }
    }

    @IBAction func save(_ sender: UIButton) {
//      myLabel.text = nameTextField.text
//      save data using userDefault
//      UserDefaults.standard.set(myLabel.text, forKey: "name")
        
        //save using CoreData
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
    
        //bikin object entity
        let user = User(context: managedContext)
        //set value ke atribut
        user.username = nameTextField.text
        user.password = passwordTextField.text
        
        //commit change
        do {
            try managedContext.save()
        } catch {
            print("error")
        }
        
    }
    
}

