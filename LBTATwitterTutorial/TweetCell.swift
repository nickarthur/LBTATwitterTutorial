//
//  TweetCell.swift
//  LBTATwitterTutorial
//
//  Created by Kevin Quisquater on 28/06/2017.
//  Copyright © 2017 Kevin Quisquater. All rights reserved.
//

import LBTAComponents

class TweetCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let tweet = datasourceItem as? Tweet else { return }
            
            let attributedText = NSMutableAttributedString(string: tweet.user.name,
                                                           attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 16)])
            
            let usernameString = "  \(tweet.user.username)\n"
            attributedText.append(NSAttributedString(string: usernameString,
                                                     attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15),
                                                                  NSForegroundColorAttributeName: UIColor.gray]))
            
            // Add spacing below Name and Username line
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            let range = NSMakeRange(0, attributedText.string.characters.count)
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
            
            attributedText.append(NSAttributedString(string: tweet.message, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15)]))
            
            messageTextView.attributedText = attributedText
        }
    }
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.text = "SOME SAMPLE TEXT"
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "brian_voong")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = Constants.Colors.separatorLine
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        addSubview(messageTextView)
        
        let metrics = Constants.Metrics.UserCell.self
        profileImageView.anchor(topAnchor,
                                left: leftAnchor,
                                bottom: nil,
                                right: nil,
                                topConstant: metrics.topMargin,
                                leftConstant: metrics.leftMargin,
                                bottomConstant: 0,
                                rightConstant: 0,
                                widthConstant: metrics.userProfileImageSideLength,
                                heightConstant: metrics.userProfileImageSideLength)
        
        // TO DO: use Constants for top and left padding
        messageTextView.anchor(topAnchor,
                               left: profileImageView.rightAnchor,
                               bottom: bottomAnchor,
                               right: rightAnchor,
                               topConstant: 4,
                               leftConstant: 4,
                               bottomConstant: 0,
                               rightConstant: 0,
                               widthConstant: 0,
                               heightConstant: 0)
    }
}
