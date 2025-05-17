import SwiftUI

struct GoalView: View {
    @StateObject private var taskManager = TaskManager()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 108/255, green: 109/255, blue: 115/255).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 0) {
                    Text("Overview")
                        .font(.largeTitle).bold()
                        .foregroundColor(.white)
                        .padding(.top, 40)
                        .padding(.leading, 24)
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(taskManager.activeTasks) { task in
                                NavigationLink(value: task) {
                                    TaskCard(task: task)
                                        .padding(.horizontal, 16)
                                }
                            }
                            ForEach(taskManager.finishedTasks) { task in
                                NavigationLink(value: task) {
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
            .navigationDestination(for: Task.self) { task in
                TaskDetailView(task: task)
            }
        }
    }
}

#Preview {
    GoalView()
} 