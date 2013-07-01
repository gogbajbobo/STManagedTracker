//
//  STLogMessage.h
//  STManagedTracker
//
//  Created by Maxim Grigoriev on 7/1/13.
//  Copyright (c) 2013 Maxim Grigoriev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "STComment.h"


@interface STLogMessage : STComment

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * type;

@end
