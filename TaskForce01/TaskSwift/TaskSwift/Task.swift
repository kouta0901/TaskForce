import Foundation

public struct Task: Identifiable, Codable {
    public let id: UUID
    public var title: String
    public var description: String
    public var dueDate: Date
    public var priority: TaskPriority
    public var status: TaskStatus
    public var goal: String
    
    public init(id: UUID = UUID(), title: String, description: String, dueDate: Date, priority: TaskPriority = .medium, status: TaskStatus = .notStarted, goal: String = "") {
        self.id = id
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.priority = priority
        self.status = status
        self.goal = goal
    }
}

public enum TaskPriority: String, Codable, CaseIterable {
    case low = "低"
    case medium = "中"
    case high = "高"
}

public enum TaskStatus: String, Codable, CaseIterable {
    case notStarted = "未着手"
    case inProgress = "進行中"
    case completed = "完了"
}

extension Task {
    static var sampleTasks: [Task] = [
        Task(title: "買い物", description: "食料品を買う", dueDate: Date().addingTimeInterval(86400)),
        Task(title: "レポート", description: "週次レポートを作成", dueDate: Date().addingTimeInterval(172800))
    ]
} 