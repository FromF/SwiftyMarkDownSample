//
//  ContentView.swift
//  SwiftyMarkDownSample
//
//  Created by 藤治仁 on 2023/03/15.
//

import SwiftUI

struct ContentView: View {
    @State var showingAlert = false
    @State var message = ""
    private let markdown1 =  "[Yahoo](https://www.yahoo.co.jp)."
    private let markdown2 = "[利用規約](Terms)と[プライバシーポリシー](PrivacyPolicy)"
    var body: some View {
        VStack {
            MarkdownTextView(
                markdown: markdown1,
                handler: nil
            )
            .frame(height: 20)
            .border(Color.red)
            .padding()
            
            MarkdownTextView(
                markdown: markdown2,
                handler: { url in
                    print(url)
                    if url.absoluteString == "Terms" {
                        message = "利用規約を押されました"
                        showingAlert.toggle()
                    } else if url.absoluteString == "PrivacyPolicy" {
                        message = "プライバシーポリシーを押されました"
                        showingAlert.toggle()
                    }
                }
            )
            .alert(message, isPresented: $showingAlert) {
                // nop
            }
            .frame(height: 20)
            .border(Color.red)
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
