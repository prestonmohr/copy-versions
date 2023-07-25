//
//  SettingsView.swift
//  copy-versions
//
//  Created by Preston Mohr on 7/7/23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var sourceDirectory: String
    @Binding var treeStructure: String

    var settingsWindow: NSWindow
    
    let treeStructureOptions = [
            "shot",
            "seq/shot",
            "scene/shot",
            "seq/scene",
            "seq/scene/shot",
            "seq/num",
            "seq/num/shot",
            "seq/scene/num",
            "seq/scene/num/shot",
            "scene/seq",
            "scene/seq/shot",
            "scene/num",
            "scene/num/shot",
            "scene/seq/num",
            "scene/seq/num/shot",
            "seq_scene/shot",
            "seq_scene/num",
            "seq_scene/num/shot",
            "scene_seq/shot",
            "scene_seq/num",
            "scene_seq/num/shot",
            "seq/scene_num",
            "seq/scene_num/shot",
            "scene/seq_num",
            "scene/seq_num/shot",
            "seq/seq_scene/shot",
            "seq/seq_scene/num",
            "seq/seq_scene/num/shot",
            "scene/seq_scene/shot",
            "scene/seq_scene/num",
            "scene/seq_scene/num/shot",
            "seq/scene_seq/shot",
            "seq/scene_seq/num",
            "seq/scene_seq/num/shot",
            "scene/scene_seq/shot",
            "scene/scene_seq/num",
            "scene/scene_seq/num/shot"
        ]
    
    var treeStructureText: String {
        switch treeStructure {
            case "shot":
                return "i.e. ABC_001_0010: ABC_001_0010/\ni.e. 001_ABC_0010: 001_ABC_0010/"
            case "seq/shot":
                return "i.e. ABC_001_0010: ABC/ABC_001_0010/\ni.e. 001_ABC_0010: 001/001_ABC_0010/"
            case "scene/shot":
                return "i.e. ABC_001_0010: 001/ABC_001_0010/\ni.e. 001_ABC_0010: ABC/001_ABC_0010/"
            case "seq/scene":
                return "i.e. ABC_001_0010: ABC/001/\ni.e. 001_ABC_0010: 001/ABC/"
            case "seq/scene/shot":
                return "i.e. ABC_001_0010: ABC/001/ABC_001_0010/\ni.e. 001_ABC_0010: 001/ABC/001_ABC_0010/"
            case "seq/num":
                return "i.e. ABC_001_0010: ABC/0010/\ni.e. 001_ABC_0010: 001/0010/"
            case "seq/num/shot":
                return "i.e. ABC_001_0010: ABC/0010/ABC_001_0010/\ni.e. 001_ABC_0010: 001/0010/001_ABC_0010/"
            case "seq/scene/num":
                return "i.e. ABC_001_0010: ABC/001/0010/\ni.e. 001_ABC_0010: 001/ABC/0010/"
            case "seq/scene/num/shot":
                return "i.e. ABC_001_0010: ABC/001/0010/ABC_001_0010/\ni.e. 001_ABC_0010: 001/ABC/0010/001_ABC_0010/"
            case "scene/seq":
                return "i.e. ABC_001_0010: 001/ABC/\ni.e. 001_ABC_0010: ABC/001/"
            case "scene/seq/shot":
                return "i.e. ABC_001_0010: 001/ABC/ABC_001_0010/\ni.e. 001_ABC_0010: ABC/001/001_ABC_0010/"
            case "scene/num":
                return "i.e. ABC_001_0010: 001/0010/\ni.e. 001_ABC_0010: ABC/0010/"
            case "scene/num/shot":
                return "i.e. ABC_001_0010: 001/0010/ABC_001_0010/\ni.e. 001_ABC_0010: ABC/0010/001_ABC_0010/"
            case "scene/seq/num":
                return "i.e. ABC_001_0010: 001/ABC/0010/\ni.e. 001_ABC_0010: ABC/001/0010/"
            case "scene/seq/num/shot":
                return "i.e. ABC_001_0010: 001/ABC/0010/ABC_001_0010/\ni.e. 001_ABC_0010: ABC/001/0010/001_ABC_0010/"
            case "seq_scene/shot":
                return "i.e. ABC_001_0010: ABC_001/ABC_001_0010/\ni.e. 001_ABC_0010: 001_ABC/001_ABC_0010/"
            case "seq_scene/num":
                return "i.e. ABC_001_0010: ABC_001/0010/\ni.e. 001_ABC_0010: 001_ABC/0010/"
            case "seq_scene/num/shot":
                return "i.e. ABC_001_0010: ABC_001/0010/ABC_001_0010/\ni.e. 001_ABC_0010: 001_ABC/0010/001_ABC_0010/"
            case "scene_seq/shot":
                return "i.e. ABC_001_0010: 001_ABC/ABC_001_0010/\ni.e. 001_ABC_0010: ABC_001/001_ABC_0010/"
            case "scene_seq/num":
                return "i.e. ABC_001_0010: 001_ABC/0010/\ni.e. 001_ABC_0010: ABC_001/0010/"
            case "scene_seq/num/shot":
                return "i.e. ABC_001_0010: 001_ABC/0010/ABC_001_0010/\ni.e. 001_ABC_0010: ABC_001/0010/001_ABC_0010/"
            case "seq/scene_num":
                return "i.e. ABC_001_0010: ABC/001_0010/\ni.e. 001_ABC_0010: 001/ABC_0010/"
            case "seq/scene_num/shot":
                return "i.e. ABC_001_0010: ABC/001_0010/ABC_001_0010/\ni.e. 001_ABC_0010: 001/ABC_0010/ABC_001_0010/"
            case "scene/seq_num":
                return "i.e. ABC_001_0010: 001/ABC_0010/\ni.e. 001_ABC_0010: ABC/001_0010/"
            case "scene/seq_num/shot":
                return "i.e. ABC_001_0010: 001/ABC_0010/ABC_001_0010/\ni.e. 001_ABC_0010: ABC/001_0010/ABC_001_0010/"
            case "seq/seq_scene/shot":
                return "i.e. ABC_001_0010: ABC/ABC_001/ABC_001_0010/\ni.e. 001_ABC_0010: 001/001_ABC/001_ABC_0010/"
            case "seq/seq_scene/num":
                return "i.e. ABC_001_0010: ABC/ABC_001/0010/\ni.e. 001_ABC_0010: 001/001_ABC/0010/"
            case "seq/seq_scene/num/shot":
                return "i.e. ABC_001_0010: ABC/ABC_001/0010/ABC_001_0010/\ni.e. 001_ABC_0010: 001/001_ABC/0010/001_ABC_0010/"
            case "scene/seq_scene/shot":
                return "i.e. ABC_001_0010: ABC/ABC_001/ABC_001_0010/\ni.e. 001_ABC_0010: 001/001_ABC/001_ABC_0010/"
            case "scene/seq_scene/num":
                return "i.e. ABC_001_0010: ABC/ABC_001/0010/\ni.e. 001_ABC_0010: 001/001_ABC/0010/"
            case "scene/seq_scene/num/shot":
                return "i.e. ABC_001_0010: ABC/ABC_001/0010/ABC_001_0010/\ni.e. 001_ABC_0010: 001/001_ABC/0010/001_ABC_0010/"
            case "seq/scene_seq/shot":
                return "i.e. ABC_001_0010: ABC/001_ABC/ABC_001_0010/\ni.e. 001_ABC_0010: 001/ABC_001/001_ABC_0010/"
            case "seq/scene_seq/num":
                return "i.e. ABC_001_0010: ABC/001_ABC/0010/\ni.e. 001_ABC_0010: 001/ABC_001/0010/"
            case "seq/scene_seq/num/shot":
                return "i.e. ABC_001_0010: ABC/001_ABC/0010/ABC_001_0010/\ni.e. 001_ABC_0010: 001/ABC_001/0010/001_ABC_0010/"
            case "scene/scene_seq/shot":
                return "i.e. ABC_001_0010: ABC/001_ABC/ABC_001_0010/\ni.e. 001_ABC_0010: 001/ABC_001/001_ABC_0010/"
            case "scene/scene_seq/num":
                return "i.e. ABC_001_0010: ABC/001_ABC/0010/\ni.e. 001_ABC_0010: 001/ABC_001/0010/"
            case "scene/scene_seq/num/shot":
                return "i.e. ABC_001_0010: ABC/001_ABC/0010/ABC_001_0010/\ni.e. 001_ABC_0010: 001/ABC_001/0010/001_ABC_0010/"
            default:
                return ""
        }
    }
    
    var body: some View {
        VStack {
            if #available(macOS 13.0, *) {
                Text("Settings")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
            } else {
                Text("**Settings**")
                    .font(.title2)
                    .padding(.bottom)
            }
            
            if #available(macOS 13.0, *) {
                Text("Source Directory")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text("**Source Directory**")
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            if #available(macOS 13.0, *) {
                Text("i.e. /Volumes/VFX_server/shots")
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text("_i.e. /Volumes/VFX_server/shots_")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Section {
                HStack {
                    Button(action: selectDirectory) {
                        Image(systemName: "folder")
                            .foregroundColor(.blue)
                    }
                    TextField("Enter target directory", text: $sourceDirectory)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            
            if #available(macOS 13.0, *) {
                Text("Shot Tree Structure")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text("**Shot Tree Structure**")
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            if #available(macOS 13.0, *) {
                Text(treeStructureText)
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text(treeStructureText)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Picker(selection: $treeStructure, label: Text("Tree Structure")) {
                ForEach(treeStructureOptions, id: \.self) { option in
                    Text(option)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            
            Button(action: saveSettings) {
                Text("Save Settings")
                    .padding()
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    
    func saveSettings() {
        settingsWindow.close()
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
                    sourceDirectory = url.path
                }
            }
        }
    }
}

