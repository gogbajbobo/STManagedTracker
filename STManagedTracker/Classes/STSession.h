//
//  STGTSession.h
//  geotracker
//
//  Created by Maxim Grigoriev on 3/11/13.
//  Copyright (c) 2013 Maxim Grigoriev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STSessionManagement.h"
#import "STSessionManager.h"
#import "STManagedDocument.h"
#import "STSyncer.h"
#import "STTracker.h"
#import "STSettings.h"
#import "STSettingsController.h"
#import "STLogger.h"

@interface STSession : NSObject <STSession>

@property (strong, nonatomic) STManagedDocument *document;
@property (strong, nonatomic) STSyncer *syncer;
@property (strong, nonatomic) STTracker *locationTracker;
@property (strong, nonatomic) STTracker *batteryTracker;
@property (weak, nonatomic) id <STSessionManager> manager;
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *status;
@property (nonatomic, strong) id <STRequestAuthenticatable> authDelegate;
@property (nonatomic, strong) STSettingsController *settingsController;
@property (nonatomic, strong) STLogger *logger;

+ (STSession *)initWithUID:(NSString *)uid authDelegate:(id <STRequestAuthenticatable>)authDelegate controllers:(NSDictionary *)controllers;
+ (STSession *)initWithUID:(NSString *)uid authDelegate:(id <STRequestAuthenticatable>)authDelegate controllers:(NSDictionary *)controllers settings:(NSDictionary *)settings;
- (void)completeSession;
- (void)dismissSession;
- (void)settingsLoadComplete;

@end
