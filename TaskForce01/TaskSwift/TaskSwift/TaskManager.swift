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
    
    var finishedTasks: [Task] {
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
    
    /// tasks 配列内の Task への read-write Binding を返す
    func binding(for task: Task) -> Binding<Task> {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            fatalError("Task not found")
        }
        return Binding(
            get: { self.tasks[index] },
            set: { self.tasks[index] = $0 }
        )
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
    
    /// すべてのタスクを削除する
    func deleteAllTasks() {
        tasks.removeAll()
        saveTasks()
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

// デフォルト通知回数（必要に応じて設定値に変更可能）
extension TaskManager {
    var defaultReminderCount: Int { 3 }
    
    /// 期限までの間にランダムなリマインダー時刻を生成
    func generateSmartReminders(dueDate: Date, count: Int) -> [Date] {
        guard count > 0 else { return [] }
        let now = Date()
        let interval = dueDate.timeIntervalSince(now)
        guard interval > 0 else { return [] }
        // ランダムな時刻を生成
        let randomIntervals = (1...count).map { _ in Double.random(in: 0..<interval) }
        let sorted = randomIntervals.sorted()
        return sorted.map { now.addingTimeInterval($0) }
    }
} 