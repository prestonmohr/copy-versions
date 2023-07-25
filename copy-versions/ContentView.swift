//
//  ContentView.swift
//  copy-versions
//
//  Created by Preston Mohr on 3/16/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var fileList = ""
    @State private var targetDirectory = ""
    @State private var fileExtension = ".mov"
    @State private var missingFiles: [String] = []
    @State private var copyStatus: String = ""
    @AppStorage("sourceDirectory") var sourceDirectory = ""
    @AppStorage("treeStructure") var treeStructure = "seq/shot"
    @State private var isSettingsWindowOpen = false

    
    var body: some View {
        ScrollView {
            Section {
                HStack{
                    Text("Copy Versions v1.30")
                        .font(.largeTitle)
                        .bold()
                    Button(action: openSettings) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.blue)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom)
            
            Section {
                VStack{
                    if #available(macOS 13.0, *) {
                        Text("Version Names Paste Bin")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .bold()
                    } else {
                        Text("**Version Names Paste Bin**")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            //.bold()
                    }
                    if #available(macOS 13.0, *) {
                        Text("file extensions (.mov, .mxf, .mp4) and extra spaces will be ignored")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .italic()
                    } else {
                        Text("_file extensions (.mov, .mxf, .mp4) and extra spaces will be ignored_")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            //.italic()
                    }
                }
            }
            .padding(.leading)
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Section {
                TextEditor(text: $fileList)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(minHeight: 50)
            }
            .padding()
            
            Section {
                VStack{
                    if #available(macOS 13.0, *) {
                        Text("Select Directory")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .bold()
                    } else {
                        Text("**Select Directory**")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            //.bold()
                    }
                    if #available(macOS 13.0, *) {
                        Text("select a directory for the files to be copied to")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .italic()
                    } else {
                        Text("_select a directory for the files to be copied to_")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            //.italic()
                    }
                }
            }
            .padding(.leading)
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Section {
                HStack {
                    Button(action: selectDirectory) {
                        Image(systemName: "folder")
                            .foregroundColor(.blue)
                    }
                    TextField("Enter target directory", text: $targetDirectory)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .padding(.leading)
            .padding(.trailing)
            
            Section {
                VStack{
                    if #available(macOS 13.0, *) {
                        Text("Select Filetype")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .bold()
                    } else {
                        Text("**Select Filetype**")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            //.bold()
                    }
                    if #available(macOS 13.0, *) {
                        Text("choose between .mov and .mxf")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .italic()
                    } else {
                        Text("_choose between .mov and .mxf_")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            //.italic()
                    }
                }
            }
            .padding(.leading)
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .leading)
             
            Section {
                HStack {
                    Text("Filetype: ")
                    Button(action: { fileExtension = ".mov" }) {
                        Text(".mov")
                            .foregroundColor(fileExtension == ".mov" ? .blue : .primary
)
                            .cornerRadius(10)
                    }
                    
                    Button(action: { fileExtension = ".mxf" }) {
                        Text(".mxf")
                            .foregroundColor(fileExtension == ".mxf" ? .blue : .primary)
                            .cornerRadius(10)
                    }
                    
                    Button(action: { fileExtension = ".mp4" }) {
                        Text(".mp4")
                            .foregroundColor(fileExtension == ".mp4" ? .blue : .primary)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.leading)
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Section {
                Button(action: copyFiles) {
                    Text("Copy Files")
                        .bold()
                        .padding()
                        .cornerRadius(10)
                }
            }
            
            Section {
                VStack{
                    if #available(macOS 13.0, *) {
                        Text("Results")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .bold()
                    } else {
                        Text("**Results**")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            //.bold()
                    }
                    if #available(macOS 13.0, *) {
                        Text("information will appear below after a copy attempt is made")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .italic()
                    } else {
                        Text("_information will appear below after a copy attempt is made_")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            //.italic()
                    }
                }
            }
            .padding(.leading)
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            
            
            Section {
                
                Divider()
                if !(missingFiles.filter { $0 != "mov" && $0 != "mxf" && $0 != "mp4" && $0 != ".mov" && $0 != ".mxf" && $0 != ".mp4"}).isEmpty {
                    Text("Missing Files:")
                        .bold()
                    
                    ForEach(missingFiles.filter { $0 != "mov" && $0 != "mxf" && $0 != "mp4" && $0 != ".mov" && $0 != ".mxf" && $0 != ".mp4"}, id: \.self) { file in
                        Text(file)
                    }
                } else if !copyStatus.isEmpty {
                    Text(copyStatus)
                }; if sourceDirectory.isEmpty || !FileManager.default.fileExists(atPath: sourceDirectory) {
                        Text("Error: Invalid source directory")
                            .foregroundColor(.red)
                }
            }
            .padding(.leading)
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(minWidth: 300, minHeight: 600)
    }
    
    func selectDirectory() {
        let openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = true
        openPanel.canChooseFiles = false
        openPanel.allowsMultipleSelection = false
        openPanel.canCreateDirectories = true
        
        openPanel.begin { response in
            if response == NSApplication.ModalResponse.OK {
                if let url = openPanel.url {
                    targetDirectory = url.path
                }
            }
        }
    }
    
    func copyFiles() {
        
        if fileList.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                copyStatus = "Please enter files to be copied"
                return
        }
            
        if targetDirectory.isEmpty || !FileManager.default.fileExists(atPath: targetDirectory) {
            copyStatus = "Please select a valid directory"
            return
        }
        
        let fileManager = FileManager.default
        missingFiles.removeAll()
        
        let files = fileList.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: CharacterSet.newlines)
        
        for file in files {
            var trimmedFile = file.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if trimmedFile.hasSuffix(".mov") || trimmedFile.hasSuffix(".mxf") || trimmedFile.hasSuffix(".mp4") || trimmedFile.hasSuffix("-exr") {
                            trimmedFile.removeLast(4)
            }
            
            trimmedFile = trimmedFile + fileExtension
            
            let seq = trimmedFile.prefix(3)
            let scene = trimmedFile.prefix(7).suffix(3)
            let shot = trimmedFile.prefix(12)
            let num = shot.suffix(4)
            
            let sourcePath: String
                switch treeStructure {
                    case "shot":
                        sourcePath = sourceDirectory + "/" + shot + "/" + trimmedFile
                    case "seq/shot":
                        sourcePath = sourceDirectory + "/" + seq + "/" + shot + "/" + trimmedFile
                    case "scene/shot":
                        sourcePath = sourceDirectory + "/" + scene + "/" + shot + "/" + trimmedFile
                    case "seq/scene":
                        sourcePath = sourceDirectory + "/" + seq + "/" + scene + "/" + trimmedFile
                    case "seq/scene/shot":
                        sourcePath = sourceDirectory + "/" + seq + "/" + scene + "/" + shot + "/" + trimmedFile
                    case "seq/num":
                        sourcePath = sourceDirectory + "/" + seq + "/" + num + "/" + trimmedFile
                    case "seq/num/shot":
                        sourcePath = sourceDirectory + "/" + seq + "/" + num + "/" + shot + "/" + trimmedFile
                    case "seq/scene/num":
                        sourcePath = sourceDirectory + "/" + seq + "/" + scene + "/" + num + "/" + trimmedFile
                    case "seq/scene/num/shot":
                        sourcePath = sourceDirectory + "/" + seq + "/" + scene + "/" + num + "/" + shot + "/" + trimmedFile
                    case "scene/seq":
                        sourcePath = sourceDirectory + "/" + scene + "/" + seq + "/" + trimmedFile
                    case "scene/seq/shot":
                        sourcePath = sourceDirectory + "/" + scene + "/" + seq + "/" + shot + "/" + trimmedFile
                    case "scene/num":
                        sourcePath = sourceDirectory + "/" + scene + "/" + num + "/" + trimmedFile
                    case "scene/num/shot":
                        sourcePath = sourceDirectory + "/" + scene + "/" + num + "/" + shot + "/" + trimmedFile
                    case "scene/seq/num":
                        sourcePath = sourceDirectory + "/" + scene + "/" + seq + "/" + num + "/" + trimmedFile
                    case "scene/seq/num/shot":
                        sourcePath = sourceDirectory + "/" + scene + "/" + seq + "/" + num + "/" + shot + "/" + trimmedFile
                    case "seq_scene/shot":
                        sourcePath = sourceDirectory + "/" + seq + "_" + scene + "/" + shot + "/" + trimmedFile
                    case "seq_scene/num":
                        sourcePath = sourceDirectory + "/" + seq + "_" + scene + "/" + num + "/" + trimmedFile
                    case "seq_scene/num/shot":
                        sourcePath = sourceDirectory + "/" + seq + "_" + scene + "/" + num + "/" + shot + "/" + trimmedFile
                    case "scene_seq/shot":
                        sourcePath = sourceDirectory + "/" + scene + "_" + seq + "/" + shot + "/" + trimmedFile
                    case "scene_seq/num":
                        sourcePath = sourceDirectory + "/" + scene + "_" + seq + "/" + num + "/" + trimmedFile
                    case "scene_seq/num/shot":
                        sourcePath = sourceDirectory + "/" + scene + "_" + seq + "/" + num + "/" + shot + "/" + trimmedFile
                    case "seq/scene_num":
                        sourcePath = sourceDirectory + "/" + seq + "/" + scene + "_" + num + "/" + trimmedFile
                    case "seq/scene_num/shot":
                        sourcePath = sourceDirectory + "/" + seq + "/" + scene + "_" + num + "/" + shot + "/" + trimmedFile
                    case "scene/seq_num":
                        sourcePath = sourceDirectory + "/" + scene + "/" + seq + "_" + num + "/" + trimmedFile
                    case "scene/seq_num/shot":
                        sourcePath = sourceDirectory + "/" + scene + "/" + seq + "_" + num + "/" + shot + "/" + trimmedFile
                    case "seq/seq_scene/shot":
                        sourcePath = sourceDirectory + "/" + seq + "/" + seq + "_" + scene + "/" + shot + "/" + trimmedFile
                    case "seq/seq_scene/num":
                        sourcePath = sourceDirectory + "/" + seq + "/" + seq + "_" + scene + "/" + num + "/" + trimmedFile
                    case "seq/seq_scene/num/shot":
                        sourcePath = sourceDirectory + "/" + seq + "/" + seq + "_" + scene + "/" + num + "/" + shot + "/" + trimmedFile
                    case "scene/seq_scene/shot":
                        sourcePath = sourceDirectory + "/" + scene + "/" + seq + "_" + scene + "/" + shot + "/" + trimmedFile
                    case "scene/seq_scene/num":
                        sourcePath = sourceDirectory + "/" + scene + "/" + seq + "_" + scene + "/" + num + "/" + trimmedFile
                    case "scene/seq_scene/num/shot":
                        sourcePath = sourceDirectory + "/" + scene + "/" + seq + "_" + scene + "/" + num + "/" + shot + "/" + trimmedFile
                    case "seq/scene_seq/shot":
                        sourcePath = sourceDirectory + "/" + seq + "/" + scene + "_" + seq + "/" + shot + "/" + trimmedFile
                    case "seq/scene_seq/num":
                        sourcePath = sourceDirectory + "/" + seq + "/" + scene + "_" + seq + "/" + num + "/" + trimmedFile
                    case "seq/scene_seq/num/shot":
                        sourcePath = sourceDirectory + "/" + seq + "/" + scene + "_" + seq + "/" + num + "/" + shot + "/" + trimmedFile
                    case "scene/scene_seq/shot":
                        sourcePath = sourceDirectory + "/" + scene + "/" + scene + "_" + seq + "/" + shot + "/" + trimmedFile
                    case "scene/scene_seq/num":
                        sourcePath = sourceDirectory + "/" + scene + "/" + scene + "_" + seq + "/" + num + "/" + trimmedFile
                    case "scene/scene_seq/num/shot":
                        sourcePath = sourceDirectory + "/" + scene + "/" + scene + "_" + seq + "/" + num + "/" + shot + "/" + trimmedFile
                    default:
                            sourcePath = "" // Handle default case here
                }
            
            let destinationPath = targetDirectory + "/" + trimmedFile
            
            print("Source Path:" + sourcePath)
            print("Destination Path:" + destinationPath)
            
            let sourceURL = URL(fileURLWithPath: sourcePath)
            let destinationURL = URL(fileURLWithPath: destinationPath)
            
            if fileManager.fileExists(atPath: sourcePath) {
                do {
                    _ = sourceURL.startAccessingSecurityScopedResource()
                    _ = destinationURL.startAccessingSecurityScopedResource()
                    
                    if sourceURL.startAccessingSecurityScopedResource() && destinationURL.startAccessingSecurityScopedResource() {
                        try fileManager.copyItem(at: sourceURL, to: destinationURL)
                    } else {
                        print("Could not access security scoped resource")
                        copyStatus = "Could not access security scoped resource. Please check app permissions"
                    }
                    
                    sourceURL.stopAccessingSecurityScopedResource()
                    destinationURL.stopAccessingSecurityScopedResource()

                } catch {
                    print(error.localizedDescription)
                }
            } else {
                missingFiles.append(trimmedFile)
            }
            
        }
        
        if copyStatus == "Could not access security scoped resource. Please check app permissions" {
            return;
        }
        else if missingFiles.isEmpty {
                copyStatus = "All file(s) copied!"
        }
        else {
                copyStatus = ""
        }
    }
    
    func openSettings() {
        // Check if the settings window is already open
        guard !isSettingsWindowOpen else {
            return
        }
        
        let settingsWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 400),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: true
        )
        let settingsView = SettingsView(sourceDirectory: $sourceDirectory, treeStructure: $treeStructure, settingsWindow: settingsWindow)
        
        settingsWindow.contentView = NSHostingView(rootView: settingsView)
        
        settingsWindow.makeKeyAndOrderFront(nil)
        settingsWindow.center()
        
        // Set the state of the settings window to open
        isSettingsWindowOpen = true
        
        // Observe the settings window's close event
        NotificationCenter.default.addObserver(forName: NSWindow.willCloseNotification, object: settingsWindow, queue: nil) { _ in
            // Reset the state of the settings window to closed
            isSettingsWindowOpen = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
