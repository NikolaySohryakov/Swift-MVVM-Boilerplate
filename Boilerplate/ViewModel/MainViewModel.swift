//
//  Created by Nikolay Sohryakov on 27/02/2018.
//

import Foundation
import RxSwift
import Action


protocol MainViewModelInputsType {
    // Mainly `PublishSubject` here
}

protocol MainViewModelOutputsType {
    // Mainly `Observable` here
}

protocol MainViewModelActionsType {
    // Mainly `Actions` here
}

protocol MainViewModelType {
    var inputs:  MainViewModelInputsType  { get }
    var outputs: MainViewModelOutputsType { get }
    var actions: MainViewModelActionsType { get }
}


class MainViewModel: MainViewModelType {
    var inputs:  MainViewModelInputsType  { return self }
    var outputs: MainViewModelOutputsType { return self }
    var actions: MainViewModelActionsType { return self }
    
    // MARK: Setup
    fileprivate var sceneCoordinator: SceneCoordinatorType
    
    // MARK: Inputs
    
    // MARK: Outputs
    
    init(coordinator: SceneCoordinatorType) {
        // Setup
        sceneCoordinator = coordinator
        
        // Inputs
        
        // Outputs
        
        // ViewModel Life Cycle
    }
    
    // MARK: Actions
}

extension MainViewModel: MainViewModelInputsType, MainViewModelOutputsType, MainViewModelActionsType {}
