//
//  FullCopy.m
//  AutoNSCodingDemo
//
//  Created by shjborage on 3/16/14.
//  Copyright (c) 2014 Saick. All rights reserved.
//

#import "FullCopy.h"
#import "NSObject+NSCoding.h"

@implementation FullCopy

- (NSString *)description
{
  return [NSString stringWithFormat:@"%@ Integer:%d, UInteger:%d, Double:%f, String:%@, Dictionary:\
          %@, Array:%@",
          NSStringFromClass([self class]),
          self.aInteger,
          self.aUInteger,
          self.aDouble,
          self.aString,
          self.aDic,
          self.aArray];
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
  [self encodeAutoWithCoder:encoder];
}

- (id)initWithCoder:(NSCoder *)decoder
{
  if (self = [super init]) {
    [self decodeAutoWithAutoCoder:decoder];
  }
  return self;
}

@end
