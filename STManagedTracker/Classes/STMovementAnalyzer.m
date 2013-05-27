//
//  STMovementAnalyzer.m
//  HippoTracker
//
//  Created by Maxim Grigoriev on 5/18/13.
//  Copyright (c) 2013 Maxim Grigoriev. All rights reserved.
//

#import "STMovementAnalyzer.h"
#import "STSession.h"

@implementation STMovementAnalyzer

@synthesize startSpeedThreshold = _startSpeedThreshold;
@synthesize finishSpeedThreshold = _finishSpeedThreshold;

- (CLLocationDistance)startSpeedThreshold {
    if (!_startSpeedThreshold) {
        //        _startSpeedThreshold = 5.0;
    }
    return _startSpeedThreshold;
}

- (void)setStartSpeedThreshold:(CLLocationDistance)startSpeedThreshold {
    if (startSpeedThreshold >= 0) {
        if (startSpeedThreshold != _startSpeedThreshold) {
            _startSpeedThreshold = startSpeedThreshold;
        }
    }
}

- (CLLocationDistance)finishSpeedThreshold {
    if (!_finishSpeedThreshold) {
        //        _finishSpeedThreshold = 10.0;
    }
    return _finishSpeedThreshold;
}

- (void)setFinishSpeedThreshold:(CLLocationDistance)finishSpeedThreshold {
    if (finishSpeedThreshold >= 0) {
        if (finishSpeedThreshold != _finishSpeedThreshold) {
            _finishSpeedThreshold = finishSpeedThreshold;
        }
    }
}


- (STQueue *)locationsQueue {
    if (!_locationsQueue) {
        _locationsQueue = [[STQueue alloc] init];
    }
    return _locationsQueue;
}

- (void)addLocation:(CLLocation *)location {
    
    [self.locationsQueue enqueue:location];
    
    int numberOfIntervals = 0;
    
    if (self.GPSMovingDetected) {
        CLLocation *head = [self.locationsQueue head];
        if (head) {
            numberOfIntervals = self.locationsQueue.queueLength - 1;
            BOOL moving = NO;
            for (CLLocation *location in self.locationsQueue) {
                if (location !=head) {
                    if ([self enoughOfDistanceFrom:location to:head distanceFilter:self.finishSpeedThreshold]) {
                        moving = YES;
                    } else {
                        numberOfIntervals --;
                    }
                    head = location;
                }
            }
            if (!moving) {
                self.GPSMovingDetected = moving;
            }
        } else {
            
        }
        
    } else {
        
        CLLocation *tail = [self.locationsQueue tail];
        if (tail) {
            numberOfIntervals = 0;
            BOOL moving = YES;
            for (CLLocation *location in [self.locationsQueue reverseObjectEnumerator]) {
                if (location != tail) {
                    if ([self enoughOfDistanceFrom:location to:tail distanceFilter:self.startSpeedThreshold]) {
                        numberOfIntervals++;
                    } else {
                        moving = NO;
                    }
                    tail = location;
                }
            }
            if (moving && numberOfIntervals == self.locationsQueue.queueLength - 1) {
                self.GPSMovingDetected = moving;
            }
        } else {
            
        }
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startAnalyzer" object:self userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:numberOfIntervals] forKey:@"numberOfIntervals"]];
    
}








//    if (self.locationsQueue.filled) {
////        CLLocationDistance distanceFilter = [[[[(STSession *)self.sesstion locationTracker] settings] valueForKey:@"distanceFilter"] doubleValue];
//
//        if (self.GPSMovingDetected) {
//            CLLocation *followingLocation = [self.locationsQueue tail];
//            if (followingLocation) {
//                BOOL moving = NO;
//                for (int i = self.locationsQueue.count - 2; i >= 0; i--) {
//                    CLLocation *location = [self.locationsQueue objectAtIndex:i];
//                    moving |= [self enoughOfDistanceFrom:location to:followingLocation distanceFilter:self.finishSpeedThreshold];
//                    if (moving) {
////                        NSLog(@"moving");
//                        break;
//                    }
//                    followingLocation = location;
//                }
//                if (!moving) {
//                    self.GPSMovingDetected = moving;
//                }
//            } else {
//
//            }
//
//        } else {
//            CLLocation *prevLocation = [self.locationsQueue head];
//            if (prevLocation) {
//                BOOL moving = YES;
//                for (int i = 1; i < self.locationsQueue.count; i++) {
//                    CLLocation *location = [self.locationsQueue objectAtIndex:i];
//                    moving &= [self enoughOfDistanceFrom:location to:prevLocation distanceFilter:self.startSpeedThreshold];
//                    if (!moving) {
////                        NSLog(@"not moving");
////                        break;
//                    }
//                    prevLocation = location;
//                }
//                if (moving) {
//                    self.GPSMovingDetected = moving;
//                }
//            } else {
//
//            }
//        }
//    }



- (BOOL)enoughOfDistanceFrom:(CLLocation *)location to:(CLLocation *)previousLocation distanceFilter:(CLLocationDistance)distanceFilter {
    return ([location distanceFromLocation:previousLocation] >= distanceFilter);
}


@end
