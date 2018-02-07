//
//  BaseServiceClient.swift
//  Placefier-iOS
//
//  Created by Anton Lyapov on 11/15/17.
//  Copyright © 2017 Anton Lyapov. All rights reserved.
//

import UIKit
import Alamofire

class BaseServiceClient: NSObject {
    
    static let sharedInstance = BaseServiceClient()
    
    func getBaseUrl() -> String {
        preconditionFailure("Override this method: getBaseUrl()")
    }
    
    func getAPIPath() -> String {
        return getBaseUrl()
    }
    
    func executeGetRequest(
        method: String,
        parameters: [String: Any]? = nil,
        successBlock: ((_ result: Any?) -> Void)? = nil,
        failureBlock: ((_ errorMessage: String?) -> Void)? = nil) {
        
        executeRequest(
            method: method,
            httpMethod: .get,
            parameters: parameters,
            successBlock: successBlock,
            failureBlock: failureBlock
        )
    }
    
    func executePostRequest(
        method: String,
        parameters: [String: Any]? = nil,
        successBlock: ((_ result: Any?) -> Void)? = nil,
        failureBlock: ((_ errorMessage: String?) -> Void)? = nil) {
        
        executeRequest(
            method: method,
            httpMethod: .post,
            parameters: parameters,
            successBlock: successBlock,
            failureBlock: failureBlock
        )
    }
    
    func executeRequest(
        method: String,
        httpMethod: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        successBlock: ((_ result: Any?) -> Void)? = nil,
        failureBlock: ((_ errorMessage: String?) -> Void)? = nil) {
        
        Alamofire
            .request(
                getAPIPath() + method,
                method: httpMethod,
                parameters: parameters)
            .responseJSON { response in
                
                print("REQUEST: \(String(describing: response.request))")
                
                if response.result.isSuccess {
                    if let json = response.result.value {
                        //print("JSON: \(json)") // serialized json response
                        
                        if successBlock != nil {
                            successBlock!(json)
                        }
                    } else {
                        if failureBlock != nil {
                            failureBlock!("Response is null")
                        }
                    }
                } else {
                    if failureBlock != nil {
                        failureBlock!(response.result.error.debugDescription)
                    }
                }
        }
    }
}
