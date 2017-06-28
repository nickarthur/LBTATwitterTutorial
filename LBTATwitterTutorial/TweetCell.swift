//
//  TweetCell.swift
//  LBTATwitterTutorial
//
//  Created by Kevin Quisquater on 28/06/2017.
//  Copyright © 2017 Kevin Quisquater. All rights reserved.
//

import LBTAComponents

class TweetCell: DatasourceCell {
    
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
    }
}
