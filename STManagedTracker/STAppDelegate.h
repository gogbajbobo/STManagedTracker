//
//  STAppDelegate.h
//  STManagedTracker
//
//  Created by Maxim Grigoriev on 5/14/13.
//  Copyright (c) 2013 Maxim Grigoriev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UDPushAuth/UDPushNotificationCenter.h>
#import <UDPushAuth/UDPushAuthCodeRetriever.h>
#import <Reachability/Reachability.h>

@interface STAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UDPushNotificationCenter *pushNotificatonCenter;
@property (strong, nonatomic) UDPushAuthCodeRetriever *authCodeRetriever;
@property (strong, nonatomic) Reachability *reachability;

@end
