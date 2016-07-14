//
//  ViewController.m
//  MADPushyApp
//
//  Created by Mariia Cherniuk on 13.07.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)requestPermissionToNotify {
    UIMutableUserNotificationAction *missAction = [[UIMutableUserNotificationAction alloc] init];
    
    missAction.identifier = @"MISS_ACTION";
    missAction.title = @"Miss";
    missAction.activationMode = UIUserNotificationActivationModeBackground;
    missAction.authenticationRequired = NO;
    missAction.destructive = YES;
    
    UIMutableUserNotificationAction *handleAction = [[UIMutableUserNotificationAction alloc] init];
    
    handleAction.identifier = @"HANDLE_ACTION";
    handleAction.title = @"Handle";
    handleAction.activationMode = UIUserNotificationActivationModeForeground;
    handleAction.authenticationRequired = NO;
    handleAction.destructive = NO;

    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    
    category.identifier = @"MAIN_CATEGORY";
    [category setActions:@[missAction, handleAction] forContext:UIUserNotificationActionContextDefault];
    
    NSSet *categoriesSet = [NSSet setWithObjects:category, nil];
    UIUserNotificationType userNotificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound |UIUserNotificationTypeAlert;
    UIUserNotificationSettings *userNotificationSettings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:categoriesSet];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:userNotificationSettings];
}

- (void)createNotifications:(double)timeInterval {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:timeInterval];
//    The fire date is fixed in time. The notification will be fired at fireDate previous time zone, whatever time zone you are
    localNotification.timeZone = nil;
    localNotification.alertBody = @"Alert body";
    localNotification.alertTitle = @"Alert title";
    localNotification.alertAction = @"Okey";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 100;
    localNotification.category = @"MAIN_CATEGORY";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (IBAction)schedulePressed:(UIButton *)sender {
    [self requestPermissionToNotify];
    [self createNotifications:10];
}

@end
