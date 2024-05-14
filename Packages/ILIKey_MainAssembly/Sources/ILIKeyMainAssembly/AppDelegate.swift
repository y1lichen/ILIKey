// (c) 2022 and onwards The ilimi-IME Project (3-Clause BSD license).
// ====================
// This code is released under the 3-Clause BSD license (SPDX-License-Identifier: BSD-3-Clause)

import Cocoa
import InputMethodKit
import SwiftUI
import UserNotifications

// MARK: - AppDelegate

public class AppDelegate: NSObject, NSApplicationDelegate {
    // MARK: Public

    public static var shared = AppDelegate()

    public func applicationDidFinishLaunching(_ notification: Notification) {
        // Insert code here to initialize your application

        doOnFirstRun()
        // regist UserDefaluts
        registUserDefaultsSetting()
        // notification
        userNotificationCenter.delegate = self
        requestNotificationAuthorization()
        // 用程式碼方法補上MainMenu.xib
        NSApplication.shared.mainMenu = MainMenu()
        // NSLog("connection tried")
    }

    public func applicationWillTerminate(_ notification: Notification) {
        // Insert code here to tear down your application
    }

    // MARK: Internal

    weak var configWindow: NSWindow?
    var configWindowController: NSWindowController?

    var queryWindow: NSWindow?
    var settingsWindow: NSWindow?
    let userNotificationCenter = UNUserNotificationCenter.current()

    func doOnFirstRun() {}

    func registUserDefaultsSetting() {
        UserDefaults.standard.register(defaults: ["isHorizontalCandidatesPanel": true])
        UserDefaults.standard.register(defaults: ["limitInputWhenNoCandidate": false])
        UserDefaults.standard.register(defaults: ["showLiuKeyAfterZhuyin": true])
        UserDefaults.standard.register(defaults: ["silentMode": false])
        UserDefaults.standard.register(defaults: ["selectCandidateBy1to8": true])
        UserDefaults.standard.register(defaults: ["autoCheckUpdate": true])
    }

    // request the authorization for pushing local notification
    func requestNotificationAuthorization() {
        userNotificationCenter.requestAuthorization(options: [.alert, .badge]) {
            _, _ in
        }
    }

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

            configWindowController = NSWindowController(window: configWindow)

            configWindow.level = .modalPanel
            configWindow.makeKeyAndOrderFront(nil)

            self.configWindow = configWindow
        }
    }

    // 查碼視窗
    func showQueryWindow() {}
}

// MARK: UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    // 推送系統通知
    func pushInstantNotification(title: String, subtitle: String, body: String, sound: Bool) {
        userNotificationCenter.getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                return
            }
            let content = UNMutableNotificationContent()
            content.title = title
            content.subtitle = subtitle
            content.body = body
            if sound {
                content.sound = UNNotificationSound.default
            }
            // 使用uuid做為identifier
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
            self.userNotificationCenter.add(request) { _ in }
        }
    }
}
