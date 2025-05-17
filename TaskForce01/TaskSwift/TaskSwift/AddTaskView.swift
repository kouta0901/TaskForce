import SwiftUI

struct AddTaskView: View {
    @StateObject private var taskManager = TaskManager()
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(red: 108/255, green: 109/255, blue: 115/255).ignoresSafeArea()
            VStack(spacing: 32) {
                Spacer()
                Text("Set a Goal")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                VStack(alignment: .leading, spacing: 16) {
                    Text("タイトル")
                        .font(.headline)
                        .foregroundColor(.white)
                    TextField("タスクのタイトル", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    Text("説明")
                        .font(.headline)
                        .foregroundColor(.white)
                    TextEditor(text: $description)
                        .frame(height: 100)
                        .padding(4)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    Text("期限")
                        .font(.headline)
                        .foregroundColor(.white)
                    DatePicker("", selection: $dueDate, displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .padding(.horizontal)
                }
                Button(action: {
                    let task = Task(title: title, description: description, dueDate: dueDate)
                    taskManager.addTask(task)
                    dismiss()
                }) {
                    Text("Set")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#343434"))
                        .cornerRadius(8)
                }
                .padding(.horizontal, 32)
                .disabled(title.isEmpty)
                Spacer()
            }
        }
    }
}

#Preview {
    AddTaskView()
} 