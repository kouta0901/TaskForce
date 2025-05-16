import SwiftUI
import Combine

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = Task.sampleTasks

    func addTask(_ task: Task) {
        tasks.append(task)
    }

    func deleteTask(offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    func toggleCompletion(for task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    var activeTasks: [Task] {
        tasks.filter { !$0.isCompleted }
    }
    
    var finishedTasks: [Task] {
        tasks.filter { $0.isCompleted }
    }
} 