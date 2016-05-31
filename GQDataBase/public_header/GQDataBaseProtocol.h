//
//  GQDataBaseProtocol.h
//  Pods
//
//  Created by 林国强 on 16/5/20.
//
//

#import <Foundation/Foundation.h>

@protocol GQDataBaseProtocol <NSObject>

@required

- (NSString *)gq_DBUserKey;

- (void)gq_DBHandleError:(NSError *)excpetion;

@end
