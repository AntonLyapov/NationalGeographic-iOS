//
//  LeadMedia.swift
//  NationalGeographic
//
//  Created by Anton Lyapov on 11/28/17.
//  Copyright © 2017 Anton Lyapov. All rights reserved.
//

import UIKit
import ObjectMapper

class LeadMedia: BaseMappable {
    var url:            String?
    var width:          Int?
    var height:         Int?
    var altText:        String?
    var isVideo:        String?
    var aspectRatio:    Float?
    
    
    override func mapping(map: Map) {
        url         <- map["url"]
        width       <- map["width"]
        height      <- map["height"]
        altText     <- map["altText"]
        isVideo     <- map["isVideo"]
        aspectRatio <- map["aspectRatio"]
    }
}
