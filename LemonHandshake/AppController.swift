//
//  AppController.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//  thanks Joel and Alex! :D

import Foundation
import UIKit
import Firebase

class AppController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    var actingViewController: UIViewController!
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInitialViewController()
        addNotificationObservers()
        
    }
    
    // MARK: Set Up
    
    private func loadInitialViewController() {
      
//       FIRAuth.auth()?.addStateDidChangeListener { (auth, user) in
       
//        if FIRAuth.auth()?.currentUser != nil {
//
////        actingViewController = loadViewController(withID: .navID)
//        actingViewController = loadViewController(withID: .tabBarControl)
//        
//        } else {
        
        actingViewController = loadViewController(withID: .loginVC)
//        }
    
        self.addActing(viewController: actingViewController)
     
    }
    
    private func addNotificationObservers() {
        // close login view controller & switch to activities once user has obtained an authorization token
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .closeLoginVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .closeMainVC , object: nil)
        
    }
    
    // MARK: View Controller Handling
    
    private func loadViewController(withID id: StoryboardID) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch id {
        case .loginVC:
            print("LOGOUT FLOW: return instantiated vc")
            return storyboard.instantiateViewController(withIdentifier: id.rawValue) as! LoginScreenViewController
        
//        case .navID:
//           
//            let navVC = storyboard.instantiateViewController(withIdentifier: "navID") as! UINavigationController
//            
//            return navVC
        case .tabBarControl:
            
            return storyboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        }
    }
    
    private func addActing(viewController: UIViewController) {
        
        self.addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
        
    }
    
    func switchViewController(with notification: Notification) {
        
        switch notification.name {
        case Notification.Name.closeLoginVC:
            
            switchToViewController(withID: .tabBarControl)
            
        case Notification.Name.closeMainVC:
            print("LOGOUT FLOW: switch to vc with storyboard id")
            switchToViewController(withID: .loginVC)
            
        default:
            fatalError("ERROR: Unable to match notification name")
        }
    }
    
    private func switchToViewController(withID id: StoryboardID) {
        
        print("LOGOUT FLOW: switch to instantiated vc. remove current vc.")
        let exitingViewController = actingViewController
        exitingViewController?.willMove(toParentViewController: nil)
        
        print("LOGOUT FLOW: exiting view controller: \(exitingViewController)")
        actingViewController = loadViewController(withID: id)
        self.addChildViewController(actingViewController)
        
        addActing(viewController: actingViewController)
        actingViewController.view.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.actingViewController.view.alpha = 1
            exitingViewController?.view.alpha = 0
            
        }) { completed in
            exitingViewController?.view.removeFromSuperview()
            exitingViewController?.removeFromParentViewController()
            self.actingViewController.didMove(toParentViewController: self)
        }
        
    }
    
}
