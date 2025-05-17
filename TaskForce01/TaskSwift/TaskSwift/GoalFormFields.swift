import SwiftUI

struct GoalFormFields: View {
    @Binding var title: String
    @Binding var description: String
    @Binding var dueDate: Date

    private enum Field { case title, description }
    @FocusState private var focus: Field?

    var body: some View {
        VStack(spacing: 24) {

            Text("タイトル").formLabel()

            TextField("タスクのタイトル", text: $title)
                .formField()
                .focused($focus, equals: .title)        // ② フォーカス紐付け
                .submitLabel(.done)                     // キーボードの return 表示を "Done" に
                .onSubmit { focus = nil }               // return を押したらフォーカス解除

            Text("説明").formLabel()

            TextEditor(text: $description)
                .formField(height: 120)
                .focused($focus, equals: .description)  // ②
                // TextEditor は submitLabel が効かないためツールバーで閉じる
        }
        /* ③ 何かのフィールドがフォーカス中ならツールバーを表示 */
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                if focus != nil {                       // フォーカスがあるときだけ
                    Button("完了") { focus = nil }       // ← これで両方閉じる
                }
            }
        }
            /* ---- 期限 ---- */
            Text("期限")
                .formLabel()

            HStack {
                DatePicker("",
                          selection: $dueDate,
                          displayedComponents: [.date])
                    .labelsHidden()
                Spacer()
            }
            .formField()
        }
    }


extension View {
    func formLabel() -> some View {
        self.font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .center)
    }

    func formField(height: CGFloat? = 44) -> some View {
        self.padding(8)
            .frame(maxWidth: .infinity, minHeight: height, alignment: .leading)
            .background(Color(.systemGray6))
            .cornerRadius(8)
    }

    func sheetTitle() -> some View {
        self.font(.largeTitle).bold()
            .foregroundColor(.white)
            .padding(.top, 24)
    }

    func primaryWideButton() -> some View {
        self.foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(hex: "#343434"))
            .cornerRadius(8)
    }

    func sheetCard() -> some View {
        self.padding()
            .frame(maxWidth: 400)
            .background(Color(red: 108/255, green: 109/255, blue: 115/255))
            .cornerRadius(16)
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
            .ignoresSafeArea(.keyboard)
    }
} 