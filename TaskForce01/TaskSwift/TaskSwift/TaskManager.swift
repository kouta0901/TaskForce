import Foundation
import SwiftUI

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var goals: [String] = []
    
    var activeTasks: [Task] {
        tasks.filter { $0.status != .completed }
    }
    
    var completedTasks: [Task] {
        tasks.filter { $0.status == .completed }
    }
    
    init() {
        loadTasks()
        loadGoals()
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
        saveTasks()
    }
    
    func updateTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            saveTasks()
        }
    }
    
    func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
        saveTasks()
    }
    
    func completeTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            var updatedTask = task
            updatedTask.status = .completed
            tasks[index] = updatedTask
            saveTasks()
        }
    }
    
    func addGoal(_ goal: String) {
        goals.append(goal)
        saveGoals()
    }
    
    func updateGoal(at index: Int, with newGoal: String) {
        if index < goals.count {
            goals[index] = newGoal
            saveGoals()
        }
    }
    
    func deleteGoal(at index: Int) {
        if index < goals.count {
            goals.remove(at: index)
            saveGoals()
        }
    }
    
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }
    
    private func saveGoals() {
        UserDefaults.standard.set(goals, forKey: "goals")
    }
    
    private func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: "tasks"),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = decoded
        } else {
            tasks = Task.sampleTasks
        }
    }
    
    private func loadGoals() {
        if let savedGoals = UserDefaults.standard.stringArray(forKey: "goals") {
            goals = savedGoals
        }
    }
} 