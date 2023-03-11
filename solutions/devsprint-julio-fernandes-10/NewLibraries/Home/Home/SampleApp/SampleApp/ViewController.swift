//
//  ViewController.swift
//  SampleApp
//

import UIKit
import Swinject
import Home
import HomeInterface
import HomeAssembly

// MARK: - Mocks Import
import FinanceService
import ActivityDetailsAssembly
import UserProfileInterface

// MARK: - Sample View Controller
final class ViewController: UIViewController {
    var assembler: Assembler = {
        let assemblies: [Assembly] = [MocksAssembly(), ActivityDetailsAssembly(), HomeAssembly()]
        return Assembler(assemblies)
    }()
    
    lazy var service = assembler.resolver.resolve(HomeInterface.self)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Sample App"

        guard let controller = service?.make() else { return }
        show(controller, sender: self)
    }
}

// MARK: - Assemblies Mocks
private final class MocksAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.autoregister(FinanceServiceProtocol.self, initializer: FinanceService.init)
        container.autoregister(UserProfileInterface.self, initializer: Mocks.init)
    }
}

// MARK: - User Profile ViewController Mock
private final class Mocks: UserProfileInterface {
    func make() -> UIViewController {
        let controller = UIViewController()
        controller.title = "User Profile View Controller"
        controller.view.backgroundColor = .systemGreen
        return controller
    }
}
