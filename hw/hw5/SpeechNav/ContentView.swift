//
//  ContentView.swift
//  SpeechNavFinished
//
//  Created by Justin Wong on 3/4/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var commandsHistory: [SpeechControlCommandType]
    var speechControlVM: SpeechControlViewModel
    @State var realstack: [SpeechControlCommandType]=[]
    @State var ispresented=false
    @State var alertpresented=false
    var body: some View {
        //TASK 3. Implement Navigation and Presentation HERE
        NavigationStack(path: $realstack){
            Color.red
                .opacity(0.1) // Set the opacity to 10%
                .ignoresSafeArea(.all)
                .navigationDestination(for:SpeechControlCommandType.self){
                    commandType in
                    switch commandType{
                    case .pushNavigation:
                        Color.blue.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    default:
                        EmptyView()
                    }
        }
                .sheet(isPresented: $ispresented, content: {
                    Color.green.ignoresSafeArea(.all)
                })
                .alert("Team Breezy",isPresented: $alertpresented) {
                    Button(action: {
                        dismiss()
                    }) {
                    Text("OK")
                    }
                }
        }
        
        //DO NOT DELETE this .onAppear MODIFIER
        .onAppear {
            speechControlVM.setCompletionHandler(for: executeVoiceCommand(for:))
        }
    }
    
    private func executeVoiceCommand(for lastTwoCommands: [String]) {
        //TASK 2A. Implement basic structure for executeVoiceCommand(for:)
        guard let commandType = SpeechControlManager.getCommandTypeFromSpeechTexts(for: lastTwoCommands) else {
            return
        }
        if commandType == .resume && speechControlVM.isSpeechControlPaused {
            speechControlVM.isSpeechControlPaused = false
        }
        guard !speechControlVM.isSpeechControlPaused else {
            return
        }
        commandsHistory.append(commandType)
        switch commandType {
        case .pushNavigation:
            realstack.append(commandType)
            break
        case .popNavigation:
            if realstack.last == .pushNavigation {
                        realstack.removeLast()
                    } else {
                        print("Error: Pop command not preceded by a Push command.")
                    }
        case .showAlert:
            realstack.append(commandType)
            alertpresented=true
            break
        case .dismissAlert:
            realstack.append(commandType)
            alertpresented=false
            break
        case .showSheet:
            ispresented=true
            realstack.append(commandType)
            break
        case .dismissSheet:
            realstack.append(commandType)
            ispresented=false
        case .resume:
            realstack.append(commandType)
            break
        case .stop:
            realstack.append(commandType)
            speechControlVM.isSpeechRecMicEnabled=false
            break
        case .pause:
            realstack.append(commandType)
            speechControlVM.isSpeechControlPaused=true
            break
        default:
            break
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    // Create a state variable to hold the commands history.
    @State static var previewCommandsHistory: [SpeechControlCommandType] = []
    @State static var stack:
    [SpeechControlCommandType] = []
    static var previews: some View {
        // Pass a binding to the previewCommandsHistory state variable.
        ContentView(commandsHistory: $previewCommandsHistory, speechControlVM: SpeechControlViewModel())
    }
}
