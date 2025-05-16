import SwiftUI

struct AddTaskView: View {
    @StateObject private var taskManager = TaskManager()
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("タイトル")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        TextField("タスクのタイトル", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("説明")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        TextEditor(text: $description)
                            .frame(height: 100)
                            .padding(4)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("期限")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        DatePicker("", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(.compact)
                            .padding(.horizontal)
                    }
                    
                    Button(action: {
                        let task = Task(title: title, description: description, dueDate: dueDate)
                        taskManager.addTask(task)
                        dismiss()
                    }) {
                        Text("タスクを追加")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 124/255, green: 168/255, blue: 255/255))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .disabled(title.isEmpty)
                }
                .padding()
            }
            .navigationTitle("タスク追加")
            .background(Color(red: 108/255, green: 109/255, blue: 115/255))
        }
    }
}

#Preview {
    AddTaskView()
} 