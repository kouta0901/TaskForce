import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var taskManager: TaskManager
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @State private var reminderCount: Int
    @State private var showDateAlert = false

    init() {
        _reminderCount = State(initialValue: TaskManager().defaultReminderCount)
    }

    var body: some View {
        VStack(spacing: 32) {
            Text("新しいGoal")
                .sheetTitle()

            GoalFormFields(title: $title,
                          description: $description,
                          dueDate: $dueDate)

            VStack(spacing: 8) {
                Text("通知回数")
                    .formLabel()
                Picker("通知回数", selection: $reminderCount) {
                    ForEach(3...9, id: \.self) { n in
                        Text("\(n) 回")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(maxWidth: 300)
            }

            Button(action: {
                let today = Calendar.current.startOfDay(for: Date())
                let selected = Calendar.current.startOfDay(for: dueDate)
                guard selected > today else {
                    showDateAlert = true
                    return
                }
                let reminders = taskManager.generateSmartReminders(dueDate: dueDate, count: reminderCount)
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
            .alert("本日以降の日付を選択してください", isPresented: $showDateAlert) {
                Button("OK", role: .cancel) { }
            }
        }
        .sheetCard()
    }
}

#Preview {
    AddTaskView()
        .environmentObject(TaskManager())
} 