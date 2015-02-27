//
//  Person.swift
//  ateam
//
//  Created by Feng Jiao on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

import Foundation

class Person: NSObject {
    var name: String
    var phone: String
    var email: String
    var info: String
    
    init(name: String, phone: String, email: String, info: String) {
        self.name = name
        self.phone = phone
        self.email = email
        self.info = info
    }
}