//
//  ViewController.swift
//  ImageColor
//
//  Created by KHUN NINE on 8/12/15.
//  Copyright (c) 2015 KHUN NINE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SlidingOverlayImageViewDelegate {
    
    var slidingView: SlidingOverlayImageView!
    
    override func viewDidLoad() {
        
        var frame = CGRectMake(0, 0, self.view.frame.width/3, self.view.frame.height/3)
        
        slidingView = SlidingOverlayImageView(frame: frame)
        // Theses commented lines are optional
        // slidingView.setBorderHeight(percent: 8)
        // slidingView.setMainBackgroundColor(self.view.backgroundColor!)
        slidingView.setSlidingoverlayImageView(imagePath: "IMG_8115")  // Put this method as the last line to call
        slidingView.animateHeightOverlayImage(from: 1, to: 0, duration: 3, delay: 0)
        slidingView.delegate = self
        slidingView.center.y = self.view.center.y
        slidingView.center.x = self.view.frame.width * 0.25
        
        self.view.addSubview(slidingView)
    }
    
    func overlayImageHeightDidChange(height: CGFloat) {
        println(height)
    }
}