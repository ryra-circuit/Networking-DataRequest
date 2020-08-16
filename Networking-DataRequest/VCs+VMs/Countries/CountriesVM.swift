//
//  CountriesVM.swift
//  Networking-Router
//
//  Created by Dushan Saputhanthri on 23/2/20.
//  Copyright © 2020 RYRA Circuit. All rights reserved.
//

import UIKit
import SwiftyJSON

class CountriesVM: BaseVM {
    
    var countryList: [Country] = []
    
    //MARK: Load All Countries data
    func loadAllCountriesDataWithAPI(completion: @escaping CompletionHandler) {
        
        CountriesAPI.getCountries(parameters: [:], completion: { response, error in
            
            if error != nil {
                self.hadleErrorResponse(error, completion: { (status, statusCode, message) in
                    let _error = CustomError.serverError(message: message)
                    completion(false, statusCode, _error.localizedDescription)
                })
                
            } else {
                if let _response: [Country] = response {
                    
                    // Set data
                    let _countries = _response
                    self.countryList = _countries

                    completion(true, 200, "Countires data has been loaded successfully.")
                    
                } else {
                    completion(false, 406, "Failed to read data.")
                }
            }
        })
    }
    
}
