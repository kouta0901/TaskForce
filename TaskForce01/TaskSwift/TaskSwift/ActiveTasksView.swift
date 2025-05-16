import SwiftUI

struct ActiveTasksView: View {
    @StateObject private var taskManager = TaskManager()
    @State private var showingAddTask = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(taskManager.activeTasks) { task in
                    NavigationLink(destination: TaskDetailView(task: task)) {
                        TaskCard(task: task)
                    }
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
        }
    }
}

#Preview {
    ActiveTasksView()
} 