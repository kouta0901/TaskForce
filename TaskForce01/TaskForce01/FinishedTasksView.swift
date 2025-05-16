import SwiftUI

struct FinishedTasksView: View {
    @EnvironmentObject var taskManager: TaskManager

    var body: some View {
        List {
            ForEach(taskManager.finishedTasks) { task in
                HStack {
                    VStack(alignment: .leading) {
                        Text(task.title)
                            .font(.headline)
                            .strikethrough(task.isCompleted, color: .gray) // 完了済みは取り消し線
                        if let dueDate = task.dueDate {
                            Text("期限: \(dueDate, style: .date)")
                                .font(.caption)
                                .strikethrough(task.isCompleted, color: .gray)
                        }
                    }
                    Spacer()
                    Image(systemName: "checkmark.circle.fill") // 完了済みなので "checkmark.circle.fill"
                        .foregroundColor(.green)
                        .onTapGesture {
                            taskManager.toggleCompletion(for: task)
                        }
                }
            }
            // .onDelete(perform: deleteTask) // フィルタリングされたリストの削除は複雑なので一旦コメントアウト
        }
        .navigationTitle("完了済みタスク")
    }
    /*
    private func deleteTask(offsets: IndexSet) {
        // IDベースの削除をTaskManagerに実装するのが望ましい
    }
    */
}

struct FinishedTasksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FinishedTasksView()
                .environmentObject(TaskManager())
        }
    }
} 