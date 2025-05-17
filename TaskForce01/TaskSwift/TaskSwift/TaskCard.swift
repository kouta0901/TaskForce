import SwiftUI

public struct TaskCard: View {
    let task: Task
    
    public init(task: Task) { self.task = task }
    
    private var isDone: Bool { task.status == .completed }
    
    private var bgColor: Color {
        isDone ? Color(hex: "#dcdcdc")
               : Color.white 
    }
    private var textColor: Color {
        isDone ? Color(hex: "#696969")
               : Color(red: 34/255, green: 34/255, blue: 34/255)
    }
    private var subColor: Color {
        isDone ? Color(hex: "#696969")
               : Color.gray
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            /* ---- タイトル ---- */
            Text(task.title)
                .font(.title3).fontWeight(.semibold)
                .foregroundColor(textColor)
                .strikethrough(isDone, color: textColor)
            
            /* ---- 説明 ---- */
            Text(task.description)
                .font(.subheadline)
                .foregroundColor(subColor)
                .strikethrough(isDone, color: subColor)
            
            /* ---- 期限 ---- */
            Text("期限: \(task.dueDate, style: .date)")
                .font(.caption)
                .foregroundColor(subColor)
                .strikethrough(isDone, color: subColor)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(bgColor)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(red: 224/255, green: 224/255, blue: 224/255), lineWidth: 1)
        )
    }
}