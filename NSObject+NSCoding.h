//
//  NSObject+NSCoding.h
//  Version:  0.1.1
//
//  Created by shjborage on 2/17/14.
//  Copyright (c) 2014 Saick. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNSCodingDebugLoging      0

@interface NSObject (NSCoding)

- (void)encodeAutoWithCoder:(NSCoder *)aCoder;
- (void)decodeAutoWithAutoCoder:(NSCoder *)aDecoder;

- (void)encodeAutoWithCoder:(NSCoder *)aCoder class:(Class)cls;
- (void)decodeAutoWithAutoCoder:(NSCoder *)aDecoder class:(Class)cls;

@end
