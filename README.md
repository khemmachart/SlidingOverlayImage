# SlidingOverlayImage

var slidingView = SlidingOverlayImageView(frame: frame)
// Theses commented lines are optional
// slidingView.setBorderHeight(percent: 8)
// slidingView.setMainBackgroundColor(self.view.backgroundColor!)
slidingView.setSlidingoverlayImageView(imagePath: "IMG_8115")  // Put this method as the last line to call
slidingView.setInitialHeightOverlayImage(0.5)
slidingView.center = self.view.center
