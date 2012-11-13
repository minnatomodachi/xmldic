xmldic
======

Xml Parser in iOS

The MIT License (MIT)

Copyright (c) 2012 MinnaTomodachi Apps Co., Ltd.

Can use the following codes:

  char*   xml = "<menu><item><a>a1</a><b>b1</b></item><item><a>a2</a><b>b2</b></item></menu>";
  XmlDic* dic = [[[XmlDic alloc] init] autorelease];
  [dic parseWithData:[NSData dataWithBytes:xml length:strlen(xml)]];

  for( XmlDic* item in [dic find:@"item"] )
  {
      NSLog( @"%@", [item first:@"a"] );
      NSLog( @"%@", [item first:@"b"] );
  }

We hope your fun.