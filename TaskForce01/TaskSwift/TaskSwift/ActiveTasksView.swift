import SwiftUI

struct ActiveTasksView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @State private var showingAddTask = false
    @State private var selectedTask: Task? = nil
    
    var body: some View {
        NavigationStack {
            List(taskManager.activeTasks) { task in
                Button(action: { selectedTask = task }) {
                    TaskCard(task: task)
                }
            }
            .navigationTitle("アクティブタスク")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView()
            }
            .sheet(item: $selectedTask) { task in
                TaskDetailView(task: taskManager.binding(for: task))
            }
        }
    }
}

#Preview {
    ActiveTasksView()
        .environmentObject(TaskManager())
} 