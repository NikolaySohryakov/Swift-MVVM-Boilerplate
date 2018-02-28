//
//  Created by Nikolay Sohryakov on 27/02/2018.
//

import Foundation
import UIKit
import RxSwift
import NSObject_Rx

final class AppCoordinator: SceneCoordinatorType, HasDisposeBag {
    fileprivate var window: UIWindow
    private(set) var currentViewController: UIViewController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first!
        } else {
            return viewController
        }
    }
    
    @discardableResult
    func transition(to scene: Navigationable, type: SceneTransitionType) -> Completable {
        var subject = PublishSubject<Void>()
        let viewController = scene.viewController()
        
        switch type {
        case .root:
            currentViewController = AppCoordinator.actualViewController(for: viewController)
            window.rootViewController = viewController
            subject.onCompleted()
            
        case .push(let animated):
            guard let navigationController = currentViewController?.navigationController else {
                fatalError("Can't push a view controller without a current navigation controller")
            }
            // one-off subscription to be notified when push complete
            navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bind(to: subject)
                .disposed(by: disposeBag)
            navigationController.pushViewController(viewController, animated: animated)
            currentViewController = AppCoordinator.actualViewController(for: viewController)
            
        case .modal(let animated):
            currentViewController?.present(viewController, animated: animated) {
                subject.onCompleted()
            }
            currentViewController = AppCoordinator.actualViewController(for: viewController)
            
        case .pop(let animated, let level):
            switch level {
            case .root:
                subject = popToRoot(animated: animated)
            case .parent:
                subject = pop(animated: animated)
            case .vc(let viewController):
                subject = popToVC(viewController, animated: animated)
            }
        }
        
        return subject.asObservable()
            .take(1)
            .ignoreElements()
    }
}

// MARK: Pop logic

extension AppCoordinator {
    fileprivate func pop(animated: Bool) -> PublishSubject<Void> {
        let subject = PublishSubject<Void>()
        
        if let presenter = currentViewController?.presentingViewController {
            // dismiss a modal controller
            currentViewController?.dismiss(animated: animated) {
                self.currentViewController = AppCoordinator.actualViewController(for: presenter)
                subject.onCompleted()
            }
        } else if let navigationController = currentViewController?.navigationController {
            // navigate up the stack
            // one-off subscription to be notified when pop complete
            navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .take(1) // To delete if already in return at bottom
                .map { _ in }
                .bind(to: subject)
                .disposed(by: disposeBag)
            
            guard navigationController.popViewController(animated: animated) != nil else {
                fatalError("can't navigate back from \(String(describing: currentViewController))")
            }
            currentViewController = AppCoordinator.actualViewController(for: navigationController.viewControllers.last!)
        } else {
            fatalError("Not a modal, no navigation controller: can't navigate back from \(String(describing: currentViewController))")
        }
        return subject
    }
    
    fileprivate func popToRoot(animated: Bool) -> PublishSubject<Void> {
        let subject = PublishSubject<Void>()
        
        if let navigationController = currentViewController?.navigationController {
            // navigate up the stack
            // one-off subscription to be notified when pop complete
            navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .take(1) // To delete if already in return at bottom
                .map { _ in }
                .bind(to: subject)
                .disposed(by: disposeBag)
            
            guard navigationController.popToRootViewController(animated: animated) != nil else {
                fatalError("can't navigate back to root VC from \(String(describing: currentViewController))")
            }
            currentViewController = AppCoordinator.actualViewController(for: navigationController.viewControllers.first!)
        }
        
        return subject
    }
    
    
    fileprivate func popToVC(_ viewController: UIViewController, animated: Bool) -> PublishSubject<Void> {
        
        let subject = PublishSubject<Void>()
        
        if let navigationController = currentViewController?.navigationController {
            // navigate up the stack
            // one-off subscription to be notified when pop complete
            navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .take(1) // To delete if already in return at bottom
                .map { _ in }
                .bind(to: subject)
                .disposed(by: disposeBag)
            
            guard navigationController.popToViewController(viewController, animated: animated) != nil else {
                fatalError("can't navigate back to VC from \(String(describing: currentViewController))")
            }
            currentViewController = AppCoordinator.actualViewController(for: navigationController.viewControllers.last!)
        }
        return subject
    }
}
