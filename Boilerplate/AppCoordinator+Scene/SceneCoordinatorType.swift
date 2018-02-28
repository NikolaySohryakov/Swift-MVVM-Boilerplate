//
//  Created by Nikolay Sohryakov on 27/02/2018.
//

import Foundation
import UIKit
import RxSwift

protocol SceneCoordinatorType {
    init(window: UIWindow)
    
    var currentViewController: UIViewController? { get }
    
    @discardableResult
    func transition(to scene: Navigationable, type: SceneTransitionType) -> Completable
}
