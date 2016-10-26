//
//  helper.m
//  PrediAdmin
//
//  Created by parastoo on 7/11/1395 AP.
//  Copyright © 1395 AP parastoo. All rights reserved.
//

#import "helper.h"
#import "NSObject+jsonDic.h"


@implementation helper

+(NSURLSession*)mySession
{
    static NSURLSession* session;
    if (!session)
    {
        NSURLSessionConfiguration* defaultConf = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:defaultConf];
    }
    
    return session;
}

+(NSURLSessionTask*)serverGetWithPath:(NSString*)path completion:(void (^) (long response_code, id obj))completionHandler
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.mactehran.com/%@", path]];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0f];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"GET"];


    NSURLSessionTask* aTask = [[helper mySession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error && data)
        {
            NSHTTPURLResponse* resp = (NSHTTPURLResponse*)response;
            if (resp.statusCode == 200)
            {
                id resposeObject = [data jsonDic];
                completionHandler(200, resposeObject);
            }
            else
            {
                completionHandler(resp.statusCode, nil);
            }
        }
        else
            completionHandler(0, error);
    }];
    
    return aTask;
}

@end
