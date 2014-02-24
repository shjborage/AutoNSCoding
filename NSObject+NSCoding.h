//
//  NSObject+NSCoding.h
//  BFServiceStation
//
//  Created by shjborage on 2/17/14.
//  Copyright (c) 2014 Baofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSCoding)

- (void)encodeAutoWithCoder:(NSCoder *)aCoder;
- (void)decodeAutoWithAutoCoder:(NSCoder *)aDecoder;

- (void)encodeAutoWithCoder:(NSCoder *)aCoder class:(Class)cls;
- (void)decodeAutoWithAutoCoder:(NSCoder *)aDecoder class:(Class)cls;

@end
