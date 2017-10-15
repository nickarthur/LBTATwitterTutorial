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
    
    required init(json: JSON) throws {
        var users = [User]()
        
        guard let usersArray = json["users"].array else {
            self.users = users
            return
        }
        
        for userJson in usersArray {
            let name = userJson["name"].stringValue
            let username = userJson["username"].stringValue
            let bio = userJson["bio"].stringValue
            
            let user = User(name: name, username: username, bioText: bio, profileImage: UIImage())
            users.append(user)
        }
        
        self.users = users
    }
    
    let tweets: [Tweet] = {
        let brianUser = User(name: "Brian Voong", username: "@buildthatapp", bioText: "iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps!", profileImage: #imageLiteral(resourceName: "brian_voong"))
        let tweet = Tweet(user: brianUser, message: "Welcome to episode 9 of the Twitter series. I really hope you guys are enjoying this series so far. I need a really long text block to rend, but let's stop here.")
        let tweet2 = Tweet(user: brianUser, message: "This is the second tweet of this very short array. In a production app, you wouldn't leave this piece of code here, but since this is a tutorial... Meh!.")
        return [tweet, tweet2]
    }()
    
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
    
    func getDummyUsers() -> [User] {
        let users: [User] = {
            let jackUser = User(name: "Jack Dorsey", username: "@jack", bioText: "Co-Founder & CEO of Twitter & Square. What will come next?", profileImage: #imageLiteral(resourceName: "jack_dorsey"))
            let brianUser = User(name: "Brian Voong", username: "@buildthatapp", bioText: "iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps!", profileImage: #imageLiteral(resourceName: "brian_voong"))
            
            return [jackUser, brianUser]
        }()
        return users
    }
}
