import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @State private var showingAddGoal = false
    
    var body: some View {
        ZStack {
            Color(red: 108/255, green: 109/255, blue: 115/255).ignoresSafeArea()
            VStack(spacing: 40) {
                Spacer()
                Text("TaskForce")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                Button(action: { showingAddGoal = true }) {
                    Text("Set Goal")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#343434"))
                        .cornerRadius(12)
                        .padding(.horizontal, 32)
                }
                Spacer()
            }
        }
        .sheet(isPresented: $showingAddGoal) {
            AddTaskView()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(TaskManager())
} 