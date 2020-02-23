//
//  CountriesVC.swift
//  Networking-DataRequest
//
//  Created by Dushan Saputhanthri on 23/2/20.
//  Copyright © 2020 RYRA Circuit. All rights reserved.
//

import UIKit

class CountriesVC: UIViewController {
    
    let vm = CountriesVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.loadAllCountriesData()
    }
    
    
}

