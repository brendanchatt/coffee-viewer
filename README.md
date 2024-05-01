# Coffee Viewer

Coffee Viewer is a sample code app designed to present users images of coffee which they may ditch or save to the device

## To Run

- To run this project, you need to have [Flutter](https://flutter.dev) installed.  Follow [this guide](https://docs.flutter.dev/get-started/install) to install.

- [Clone the repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)

- Make sure you have an iOS or Android emulator

- Run the commands `flutter pub get` and `flutter run`

## Using the app

The app is very self-explanatory

The initial tabs allows you to swipe left to ditch an image, or right to save it.

To view your saved images, navigate to your saved tab using the tab bar at the top.

## Possible enhancments

Some things I would do to improve this app if it were not a sample are

1. Manually manage the image caching, so as not to cache all, then evict those not saved.
2. Modify explainer row at the bottom of the swipe tab to have gesture detectors around the left and right text and arrows connected to to swipable stack controller.
