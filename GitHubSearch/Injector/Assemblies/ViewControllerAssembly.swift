//
//  ViewControllerAssembly.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 09. 09..
//

import Swinject

class ViewControllerAssembly: Assembly {

    func assemble(container: Container) {

        container.register(SearchViewController.self) { r in
            let controller = SearchViewController()
            controller.viewModel = r.resolve(SearchViewModel.self)
            controller.searchView = r.resolve(SearchView.self)
            return controller
        }.inObjectScope(.container)

        container.register(DetailViewController.self) { r in
            let controller = DetailViewController()
            controller.contentView = r.resolve(DetailView.self)
            return controller
        }.inObjectScope(.container)

    }
}
