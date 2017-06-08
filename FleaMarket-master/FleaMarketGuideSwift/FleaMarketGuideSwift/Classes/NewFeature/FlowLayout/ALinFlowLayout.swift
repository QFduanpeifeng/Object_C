//
//  ALinFlowLayout.swift
//  FleaMarketGuideSwift
//
//  Created by ALin on 16/6/12.
//  Copyright © 2016年 ALin. All rights reserved.
//

import UIKit

class ALinFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        scrollDirection = .horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        itemSize = collectionView!.bounds.size
        
        collectionView!.showsVerticalScrollIndicator = false
        collectionView!.showsHorizontalScrollIndicator = false
        collectionView!.bounces = false
        collectionView!.isPagingEnabled = true
    }

}
