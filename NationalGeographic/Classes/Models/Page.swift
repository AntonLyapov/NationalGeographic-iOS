//
//  Page.swift
//  NationalGeographic
//
//  Created by Anton Lyapov on 11/28/17.
//  Copyright © 2017 Anton Lyapov. All rights reserved.
//

import UIKit
import ObjectMapper

class Page: BaseMappable {
    var url:                    String?
    var type:                   String?
    var title:                  String?
    var series:                 String?
    var abstract:               String?
    var sponsored:              String?
    var publishDate:            String?
    var sponsorContentLabel:    String?
    
    
    override func mapping(map: Map) {
        url                 <- map["url"]
        type                <- map["type"]
        title               <- map["title"]
        series              <- map["series"]
        abstract            <- map["abstract"]
        sponsored           <- map["sponsored"]
        publishDate         <- map["publishDate"]
        sponsorContentLabel <- map["sponsorContentLabel"]
    }
}
