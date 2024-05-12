//
//  Cards.swift
//  animations!
//
//  Created by Andy Huang on 3/11/24.
//

import SwiftUI

struct Cards: View {
    @State var toggled=true
    @State var selectedCard=0
    @State var cardIsSelected=false
    @Namespace var namespace
    var body: some View {
            if cardIsSelected{
                CardView(cardNum: selectedCard)
                    .matchedGeometryEffect(id: "card", in: namespace)
                    .offset(y:-200)
                    
                    .onTapGesture {
                        withAnimation{cardIsSelected.toggle()}
                    }
            }else{
                ZStack{
                    ForEach(0...5,id: \.self){ i in
                        CardView(cardNum: i)
                            .offset(y: toggled ? CGFloat(i)*5 : CGFloat(i)*50)
                            
                            .onTapGesture {
                                if toggled{
                                    withAnimation{toggled.toggle()}
                                }
                                else{
                                    withAnimation{toggled.toggle()}
                                    withAnimation{selectedCard=i}
                                    withAnimation{cardIsSelected.toggle()}
                                }
                            }
                    }
                    .matchedGeometryEffect(id: "card", in: namespace)
                }
               
                
        }
    }
    
    // Do not modify
    struct CardView: View {
        var cardNum: Int
        var body: some View {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: 300, height: 200)
                .foregroundStyle(.blue)
                .shadow(radius: 10)
                .overlay {
                    Text("Card: \(cardNum)")
                        .foregroundStyle(.white)
                        .font(.title2)
                }
        }
    }
}

#Preview {
    Cards()
}
