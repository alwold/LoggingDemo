//
//  Logs.swift
//  LoggingDemo
//
//  Created by Al Wold on 8/28/17.
//  Copyright © 2017 Al Wold. All rights reserved.
//

import Foundation
import os.log

class Logs {
    static let shared = Logs()
    
    let defaultLog = OSLog(subsystem: "com.alwold.LoggingDemo", category: "Default")
}
