//
//  MarkdownTextView.swift
//  SwiftyMarkDownSample
//
//  Created by 藤治仁 on 2023/03/15.
//

import SwiftUI
import SwiftyMarkdown

struct MarkdownTextView: UIViewRepresentable {
    typealias UIViewType = UITextView
    let markdown: String
    /// コールバック
    var handler: ((URL) -> Void)?

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .link
        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        let swiftyMarkdown = SwiftyMarkdown(string: markdown)
        swiftyMarkdown.body.fontStyle = .bold
        textView.attributedText = swiftyMarkdown.attributedString()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        let parent: MarkdownTextView
        
        init(_ parent: MarkdownTextView) {
            self.parent = parent
        }
        
        func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            // タップされたリンクを検出
            print("Tapped URL: \(URL)")
            // カスタム動作を実行するかどうかを決定するために、このメソッドからtrueまたはfalseを返します。
            // trueを返すと、デフォルトのリンクタップ動作が実行されます。
            // falseを返すと、デフォルトの動作はキャンセルされ、カスタム動作のみが実行されます。
            if let handler = parent.handler {
                handler(URL)
                return false
            }
            return true
        }
    }
}
