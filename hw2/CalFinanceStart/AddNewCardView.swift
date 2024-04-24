//
//  AddNewCardView.swift
//  CalFinance
//
//  Created by Justin Wong on 1/14/24.
//

import SwiftUI

/// View that users can add a new credit card. Presented by ``MyCardsView``.
struct AddNewCardView: View {
    @Environment(\.dismiss) private var dismiss
    
    var cardManager: CardManager 
    @State private var ownerName = ""
    @State private var cardNumber = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                TitleTextFieldView(title: "Owner Name", contentText: $ownerName)
                VStack(alignment: .leading, spacing: 10) {
                    TitleTextFieldView(title: "Card Number", contentText: $cardNumber)
                    Button(action: {
                        generateCreditCardNumber()
                    }) {
                        generateCreditCardNumberButton
                    }
                    
                }
                Spacer()
                Button(action: {
                    var newcard=CFCard(cardNumber: cardNumber, ownerName: ownerName, balance: 0, transactions: [])
                    cardManager.addCard(for: newcard)
                    dismiss()
                }) {
                    addCreditCardButton
                }
            }
            .navigationTitle("Add New Card")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                            .font(.system(size: 25))
                    }
                }
            }
        }
    }
    
    //TODO: Implement generateCreditCardNumberButton
    private var generateCreditCardNumberButton: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.green)
            .stroke(.white, lineWidth: 2)
            .overlay( Text("Generate Credit Card Number !")
                .bold()
                .foregroundColor(.white))
            .frame(height: 45)
    }
    
    //TODO: Implement addCreditCardButton 
    private var addCreditCardButton: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue)
            .stroke(.white, lineWidth: 2)
            .overlay( Text("Add Credit Card !")
                .bold()
                .foregroundColor(.white))
            .frame(height: 45)
    }
    
    private func generateCreditCardNumber() {
        cardNumber = cardManager.createCreditCardNumber()
    }
}

/// A helper view that customizes a `TextField` by adding an associated title at the top as well as some UI customization.
struct TitleTextFieldView: View {
    var title: String
    @Binding var contentText: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .bold()
            RoundedRectangle(cornerRadius: 10)
                .fill(.blue.opacity(0.1))
                .stroke(.blue, lineWidth: 1)
                .frame(height: 50)
                .overlay(
                    TextField("Enter \(title)", text: $contentText)
                        .padding(10)
                        .bold()
                )
        }
    }
}

#Preview {
    AddNewCardView(cardManager: CardManager())
}
