//
//  Post.swift
//  NationalGeographic
//
//  Created by Anton Lyapov on 7.02.18.
//  Copyright © 2018 Anton Lyapov. All rights reserved.
//

import UIKit
import ObjectMapper

class Content: BaseMappable {
    var page: Page?
    var leadMedia: LeadMedia?
    
    override func mapping(map: Map) {
        page        <- map["page"]
        leadMedia   <- map["leadMedia"]
    }
}
