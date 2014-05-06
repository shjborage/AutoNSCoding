//
//  NSObject+NSCodingSpec.m
//  AutoNSCodingDemo
//
//  Created by shihaijie on 5/6/14.
//  Copyright 2014 Saick. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NSObject+NSCoding.h"
#import "FullCopy.h"
#import "Parent.h"
#import "Children.h"
#import "TMCache.h"


SPEC_BEGIN(NSObject_NSCodingSpec)

describe(@"NSObject+NSCoding", ^{
  context(@"Coding a obj and decode it", ^{
    it(@"should equal to origin FullCopy", ^{
      FullCopy *full = [[FullCopy alloc] init];
      full.aInteger = -2;
      full.aUInteger = 3;
      full.aDouble = 5.45f;
      full.aString = @"asdf";
      full.aBool = YES;
      full.aDic = @{@"key1": @"1", @"key2": @"22"};
      full.aArray = @[@"a1", @"a2", @"a3"];
      
      [[TMDiskCache sharedCache] setObject:full forKey:@"kFullCopy"];

      FullCopy *anotherFull = (FullCopy *)[[TMDiskCache sharedCache] objectForKey:@"kFullCopy"];
      [[anotherFull shouldNot] beNil];
//      [[anotherFull should] beKindOfClass:[FullCopy class]];
      [[theValue(anotherFull.aInteger) should] equal:theValue(full.aInteger)];
      [[theValue(anotherFull.aUInteger) should] equal:theValue(full.aUInteger)];
      [[theValue(anotherFull.aDouble) should] equal:theValue(full.aDouble)];
      [[theValue(anotherFull.aBool) should] equal:theValue(full.aBool)];
      [[anotherFull.aString should] equal:anotherFull.aString];
      [[[anotherFull should] have:3] aArray];
    });
    
    it(@"should equal to origin Children", ^{
      // NSCoding all properties including parent's.
      Children *ch = [[Children alloc] init];
      ch.aInteger = 5;
      ch.aString = @"John";
      
      [[TMDiskCache sharedCache] setObject:ch forKey:@"kChildren"];
      
      Children *anotherChild = (Children *)[[TMDiskCache sharedCache] objectForKey:@"kChildren"];
      [[anotherChild shouldNot] beNil];
//      [[anotherChild should] beKindOfClass:[Children class]];
      [[theValue(anotherChild.aInteger) should] equal:theValue(ch.aInteger)];
      [[anotherChild.aString should] equal:ch.aString];
    });
  });
});

SPEC_END
