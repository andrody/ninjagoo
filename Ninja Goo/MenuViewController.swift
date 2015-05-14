//
//  GameViewController.swift
//  Ninja Goo
//
//  Created by Andrew on 4/2/15.
//  Copyright (c) 2015 Koruja. All rights reserved.
//

import UIKit
import SpriteKit

class MenuViewController: UIViewController, UIPageViewControllerDataSource {
    
    // MARK: - Variables
    private var pageViewController: UIPageViewController?
    
    // Initialize it right away here
    private let contentImages = [["fundoMenu"],
        ["minifase1", "minifase2","minifase3"]
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPageViewController()
    }
    
   
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("MenuController") as! UIPageViewController
        pageController.dataSource = self
        
        if contentImages.count > 0 {
            let startScreenCtrl = getStartSItemController()!
            let startingViewControllers: NSArray = [startScreenCtrl]
            pageController.setViewControllers(startingViewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        
        let itemController = viewController as? ItemViewCtrl
            
        if itemController!.itemIndex > 0 {
            if(itemController!.itemIndex-1 == 0){
                return getStartSItemController()
            }
            return getItemController(itemController!.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var itemController = viewController as! ItemViewCtrl
        
        if itemController.itemIndex+1 < contentImages.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> LevelsController? {
        
      if itemIndex < contentImages.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("LevelsController") as! LevelsController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageOneName = contentImages[itemIndex][0]
            pageItemController.imageTwoName = contentImages[itemIndex][1]
            pageItemController.imageThreeName = contentImages[itemIndex][2]
            return pageItemController
        }
    
        
        return nil
    }
    
    private func getStartSItemController() -> StartScreenViewController? {
        
        let startScreenCtrl = self.storyboard!.instantiateViewControllerWithIdentifier("StartScreenViewCtrl") as! StartScreenViewController
        startScreenCtrl.itemIndex = 0
        startScreenCtrl.imageName = contentImages[0][0]
        startScreenCtrl.menuViewController = self
        return startScreenCtrl
    }
    
    func goToPage(page : Int) {
        
        let startingViewControllers: NSArray = [getItemController(page)!]
        self.pageViewController!.setViewControllers(startingViewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
    }

    
   
    
    // MARK: - Page Indicator
    
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return contentImages.count
//    }
//    
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
    
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    
    
    
    
}
