//
//  HomeDatasourceController.swift
//  LBTATwitterTutorial
//
//  Created by Kevin Quisquater on 25/06/2017.
//  Copyright © 2017 Kevin Quisquater. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

class HomeDatasourceController: DatasourceController {
    
    let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Apologies, something went wrong.\nPlease try again later..."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        APIService.shared.fetchHomeFeed { homeDataSource, error  in
            if let error = error {
                print(error)
                self.errorMessageLabel.isHidden = false
                if let apiError = error as? APIError<APIService.JSONError> {
                    if apiError.response?.statusCode != 200 {
                        self.errorMessageLabel.text = "Error: Status code was not 200\n(Please check your internet connection)"
                    }
                }
                
                return
            }
            self.errorMessageLabel.isHidden = true
            self.datasource = homeDataSource
        }
        
    }
    
    private func setupViews() {
        view.addSubview(errorMessageLabel)
        errorMessageLabel.fillSuperview()
        
        collectionView?.backgroundColor = .lightBlueBackground
        setupNavigationBarItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // User section
        if indexPath.section == 0 {
            if let user = datasource?.item(indexPath) as? User {
                
                let cellHeight = estimatedHeight(forText: user.bioText)
                return CGSize(width: view.frame.width, height: cellHeight)
            }
        
            // Tweets section
        } else if indexPath.section == 1 {
            
            guard let tweet = datasource?.item(indexPath) as? Tweet else {
                return .zero
            }
            
            let cellHeight = estimatedHeight(forText: tweet.message)
            return CGSize(width: view.frame.width, height: cellHeight)
        }
        
        return .zero
    }
    
    private func estimatedHeight(forText text: String) -> CGFloat {
        let cellMetrics = Constants.Metrics.UserCell.self
        let attributes = [NSAttributedStringKey.font: cellMetrics.fontBioText]
        let approximateHeightTextView = view.frame.width - cellMetrics.userProfileImageSideLength - cellMetrics.leftMargin - cellMetrics.spacingProfileImageAndContent
        let size = CGSize(width: approximateHeightTextView, height: 1000)
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        let additionalHeightNecessary: CGFloat = 20
        let cellHeight = cellMetrics.topMargin + cellMetrics.heightNameLabel + cellMetrics.heightUsernameLabel + estimatedFrame.height + additionalHeightNecessary
        
        return cellHeight
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 50)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 50 + Constants.Metrics.Home.verticalSpacingSections)
        }
        return .zero
    }
}
