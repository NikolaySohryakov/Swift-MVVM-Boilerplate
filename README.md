# Boilerplate

A simple and lovely project boilerplate for those who ❤️ MVVM and RxSwift.

# How to use

Simple as is:
1. Clone repo
2. Rename project and targets in Podfile to match your new project name
3. PROFIT!

*(sorry, I was too lazy to write a rename script for this)*

# How to code
The most interesting part comes here. 

To get a better vision of how to keep the architecture, you should [these articles](https://medium.com/smoke-swift-every-day/smvvm-with-rxswift-b3c1e00ca9b).

I made some improvements for the codebase though:
1. Scene is not an `enum` anymore. It should be a `struct` implementing protocol named `SceneType` and one of `InstantiatableFromNIB` or `InstantiatableFromStoryboard` depending on where your scene is going to load UI from. If you prefer a code layout -- well, implement any of these and simply return a view controller.
2. `SceneTransitionType` is improved to have `pop` as it's `enum` case.
3. ... ?

Other than that it's pretty the same what is described in the articles stated above.

# License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

# Third-Party License Rundown

 - [RxSwift](https://github.com/ReactiveX/RxSwift/blob/master/LICENSE.md)
 [- NSObject+Rx](https://github.com/RxSwiftCommunity/NSObject-Rx/blob/master/LICENSE)
 - [R.swift](https://github.com/mac-cain13/R.swift/blob/master/License)
 - [RxKeyboard](https://github.com/RxSwiftCommunity/RxKeyboard/blob/master/LICENSE)
 - [Action](https://github.com/RxSwiftCommunity/Action/blob/master/License.md)
