import SwiftUI

struct HomeView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var showingAddTaskSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(taskManager.tasks) { task in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(task.title)
                                .font(.headline)
                            if let dueDate = task.dueDate {
                                Text("期限: \(dueDate, style: .date)")
                                    .font(.caption)
                            }
                        }
                        Spacer()
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(task.isCompleted ? .green : .gray)
                            .onTapGesture {
                                taskManager.toggleCompletion(for: task)
                            }
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("ホーム (全タスク)")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddTaskSheet = true
                    } label: {
                        Label("タスク追加", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTaskSheet) {
                AddTaskView { newTask in
                    taskManager.addTask(newTask)
                }
            }
        }
    }

    private func deleteTask(offsets: IndexSet) {
        taskManager.deleteTask(offsets: offsets)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(TaskManager())
    }
} 