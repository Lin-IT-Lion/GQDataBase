//
//  GQfmdbTestTool.m
//  GQDataBaseDemo
//
//  Created by 林国强 on 16/5/31.
//  Copyright © 2016年 林国强. All rights reserved.
//
#import "FMDB.h"
#import "GQNormalModel.h"
#import "GQfmdbTestTool.h"
static FMDatabaseQueue *_queue;
NSString *const dbaseName = @"GQDataBase.sqlite";
@implementation GQfmdbTestTool
+ (void)initialize
{
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:dbaseName];
    
    _queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists tb_GQNormalModelTable (id integer primary key autoincrement,title text,nId text)"];
    }];
}

+ (void)saveList:(NSArray <GQNormalModel *>*)list
{
    [_queue inDatabase:^(FMDatabase *db) {
        for (GQNormalModel *item in list) {
            [db executeUpdate:@"insert into tb_GQNormalModelTable(title,nId) values(?,?)",item.title,[item.nId stringValue]];
        }
    }];
}

+ (NSArray <GQNormalModel *>*)getAllTestList
{
    __block NSMutableArray *arry = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        arry = [NSMutableArray array];
        FMResultSet *rs;
        rs = [db executeQuery:@"select * from tb_GQNormalModelTable"];
        while (rs.next) {
            GQNormalModel *model = [[GQNormalModel alloc] init];
            model.nId = @([[rs stringForColumn:@"nId"] integerValue]);
            model.title = [rs stringForColumn:@"title"];
            [arry addObject:model];
        }
    }];
    return arry;
}

+ (void)delAll
{
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"delete from tb_GQNormalModelTable"];
        
    }];
}

@end
