//
//  CountriesVC.swift
//  Networking-DataRequest
//
//  Created by Dushan Saputhanthri on 23/2/20.
//  Copyright © 2020 RYRA Circuit. All rights reserved.
//

import UIKit

class CountriesVC: BaseVC {
    
    let vm = CountriesVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadCountries()
    }
    
    
    //MARK: Load countries data
    func loadCountries() {
        
        self.startLoading()
        self.vm.loadAllCountriesDataWithAPI(completion: { status, code, message in
            self.stopLoading()
            
            switch status {
            case true:
                print("SUCCESS")
                
            default:
                print("FAILED")
            }
        })
    }
    
}

