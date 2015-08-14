//
//  ViewController.swift
//  ImageColor
//
//  Created by KHUN NINE on 8/12/15.
//  Copyright (c) 2015 KHUN NINE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        var frame = CGRectMake(0, 0, self.view.frame.width/2, self.view.frame.height/2)
        var slidingView = SlidingOverlayImageView(frame: frame)
        // Theses commented lines are optional
        // slidingView.setBorderHeight(percent: 8)
        // slidingView.setMainBackgroundColor(self.view.backgroundColor!)
        slidingView.setSlidingoverlayImageView(imagePath: "IMG_8115")  // Put this method as the last line to call
        slidingView.setInitialHeightOverlayImage(0.5)
        slidingView.center = self.view.center
        
        self.view.addSubview(slidingView)
    }
}