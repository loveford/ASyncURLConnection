//
//  ASyncURLConnection.m
//  tableviewEdit
//
//  Created by mouwenbin on 12/3/12.
//  Copyright (c) 2012 mouwenbin. All rights reserved.
//

#import "ASyncURLConnection.h"

@implementation ASyncURLConnection

+ (id)request:(NSString *)requestUrl completeBlock:(completeBlock_t)completeBlock errorBlock:(errorBlock_t)errorBlock
{
    /*
     * If ARC is disabled,
     * This method should return an object after autorelease is called:
     * * id obj = [[[self alloc] initWithRequest:requestUrl
     * completeBlock:completeBlock errorBlock:errorBlock];
     * return [obj autorelease];
     *
     * Because this method name doesn't begin with alloc/new/copy/mutableCopy,
     * the returned object has been automatically registered in autoreleasepool. */
    return [[self alloc] initWithRequest:requestUrl completeBlock:completeBlock errorBlock:errorBlock];
}
- (id)initWithRequest:(NSString *)requestUrl completeBlock:(completeBlock_t)completeBlock errorBlock:(errorBlock_t)errorBlock
{
    NSURL *url = [NSURL URLWithString:requestUrl]; NSURLRequest *request = [NSURLRequest requestWithURL:url];
    if ((self = [super initWithRequest:request delegate:self startImmediately:NO])) {
        data_ = [[NSMutableData alloc] init];
        /*
         * To make sure that you can use the passed Block safely,
         * the instance method 'copy' is called to put the Block on the heap.
         
         * To give the source code better readability,
         * The typedefined Block type variable is used for the argument. */

        completeBlock_ = [completeBlock copy]; errorBlock_ = [errorBlock copy];
        [self start];
    }
    /*
     * Member variables that have a __strong qualifier
     * have ownership of the created NSMutableData class object *
     * When the object is discarded, the strong references
     * of the member variables with the __strong qualifier disappear.
     * The NSMutableData class object and the Block will be released automatically. *
     * So, you don't need to implement the dealloc instance method explicitly. */
    return self;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [data_ setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [data_ appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    /*
     * Execute the Block assigned as callback for downloading success.
     * The legacy delegate callback can be replaced by Block. */
    completeBlock_(data_);
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    /*
     * Execute the Block that is assigned for error. */
    errorBlock_(error);
}
@end
