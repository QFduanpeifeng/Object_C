//
//  AppDelegate.swift
//  FleaMarketGuideSwift
//
//  Created by ALin on 16/6/12.
//  Copyright © 2016年 ALin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 配置本地视频路径和视频的封面图片
        var paths = [String]()
        var images = [UIImage]()
        for i in 0..<4 {
            paths.append(Bundle.main.path(forResource: "guide\(i)", ofType: "mp4")!)
            images.append(UIImage(named: "guide\(i)")!)
        }
        // 设置新特性
        window?.rootViewController = NewFeatureViewController(images: images, moviePaths: paths, playFinished: { [unowned self] in
            self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
        })
        
        window?.makeKeyAndVisible()
        
        return true
    }

}

