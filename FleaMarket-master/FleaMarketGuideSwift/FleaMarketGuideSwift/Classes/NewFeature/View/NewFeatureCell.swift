//
//  NewFeatureCell.swift
//  FleaMarketGuideSwift
//
//  Created by ALin on 16/6/12.
//  Copyright © 2016年 ALin. All rights reserved.
//测试代码
//

import UIKit
import MediaPlayer

let PlayFinishedNotify = "PlayFinishedNotify"

class NewFeatureCell: UICollectionViewCell {
    var coverImage : UIImage?
    {
        didSet{
            if let _ = coverImage {
               imageView.image = coverImage
            }
            
        }
    }
    var moviePath : String?{
        didSet{
            if let iPath = moviePath {
                moviePlayer.contentURL = URL(fileURLWithPath: iPath, isDirectory: false)
                moviePlayer.prepareToPlay()
                moviePlayer.play()
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(moviePlayer.view)
        moviePlayer.view.addSubview(imageView)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate lazy var imageView : UIImageView = {
        let imageView = UIImageView(frame:self.moviePlayer.view.bounds)
        return imageView
    }()
    
    fileprivate lazy var moviePlayer : MPMoviePlayerController = {
        let player = MPMoviePlayerController()
        player.view.frame = self.contentView.bounds
        // 设置自动播放
        player.shouldAutoplay = true
        // 设置源类型
        player.movieSourceType = .file
        // 取消下面的控制视图: 快进/暂停等...
        player.controlStyle = .none
        NotificationCenter.default.addObserver(self, selector: #selector(NewFeatureCell.playerDisplayChange), name: NSNotification.Name.MPMoviePlayerReadyForDisplayDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewFeatureCell.playFinished), name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: nil)
        return player
 
    }()
    
    // MARK: - private method
    
    func playerDisplayChange()
    {
        if moviePlayer.readyForDisplay {
            moviePlayer.backgroundView.addSubview(imageView)
        }
    }
    
    func playFinished()
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: PlayFinishedNotify), object: nil)
    }

    
}
