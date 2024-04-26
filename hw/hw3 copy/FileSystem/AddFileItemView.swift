//
//  AddFileItemView.swift
//  FileSystem
//
//  Created by Andy Huang on 1/19/24.
//

import SwiftUI

struct AddFileItemView: View {
    // Uncomment once you reach this step.
//    var directories: [String] {
//        return ["root"] + getDirectoryNames(files: files)
//    }
    
    let fileTypes: [String] = ["Folder", "Text", "Image", "Video"]
    @State private var filetype = "Folder"
    @State private var directory = "root"
    @State private var text = ""
    @Binding var files:[FileItem]
    @Binding  var flag : Bool
    var directories: [String] {
            return ["root"] + getDirectoryNames(files: files)
        }
    var body: some View {
        VStack{
            HStack{
                Text("Add File")
                    .font(.system(size: 30))
                    .bold()
                Spacer()
            }.padding()
            Spacer()
            HStack{
                TextField("", text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.yellow, lineWidth: 1)
                    )
                    .padding()
                Picker("Choose a directory",selection: $directory){
                    ForEach(directories,id:\.self){
                        Text($0)
                    }
                }
            }
            Spacer()
            Picker("Choose a file type",selection: $filetype){
                ForEach(fileTypes,id:\.self){
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            
           Spacer()
            Button(action: {
                var newfile=FileItem(name: text+getSuffixName(filetype: filetype), contents: "")
                insertNewFile(files: &files, parentDirectoryName: directory, newFile: newfile)
                flag=false
            }, label: {
                Text("Add")
                    .font(.system(size: 25))
            })
        }
    }
}

#Preview {
    ContentView(files: [
        FileItem(name: "Users", children:
          [FileItem(name: "guest", children:
            [FileItem(name: "Photos", children:
                        [FileItem(name: "photo001.jpg", contents: "")], contents: ""),
             FileItem(name: "Movies", children:
                        [FileItem(name: "movie001.mp4", contents: "")], contents: ""),
             FileItem(name: "Documents", children: [FileItem(name: "document.txt", contents: "dcsc")], contents: "")
            ], contents: ""),
          ], contents: ""),
        FileItem(name: "Shared", children: nil, contents: "")
    ])
}
