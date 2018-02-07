//
//  CacheManager.swift
//  NationalGeographic
//
//  Created by Anton Lyapov on 7.02.18.
//  Copyright © 2018 Anton Lyapov. All rights reserved.
//

import UIKit
import SVProgressHUD

class CacheManager: BaseManager {
    
    static var sharedInstance: CacheManager! = CacheManager()
    
//    var dataManager:        DataManager!
    var serviceManager:     ServiceManager!
    
    var managers:[BaseManager]?
    
    
    override init(){
        super.init()
        
        self.serviceManager     = ServiceManager()
        
        self.managers = [
            self.serviceManager
        ]
    }
    
    override func setup() {
        for manager in self.managers! {
            manager.setup()
        }
        
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
    }
}
