import SwiftUI

struct FinishedTasksView: View {
    @StateObject private var taskManager = TaskManager()
    
    var body: some View {
        NavigationStack {
            List(taskManager.completedTasks) { task in
                NavigationLink(value: task) {
                    TaskCard(task: task)
                }
            }
            .navigationDestination(for: Task.self) { task in
                TaskDetailView(task: task)
            }
            .navigationTitle("完了済みタスク")
        }
    }
}

#Preview {
    FinishedTasksView()
} 