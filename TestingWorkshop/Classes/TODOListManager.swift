//
//  TODOListManager.swift
//  TestingWorkshop
//
//  Created by Rishita Panchal on 03/07/24.
//

import Alamofire

struct ToDoItem {
    var title: String
    var description: String
    var dueDate: Date
    var isCompleted: Bool
}

class ToDoListManager {
    static let shared = ToDoListManager()
    private var toDoList: [ToDoItem] = []

    // Add a new to-do item
    func addTodoItem(title: String, description: String, dueDate: Date) {
        guard dueDate > Date() else { return }

        let newToDoItem = ToDoItem(
            title: title,
            description: description,
            dueDate: dueDate,
            isCompleted: false
        )

        toDoList.append(newToDoItem)
    }

    // Retrieve all to-do items
    func getAllToDoItems() -> [ToDoItem] {
        return toDoList
    }

    // Mark a to-do item as completed
    func markTodoItemCompleted(at index: Int) {
        guard index >= 0 && index < toDoList.count else { return }
        toDoList[index].isCompleted = true
    }

    // Delete a to-do item by index
    func deleteTodoItem(at index: Int) {
        guard index >= 0 && index < toDoList.count else { return }
        toDoList.remove(at: index)
    }

    // Clear all to-do items
    func clearToDoList() {
        toDoList.removeAll()
    }

    // Update a to-do item
    func updateTodoItem(at index: Int, title: String? = nil, description: String? = nil, dueDate: Date? = nil, isCompleted: Bool? = nil) {
        guard index >= 0 && index < toDoList.count else { return }
        if let title = title {
            toDoList[index].title = title
        }
        if let description = description {
            toDoList[index].description = description
        }
        if let dueDate = dueDate {
            toDoList[index].dueDate = dueDate
        }
        if let isCompleted = isCompleted {
            toDoList[index].isCompleted = isCompleted
        }
    }

    // Retrieve to-do items by completion status
    func getToDoItems(byCompletionStatus isCompleted: Bool) -> [ToDoItem] {
        return toDoList.filter { $0.isCompleted == isCompleted }
    }

    // Retrieve to-do items by due date range
    func getToDoItems(byDueDateRange startDate: Date, endDate: Date) -> [ToDoItem] {
        return toDoList.filter { $0.dueDate >= startDate && $0.dueDate <= endDate }
    }

    // Sort to-do items by due date
    func sortToDoItemsByDueDate(ascending: Bool = true) -> [ToDoItem] {
        return toDoList.sorted { ascending ? $0.dueDate < $1.dueDate : $0.dueDate > $1.dueDate }
    }

    // Search to-do items by title
    func searchToDoItems(byTitle title: String) -> [ToDoItem] {
        return toDoList.filter { $0.title.localizedCaseInsensitiveContains(title) }
    }
}
