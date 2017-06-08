//
//  NewFeatureViewController.swift
//  FleaMarketGuideSwift
//
//  Created by ALin on 16/6/12.
//  Copyright © 2016年 ALin. All rights reserved.
//

import UIKit

let MS_Width = UIScreen.main.bounds.size.width
let MS_Height = UIScreen.main.bounds.size.height
let Key_Window = UIApplication.shared.keyWindow

private let reuseIdentifier = "NewFeatureCell"

class NewFeatureViewController: UICollectionViewController {
    
    var guideImages: [UIImage]
    
    var guideMoviePaths: [String]
    
    var lastOnePlayFinished: ()->()
    
    // MARK: - life circle
    
    /**
     构造方法
     
     - parameter images:       封面图片
     - parameter moviePaths:   视频地址
     - parameter playFinished: 最后一个视频播放完毕
     */
    init(images:[UIImage], moviePaths:[String], playFinished: @escaping ()->()) {
        guideImages = images
        guideMoviePaths = moviePaths
        lastOnePlayFinished = playFinished
        
        super.init(collectionViewLayout: ALinFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(NewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        NotificationCenter.default.addObserver(self, selector: #selector(finishedPlay), name: NSNotification.Name(rawValue: PlayFinishedNotify), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        pageControl.numberOfPages = guideMoviePaths.count ?? 0
        
    }
    
    deinit
    {
        pageControl.removeFromSuperview()
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - private method
    
    fileprivate var isMovieFinished = false
    func finishedPlay() {
        isMovieFinished = true
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return guideMoviePaths.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewFeatureCell
        
        cell.coverImage = guideImages[(indexPath as NSIndexPath).item]
        
        cell.moviePath = guideMoviePaths[(indexPath as NSIndexPath).item]
        print(cell.moviePath);
        
        isMovieFinished = false
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).item ==  guideMoviePaths.count - 1 && isMovieFinished{
            lastOnePlayFinished()
        }
    }
    
    // MARK: UIScrollViewDelegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / collectionView!.bounds.width + 0.5)
        pageControl.currentPage = page
    }

    // MARK : - 懒加载
    fileprivate lazy var pageControl : UIPageControl =
    {
        let width : CGFloat = 120.0
        let height : CGFloat = 30.0
        let x : CGFloat = (MS_Width - width) * 0.5;
        let y : CGFloat =  MS_Height - 30 - 20;
        let pageControl = UIPageControl(frame: CGRect(x: x, y: y, width: width, height: height))
            pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.red
        Key_Window?.addSubview(pageControl)
        return pageControl;
    }()
    
    
}
