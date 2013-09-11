//
//  LabelThin.m
//  BraggingRightsBronze
//
//  Created by admin on 9/12/13.
//  Copyright (c) 2013 iBrag. All rights reserved.
//

#import "LabelThin.h"

@implementation LabelThin

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder: decoder]) {
        [self setFont: [UIFont fontWithName: @"HelveticaNeueCyr" size: self.font.pointSize]];
    }
    
    return self;
}

@end
