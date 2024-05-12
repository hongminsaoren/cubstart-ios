//
//  ProgressBar.swift
//  animations!
//
//  Created by Andy Huang on 3/11/24.
//

import SwiftUI

struct ProgressBar: View {
    @State var progress = 0.0
    var result: String {
        progress >= 1.0 ? "Complete!" : "Loading…"
    }
    var body: some View {
        VStack{
            Text(result)
                .font(.system(size: 24))
                .bold()
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 12.5)
                    .strokeBorder(Color.gray,lineWidth: 1)
                    .frame(width: 300, height: 25)
                RoundedRectangle(cornerRadius: 12.5)
                    .fill(Color.blue)
                    .frame(width: 300*progress, height: 25)
            }
            .animation(.default, value: progress)
            Button(action:  {
                if progress < 1.0 {
                    progress += 0.2
                }
            }){
                Text("Add Progress")
            }
        }
    }
}
#Preview {
    ProgressBar()
}
