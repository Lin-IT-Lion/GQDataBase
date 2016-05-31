//
//  GQBaseDBModel.m
//  Pods
//
//  Created by 林国强 on 16/5/20.
//
//

#import "GQBaseDBModel.h"
#import "MJExtension.h"
#import "RLMObject+Copying.h"
#import "GQModelTransformer.h"
#import "RLMObject+JSON.h"
#import <Realm/RLMProperty.h>
#import <Realm/RLMObjectSchema.h>

NSString *const gq_DBprimaryKeyString = @"gq_DBprimaryKey";
NSString *const gq_DBModelBaseClassName = @"GQBaseDBModel";

@interface RLMObject (JSON_Internal)

// RLMObject private methods
+ (RLMObjectSchema *)sharedSchema;

@end


@interface GQBaseDBModel()
@property (nonatomic, copy) NSString *gq_DBprimaryKey;
@end

@implementation GQBaseDBModel

static id<GQDataBaseProtocol>gq_DBsetting;
static NSMutableDictionary *dicForClass;

+ (void)initialize
{
    static NSMutableSet *table;
    if (table == nil) {
        table = [NSMutableSet set];
    }
    Class classDBName = [GQModelTransformer gq_DBClassName:[self class]];
    NSString *key = NSStringFromClass(classDBName);
    
    if (dicForClass == nil) {
        dicForClass = [NSMutableDictionary dictionary];
    }
    if (([key isEqualToString:gq_DBModelBaseClassName] == NO) && ([table containsObject:key] == NO)) {
        [self createRealm:classDBName];
        RLMObjectSchema *schema = [self sharedSchema];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (RLMProperty *property in schema.properties) {
            if (property.type == RLMPropertyTypeArray) {
                if (property.objectClassName.length > 0) {
                    dic[property.name] = [GQModelTransformer gq_NormalClassName:NSClassFromString(property.objectClassName)];
                }
            }
        }
        if (dic.count > 0) {
            dicForClass[key] = dic;
        }
        [table addObject:key];
    }
}

+ (NSDictionary *)modelClassInArray
{
    Class classDBName = [GQModelTransformer gq_DBClassName:[self class]];
    NSString *key = NSStringFromClass(classDBName);
    return dicForClass[key];
}

+ (__kindof GQBaseDBModel*)createRealm:(Class)classDBName
{
    return [[classDBName alloc] initWithJSONDictionary:nil];
}

+ (id<GQDataBaseProtocol>)gq_DBsettingReader
{
    return gq_DBsetting;
}

+ (void)registerProtocol:(id<GQDataBaseProtocol>)protocol
{
    gq_DBsetting = protocol;
}


- (NSString *)gq_DBprimaryKey
{
    if (_gq_DBprimaryKey == nil) {
        if ([self respondsToSelector:@selector(gq_DBModelId)]) {
            _gq_DBprimaryKey = [self gq_DBModelId];
        } else {
            _gq_DBprimaryKey = [NSString stringWithFormat:@"%@",[NSDate date]];
        }
    }
    return _gq_DBprimaryKey;
    
}


- (id)copyWithZone:(NSZone *)zone
{
    return [self deepCopy];
}

+ (NSString *)primaryKey
{
    return gq_DBprimaryKeyString;
}

+ (NSDictionary *)JSONInboundMappingDictionary
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    [self mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {
        mapping[property.name] = property.name;
    }];
    return mapping;
}

+ (NSDictionary *)JSONOutboundMappingDictionary
{
    return [self JSONInboundMappingDictionary];
}
@end

