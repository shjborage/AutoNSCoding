//
//  NSObject+NSCoding.m
//
//  Created by shjborage on 2/17/14.
//  Copyright (c) 2014 Saick. All rights reserved.
//

/*
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList([self class], &methodCount);
    for (int j=0; j<methodCount; j++) {
      Method mt = methods[j];
      NSString *methodName = NSStringFromSelector(method_getName(mt));
      NSLog(@"method:%@", methodName);
      if ([methodName isEqualToString:name]) {
        id value = method_invoke(self, mt);
        NSLog(@"value:%@", value);
        break;
      }
    }
    free(methods);
 
 //    id value = objc_msgSend(self, selector);
 //    int value = ((int(*)(id, SEL))objc_msgSend)(self, selector);
 */

#import "NSObject+NSCoding.h"

#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (NSCoding)

- (void)encodeAutoWithCoder:(NSCoder *)aCoder class:(Class)class
{
  unsigned int outCount = 0;
  objc_property_t *pt = class_copyPropertyList(class, &outCount);
  for (int i = 0; i< outCount; i++) {
    objc_property_t property = pt[i];
    NSString *name = [NSString stringWithUTF8String:property_getName(property)];
    
    SEL selector = NSSelectorFromString(name);
    Method mt = class_getInstanceMethod(class, selector);
    if (mt != NULL) {
      NSString *returnType = [class getMethodReturnType:mt];
      if ([returnType isEqualToString:@"i"] || [returnType isEqualToString:@"q"]) {
        int intValue = ((int(*)(id, Method))method_invoke)(self, mt);
        NSLog(@"Encode %@ %@ int value:%d", NSStringFromClass(class), name, intValue);
        
        [aCoder encodeInteger:intValue forKey:name];
      } else if ([returnType isEqualToString:@"I"]) {
        unsigned intValue = ((unsigned(*)(id, Method))method_invoke)(self, mt);
        NSLog(@"Encode %@ %@ int value:%d", NSStringFromClass(class), name, intValue);
        
        [aCoder encodeInteger:intValue forKey:name];
      } else if ([returnType isEqualToString:@"f"] || [returnType isEqualToString:@"d"]) {
        double doubleValue = ((double(*)(id, Method))method_invoke)(self, mt);
        NSLog(@"Encode %@ %@ double value:%.f", NSStringFromClass(class), name, doubleValue);
        
        [aCoder encodeDouble:doubleValue forKey:name];
      } else if ([returnType isEqualToString:@"c"]) {   // char 一般为BOOL, property不用char即可
        BOOL boolValue = ((char(*)(id, Method))method_invoke)(self, mt);
        NSLog(@"Encode %@ %@ BOOL value:%d", NSStringFromClass(class), name, boolValue);
        
        [aCoder encodeBool:boolValue forKey:name];
      } else {
        @try {
          id value = ((id(*)(id, Method))method_invoke)(self, mt);
          NSLog(@"Encode %@ %@  value:%@", NSStringFromClass(class), name, value);
          
          [aCoder encodeObject:value forKey:name];
        }
        @catch (NSException *exception) {
          NSLog(@"Encode Return Value Type undefined in %@", NSStringFromClass(class));
        }
        @finally {
        }
      } // end of } else {
    } // end of if (mt != NULL) {
  }
  free(pt);
}

- (void)encodeAutoWithCoder:(NSCoder *)aCoder
{
  [self encodeAutoWithCoder:aCoder class:[self class]];
}

- (void)decodeAutoWithAutoCoder:(NSCoder *)aDecoder class:(Class)class
{
  unsigned int outCount = 0;
  objc_property_t *pt = class_copyPropertyList(class, &outCount);
  for (int i = 0; i< outCount; i++) {
    objc_property_t property = pt[i];
    NSString *name = [NSString stringWithUTF8String:property_getName(property)];
    
    SEL selector = NSSelectorFromString([class getSetMethodName:name]);
    Method mt = class_getInstanceMethod(class, selector);
    if (mt != NULL) {
      NSString *argumentType = [class getMethodArgumentType:mt index:2];
      if ([argumentType isEqualToString:@"i"] || [argumentType isEqualToString:@"q"]) {
        int intValue = [aDecoder decodeIntegerForKey:name];
        void (*method_invokeTyped)(id self, Method mt, int value) = (void*)method_invoke;
        method_invokeTyped(self, mt, intValue);
        
        NSLog(@"Decode %@ %@  intValue:%d", NSStringFromClass(class), name, intValue);
      } else if ([argumentType isEqualToString:@"I"]) {
        unsigned intValue = [aDecoder decodeIntegerForKey:name];
        void (*method_invokeTyped)(id self, Method mt, unsigned value) = (void*)method_invoke;
        method_invokeTyped(self, mt, intValue);
        
        NSLog(@"Decode %@ %@   unsigned intValue:%d", NSStringFromClass(class), name, intValue);
      } else if ([argumentType isEqualToString:@"f"] || [argumentType isEqualToString:@"d"]) {
        double doubleValue = [aDecoder decodeDoubleForKey:name];
        void (*method_invokeTyped)(id self, Method mt, double value) = (void*)method_invoke;
        method_invokeTyped(self, mt, doubleValue);
        
        NSLog(@"Decode %@ %@  doubleValue:%f", NSStringFromClass(class), name, doubleValue);
      } else if ([argumentType isEqualToString:@"c"]) {   // char 一般为BOOL, property不用char即可
        BOOL boolValue = [aDecoder decodeBoolForKey:name];
        void (*method_invokeTyped)(id self, Method mt, BOOL value) = (void*)method_invoke;
        method_invokeTyped(self, mt, boolValue);
        
        NSLog(@"Decode %@ %@  boolValue:%d", NSStringFromClass(class), name, boolValue);
      } else if ([argumentType isEqualToString:@"@"]) {
        NSString *value = [aDecoder decodeObjectForKey:name];
        void (*method_invokeTyped)(id self, Method mt, NSString *value) = (void*)method_invoke;
        method_invokeTyped(self, mt, value);
        
        NSLog(@"Decode %@ %@  strValue:%@", NSStringFromClass(class), name, value);
      } else {
        @try {
          id value = [aDecoder decodeObjectForKey:name];
          if (value != nil)
            method_invoke(self, mt, value);
          
          NSLog(@"Decode %@ %@  value:%@", NSStringFromClass(class), name, value);
        }
        @catch (NSException *exception) {
          NSLog(@"Decode Argument Value Type undefined in %@", NSStringFromClass(class));
        }
        @finally {
        }
      } // end of } else {
    } // end of if (mt != NULL) {
  }
  free(pt);
}

- (void)decodeAutoWithAutoCoder:(NSCoder *)aDecoder
{
  [self decodeAutoWithAutoCoder:aDecoder class:[self class]];
}

#pragma mark - private

+ (NSString *)getMethodReturnType:(Method)mt
{
  char dstType[10] = {0};
  size_t dstTypeLen = 10;
  method_getReturnType(mt, dstType, dstTypeLen);
  return [NSString stringWithUTF8String:dstType];
}

+ (NSString *)getMethodArgumentType:(Method)mt index:(NSInteger)index
{
  char dstType[10] = {0};
  size_t dstTypeLen = 10;
  method_getArgumentType(mt, index, dstType, dstTypeLen);
  return [NSString stringWithUTF8String:dstType];
}

+ (NSString *)getSetMethodName:(NSString *)propertyName
{
  if ([propertyName length] == 0)
    return @"";
  
  NSString *firstChar = [propertyName substringToIndex:1];
  firstChar = [firstChar uppercaseString];
  NSString *lastName = [propertyName substringFromIndex:1];
  return [NSString stringWithFormat:@"set%@%@:", firstChar, lastName];
}

@end
