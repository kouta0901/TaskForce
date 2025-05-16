import SwiftUI

struct FinishedTasksView: View {
    @StateObject private var taskManager = TaskManager()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(taskManager.completedTasks) { task in
                    NavigationLink(destination: TaskDetailView(task: task)) {
                        TaskCard(task: task)
                    }
                }
            }
            .navigationTitle("完了済みタスク")
        }
    }
}

#Preview {
    FinishedTasksView()
} 