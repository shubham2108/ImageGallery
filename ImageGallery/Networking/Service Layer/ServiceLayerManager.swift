//
//  ServiceLayerManager.swift
//  ImageGallery
//
//  Created by Shubham Choudhary on 24/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import Foundation
import Alamofire
import ReachabilitySwift

class ServiceLayerManager {
    
    // Handle API response
    class func request(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, completionHandler: @escaping (_ responseData: Any?, _ error: String?) -> ()) {
        
        // Check Network Connectivity
        if Reachability()?.currentReachabilityStatus != .notReachable {
            Alamofire.request(url).responseJSON { responseData in
                print(responseData.request ?? "")
                if let resultValue = responseData.result.value {
                    completionHandler(resultValue, nil)
                }else {
                    completionHandler(nil, responseData.error?.localizedDescription)
                }
            }
        }else {
            completionHandler(nil, NO_CONNECTION)
        }
    }
}
