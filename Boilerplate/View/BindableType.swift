//
//  Created by Nikolay Sohryakov on 28/02/2018.
//

import Foundation
import UIKit

protocol BindableType: class {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    func bindViewModel(to vm: Self.ViewModelType) {
        viewModel = vm
        loadViewIfNeeded()
        bindViewModel()
    }
}
