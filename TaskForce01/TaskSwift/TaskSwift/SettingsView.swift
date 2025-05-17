import SwiftUI

struct SettingsView: View {
    @State private var notificationStatus = "通知する"
    @State private var reminderCount = 3
    @State private var showConfirm = false
    var body: some View {
        ZStack {
            Color(red: 108/255, green: 109/255, blue: 115/255).ignoresSafeArea()
            VStack(spacing: 32) {
                Text("Setting")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                    .padding(.top, 40)
                VStack(spacing: 16) {
                    Text("通知を一時的に停止")
                        .font(.headline)
                        .foregroundColor(.white)
                    Picker("通知を一時的に停止", selection: $notificationStatus) {
                        Text("一時停止").tag("一時停止")
                        Text("通知する").tag("通知する")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(maxWidth: 200)
                }
                VStack(spacing: 16) {
                    Text("デフォルト通知回数")
                        .font(.headline)
                        .foregroundColor(.white)
                    Picker("デフォルト通知回数", selection: $reminderCount) {
                        ForEach(3...9, id: \.self) { n in
                            Text("\(n) 回")
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: 200)
                }
                Button(action: { showConfirm = true }) {
                    Text("すべてのGoalを削除")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#343434"))
                        .cornerRadius(8)
                }
                .padding(.horizontal, 32)
                Spacer()
            }
            if showConfirm {
                Color.black.opacity(0.3).ignoresSafeArea()
                VStack(spacing: 32) {
                    Text("あなたは人生を諦めるのですか？")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.top, 32)
                    HStack {
                        Button(action: { showConfirm = false }) {
                            Text("いいえ")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#343434"))
                                .cornerRadius(8)
                        }
                        .padding(.leading, 16)
                        Button(action: {
                            // Goal全削除処理
                            showConfirm = false
                        }) {
                            Text("はい")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#343434"))
                                .cornerRadius(8)
                        }
                        .padding(.trailing, 16)
                    }
                    .padding(.bottom, 32)
                }
                .frame(maxWidth: 340)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 20)
                .padding()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
} 