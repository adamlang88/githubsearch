//
//  ViewAssembly.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 09. 09..
//

import Swinject

class ViewAssembly: Assembly {

    func assemble(container: Container) {

        container.register(SearchView.self) { r in
            return SearchView.instantiate()
        }.inObjectScope(.container)

        container.register(DetailView.self) { r in
            return DetailView.instantiate()
        }.inObjectScope(.container)

    }
}
