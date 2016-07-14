//
//  AppDelegate.m
//  MADPushyApp
//
//  Created by Mariia Cherniuk on 13.07.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UILocalNotification *localNotification = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (localNotification) {
        [self configureControllerWithMessage:localNotification.alertBody title:@"Received on lounch" application:application];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [self configureControllerWithMessage:notification.alertBody title:@"Receive while running" application:application];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    [self configureControllerWithMessage:identifier title:@"Received on action" application:application];
    
    completionHandler();
}

- (void)configureControllerWithMessage:(NSString *)message title:(NSString *)title application:(UIApplication *)application {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Okey"
                                                          style:UIAlertActionStyleDefault
                                                        handler:nil];
    application.applicationIconBadgeNumber = 0;
    [alertController addAction:alertAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [application.keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}

@end
