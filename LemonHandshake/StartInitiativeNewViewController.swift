//
//  StartInitiativeNewViewController.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 12/3/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Former

class StartInitiativeNewViewController: UIViewController {
    
    var form = FormManager()
    var formView: UIView!
    var landmark: Landmark!
    var sender = ""
    
    @IBOutlet weak var closeButton: UIView!
    @IBOutlet weak var closeCircleButton: UIButton!
    
    @IBOutlet weak var saveCircleButton: UIButton!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func savePressed(_ sender: UIButton) {
        let isSaved = form.saveInitiative(landmark)
        
        if isSaved {
            let alertController = UIAlertController(title: nil, message: "\(form.nameText) added to your initiatives!", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default) { completion -> Void in
                self.dismiss(animated: true, completion: nil)
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            let alertController = UIAlertController(title: nil, message: "Please fill in the required fields.", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var landmarkView: UIView!
    @IBOutlet weak var formerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form.landmark = landmark
        form.makeStartInitiativeForm()
        formerView.addSubview((form.view)!)
    }
    
  
}
