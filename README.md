# SuperHeroAppiOS
This repo is a code challenge for the job application at Coppel

[![Swift Version][swift-image]][swift-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
## Specs

- [x] Heros TableView
- [x] Heros CollectionView
- [x] Hero Search by Name
- [x] Hero Detail View

## Screenshots

![Simulator Screen Shot - iPhone 8 - 2020-08-14 at 14 37 28](https://user-images.githubusercontent.com/68290230/90286753-18945600-de3c-11ea-8e33-1a07fca983b5.png)
![Simulator Screen Shot - iPhone 8 - 2020-08-14 at 14 41 37](https://user-images.githubusercontent.com/68290230/90286866-52fdf300-de3c-11ea-8428-25446a57e650.png)
## Examples

![ScrollTable Clip](https://user-images.githubusercontent.com/68290230/90288401-69f21480-de3f-11ea-8ca6-933e32505b6a.gif)
![Collection Scroll Clip](https://user-images.githubusercontent.com/68290230/90288681-ff8da400-de3f-11ea-880f-e477a098059c.gif)
![Detail Gif](https://user-images.githubusercontent.com/68290230/90288691-05838500-de40-11ea-96c4-78de83ce0888.gif)
![Search clip](https://user-images.githubusercontent.com/68290230/90288702-07e5df00-de40-11ea-87c0-c4a3e92cc5dc.gif)

## Known Issues
Due to the way of the API is constructed, and the many times the API method should be called in order to get the information required to populate both, the TableView and the CollectionView, I opted for those controllers to share the same information between them.
So this provokes some unexpected behavior, for example: when the CollectionView repopulates its data, the TableView can no longer call for more information, and viceversa.

## Info
Pablo Figueroa Diaz –  figueroadpabloso@gmail.com

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
