xmldic
======

Xml Parser in iOS

The MIT License (MIT)

Copyright (c) 2012 MinnaTomodachi Apps Co., Ltd.

Can use the following codes:

char*   xml = "&lt;menu&gt;&lt;item&gt;&lt;a&gt;a1&lt;/a&gt;&lt;b&gt;b1&lt;/b&gt;&lt;/item&gt;&lt;item&gt;&lt;a&gt;a2&lt;/a&gt;&lt;b&gt;b2&lt;/b&gt;&lt;/item&gt;&lt;/menu&gt;";<br/>
XmlDic* dic = [[[XmlDic alloc] init] autorelease];<br/>
[dic parseWithData:[NSData dataWithBytes:xml length:strlen(xml)]];<br/>
<br/>
for( XmlDic* item in [dic find:@"item"] )<br/>
{<br/>
&nbsp; &nbsp; NSLog( @"%@", [item first:@"a"] );<br/>
&nbsp; &nbsp; NSLog( @"%@", [item first:@"b"] );<br/>
}<br/>

We hope your fun.