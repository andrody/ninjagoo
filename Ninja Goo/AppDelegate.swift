//
//  AppDelegate.swift
//  Ninja Goo
//
//  Created by Andrew on 4/2/15.
//  Copyright (c) 2015 Koruja. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotate", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        // initialize the SDK with your appID and devID
        let sdk: STAStartAppSDK = STAStartAppSDK.sharedInstance()
        sdk.appID = "204046936"
        sdk.devID = "104719604"
    

        return true
    }
    
//    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> Int {
//        
//        if self.window?.rootViewController?.presentedViewController is GameViewController {
//            return Int(UIInterfaceOrientationMask.LandscapeRight.rawValue) || Int(UIInterfaceOrientationMask.Landscape.rawValue);
//        } else {
//            return Int(UIInterfaceOrientationMask.LandscapeRight.rawValue);
//        }
//        
//    }
    
    func rotate(){
        if(SceneManager.sharedInstance.scene != nil) {
            SceneManager.sharedInstance.scene.resizePositions()
        }
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method /Users/brunorolim/Dropbox/Challenge2/Ninja Goo Assets/Maps/zerofase/minifase5.tmxis called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

