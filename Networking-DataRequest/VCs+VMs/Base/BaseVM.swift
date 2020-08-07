//
//  BaseVM.swift
//  Networking-DataRequest
//
//  Created by Developer on 8/7/20.
//  Copyright © 2020 RYRA Circuit. All rights reserved.

import UIKit
import SwiftyJSON

class BaseVM: NSObject {

    //MARK: Handle error response
    func hadleErrorResponse(_ error: Error?, completion: CompletionHandler) {
        
        if let errorResponse = error as? ErrorResponse {
            switch errorResponse {
            case .error(let statusCode, let data, _):
                guard let responseData = data else {
                    return
                }
                let errorJson = JSON(responseData)
                completion(false, statusCode, errorJson["error"].stringValue)
            }
        } else {
            completion(false, error?.asAFError?.responseCode ?? 500, "Server error occured.")
        }
    }
    
}
