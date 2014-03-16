AutoNSCoding
============

Few words to make your NSCoding protocol automatic.


##Usage

### Install
Copy two files to you project, and `#import "NSObject+NSCoding.h"`.
`CocoaPods` is support now.

###Custom Class

`self` is a subclass of `Parent`

Parent:
```objc
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

```

Children:
```objc
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
```

###Normal Class


```objc
#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
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
