//
//  ViewController.m
//  GQDataBaseDemo
//
//  Created by 林国强 on 16/5/18.
//  Copyright © 2016年 林国强. All rights reserved.
//

#import "ViewController.h"
#import "GQNormalModel.h"
#import "GQSecNormalModel.h"
#import "NSObject+GQDBOperation.h"
#import "GQfmdbTestTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testNormalModel];
//    [self performanceAnalysis];
    // Do any additional setup after loading the view, typically from a nib.

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.center = self.view.center;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(performanceAnalysis) forControlEvents:UIControlEventTouchUpInside];
}

- (void)performanceAnalysis
{
   
    NSMutableArray *arry = [NSMutableArray array];
    for (int i = 0; i < 10000; i++) {
        GQNormalModel *item = [[GQNormalModel alloc] init];
        item.title = [NSString stringWithFormat:@"%d",i];
        item.nId = @(i);
        [arry addObject:item];
    }
    
     //realm
    [self saveByRealm:arry];
    
    //sqlite
    [self saveBySQLITE:arry];
    
    [self getByRealm];
    
    [self getBySQLITE];
    
    [self delAllRealm];
    
    [self delAllSQLITE];
    
}

- (void)saveByRealm:(NSArray *)list
{
     [list gq_DBaddOrUpdate];
}

- (void)getByRealm
{
    NSLog(@"realm:%@",[GQNormalModel gq_DBgetAllObject]);
}

- (void)delAllRealm
{
    [GQNormalModel gq_DBdelAll];
}


- (void)saveBySQLITE:(NSArray *)list
{
    [GQfmdbTestTool saveList:list];
}
- (void)getBySQLITE
{
    NSLog(@"sqitel  :%@",[GQfmdbTestTool getAllTestList]);
}

- (void)delAllSQLITE
{
    [GQfmdbTestTool delAll];
}


- (void)testNormalModel
{
//    GQSecNormalDBModel *dbModle = [[GQSecNormalDBModel alloc] init];
    
    GQNormalModel *model = [[GQNormalModel alloc] init];
    model.title = @"1";
    model.nId = @(111);
    //save single
//    GQSecNormalDBModel *xx = [[GQSecNormalDBModel alloc] init];
    GQSecNormalModel *secModel = [[GQSecNormalModel alloc] init];
    secModel.smallTitle = @"xxxxxxxxxxx";
    secModel.smallTitle1 = @"123451111119999";
//    [secModel gq_DBaddOrUpdate];
    
    model.oneModel = secModel;
    
    for (int i = 0; i < 100; i++) {
        GQSecNormalModel *item = [[GQSecNormalModel alloc] init];
        item.smallTitle = [NSString stringWithFormat:@"%d",i];
        [model.oneModelList addObject:item];
    }
    
    [model gq_DBaddOrUpdate];
    NSMutableArray *arry = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        GQNormalModel *item = [[GQNormalModel alloc] init];
        item.title = [NSString stringWithFormat:@"%d",i];
        item.nId = @(i);
        [arry addObject:item];
    }
    [arry gq_DBaddOrUpdate];
    //save arry
    
    //get single
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(nId == %@)",model.nId];
    GQNormalModel *testModel = [GQNormalModel gq_DBgetObjectsWithPredicate:predicate].lastObject;
    
    NSLog(@"%@",testModel.title);
    
//   [testModel gq_DBDel];
    model.title = @"213123123";
   [model gq_DBaddOrUpdate];

    //get arry
    NSArray *list = [GQNormalModel gq_DBgetAllObject];
    NSLog(@"%@",list);
    
    [GQNormalModel gq_DBdelAll];
    NSLog(@"%@", [GQNormalModel gq_DBgetAllObject]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
