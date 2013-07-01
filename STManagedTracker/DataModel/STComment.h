//
//  STComment.h
//  STManagedTracker
//
//  Created by Maxim Grigoriev on 7/1/13.
//  Copyright (c) 2013 Maxim Grigoriev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "STDatum.h"

@class STDatum;

@interface STComment : STDatum

@property (nonatomic, retain) NSString * commentText;
@property (nonatomic, retain) STDatum *owner;

@end
