//
//  ServiceManager.swift
//  NationalGeographic
//
//  Created by Anton Lyapov on 7.02.18.
//  Copyright © 2018 Anton Lyapov. All rights reserved.
//

import UIKit

class ServiceManager: BaseManager {
    
    private let PARENT_CATEGORY = 3
    private let CATEGORIES_SIZE = 100
    
    var apiServiceClient: APIServiceClient!
    
    override init() {
        super.init()
    }
    
    override func setup() {
        self.apiServiceClient = APIServiceClient()
    }
    
    func getContent(
        page: Int,
        size: Int,
        successBlock: ((_ categories: [Content]) -> ())? = nil,
        failureBlock: ((_ errorMessage: String?) -> ())? = nil) {
        
        self.apiServiceClient.getContent(
            page: page,
            size: size,
            successBlock: successBlock,
            failureBlock: failureBlock)
    }
}
