import SwiftUI

struct FinishedTasksView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @State private var selectedTask: Task? = nil
    
    var body: some View {
        NavigationStack {
            List(taskManager.completedTasks) { task in
                Button(action: { selectedTask = task }) {
                    TaskCard(task: task)
                }
            }
            .navigationTitle("完了済みタスク")
            .sheet(item: $selectedTask) { task in
                TaskDetailView(task: taskManager.binding(for: task))
            }
        }
    }
}

#Preview {
    FinishedTasksView()
        .environmentObject(TaskManager())
} 