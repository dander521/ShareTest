//
//  ViewController.m
//  AFN封装SOAP请求
//
//  Created by 李堪阶 on 15/11/1.
//  Copyright © 2015年 KJ. All rights reserved.
//

#import "ViewController.h"
#import "LGHTTPClient.h"

@interface ViewController ()<NSXMLParserDelegate>
/**拼接XML数据*/
@property (strong, nonatomic) NSMutableString *soapResults;
/**XML*/
@property (strong, nonatomic) NSXMLParser *xmlParser;
/**标记节点*/
@property (nonatomic,assign) BOOL elementFound;
/**xml节点*/
@property (strong, nonatomic) NSString *matchingElement;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getData];
}


/**
 *  网络请求
 */
- (void)getData
{
    //XML解析节点
    _matchingElement = @"result";
    
    //以实际开发更改下面的中文即可
    NSString *methodName = [NSString stringWithFormat:@"<soap11:Body>"
                            "<方法名 xmlns=\"命名空间\">"
                            "<参数1>%@</参数1>\n"
                            "<参数2>%@</参数2>\n"
                            "</方法名>"
                            "</soap11:Body>"
                            "</soap11:Envelope>", @"对应第一个参数",@"对应第二个参数"];////例：参数："<UserNo>%@</UserNo>" 类型：NSString ；类型为int时把%@改为%d
    
    //封装soap
    NSString *soapMessage = [[LGHTTPClient LGSoapMessage]stringByAppendingString:methodName];
    
    //网络请求
    [LGHTTPClient LGPOST:@"访问地址URL" withParam:soapMessage withSoapMessage:soapMessage withSuccessBlock:^(id data) {
        
        //网络请求的数据是二进制需要转化成NSString打印看请求结果
        NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@ ",result);
       //打印出来的结果。 其中我们想要解析的内容是在<result>与</result>之间，<result>是不固定的，以实际开发为准，一般在<ns:方法名Response>后面。因此可以根据result作为节点进行XML解析，
        /*
         <?xml version="1.0" encoding="UTF-8"?>
         <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope" xmlns:SOAP-ENC="http://www.w3.org/2003/05/soap-encoding" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:ns="http://tempuri.org/ns.xsd"><SOAP-ENV:Body><ns:UserLoginResponse><result>Success</result></ns:UserLoginResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>
         */
        
        //XML解析
        _xmlParser = [[NSXMLParser alloc] initWithData: data];
        [_xmlParser setDelegate: self];
        [_xmlParser setShouldResolveExternalEntities: YES];
        [_xmlParser parse];
        
    } withFalieBlock:^(NSError *error) {
        
    } withErrorBlock:^(id error) {
        
    }];
}
#pragma mark - XML解析
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"开始解析");
}

// 开始解析一个元素名
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    
    NSLog(@"准备解析");
    
    if ([elementName isEqualToString:_matchingElement]) {
        if (!_soapResults) {
            _soapResults = [[NSMutableString alloc] init];
        }
        _elementFound = YES;
    }
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    NSLog(@"追回解析");
    if (_elementFound) {
        [_soapResults appendString: string];
    }
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"完成解析");
    if ([elementName isEqualToString:_matchingElement]) {
        
        //解析结果
        NSLog(@"%@",_soapResults);
        //如果XML 解析出来的数据是JSON，还需要解析JSON,可通过实际开发使用MJExtension进行解析

        
        _elementFound = FALSE;
        // 强制放弃解析
        [_xmlParser abortParsing];
    }
    
}


// 解析整个文件结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    if (_soapResults) {
        _soapResults = nil;
    }
}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (_soapResults) {
        _soapResults = nil;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
