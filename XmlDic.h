/*
 *  XmlDic.h
 *  MinnaTomodachiLibrary
 *
 *  Created by ARAI Shigenari on 12/11/04.
 *  Copyright 2012 MinnaTomodachi Co., Ltd. All rights reserved.
 *
 *  The MIT License (MIT)
 */

#import <Foundation/Foundation.h>


@interface XmlDic : NSObject <NSXMLParserDelegate>
{
    NSString*           _name;      //  名前 (name)
    NSMutableString*    _value;     //  値 (value)
    XmlDic*             _parent;    //  上位階層 (parent item)
    NSMutableArray*     _items;     //  子要素 (child item)
}


@property( nonatomic, retain ) NSString*          name;
@property( nonatomic, retain ) NSMutableString*   value;
@property( nonatomic, assign ) XmlDic*            parent;
@property( nonatomic, retain ) NSMutableArray*    items;


//  XML を取得してパースする
//  Get a XML from the uri, and parse it.
- (BOOL)parseWithURI:(NSString*)uri;

//  XML を指定してパースする
//  Parse the XML data.
- (void)parseWithData:(NSData*)data;

//  名前の要素を全て取得する
//  Get all items by the name.  
- (NSMutableArray*)find:(NSString*)name;

//  名前の要素を全て取得する
//  Get all items by the name.  
- (NSMutableArray*)find:(NSString*)name items:(NSMutableArray*)items;

//  名前の要素を最初に見付けた1つ取得する
//  Get first item only by the name.
- (NSString*)first:(NSString*)name;

//  名前と値が同じ要素を最初に見付けた1つ取得する
//  Get first item only by the name, the tag and value.
- (XmlDic*)first:(NSString*)name tag:(NSString*)tag value:(NSString*)value;


@end
