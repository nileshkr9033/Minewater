//
//  SubsidiaryTableViewCell.swift
//  minewater1
//
//  Created by HQ-ICT-VINAYJ on 14/10/16.
//  Copyright © 2016 HQ-ICT-VINAYJ. All rights reserved.
//

import UIKit

class SubsidiaryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
}

    extension SubsidiaryTableViewCell {
    
    func setCollectionViewDataSourceDelegate<D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: D, forRow row: Int) {
    
    collectionView.delegate = dataSourceDelegate
    collectionView.dataSource = dataSourceDelegate
    collectionView.tag = row
    collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
    collectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
    set {
    collectionView.contentOffset.x = newValue
    }
    
    get {
    return collectionView.contentOffset.x
    }
    }
}
