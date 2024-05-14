//
//  AppDelegate.swift
//  ILIKey
//
//  Created by 陳奕利 on 2024/5/14.
//

import Foundation
import Cocoa
import SwiftUI
import InputMethodKit



class NSManualApplication: NSApplication {
	let appDelegate = AppDelegate()

	override init() {
		super.init()
		self.delegate = appDelegate
	}

	required init?(coder: NSCoder) {
		// No need for implementation
		fatalError("init(coder:) has not been implemented")
	}
}

@main
class AppDelegate: NSObject, NSApplicationDelegate {
	var server = IMKServer()
	var candidatesWindow = IMKCandidates()
	weak var configWindow: NSWindow?
	var configWindowController: NSWindowController?

	func openConfigWindow() {
		if let configWindow {
			// Show the window
			configWindow.level = .modalPanel
			configWindow.makeKeyAndOrderFront(nil)
		} else {
			let configWindow = NSWindow(
				contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
				styleMask: [.titled, .closable, .resizable, .borderless],
				backing: .buffered,
				defer: false
			)
			// Set the window title
			configWindow.title = "Settings"
			configWindow.contentViewController = NSHostingController(rootView: ConfigWindow())
			
			self.configWindowController = NSWindowController(window: configWindow)
			
			configWindow.level = .modalPanel
			configWindow.makeKeyAndOrderFront(nil)
			
			self.configWindow = configWindow
		}
	}

	func applicationDidFinishLaunching(_ notification: Notification) {
		// Insert code here to initialize your application
		self.server = IMKServer(name: Bundle.main.infoDictionary?["InputMethodConnectionName"] as? String, bundleIdentifier: Bundle.main.bundleIdentifier)
		self.candidatesWindow = IMKCandidates(server: server, panelType: kIMKSingleColumnScrollingCandidatePanel, styleType: kIMKMain)
		NSLog("tried connection")
	}

	func applicationWillTerminate(_ notification: Notification) {
		// Insert code here to tear down your application
	}
}
