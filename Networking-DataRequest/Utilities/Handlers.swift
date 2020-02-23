//
//  Handlers.swift
//  Networking-DataRequest
//
//  Created by Dushan Saputhanthri on 23/2/20.
//  Copyright © 2020 RYRA Circuit. All rights reserved.
//

import Foundation

// Action Handler
typealias ActionHandler = (_ status: Bool, _ message: String) -> ()

// Completion Handler
typealias CompletionHandler = (_ status: Bool, _ code: Int, _ message: String) -> ()

// Completion Handler with data
typealias CompletionHandlerWithData = (_ status: Bool, _ code: Int, _ message: String, _ data: Any?) -> ()
