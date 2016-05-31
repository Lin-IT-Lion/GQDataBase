//
//  GQModelDBContext.m
//  Pods
//
//  Created by 林国强 on 16/5/20.
//
//

#import "GQModelDBContext.h"
#import "GQModelTransformer.h"
NSString *const gq_DB = @"gq_DB";
NSString *const gq_DBglobalString = @"global";

@implementation GQModelDBContext
+ (BOOL)gq_DBdelDBModel:(GQBaseDBModel *)dbModel
{
    BOOL ret = NO;
    RLMRealm *realm = [self gq_DBcurrentRealm:dbModel.class];
    BOOL isBegin = realm.inWriteTransaction;
    if (isBegin == NO) {
        [realm beginWriteTransaction];
    }
    @try {
        Class dbClassModel = [GQModelTransformer gq_DBClassName:dbModel.class];
        if ([dbClassModel respondsToSelector:@selector(objectInRealm:forPrimaryKey:)]) {
            NSString *key = [dbModel valueForKey:gq_DBprimaryKeyString];
            id model = [dbClassModel objectInRealm:realm forPrimaryKey:key];
            [realm deleteObject:model];
            [realm commitWriteTransaction];
            ret = YES;
        }
    }
    @catch (NSException *exception) {
        [self gq_DBdealWithException:exception modelClassName:dbModel.class];
    }
    return ret;
}

+ (BOOL)gq_DBdelAllDBModel:(Class)dbModelClassName
{
    BOOL ret = NO;
    
    RLMRealm *realm = [self gq_DBcurrentRealm:dbModelClassName];
    BOOL isBegin = realm.inWriteTransaction;
    if (isBegin == NO) {
        [realm beginWriteTransaction];
    }
    @try {
        [realm deleteAllObjects];
        [realm commitWriteTransaction];
        ret = YES;
    }
    @catch (NSException *exception) {
        [self gq_DBdealWithException:exception modelClassName:dbModelClassName];
    }
    return ret;
}

+ (BOOL)gq_DBaddOrUpateDBModelList:(NSArray <GQBaseDBModel *> *)dbModellist
{
    BOOL ret = NO;
    
    GQBaseDBModel *firstModel = dbModellist.firstObject;
    RLMRealm *realm = [self gq_DBcurrentRealm:firstModel.class];
    BOOL isBegin = realm.inWriteTransaction;
    if (isBegin == NO) {
        [realm beginWriteTransaction];
    }
    @try {
        [realm addOrUpdateObjectsFromArray:dbModellist];
        [realm commitWriteTransaction];
        ret = YES;
    }
    @catch (NSException *exception) {
        [self gq_DBdealWithException:exception modelClassName:firstModel.class];
    }
    return ret;
}

+ (NSArray *)gq_DBgetAllDBModel:(Class)dbModelClassName
{
    NSArray *ret;
    @try {
        RLMRealm *realm =  [self gq_DBcurrentRealm:dbModelClassName];
        if (realm) {
            if ([dbModelClassName respondsToSelector:@selector(allObjectsInRealm:)]) {
                RLMResults *results = [dbModelClassName allObjectsInRealm:realm];
                ret = [self gq_DBobjectsWithRealmResults:results];
            }
        }
    }
    @catch (NSException *exception) {
       [self gq_DBdealWithException:exception modelClassName:dbModelClassName];
    }
    
    return ret;
}

+ (NSArray *)gq_DBgetDBModelList:(Class )dbModelClassName withPredicate:(NSPredicate *)predicate
{
    NSArray *ret;
    @try {
        RLMRealm *realm =  [self gq_DBcurrentRealm:dbModelClassName];
        if (realm) {
            if ([dbModelClassName respondsToSelector:@selector(objectsInRealm:withPredicate:)]) {
                RLMResults *results = [dbModelClassName objectsInRealm:realm withPredicate:predicate];
                ret = [self gq_DBobjectsWithRealmResults:results];
            }
        }
    }
    @catch (NSException *exception) {
        [self gq_DBdealWithException:exception modelClassName:dbModelClassName];
    }
    
    return ret;
}

+ (id)gq_DBcurrentRealm:(Class)dbModelClassName
{
    RLMRealm *realm = nil;
    @try {
        NSString *path = [self gq_DBcurrentRealmPath:dbModelClassName];
        RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
        configuration.path = path;
        configuration.encryptionKey = [self gq_DBrealmKey];
        NSError *e = nil;
        realm = [RLMRealm realmWithConfiguration:configuration error:&e];
    }
    @catch (NSException *exception) {
        [GQBaseDBModel.gq_DBsettingReader gq_DBHandleError:exception];
    }
    if (!realm) {
        [[NSFileManager defaultManager] removeItemAtPath:[self gq_DBcurrentRealmPath:dbModelClassName] error:nil];
    }
    
    return realm;
}

+ (NSString *)gq_DBcurrentRealmPath:(Class)dbModelClassName
{
    NSString *pathIdentifier = gq_DBglobalString;
    if ([GQBaseDBModel respondsToSelector:@selector(gq_DBglobal)]) {
        if ([GQBaseDBModel gq_DBglobal]) {
            pathIdentifier = gq_DBglobalString;
        }
    } else {
        if ([GQBaseDBModel.gq_DBsettingReader respondsToSelector:@selector(gq_DBUserKey)]) {
            pathIdentifier = [GQBaseDBModel.gq_DBsettingReader gq_DBUserKey];
        }
    }
    if (pathIdentifier.length == 0) {
        pathIdentifier = gq_DBglobalString;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *folder = [paths.firstObject stringByAppendingPathComponent:gq_DB];
    folder = [folder stringByAppendingPathComponent:pathIdentifier];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folder]) {
        [manager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return [folder stringByAppendingPathComponent:[self gq_DBcurrentRealmName:dbModelClassName]];
}

+ (NSString *)gq_DBcurrentRealmName:(Class)dbModelClassName
{
    return[GQModelTransformer gq_NormalClassName:dbModelClassName];
}

+ (NSData *)gq_DBrealmKey
{
    static const uint8_t kKeychainIdentifier[] = "www.linit.space";
    NSData *tag = [[NSData alloc] initWithBytesNoCopy:(void *)kKeychainIdentifier
                                               length:sizeof(kKeychainIdentifier)
                                         freeWhenDone:NO];
    
    NSDictionary *query = @{(__bridge id)kSecClass: (__bridge id)kSecClassKey,
                            (__bridge id)kSecAttrApplicationTag: tag,
                            (__bridge id)kSecAttrKeySizeInBits: @512,
                            (__bridge id)kSecReturnData: @YES};
    
    CFTypeRef dataRef = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &dataRef);
    if (status == errSecSuccess) {
        return (__bridge NSData *)dataRef;
    }
    
    uint8_t buffer[64];
    SecRandomCopyBytes(kSecRandomDefault, 64, buffer);
    NSData *keyData = [[NSData alloc] initWithBytes:buffer length:sizeof(buffer)];
    
    query = @{(__bridge id)kSecClass: (__bridge id)kSecClassKey,
              (__bridge id)kSecAttrApplicationTag: tag,
              (__bridge id)kSecAttrKeySizeInBits: @512,
              (__bridge id)kSecValueData: keyData};
    
    status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    NSAssert(status == errSecSuccess, @"Failed to insert new key in the keychain");
    
    return keyData;
}

+ (void)gq_DBdealWithException:(NSException *)exception modelClassName:(Class)dbModelClassName
{
    NSError *e = [NSError errorWithDomain:RLMErrorDomain
                                     code:0
                                 userInfo:@{NSLocalizedDescriptionKey: exception.reason}];
    
    if ([GQBaseDBModel.gq_DBsettingReader respondsToSelector:@selector(gq_DBHandleError:)]) {
        [GQBaseDBModel.gq_DBsettingReader gq_DBHandleError:e];
    }
    [[NSFileManager defaultManager] removeItemAtPath:[self gq_DBcurrentRealm:dbModelClassName] error:nil];
}

+ (NSArray *)gq_DBobjectsWithRealmResults:(RLMResults *)results
{
    NSMutableArray *objects = [NSMutableArray array];
    if ([results isKindOfClass:RLMResults.class]) {
        for (NSUInteger idx = 0; idx < results.count; ++idx) {
            [objects addObject:[results objectAtIndex:idx]];
        }
    }
    return objects;
}

@end
