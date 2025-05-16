import SwiftUI

public struct TaskDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var task: Task
    @State private var isEditing = false
    @State private var editedTitle: String
    @State private var editedDescription: String
    @State private var editedDueDate: Date
    @State private var editedPriority: TaskPriority
    @State private var editedStatus: TaskStatus
    @State private var editedGoal: String
    
    public init(task: Task) {
        _task = State(initialValue: task)
        _editedTitle = State(initialValue: task.title)
        _editedDescription = State(initialValue: task.description)
        _editedDueDate = State(initialValue: task.dueDate)
        _editedPriority = State(initialValue: task.priority)
        _editedStatus = State(initialValue: task.status)
        _editedGoal = State(initialValue: task.goal)
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // タイトル
                TextField("タイトル", text: $editedTitle)
                    .font(.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(!isEditing)
                
                // 説明
                Text("説明")
                    .font(.headline)
                TextEditor(text: $editedDescription)
                    .frame(minHeight: 100)
                    .padding(4)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .disabled(!isEditing)
                
                // 期限
                DatePicker("期限", selection: $editedDueDate, displayedComponents: [.date, .hourAndMinute])
                    .disabled(!isEditing)
                
                // 優先度
                Picker("優先度", selection: $editedPriority) {
                    ForEach(TaskPriority.allCases, id: \.self) { priority in
                        Text(priority.rawValue).tag(priority)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .disabled(!isEditing)
                
                // ステータス
                Picker("ステータス", selection: $editedStatus) {
                    ForEach(TaskStatus.allCases, id: \.self) { status in
                        Text(status.rawValue).tag(status)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .disabled(!isEditing)
                
                // 目標
                TextField("目標", text: $editedGoal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(!isEditing)
                
                if isEditing {
                    Button(action: saveChanges) {
                        Text("保存")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "キャンセル" : "編集") {
                    if isEditing {
                        // 編集をキャンセル
                        editedTitle = task.title
                        editedDescription = task.description
                        editedDueDate = task.dueDate
                        editedPriority = task.priority
                        editedStatus = task.status
                        editedGoal = task.goal
                    }
                    isEditing.toggle()
                }
            }
        }
    }
    
    private func saveChanges() {
        task.title = editedTitle
        task.description = editedDescription
        task.dueDate = editedDueDate
        task.priority = editedPriority
        task.status = editedStatus
        task.goal = editedGoal
        isEditing = false
    }
}

#Preview {
    TaskDetailView(task: Task(title: "サンプルタスク", description: "これはサンプルタスクです", dueDate: Date()))
} 