import Foundation
import UIKit

protocol SlidingOverlayImageViewDelegate {
    func overlayImageHeightDidChange (height: CGFloat)
}

class SlidingOverlayImageView: UIView {
    
    var backgroundImageView = UIImageView()
    var overlayImageView    = UIImageView()
    
    var imgPercentHeight    = CGFloat(8)
    
    var delegate: SlidingOverlayImageViewDelegate!
    
    // MARK: - Initialization
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
        // Default setting
        setMainBackgroundColor(UIColor.whiteColor())
        setOverlayImageHeight(heightPercentage: 0)
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
    
    func setOverlayImageHeight (#heightPercentage: CGFloat) {
        
        let imageFrame  = backgroundImageView.frame
        
        let frameWidth  = imageFrame.width
        let frameHeight = imageFrame.height
        
        let origin = CGPoint(x: imageFrame.origin.x, y: imageFrame.origin.y)
        let height = imageFrame.height * heightPercentage
        
        overlayImageView.frame = CGRectMake(origin.x, origin.y, frameWidth, height)
    }
    
    func animateHeightOverlayImage (#from: CGFloat, to: CGFloat, duration: NSTimeInterval, delay: NSTimeInterval) {
       
        setOverlayImageHeight(heightPercentage: from)
        
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.setOverlayImageHeight(heightPercentage: to)
        }, completion: nil)
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
        
        setOverlayImageHeight(heightPercentage: height/frameHeight)
        
        if (location.y - origin.y < frameHeight * imgPercentHeight/100) {
            setOverlayImageHeight(heightPercentage: 0)
        }
        
        if (location.y > origin.y + frameHeight * (100-imgPercentHeight)/100) {
            setOverlayImageHeight(heightPercentage: 1)
        }
        
        // Calling delegate method
        
        if let del = delegate {
            del.overlayImageHeightDidChange(getHeightOverlayImage())
        }
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
