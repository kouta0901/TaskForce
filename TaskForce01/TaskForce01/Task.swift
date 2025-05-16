import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var detail: String?
    var dueDate: Date?
    var isCompleted: Bool
    var createdAt: Date
    var priority: Priority

    enum Priority: String, CaseIterable, Codable {
        case low = "低"
        case medium = "中"
        case high = "高"
    }

    init(id: UUID = UUID(), title: String, detail: String? = nil, dueDate: Date? = nil, isCompleted: Bool = false, createdAt: Date = Date(), priority: Priority = .medium) {
        self.id = id
        self.title = title
        self.detail = detail
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.createdAt = createdAt
        self.priority = priority
    }
}

extension Task {
    static var sampleTasks: [Task] = [
        Task(title: "牛乳を買う", detail: "近所のスーパーで", dueDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()), priority: .high),
        Task(title: "SwiftUIの勉強", isCompleted: true, priority: .medium),
        Task(title: "部屋の掃除", dueDate: Calendar.current.date(byAdding: .day, value: 3, to: Date()), priority: .low),
        Task(title: "プロジェクトの資料作成", priority: .high)
    ]
} 