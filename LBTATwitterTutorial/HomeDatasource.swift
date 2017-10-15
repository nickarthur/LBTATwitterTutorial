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
        var users = [User]()
        
        if let usersArray = json["users"].array {
            for userJson in usersArray {
                let name = userJson["name"].stringValue
                let username = userJson["username"].stringValue
                let bio = userJson["bio"].stringValue
                
                let user = User(name: name, username: username, bioText: bio, profileImage: UIImage())
                users.append(user)
            }
        }
        
        var tweets = [Tweet]()
        if let tweetsArray = json["tweets"].array {
            for tweetJson in tweetsArray {
                let userJson = tweetJson["user"]
                
                let name = userJson["name"].stringValue
                let username = userJson["username"].stringValue
                let bio = userJson["bio"].stringValue
                
                let user = User(name: name, username: username, bioText: bio, profileImage: UIImage())
                
                let message = tweetJson["message"].stringValue
                
                let tweet = Tweet(user: user, message: message)
                tweets.append(tweet)
            }
        }
        
        self.users = users
        self.tweets = tweets
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
    
    func getDummyUsers() -> [User] {
        let users: [User] = {
            let jackUser = User(name: "Jack Dorsey", username: "@jack", bioText: "Co-Founder & CEO of Twitter & Square. What will come next?", profileImage: #imageLiteral(resourceName: "jack_dorsey"))
            let brianUser = User(name: "Brian Voong", username: "@buildthatapp", bioText: "iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps!", profileImage: #imageLiteral(resourceName: "brian_voong"))
            
            return [jackUser, brianUser]
        }()
        return users
    }
}
