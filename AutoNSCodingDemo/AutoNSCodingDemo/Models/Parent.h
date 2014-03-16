//
//  Parent.h
//  AutoNSCodingDemo
//
//  Created by shjborage on 3/16/14.
//  Copyright (c) 2014 Saick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+NSCoding.h"

@interface Parent : NSObject <
NSCoding
>

@property (nonatomic, assign) NSInteger aInteger;

@end
