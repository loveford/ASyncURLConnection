//
//  ASyncURLConnection.h
//  tableviewEdit
//
//  Created by mouwenbin on 12/3/12.
//  Copyright (c) 2012 mouwenbin. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * By using typedef for a Block type variables, * Source code will have better readability.
 */
typedef void (^completeBlock_t)(NSData *data);
typedef void (^errorBlock_t)(NSError *error);


@interface ASyncURLConnection : NSURLConnection {
    completeBlock_t completeBlock_;
    errorBlock_t errorBlock_;
    NSMutableData *data_;
}
+ (id)request:(NSString *)requestUrl completeBlock:(completeBlock_t)completeBlock errorBlock:(errorBlock_t)errorBlock;
- (id)initWithRequest:(NSString *)requestUrl completeBlock:(completeBlock_t)completeBlock errorBlock:(errorBlock_t)errorBlock;
@end
