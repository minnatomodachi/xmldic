xmldic
======

Xml Parser in iOS

The MIT License (MIT)

Copyright (c) 2012 MinnaTomodachi Apps Co., Ltd.

Can use the following codes:

  char*   xml = "&lt;menu&gt;&lt;item&gt;&lt;a&gt;a1&lt;/a&gt;&lt;b&gt;b1&lt;/b&gt;&lt;/item&gt;&lt;item&gt;&lt;a&gt;a2&lt;/a&gt;&lt;b&gt;b2&lt;/b&gt;&lt;/item&gt;&lt;/menu&gt;";
  XmlDic* dic = [[[XmlDic alloc] init] autorelease];
  [dic parseWithData:[NSData dataWithBytes:xml length:strlen(xml)]];

  for( XmlDic* item in [dic find:@"item"] )
  {
      NSLog( @"%@", [item first:@"a"] );
      NSLog( @"%@", [item first:@"b"] );
  }

We hope your fun.