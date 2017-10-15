//
//  HomeDatasource.swift
//  LBTATwitterTutorial
//
//  Created by Kevin Quisquater on 25/06/2017.
//  Copyright © 2017 Kevin Quisquater. All rights reserved.
//

import LBTAComponents
import UIKit
import TRON
import SwiftyJSON

class HomeDatasource: Datasource, JSONDecodable {
    
    let users: [User]
    let tweets: [Tweet]
    
    required init(json: JSON) throws {
        guard let usersJsonArray = json["users"].array,
            let tweetsJsonArray = json["tweets"].array else {
                throw NSError(domain: "com.kevinquisquater",
                              code: 1,
                              userInfo: [NSLocalizedDescriptionKey : "Home data JSON not valid."])
        }
        
        self.users = usersJsonArray.map { User(json: $0) }
        self.tweets = tweetsJsonArray.map { Tweet(json: $0) }
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self, TweetCell.self]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if section == 1 { return tweets.count }
        return users.count
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        switch indexPath.section {
        case 0:
            return users[indexPath.item]
        case 1:
            return tweets[indexPath.item]
        default: return nil
        }
        
    }
}
