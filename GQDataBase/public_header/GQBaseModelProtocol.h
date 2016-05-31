//
//  GQBaseModelProtocol.h
//  Pods
//
//  Created by 林国强 on 16/5/24.
//
//

#import <Foundation/Foundation.h>

@protocol GQBaseModelProtocol <NSObject>

@optional

+ (BOOL)gq_DBglobal;

- (NSString *)gq_DBModelId;

@end
