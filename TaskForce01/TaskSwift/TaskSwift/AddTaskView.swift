import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var taskManager: TaskManager
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()

    var body: some View {
        VStack(spacing: 32) {
            Text("新しいGoal")
                .sheetTitle()

            GoalFormFields(title: $title,
                          description: $description,
                          dueDate: $dueDate)

            Button(action: {
                let reminders = taskManager.generateSmartReminders(dueDate: dueDate, count: taskManager.defaultReminderCount)
                let newTask = Task(
                    title: title,
                    description: description,
                    dueDate: dueDate,
                    reminders: reminders
                )
                taskManager.addTask(newTask)
                dismiss()
            }) {
                Text("Set")
                    .primaryWideButton()
            }
        }
        .sheetCard()
    }
}

#Preview {
    AddTaskView()
        .environmentObject(TaskManager())
} 