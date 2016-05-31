//
//  GQBaseDBModel.h
//  Pods
//
//  Created by 林国强 on 16/5/20.
//
//

#import <Realm/Realm.h>
#import "GQBaseModelProtocol.h"
#import "GQDataBaseProtocol.h"
extern NSString *const gq_DBprimaryKeyString;
@interface GQBaseDBModel : RLMObject <GQBaseModelProtocol>

+ (id<GQDataBaseProtocol>)gq_DBsettingReader;

+ (void)registerProtocol:(id<GQDataBaseProtocol>)protocol;

+ (NSDictionary *)modelClassInArray;
@end
