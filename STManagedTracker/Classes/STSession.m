//
//  STGTSession.m
//  geotracker
//
//  Created by Maxim Grigoriev on 3/11/13.
//  Copyright (c) 2013 Maxim Grigoriev. All rights reserved.
//

#import "STSession.h"
#import "STSyncer.h"
#import "STLogger.h"
#import "STLocationTracker.h"
#import "STBatteryTracker.h"

@interface STSession()

@property (nonatomic, strong) NSDictionary *startSettings;

@end


@implementation STSession

+ (STSession *)initWithUID:(NSString *)uid authDelegate:(id <STRequestAuthenticatable>)authDelegate controllers:(NSDictionary *)controllers {
    return [self initWithUID:uid authDelegate:authDelegate controllers:(NSDictionary *)controllers settings:nil];
}

+ (STSession *)initWithUID:(NSString *)uid authDelegate:(id<STRequestAuthenticatable>)authDelegate controllers:(NSDictionary *)controllers settings:(NSDictionary *)settings {

    if (uid) {
        STSession *session = [[STSession alloc] init];
        session.uid = uid;
        session.startSettings = settings;
        session.authDelegate = authDelegate;
        
        id locationTracker = [controllers objectForKey:@"locationTracker"];
        if ([locationTracker isKindOfClass:[STTracker class]]) {
            session.locationTracker = locationTracker;
        } else {
            session.locationTracker = [[STLocationTracker alloc] init];
        }
        id batteryTracker = [controllers objectForKey:@"batteryTracker"];
        if ([batteryTracker isKindOfClass:[STTracker class]]) {
            session.batteryTracker = batteryTracker;
        } else {
            session.batteryTracker = [[STBatteryTracker alloc] init];
        }
        
        id settingsController = [controllers objectForKey:@"settingsController"];
        if ([settingsController isKindOfClass:[STSettingsController class]]) {
            session.settingsController = settingsController;
        } else {
            session.settingsController = [[STSettingsController alloc] init];
        }

        id syncer = [controllers objectForKey:@"syncer"];
        if ([syncer isKindOfClass:[STSyncer class]]) {
            session.syncer = syncer;
        } else {
            session.syncer = [[STSyncer alloc] init];
        }
        
        session.syncer = [[STSyncer alloc] init];

        [[NSNotificationCenter defaultCenter] addObserver:session selector:@selector(documentReady:) name:@"documentReady" object:nil];

        NSString *dataModelName = [settings valueForKey:@"dataModelName"];
        
        if (!dataModelName) {
            dataModelName = @"STDataModel";
        }
        
        session.document = [STManagedDocument documentWithUID:session.uid dataModelName:dataModelName];

        return session;
        
    } else {
        NSLog(@"no uid");
        return nil;
    }

}

- (void)completeSession {
    if (self.document) {
        if (self.document.documentState == UIDocumentStateNormal) {
            [self.document saveDocument:^(BOOL success) {
                if (success) {
                    [self.manager sessionCompletionFinished:self];
                }
            }];
        }
    }
}

- (void)dismissSession {
    if ([self.status isEqualToString:@"completed"]) {
        if (self.document) {
            if (self.document.documentState != UIDocumentStateClosed) {
                [self.document closeWithCompletionHandler:^(BOOL success) {
                    [self.document.managedObjectContext reset];
                    [(STSessionManager *)self.manager removeSessionForUID:self.uid];
                }];
            }
        }
    }
}

- (void)documentReady:(NSNotification *)notification {
    if ([[notification.userInfo valueForKey:@"uid"] isEqualToString:self.uid]) {
        self.settingsController.startSettings = [self.startSettings mutableCopy];
//        self.settingsController = [STSettingsController initWithSettings:self.startSettings];
        self.settingsController.session = self;
    }
}

- (void)settingsLoadComplete {
//    NSLog(@"currentSettings %@", [self.settingsController currentSettings]);
    self.logger = [[STLogger alloc] init];
    self.logger.session = self;
    self.locationTracker.session = self;
    self.batteryTracker.session = self;
    self.syncer.authDelegate = self.authDelegate;
    self.syncer.session = self;
    self.status = @"running";
//    [self.lapTracker startTracking];
}

- (void)setAuthDelegate:(id<STRequestAuthenticatable>)authDelegate {
    if (_authDelegate != authDelegate) {
        _authDelegate = authDelegate;
        self.syncer.authDelegate = _authDelegate;
    }
}

- (void)setStatus:(NSString *)status {
    if (_status != status) {
        _status = status;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sessionStatusChanged" object:self];
        [self.logger saveLogMessageWithText:[NSString stringWithFormat:@"Session status changed to %@", self.status] type:nil];
    }
}


@end
