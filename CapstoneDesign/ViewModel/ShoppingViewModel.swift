//
//  ShoppingViewModel.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/28.
//

import Foundation

class ShoppingViewModel {
    var todos = [Todo]()
    
    var numOfTodos: Int {
        return todos.count
    }
    
    func addTodo(_ memo: String) {
        todos.append(Todo(memo: memo))
        saveTodos()
    }
    
    func deleteTodo(_ todo: Todo) {
        todos = todos.filter { $0.memo != todo.memo }
        saveTodos()
    }
    
    func saveTodos() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(todos), forKey: "ShoppingList")
    }
    
    func loadTodos() {
        guard let data = UserDefaults.standard.data(forKey: "ShoppingList") else { return }
        todos = (try? PropertyListDecoder().decode([Todo].self, from: data)) ?? []
    }
}
