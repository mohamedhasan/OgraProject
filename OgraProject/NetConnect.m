//
//  NetConnect.m
//  OgraProject
//
//  Created by Mohammed Hasan on 10/7/12.
//  Copyright (c) 2012 Mohammed Hasan. All rights reserved.
//

#import "NetConnect.h"

@implementation NetConnect
@synthesize responseData;
-(void)dealloc{


}
-(void)loadRequestWithLat:(NSString*)latitude andLong:(NSString*)longitude{

    responseData=[NSMutableData data];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://2ogra.com/recruit/location"]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:1.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[[NSString stringWithFormat:@"lat=%@&lng=%@",latitude,longitude]dataUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    

    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = [httpResponse statusCode];
    NSLog(@"the response in %d",responseStatusCode);


    

    
    if(responseStatusCode==200)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Ogra.com " message:@"Yeah that's in Egypt " delegate:self cancelButtonTitle:@"Ok thank's" otherButtonTitles:nil ];

        [alert show];
        success=YES;
    
    }else
    {
        success=NO;
        
        

        
    }
//    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
        
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"2ogra.com" message:@"error in connection" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    

    
    if(!success)
    {

         NSError *myError = nil;
                NSDictionary *res = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&myError];
                    NSString* value = [res objectForKey:@"reason"];
    
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"error " message:value delegate:self cancelButtonTitle:@"Ok thank's" otherButtonTitles:nil ];
        
        [alert show];
    }
    
}


@end
