import SwiftUI

public struct TaskCard: View {
    let task: Task
    
    public init(task: Task) {
        self.task = task
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(task.title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color(red: 34/255, green: 34/255, blue: 34/255))
            
            Text(task.description)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("期限: \(task.dueDate, style: .date) \(task.dueDate, style: .time)")
                .font(.caption)
                .foregroundColor(Color(red: 136/255, green: 136/255, blue: 136/255))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(red: 224/255, green: 224/255, blue: 224/255), lineWidth: 1)
        )
    }
} 