AutoNSCoding
============

Few words to make your NSCoding protocol automatic.


##Usage

### Install
Copy two files to you project, and `#import "NSObject+NSCoding.h"`.
Demo and CocoaPods support is comming soon.

###Custom Class

`self` is a subclass of `Res`

```objc
#pragma mark - NSCoping

- (void)encodeWithCoder:(NSCoder *)aCoder
{
  if ([super respondsToSelector:@selector(encodeWithCoder:)])
    [super encodeWithCoder:aCoder];
  
  [self encodeAutoWithCoder:aCoder class:[Res class]];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self decodeAutoWithAutoCoder:aDecoder class:[Res class]];
  }
  return self;
}
```

###Normal Class


```objc
#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
  if ([super respondsToSelector:@selector(encodeWithCoder:)])
    [super encodeWithCoder:aCoder];
  
  [self encodeAutoWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  if (self = [super initWithCoder:aDecoder]) {
    [self decodeAutoWithAutoCoder:aDecoder];
  }
  return self;
}
```