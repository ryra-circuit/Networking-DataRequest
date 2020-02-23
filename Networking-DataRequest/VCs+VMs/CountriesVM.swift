//
//  CountriesVM.swift
//  Networking-Router
//
//  Created by Dushan Saputhanthri on 23/2/20.
//  Copyright © 2020 RYRA Circuit. All rights reserved.
//

import UIKit
import SwiftyJSON

class CountriesVM: NSObject {
    
    //MARK: Load All Countries data
    func loadAllCountriesData() {
        
        let _url = API.BaseURL + WebService.allCountries.rawValue
        
        URLDataRequest(url: _url, header: .Guest, param: nil).requestData(completion: { response in
            
            switch response {
            case .Success(let data):
                let _json = JSON(data)
                print("**** JSON: \(_json)")
                break
            case .Invalid(let message):
                break
            case .Failure(let error):
                break
            }
        })
    }
}
