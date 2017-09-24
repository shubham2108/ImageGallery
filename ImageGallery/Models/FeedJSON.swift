//
//  FeedJSON.swift
//  ImageGallery
//
//  Created by Shubham Choudhary on 24/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import Foundation
import ObjectMapper

class FeedJSON: Mappable {
    
    var status: Bool?
    var data: FeedData?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        self.status <- map["status"]
        self.data <- map["data"]
    }
    
}
