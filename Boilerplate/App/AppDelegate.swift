//
//  Created by Nikolay Sohryakov on 27/02/2018.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    fileprivate var coordinator: SceneCoordinatorType?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        guard let uWindow = window else {
            fatalError("Unable to create application window")
        }
        
        coordinator = AppCoordinator(window: uWindow)
        let viewModel = MainViewModel(coordinator: coordinator!)
        let scene = MainScene(viewModel: viewModel)
        
        coordinator?.transition(to: scene, type: .root)
        
        return true
    }
}

