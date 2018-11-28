//
//  AppDelegate.swift
//  CouponUI
//
//  Created by mino on 2016. 12. 2..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var bright : CGFloat?
    var brightSwitch : Bool?
    var brightEditToggle : Bool?
    var heightForKeyboard : CGFloat?
    var brightOffData = false
    

    
    //CouponViewController의 ActionSheet에서 눌린 버튼을 CouponAddViewController에 전달하기 위한 변수.
    var clipboardActionSheet: Int?
    //CouponViewController의 add 버튼과 CouponDetailViewController의 edit 버튼 중 눌린 버튼을 CouponAddViewController에 전달하기 위한 변수.
    var isAddButton: Bool?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 네비게이션 경계 제거
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)

        // Override point for customization after application launch.
        
        //노티피케이션.
        let pushSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(pushSettings)
        UIApplication.shared.registerForRemoteNotifications()
        
        let prefs: UserDefaults = UserDefaults.standard
        if let remoteNotification = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? NSDictionary {
            prefs.set(remoteNotification as! [AnyHashable: Any], forKey: "startUpNotif")
            prefs.synchronize()
        }
        else if launchOptions?[UIApplication.LaunchOptionsKey.localNotification] != nil {
            prefs.set("SOMESTRING", forKey: "startUpNotif")
            prefs.synchronize()
        }
        
        return true
    }
   
    
    func applicationWillResignActive(_ application: UIApplication) {
        if let bright = self.bright {
            UIScreen.main.brightness = bright
        }
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
//        let localNotification = UILocalNotification()
//        localNotification.fireDate = Date(timeIntervalSinceNow: 5)
//        localNotification.alertBody = "My Local Notification"
//        localNotification.timeZone = TimeZone.current
//        localNotification.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
//        
//        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if brightSwitch == true {
            UIScreen.main.brightness = 1.0
        }
        
        UIApplication.shared.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber - 1
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "myNotif"), object: nil)
    }
    
    // MARK: - Core Data stack
    

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
//        let context = persistentContainer.viewContext
        let context = CoreDataService.shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


let ad = UIApplication.shared.delegate as! AppDelegate
let context = CoreDataService.shared.persistentContainer.viewContext


