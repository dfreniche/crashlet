//
//  AppDelegate.swift
//  CrashLet
//
//  Created by Diego Freniche Brito on 18/03/15.
//  Copyright (c) 2015 Freniche. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet var view: NSView!
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var menu: NSMenu!
    
    var end: Bool = false
    
    var timer: Timer?
    var showing: Bool = true
    var statusItem: NSStatusItem?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.view.wantsLayer = true
        self.view.layer?.cornerRadius = 20.0
        self.label.layer?.cornerRadius = 20.0
        self.view.layer?.backgroundColor = NSColor.clear.cgColor
        self.window.backgroundColor = NSColor.clear

        self.window.isOpaque = false
        addIconToStatusBar()
        
        mainLoop()
    }

    func addIconToStatusBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.image = NSImage(named: NSImage.Name(rawValue: "skull-n-bones"))
        statusItem?.menu = self.menu
    }
    
    @objc func mainLoop() {
        if showing {
        } else {
        }
        
        self.showing = !self.showing
        showWindow(self.window, fromAppDelegate: self)

        let randomNumber = 10 + arc4random() % 60
        print("Random \( randomNumber )")
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(randomNumber), target: self, selector: #selector(AppDelegate.mainLoop), userInfo: nil, repeats: false)
    }
    
    func showWindow(_ window: NSWindow, fromAppDelegate: NSApplicationDelegate) {
        window.makeKeyAndOrderFront(fromAppDelegate)
        NSApp.activate(ignoringOtherApps: true)
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            context.duration = 1.5
            window.animator().alphaValue = 1
        }, completionHandler: { [weak self] () -> Void in
            sleep(1)
            self?.hideWindow(window, fromAppDelegate: fromAppDelegate)
        })
    }
    
    func hideWindow(_ window: NSWindow, fromAppDelegate: NSApplicationDelegate) {
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            context.duration = 1.5
            window.animator().alphaValue = 0
        }, completionHandler: { () -> Void in
            window.orderOut(fromAppDelegate)
        })
    }
}

