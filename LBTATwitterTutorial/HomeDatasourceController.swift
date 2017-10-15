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
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .lightBlueBackground
        setupNavigationBarItems()
        APIService.shared.fetchHomeFeed { homeDataSource in
            self.datasource = homeDataSource
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let user = datasource?.item(indexPath) as? User {
            print(user.bioText)
            
            // Estimate height of cell using bioText height estimation
            let cellMetrics = Constants.Metrics.UserCell.self
            let attributes = [NSAttributedStringKey.font: cellMetrics.fontBioText]
            let approximateHeightTextView = view.frame.width - cellMetrics.userProfileImageSideLength - cellMetrics.leftMargin - cellMetrics.spacingProfileImageAndContent
            let size = CGSize(width: approximateHeightTextView, height: 1000)
            let estimatedFrame = NSString(string: user.bioText).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            
            let additionalHeightNecessary: CGFloat = 14
            let cellHeight = cellMetrics.topMargin + cellMetrics.heightNameLabel + cellMetrics.heightUsernameLabel + estimatedFrame.height + additionalHeightNecessary
            
            return CGSize(width: view.frame.width, height: cellHeight)
        }
        
        
        return CGSize(width: view.frame.width, height: 200)
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
