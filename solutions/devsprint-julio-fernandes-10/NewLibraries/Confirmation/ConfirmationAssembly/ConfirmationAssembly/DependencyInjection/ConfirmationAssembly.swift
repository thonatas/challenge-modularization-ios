import Foundation
import Swinject
import SwinjectAutoregistration

import ConfirmationInterface
import Confirmation

public class ConfirmationAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(String.self) { _ in
            return "Hello DI!!!"
        }
        container.autoregister(ConfirmationInterface.self, initializer: ConfirmationInitializer.init)
    }
}
