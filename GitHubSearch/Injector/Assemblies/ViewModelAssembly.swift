//
//  ViewModelAssembly.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 09. 09..
//

import Swinject

class ViewModelAssembly: Assembly {

    func assemble(container: Container) {

        container.register(SearchViewModel.self) { r in
            let vm = SearchViewModel()
            vm.dataRepository = r.resolve(DataRepository.self)
            return vm
        }.inObjectScope(.container)

    }
}
