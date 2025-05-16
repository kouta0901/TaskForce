import SwiftUI

struct ActiveTasksView: View {
    @EnvironmentObject var taskManager: TaskManager

    var body: some View {
        List {
            ForEach(taskManager.activeTasks) { task in
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
                    Image(systemName: "circle")
                        .foregroundColor(.gray)
                        .onTapGesture {
                            taskManager.toggleCompletion(for: task)
                        }
                }
            }
            // .onDelete(perform: deleteTask) // フィルタリングされたリストの削除は複雑なので一旦コメントアウト
        }
        .navigationTitle("アクティブなタスク")
    }
    
    /*
    private func deleteTask(offsets: IndexSet) {
        // IDベースの削除をTaskManagerに実装するのが望ましい
    }
    */
}

struct ActiveTasksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ActiveTasksView()
                .environmentObject(TaskManager())
        }
    }
} 