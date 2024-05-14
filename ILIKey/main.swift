//
//  AppDelegate.swift
//  ILIKey
//
//  Created by 陳奕利 on 2024/5/14.
//

import Cocoa
import Foundation
import ILIKeyMainAssembly
import InputMethodKit
import SwiftUI

var server = IMKServer()
var candidatesWindow = IMKCandidates()

// 此處的執行比 AppDelegate 的 applicationDidFinishLaunching 要更早。
// Insert code here to initialize your application
server = IMKServer(
    name: Bundle.main.infoDictionary?["InputMethodConnectionName"] as? String,
    bundleIdentifier: Bundle.main.bundleIdentifier
)
candidatesWindow = IMKCandidates(
    server: server,
    panelType: kIMKSingleColumnScrollingCandidatePanel,
    styleType: kIMKMain
)
NSLog("tried connection")

NSApplication.shared.delegate = AppDelegate.shared
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
