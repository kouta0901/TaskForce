import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss

    @State private var taskTitle: String = ""
    @State private var taskPriority: Task.Priority = .medium

    var onAddTask: ((Task) -> Void)?

    var body: some View {
        NavigationView {
            Form {
                TextField("タスク名", text: $taskTitle)

                Picker("優先度", selection: $taskPriority) {
                    ForEach(Task.Priority.allCases, id: \.self) { priority in
                        Text(priority.rawValue).tag(priority)
                    }
                }
                
                Button("追加") {
                    let newTask = Task(title: taskTitle, priority: taskPriority)
                    print("新しいタスクが追加されました: \(newTask.title), 優先度: \(newTask.priority.rawValue)")
                    onAddTask?(newTask)
                    dismiss()
                }
                .disabled(taskTitle.isEmpty)
            }
            .navigationTitle("新しいタスク")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
} 