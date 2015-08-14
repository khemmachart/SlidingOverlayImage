import Foundation
import UIKit

class SlidingOverlayImageView: UIView {
    
    var backgroundImageView = UIImageView()
    var overlayImageView    = UIImageView()
    
    var imgPercentHeight    = CGFloat(8)
    
    // MARK: - Initialization
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
        setMainBackgroundColor(UIColor.whiteColor())
    }
    
    convenience  init () {
        self.init(frame:CGRectZero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    // MARK: - Setter methods
    
    func setBorderHeight (#percent: CGFloat) {
        imgPercentHeight = percent
    }
    
    func setMainBackgroundColor (color: UIColor) {
        self.backgroundColor = color
    }
    
    func setInitialHeightOverlayImage (height: CGFloat) {
        
        let imageFrame  = backgroundImageView.frame
        
        let frameWidth  = imageFrame.width
        let frameHeight = imageFrame.height
        
        let origin = CGPoint(x: imageFrame.origin.x, y: imageFrame.origin.y)
        let height = imageFrame.height * height
        
        overlayImageView.frame = CGRectMake(origin.x, origin.y, frameWidth, height)
    }
    
    func setSlidingoverlayImageView (#imagePath: String) {
        
        backgroundImageView = UIImageView(frame: frame)
        backgroundImageView.image = UIImage(named: imagePath)
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFit
        backgroundImageView.center = self.center
        
        overlayImageView = UIImageView(frame: self.backgroundImageView.frame)
        overlayImageView.image = UIImage().coloredImage(self.backgroundColor!)
        overlayImageView.contentMode = UIViewContentMode.ScaleToFill
        overlayImageView.center = self.center
        overlayImageView.alpha = 0.9
        
        self.addSubview(backgroundImageView)
        self.addSubview(overlayImageView)
    }
    
    // MARK: - Getter methods
    
    func getHeightOverlayImage () -> CGFloat {
        return overlayImageView.frame.height / backgroundImageView.frame.height
    }
    
    // MARK: - Util
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let touch = touches.first as! UITouch
        let location = touch.locationInView(self)
        
        if (CGRectContainsPoint(backgroundImageView.frame, location)) {
            calculateMarkViewHeight(location)
        }
    }
    
    private func calculateMarkViewHeight (location: CGPoint) {
        
        let imageFrame  = backgroundImageView.frame
        
        let frameWidth  = imageFrame.width
        let frameHeight = imageFrame.height
        
        let origin = CGPoint(x: imageFrame.origin.x, y: imageFrame.origin.y)
        let height = location.y - imageFrame.origin.y
        
        overlayImageView.frame = CGRectMake(origin.x, origin.y, frameWidth, height)
        
        if (location.y - origin.y < frameHeight * imgPercentHeight/100) {
            overlayImageView.frame = CGRectMake(origin.x, origin.y, frameWidth, 0)
        }
        
        if (location.y > origin.y + frameHeight * (100-imgPercentHeight)/100) {
            overlayImageView.frame = CGRectMake(origin.x, origin.y, frameWidth, frameHeight)
        }
        
        println(getHeightOverlayImage())
    }
}

extension UIImage {
    
    func coloredImage (color: UIColor) -> UIImage {
        
        let rect = CGRectMake(0, 0, 1, 1)
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}