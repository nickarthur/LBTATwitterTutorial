//
//  Tweet.swift
//  LBTATwitterTutorial
//
//  Created by Kevin Quisquater on 29/06/2017.
//  Copyright © 2017 Kevin Quisquater. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Tweet {
    let user: User
    let message: String
    
    init(json: JSON) {
        let userJson = json["user"]
        self.user = User(json: userJson)
        self.message = json["message"].stringValue
    }
}
