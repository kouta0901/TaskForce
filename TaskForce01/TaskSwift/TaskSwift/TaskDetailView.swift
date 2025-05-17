import SwiftUI

public struct TaskDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var task: Task
    @State private var editedTitle: String
    @State private var editedDescription: String
    @State private var editedDueDate: Date

    public init(task: Task) {
        _task = State(initialValue: task)
        _editedTitle = State(initialValue: task.title)
        _editedDescription = State(initialValue: task.description)
        _editedDueDate = State(initialValue: task.dueDate)
    }

    public var body: some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()
            VStack(spacing: 24) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.top)
                Text("Goalの詳細")
                    .font(.largeTitle).bold()
                    .foregroundColor(.black)
                Text("残り通知回数: \(task.remainingReminders)回")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text("タイトル")
                    .font(.headline)
                    .foregroundColor(.black)
                TextField("タイトル", text: $editedTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                Text("詳細")
                    .font(.headline)
                    .foregroundColor(.black)
                TextEditor(text: $editedDescription)
                    .frame(height: 100)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                Text("期限")
                    .font(.headline)
                    .foregroundColor(.black)
                DatePicker("", selection: $editedDueDate, displayedComponents: [.date])
                    .datePickerStyle(.compact)
                
                HStack {
                    Button(action: { saveChanges() }) {
                        Text("保存")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#343434"))
                            .cornerRadius(8)
                    }
                    .padding(.trailing, 8)
                    Button(action: { toggleDone() }) {
                        Text(task.status == .completed ? "未完了に戻す" : "完了にする")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#343434"))
                            .cornerRadius(8)
                    }
                    .padding(.leading, 8)
                }
            }
            .padding()
            .frame(maxWidth: 400)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 20)
            .padding()
        }
    }

    private func saveChanges() {
        task.title = editedTitle
        task.description = editedDescription
        task.dueDate = editedDueDate
        dismiss()
    }

    private func toggleDone() {
        task.status = (task.status == .completed ? .notStarted : .completed)
        dismiss()
    }
}

#Preview {
    TaskDetailView(task: Task.sampleTasks.first!)
} 