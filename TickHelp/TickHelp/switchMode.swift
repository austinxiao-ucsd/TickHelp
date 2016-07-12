//
//  switchMode.swift
//  TickHelp
//
//  Created by Hongda Xiao on 5/23/16.
//  Copyright © 2016 Ariel. All rights reserved.
//

import UIKit
import Firebase

class switchMode: UIViewController {
    
    weak var currentViewController: UIViewController?
    @IBOutlet weak var containerView: UIView!
  //  let appDelagate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    
    override func viewDidLoad() {
        self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("onlineNearbyUsers")
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
        self.addSubview(self.currentViewController!.view, toView: self.containerView)
        super.viewDidLoad()
    }
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
    }
    
    
    @IBAction func showComponent(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("onlineNearbyUsers")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
        } else {
            //self.appDelagate.mpcOfflineManager = MPCOfflineManager()
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("offlineNoNavBar")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
        }
    }
    
    @IBAction func LogOutBtnPressed(sender: UIBarButtonItem) {
        // Delete the corresponding location in Firebase
        /*
        let ref = Firebase(url: constant.userURL + "/locations/")
        ref.observeEventType(.ChildAdded, withBlock: { snapshot in
            if(snapshot.value.objectForKey("currLoc") as! String == constant.uid){
                ref.childByAppendingPath(snapshot.value.objectForKey("currLoc")as! String).setValue("")
            }
        })
         */
        let next = self.storyboard!.instantiateViewControllerWithIdentifier("InitialViewController")
        self.presentViewController(next, animated: true, completion: nil)
    }
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        oldViewController.willMoveToParentViewController(nil)
        self.addChildViewController(newViewController)
        self.addSubview(newViewController.view, toView:self.containerView!)
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
            },
                                   completion: { finished in
                                    oldViewController.view.removeFromSuperview()
                                    oldViewController.removeFromParentViewController()
                                    newViewController.didMoveToParentViewController(self)
        })
    }
    
    
}
