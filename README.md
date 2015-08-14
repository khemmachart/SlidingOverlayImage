# SlidingOverlayImage

var slidingView = SlidingOverlayImageView(frame: frame)<br>
// Theses commented lines are optional<br>
// slidingView.setBorderHeight(percent: 8)<br>
// slidingView.setMainBackgroundColor(self.view.backgroundColor!)<br>
slidingView.setSlidingoverlayImageView(imagePath: "IMG_8115")  // Put this method as the last line to call<br>
slidingView.setInitialHeightOverlayImage(0.5)<br>
slidingView.center = self.view.center<br>
