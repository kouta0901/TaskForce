import SwiftUI

struct GoalView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @State private var selectedTask: Task? = nil
    
    var body: some View {
        ZStack {
            Color(red: 108/255, green: 109/255, blue: 115/255).ignoresSafeArea()
            VStack(alignment: .center, spacing: 0) {
                Text("Overview")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                    .padding(.top, 40)
                    .padding(.leading, 24)
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(taskManager.activeTasks) { task in
                            Button(action: { selectedTask = task }) {
                                TaskCard(task: task)
                                    .padding(.horizontal, 16)
                            }
                        }
                        ForEach(taskManager.finishedTasks) { task in
                            Button(action: { selectedTask = task }) {
                                TaskCard(task: task)
                                    .padding(.horizontal, 16)
                            }
                        }
                    }
                    .padding(.top, 16)
                }
                Spacer()
            }
        }
        .sheet(item: $selectedTask) { task in
            TaskDetailView(task: taskManager.binding(for: task))
        }
    }
}

#Preview {
    GoalView()
        .environmentObject(TaskManager())
} 