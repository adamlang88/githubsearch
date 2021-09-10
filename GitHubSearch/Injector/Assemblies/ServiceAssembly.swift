//
//  ServiceAssembly.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 29..
//

import Swinject

class ServiceAssembly: Assembly {

    func assemble(container: Container) {

        container.register(APIServiceProtocol.self) { r in
            return APIService()
        }.inObjectScope(.container)

        container.register(DataRepository.self) { r in
            let repository = DataRepository()
            repository.apiService = r.resolve(APIServiceProtocol.self)
            return repository
        }.inObjectScope(.container)

    }
}
