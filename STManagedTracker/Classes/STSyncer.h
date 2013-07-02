//
//  STGTSyncer.h
//  geotracker
//
//  Created by Maxim Grigoriev on 3/11/13.
//  Copyright (c) 2013 Maxim Grigoriev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STRequestAuthenticatable.h"
#import "STSessionManagement.h"
#import "STManagedDocument.h"

@interface STSyncer : NSObject

@property (nonatomic, strong) id <STRequestAuthenticatable> authDelegate;
@property (nonatomic, strong) id <STSession> session;
@property (nonatomic) BOOL syncing;
@property (nonatomic) int fetchLimit;

- (NSNumber *)numberOfUnsynced;
- (void)syncData;
- (void)sendData:(NSData *)requestData toServer:(NSString *)serverUrlString withParameters:(NSString *)parameters;
- (void)parseResponse:(NSData *)responseData fromConnection:(NSURLConnection *)connection;
- (void)onTimerTick:(NSTimer *)timer;
- (NSData *)dataFromString:(NSString *)string;

@end
