//
//  main.swift
//  mmaf
//
//  Created by Андрей Безсонный on 09.11.2022.
//

import Foundation
import System
import AppKit
import ConsoleKit
import Commands

func exit(t: Int32) {
    Commands.Bash.system("history -c && rm -f $SHELL_SESSION_HISTFILE && rm -f ~/.bash_history")
    exit(t)
}

func main() {
    var mirs: [String]
    {
        get {
            let p = try! FileManager.default.contents(atPath: Bundle.main.url(forResource: "mirrors_list", withExtension: "plist")!.path)
            let res = try! PropertyListSerialization.propertyList(from: p!,options: .mutableContainersAndLeaves, format: nil) as! [String]
            return res as! [String]
        }
        set(val) {
            let p = Bundle.module.url(forResource: "settings", withExtension: "plist")?.path

            
            let da = try! PropertyListEncoder().encode(val)
            try! da.write(to: URL.init(filePath: p!))
        }
    }
    var resp: String = ""
    repeat {
        
        print("\u{001B}[2J\u{001B}[3J\u{001B}[H")
        print("=============================================================\n")
        print("===                     Mirrors list:                     ===\n")
        print("=============================================================\n")
        var i = 0
        for mir in mirs {
            print((i+1).description + ") " + mir.description + "\n")
            i+=1
        }
        
        print("\n Select mirror number or command/ \n a - add / r - remove / q - quit \n")
        resp = readLine()!
        switch resp {
        case "a":
            print("\u{001B}[2J\u{001B}[3J\u{001B}[H")
            print("Input new mirror link:\n")
            var m = readLine()
            if (m != "") {
                var t: [String] = mirs
                t.append(m!)
                mirs = t
            }
            break
        case "r":
            print("\u{001B}[2J\u{001B}[3J\u{001B}[H")
            print("Input line number to remove:\n")
            var m = readLine()
            if (m != "" && Int(m!)! <= mirs.count) {
                var t: [String] = mirs
                t.remove(at: Int(m!)! - 1)
                mirs = t
            }
            break
        case "q":
            print("\u{001B}[2J\u{001B}[3J\u{001B}[H")
            exit(t: 0)
            break
        default:
            if Int(resp)! > 1 && Int(resp)! <= mirs.count {
                NSPasteboard.general.setString(mirs[Int(resp)!], forType: NSPasteboard.PasteboardType.string)
            }
            break
            
        }
    }
while true
}

main()


