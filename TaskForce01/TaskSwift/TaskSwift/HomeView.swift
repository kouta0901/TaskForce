import SwiftUI

struct HomeView: View {
    @StateObject private var taskManager = TaskManager()
    @State private var showingAddTask = false
    @State private var showingAddGoal = false
    @State private var newGoal = ""
    
    var body: some View {
        TabView {
            NavigationView {
                List {
                    Section(header: Text("アクティブタスク")) {
                        ForEach(taskManager.activeTasks) { task in
                            NavigationLink(destination: TaskDetailView(task: task)) {
                                TaskCard(task: task)
                            }
                        }
                        .onDelete { indexSet in
                            let tasksToDelete = indexSet.map { taskManager.activeTasks[$0] }
                            tasksToDelete.forEach { taskManager.deleteTask($0) }
                        }
                    }
                    
                    Section(header: Text("目標")) {
                        ForEach(taskManager.goals.indices, id: \.self) { index in
                            Text(taskManager.goals[index])
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { taskManager.deleteGoal(at: $0) }
                        }
                    }
                }
                .navigationTitle("ホーム")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingAddTask = true }) {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingAddGoal = true }) {
                            Image(systemName: "target")
                        }
                    }
                }
                .sheet(isPresented: $showingAddTask) {
                    AddTaskView()
                }
                .alert("新しい目標", isPresented: $showingAddGoal) {
                    TextField("目標を入力", text: $newGoal)
                    Button("キャンセル", role: .cancel) { }
                    Button("追加") {
                        if !newGoal.isEmpty {
                            taskManager.addGoal(newGoal)
                            newGoal = ""
                        }
                    }
                }
            }
            .tabItem {
                Label("ホーム", systemImage: "house")
            }
            
            FinishedTasksView()
                .tabItem {
                    Label("完了済み", systemImage: "checkmark.circle")
                }
        }
    }
}

#Preview {
    HomeView()
} 