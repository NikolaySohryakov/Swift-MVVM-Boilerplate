//
//  Created by Nikolay Sohryakov on 27/02/2018.
//

import Foundation
import UIKit.UIViewController

// Any object implementing `SceneType` MUST implement `InstantiatableFromNIB` or `InstantiatableFromStoryboard` protocol
// depending on how it will load ViewController

protocol InstantiatableFromNIB {
    func instantiateFromNIB() -> UIViewController
}

protocol InstantiatableFromStoryboard {
    func instantiateFromStoryboard() -> UIViewController
}

protocol Navigationable {
    func viewController() -> UIViewController
}

protocol SceneType: Navigationable {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType { get set }
    
    func viewController() -> UIViewController
}
