import SwiftUI

struct ActiveTasksView: View {
    @StateObject private var taskManager = TaskManager()
    @State private var showingAddTask = false
    
    var body: some View {
        NavigationStack {
            List(taskManager.activeTasks) { task in
                NavigationLink(value: task) {
                    TaskCard(task: task)
                }
            }
            .navigationDestination(for: Task.self) { task in
                TaskDetailView(task: task)
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
        }
    }
}

#Preview {
    ActiveTasksView()
} 