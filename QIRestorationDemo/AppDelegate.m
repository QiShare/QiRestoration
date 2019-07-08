//
//  AppDelegate.m
//  QIRestorationDemo
//
//  Created by QLY on 2019/6/30.
//  Copyright © 2019 qishare. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = UIColor.whiteColor;
//    [self.window makeKeyAndVisible];
//    
//    ViewController  *viewCtrl = [[ViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewCtrl];
//    self.window.rootViewController= nav;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    return YES;
}
- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    return YES;
}
- (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"状态将要保存");
}
- (void) application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"状态已经恢复");
}
/*
 注意：如果我们没有指明：恢复每一个控制器时 用于创建此控制器的对象所属的类，则必须在AppDelegate中实现此方法：让我们可以在恢复期间创建一个新的控制器。
 */

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents coder:(NSCoder *)coder {
   
    UIViewController *vc;
    UIStoryboard *storyboard = [coder decodeObjectForKey:UIStateRestorationViewControllerStoryboardKey];
    if (storyboard){
        //此处为何这样做？来自故事版的视图，会由UIKIT 自动帮我们查找和创建视图控制器的。若是使用从故事版初始化对象，反而对此初始化影响恢复。
        /*vc = [storyboard instantiateViewControllerWithIdentifier:identifierComponents.lastObject];
        vc.restorationIdentifier = [identifierComponents lastObject];
        vc.restorationClass = NSClassFromString(identifierComponents.lastObject);*/
        return nil;
        
    } else {
      vc = [[NSClassFromString(identifierComponents.lastObject) alloc]init];
    }
    
    
    return vc;

}
@end
