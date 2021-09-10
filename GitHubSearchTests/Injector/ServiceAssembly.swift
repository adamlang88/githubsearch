//
//  ServiceAssembly.swift
//  GitHubSearchTests
//
//  Created by Lang Ádám on 2021. 09. 08..
//

import Swinject

class ServiceAssembly: Assembly {

    func assemble(container: Container) {

        container.register(APIServiceProtocol.self) { r in
            return APIServiceMock()
        }.inObjectScope(.container)

        container.register(DataRepository.self) { r in
            let repository = DataRepository()
            repository.apiService = r.resolve(APIServiceProtocol.self)
            return repository
        }.inObjectScope(.container)

    }
}
