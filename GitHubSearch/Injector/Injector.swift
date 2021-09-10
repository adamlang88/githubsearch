//
//  Injector.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 29..
//

import Foundation
import Swinject

final class Injector {

    private static let shared = Injector()
    private let assembler: Assembler

    class func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return shared.assembler.resolver.resolve(serviceType)
    }

    // Put module assemblies here
    private init() {
        let assemblies : [Assembly] = [
            ViewAssembly(),
            ViewModelAssembly(),
            ViewControllerAssembly(),
            ServiceAssembly()
        ]
        assembler = Assembler(assemblies)
    }
}
