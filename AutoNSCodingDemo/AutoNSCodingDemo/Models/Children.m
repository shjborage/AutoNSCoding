//
//  Children.m
//  AutoNSCodingDemo
//
//  Created by shjborage on 3/16/14.
//  Copyright (c) 2014 Saick. All rights reserved.
//

#import "Children.h"

@implementation Children

- (NSString *)description
{
  return [NSString stringWithFormat:@"%@ Integer:%d, String:%@",
          NSStringFromClass([self class]),
          self.aInteger,
          self.aString];
}


#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
  [super encodeWithCoder:encoder];
  
  [self encodeAutoWithCoder:encoder];
}

- (id)initWithCoder:(NSCoder *)decoder
{
  if (self = [super initWithCoder:decoder]) {
    [self decodeAutoWithAutoCoder:decoder];
  }
  return self;
}

@end
