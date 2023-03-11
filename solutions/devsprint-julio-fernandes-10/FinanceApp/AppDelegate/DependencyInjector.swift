//
//  DependencyInjector.swift
//  FinanceApp
//
//  Created by Thonatas Borges on 3/11/23.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import ActivityDetailsAssembly
import ConfirmationAssembly
import ContactListAssembly
import HomeAssembly
import TransfersAssembly
import UserProfileAssembly
import FinanceService

// MARK: - Dependency Injector
final class DependencyInjector {
    static let shared = DependencyInjector()

    private var assembler: Assembler = {
        let assemblies: [Assembly] = [ActivityDetailsAssembly(),
                                      ConfirmationAssembly(),
                                      ContactListAssembly(),
                                      HomeAssembly(),
                                      TransfersAssembly(),
                                      UserProfileAssembly(),
                                      FinanceServiceAssembly()]

        return Assembler(assemblies)
    }()

    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = assembler.resolver.resolve(serviceType) else {
            fatalError("\(serviceType) is not registred")
        }
        return service
    }
}

// MARK: - Finance Service Assembly
private class FinanceServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(FinanceServiceProtocol.self, initializer: FinanceService.init)
    }
}
