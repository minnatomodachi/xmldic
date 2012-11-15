/*
 *  XmlDic.h
 *  MinnaTomodachiLibrary
 *
 *  Created by ARAI Shigenari on 12/11/04.
 *  Copyright 2012 MinnaTomodachi Co., Ltd. All rights reserved.
 *
 *  The MIT License (MIT)
 */

#import "XmlDic.h"


@implementation XmlDic


//  初期設定する
//  Initialize instance.
- (id)init
{
    self = [super init];
    
    if( self )
    {
        self.value = [[[NSMutableString alloc] init] autorelease];
        self.items = [[[NSMutableArray  alloc] init] autorelease];
    }
    
    return self;
}


//  XML を取得してパースする
//  Get a XML from the uri, and parse it.
- (BOOL)parseWithURI:(NSString*)uri
{
    //  URL で XML の取得本の作成
    NSURL* url = [NSURL URLWithString:uri];
    
    //  XML データの受信
    NSMutableURLRequest* request = [[[NSMutableURLRequest alloc]
        initWithURL:url
        cachePolicy:NSURLRequestReloadIgnoringCacheData
        timeoutInterval:30] autorelease];
    NSURLResponse* response = nil;
    NSError*       error    = nil;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request
        returningResponse:&response error:&error];
    
    //  エラー？
    NSString* msg = [error localizedDescription];

    if( 0 < [msg length] )
    {
        return NO;
    }
    
    //  パースの開始
    [self parseWithData:data];
    
    return YES;
}


//  XML を指定してパースする
//  Parse the XML data.
- (void)parseWithData:(NSData*)data
{
    NSXMLParser* parser =
        [[[NSXMLParser alloc] initWithData:data] autorelease];
    [parser setDelegate:self];
    [parser parse];
}


//  名前の要素を全て取得する
//  Get all items by the name.  
- (NSMutableArray*)find:(NSString*)name
{
    //  配列の指定がなければ自動作成
    NSMutableArray* items =
        [[[NSMutableArray alloc] init] autorelease];

    return [self find:name items:items];
}


//  名前の要素を全て取得する
//  Get all items by the name.  
- (NSMutableArray*)find:(NSString*)name items:(NSMutableArray*)items
{
    //  名前で探して全て配列にまとめる
    for( XmlDic* item in _items )
    {
        //  名前発見 => 登録
        if( [item.name isEqualToString:name] )
        {
            [items addObject:item];
        }

        //  名前未発見 => 子要素の探索
        else
        {
            [item find:name items:items];
        }
    }
    
    //  該当する名前の要素の配列
    return items;
}


//  名前の要素を最初に見付けた1つ取得する
//  Get first item only by the name.
- (NSString*)first:(NSString*)name
{
    //  最初に見付けたところで止まる
    for( XmlDic* item in _items )
    {
        //  名前発見 => 登録
        if( [item.name isEqualToString:name] )
        {
            return item.value;
        }

        //  名前未発見 => 子要素の探索
        else
        {
            NSString* value = [item first:name];
            if( value )
            {
                return value;
            }
        }
    }
    
    return nil;
}


//  名前と値が同じ要素を最初に見付けた1つ取得する
//  Get first item only by the name, the tag and value.
- (XmlDic*)first:(NSString*)name tag:(NSString*)tag value:(NSString*)value
{
    for( XmlDic* item in [self find:name] )
    {
        if( [[item first:tag] isEqualToString:value] )
        {
            return item;
        }
    }
    return nil;
}


//  パースを開始するときに実行する
//  Start the XML data parsing.
- (void)parserDidStartDocument:(NSXMLParser*)parser
{
    self.name = @"top";
}


//  パースを終了するときに実行する
//  End the XML data parsing.
- (void)parserDidEndDocument:(NSXMLParser*)parser
{
}


//  開始タグを取得する
//  Find the starting tag.
- (void)parser:(NSXMLParser*)parser
    didStartElement:(NSString*)elementName
    namespaceURI:(NSString*)namespaceURI
    qualifiedName:(NSString*)qualifiedName
    attributes:(NSDictionary*)attributeDict
{
    //  子要素の作成
    XmlDic* dic = [[[XmlDic alloc] init] autorelease];
    dic.name = elementName;
    dic.parent = self;
    parser.delegate = dic;

    //  子要素の登録
    [_items addObject:dic];
}


//  終了タグを取得する
//  Find the ending tag.
- (void)parser:(NSXMLParser*)parser
    didEndElement:(NSString*)elementName
    namespaceURI:(NSString*)namespaceURI
    qualifiedName:(NSString*)qualifiedName
{
    //  自分の階層の解析完了 => 上位層へ戻る
    if( [elementName isEqualToString:_name] )
    {
        parser.delegate = _parent;
    }
}


//  タグの値を取得する
//  Find the starting tag.
- (void)parser:(NSXMLParser*)parser
    foundCharacters:(NSString*)string
{
    [_value appendString:string];
}


//  解放する
//  Release instance.
- (void)dealloc
{
    [_name  release];
    [_value release];
    [_items release];
    
    [super dealloc];
}


@end
