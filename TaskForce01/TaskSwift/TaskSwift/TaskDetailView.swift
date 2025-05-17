import SwiftUI

public struct TaskDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var taskManager: TaskManager
    @Binding var task: Task
    @State private var editedTitle: String
    @State private var editedDescription: String
    @State private var editedDueDate: Date

    public init(task: Binding<Task>) {
        self._task = task
        _editedTitle = State(initialValue: task.wrappedValue.title)
        _editedDescription = State(initialValue: task.wrappedValue.description)
        _editedDueDate = State(initialValue: task.wrappedValue.dueDate)
    }

    public var body: some View {
        VStack(spacing: 32) {
            Text("Goalの詳細")
                .sheetTitle()

            Text("残り通知回数: \(task.remainingReminders)回")
                .foregroundColor(.white)

            GoalFormFields(title: $editedTitle,
                          description: $editedDescription,
                          dueDate: $editedDueDate)

            HStack {
                Button(action: { saveChanges() }) {
                    Text("保存")
                        .primaryWideButton()
                }
                .padding(.trailing, 8)
                Button(action: { toggleDone() }) {
                    Text(task.status == .completed ? "未完了に戻す" : "完了にする")
                        .primaryWideButton()
                }
                .padding(.leading, 8)
            }
        }
        .sheetCard()
    }

    private func saveChanges() {
        task.title = editedTitle
        task.description = editedDescription
        task.dueDate = editedDueDate
        taskManager.updateTask(task)
        dismiss()
    }

    private func toggleDone() {
        task.status = (task.status == .completed ? .notStarted : .completed)
        taskManager.updateTask(task)
        dismiss()
    }
}

#Preview {
    TaskDetailView(task: .constant(Task.sampleTasks.first!))
        .environmentObject(TaskManager())
} 