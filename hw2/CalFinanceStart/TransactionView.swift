//
//  TransactionView.swift
//  CalFinance
//
//  Created by Justin Wong on 1/14/24.
//

import SwiftUI

/// View for a ``CFTransaction``. Shown as a list in ``MyCardsView``.
/// - Each ``CFTransaction`` has three types: transfer, deposit, and purchase. Depending on the type, `TransactionView` will show the appropriate UI.
struct TransactionView: View {
    var transaction: CFTransaction
    
    var body: some View {
        //TODO: Implement TransactionView body
        RoundedRectangle(cornerRadius: 10)
            .fill(getTransactionColor())
            .stroke(.black, lineWidth: 1)
            .overlay(
                VStack(alignment:.leading){
            creditCardNumberSection
            HStack{
                imageSection
                transactionNameSection
                infoSection
            }
        }
        )
            .frame(height: 100)
    }
    
    //Credit card number at the top
    private var creditCardNumberSection: some View {
        //TODO: Implement creditCardNumberSection
        Text(transaction.associatedCardNumber)
    }
    
    //Transaction type image
    private var imageSection: some View {
        //TODO: Implement imageSection
        Image(systemName: getTransactionImageName())
        
    }
    
    //"Transfer", "Deposit", "Purchase"
    private var transactionNameSection: some View {
        //TODO: Implement transactionNameSection
        switch transaction.type {
        case .transfer:
            return Text("Transfer")
                .bold()
        case .deposit:
            return Text("Deposit")
                .bold()
        case .purchase:
            return Text("Purchase")
                .bold()
        }
    }
    
    //Right hand side transaction information
    //HINT: Use BalanceAmountView here!
    private var infoSection: some View {
        //TODO: Implement infoSection
        VStack{
            BalanceAmountView(amount: transaction.changeAmount)
            Text(transaction.date, style: .date)
        }
    }
    
    //MARK: - Helper Functions
    //Don't forget to use these functions!! They are indeed quite handy.
    //💡 TIP: To view these function's documentation in a more prettier way, <Option> click on the function names.
    
    /// For the current transaction, get the associated color. For example, if the transaction is of type `transfer`, &nbsp; `getTransactionColor()` returns `Color.green`.
    /// - Returns: The associated transaction color.
    private func getTransactionColor() -> Color {
        switch transaction.type {
        case .transfer:
            return .green
        case .deposit:
            return .gray
        case .purchase:
            return .red
        }
    }
    
    /// For the current transaction, get the associated system SF Symbols image name which is a `String`. Use it with `Image`.
    /// - Returns: The associated transaction SF Symbols image name.
    private func getTransactionImageName() -> String {
        switch transaction.type {
        case .transfer:
            return "tray.and.arrow.up.fill"
        case .deposit:
            return "tray.and.arrow.down.fill"
        case .purchase:
            return "dollarsign.square.fill"
        }
    }
}

struct TransactionViewPreviewProvider: PreviewProvider {
    static var cardManager = CardManager()
    static var previews: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading){
                Text("Purchase Transaction View:")
                    .bold()
                TransactionView(transaction: CFTransaction(type: .purchase, changeAmount: -10000, date: Date(), associatedCardNumber: cardManager.createCreditCardNumber()))
            }
            
            VStack(alignment: .leading) {
                Text("Transfer Transaction View:")
                    .bold()
                TransactionView(transaction: CFTransaction(type: .transfer, changeAmount: -10000, date: Date(), associatedCardNumber: cardManager.createCreditCardNumber()))
            }
            
            VStack(alignment: .leading) {
                Text("Deposit Transaction View:")
                    .bold()
                TransactionView(transaction: CFTransaction(type: .deposit, changeAmount: -10000, date: Date(), associatedCardNumber: cardManager.createCreditCardNumber()))
            }
        }
        .padding()
    }
}

