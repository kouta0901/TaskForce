import SwiftUI

struct GoalView: View {
    @StateObject private var taskManager = TaskManager()
    @State private var newGoal: String = ""
    @State private var isEditing: Bool = false
    @State private var editingIndex: Int?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    if taskManager.goals.isEmpty {
                        Text("目標を設定してください")
                            .foregroundColor(.white)
                            .padding()
                    } else {
                        ForEach(Array(taskManager.goals.enumerated()), id: \.offset) { index, goal in
                            if isEditing && editingIndex == index {
                                TextEditor(text: $newGoal)
                                    .frame(height: 100)
                                    .padding(4)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    .padding(.horizontal)
                                
                                HStack {
                                    Button("保存") {
                                        taskManager.updateGoal(at: index, with: newGoal)
                                        isEditing = false
                                        editingIndex = nil
                                    }
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(red: 124/255, green: 168/255, blue: 255/255))
                                    .cornerRadius(8)
                                    
                                    Button("キャンセル") {
                                        isEditing = false
                                        editingIndex = nil
                                    }
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.gray)
                                    .cornerRadius(8)
                                }
                                .padding(.horizontal)
                            } else {
                                HStack {
                                    Text(goal)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(8)
                                    
                                    Button(action: {
                                        newGoal = goal
                                        isEditing = true
                                        editingIndex = index
                                    }) {
                                        Image(systemName: "pencil")
                                            .foregroundColor(.white)
                                    }
                                    .padding(.horizontal)
                                    
                                    Button(action: {
                                        taskManager.deleteGoal(at: index)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                    .padding(.trailing)
                                }
                            }
                        }
                    }
                    
                    if !isEditing {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("新しい目標")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            TextEditor(text: $newGoal)
                                .frame(height: 100)
                                .padding(4)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .padding(.horizontal)
                            
                            Button(action: {
                                if !newGoal.isEmpty {
                                    taskManager.addGoal(newGoal)
                                    newGoal = ""
                                }
                            }) {
                                Text("目標を追加")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(red: 124/255, green: 168/255, blue: 255/255))
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal)
                            .disabled(newGoal.isEmpty)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("目標設定")
            .background(Color(red: 108/255, green: 109/255, blue: 115/255))
        }
    }
}

#Preview {
    GoalView()
} 