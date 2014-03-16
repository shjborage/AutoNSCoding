//
//  FullCopy.h
//  AutoNSCodingDemo
//
//  Created by shjborage on 3/16/14.
//  Copyright (c) 2014 Saick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FullCopy : NSObject <
NSCoding
>

@property (nonatomic, assign) NSInteger aInteger;
@property (nonatomic, assign) NSUInteger aUInteger;
@property (nonatomic, assign) double aDouble;
@property (nonatomic, assign) BOOL aBool;

@property (nonatomic, copy) NSString *aString;

@property (nonatomic, strong) NSDictionary *aDic;
@property (nonatomic, strong) NSArray *aArray;

@end
