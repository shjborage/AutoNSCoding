//
//  Parent.m
//  AutoNSCodingDemo
//
//  Created by shjborage on 3/16/14.
//  Copyright (c) 2014 Saick. All rights reserved.
//

#import "Parent.h"

@implementation Parent

- (NSString *)description
{
  return [NSString stringWithFormat:@"%@ Integer:%d",
          NSStringFromClass([self class]),
          self.aInteger];
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
  [self encodeAutoWithCoder:encoder class:[Parent class]];
}

- (id)initWithCoder:(NSCoder *)decoder
{
  if (self = [super init]) {
    [self decodeAutoWithAutoCoder:decoder class:[Parent class]];
  }
  return self;
}

@end
