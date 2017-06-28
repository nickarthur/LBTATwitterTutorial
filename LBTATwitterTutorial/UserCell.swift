//
//  UserCel.swift
//  LBTATwitterTutorial
//
//  Created by Kevin Quisquater on 25/06/2017.
//  Copyright © 2017 Kevin Quisquater. All rights reserved.
//

import LBTAComponents

class UserCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let user = datasourceItem as? User else {
                return
            }
            
            nameLabel.text = user.name
            usernameLabel.text = user.username
            bioTextView.text = user.bioText
            profileImageView.image = user.profileImage
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        return label
    }()
    
    let bioTextView: UITextView = {
        let textView = UITextView()
        textView.font = Constants.Metrics.UserCell.fontBioText
        textView.backgroundColor = .clear
        textView.isEditable = false
        return textView
    }()
    
    let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderColor = twitterBlue.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(twitterBlue, for: .normal)
        button.setImage(#imageLiteral(resourceName: "follow"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(usernameLabel)
        addSubview(bioTextView)
        addSubview(followButton)
        
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
        
        nameLabel.anchor(profileImageView.topAnchor,
                         left: profileImageView.rightAnchor,
                         bottom: nil,
                         right: followButton.leftAnchor,
                         topConstant: 0,
                         leftConstant: metrics.spacingProfileImageAndContent,
                         bottomConstant: 0,
                         rightConstant: 12,
                         widthConstant: 0,
                         heightConstant: metrics.heightNameLabel)
        
        usernameLabel.anchor(nameLabel.bottomAnchor,
                             left: nameLabel.leftAnchor,
                             bottom: nil,
                             right: nameLabel.rightAnchor,
                             topConstant: 0,
                             leftConstant: 0,
                             bottomConstant: 0,
                             rightConstant: 0,
                             widthConstant: 0,
                             heightConstant: metrics.heightUsernameLabel)
        
        bioTextView.anchor(usernameLabel.bottomAnchor,
                           left: usernameLabel.leftAnchor,
                           bottom: bottomAnchor, right: rightAnchor,
                           topConstant: -4,
                           leftConstant: -4,
                           bottomConstant: 0,
                           rightConstant: 0,
                           widthConstant: 0,
                           heightConstant: 0)
        
        followButton.anchor(topAnchor,
                            left: nil,
                            bottom: nil,
                            right: rightAnchor,
                            topConstant: 12,
                            leftConstant: 0,
                            bottomConstant: 0,
                            rightConstant: 12,
                            widthConstant: 120,
                            heightConstant: 34)
    }
}





