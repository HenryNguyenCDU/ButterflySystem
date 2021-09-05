//
//  ISDBManager.m
//  SoapWebServiceDemo
//
//  Created by Henry Nguyen on 5/13/15.
//  Copyright (c)  Amogh Natu. All rights reserved.
//

#import "BSAppDBManager.h"
#import "FMDB.h"
#import "BSAppSQL.h"
#import <UIKit/UIKit.h>
#import "BSAppHelper.h"
#import "Constants.h"

#define kDefaultDBName @"butterflySystems.db"

static NSString *dbFileName = kDefaultDBName;
static  NSString *DATABASE_NAME = @"butterflySystems";

//meta tables


@interface BSAppDBManager ()

@property (nonatomic,strong)  FMDatabaseQueue *queue;
@property (nonatomic,retain)  NSString *path;

@end

@implementation BSAppDBManager{

    BSAppSQL *sqlsClass;
    NSUserDefaults *ses_db;
}

static id _sharedDatabaseManager;

+ (id)sharedDatabaseManager{
    static id _sharedDatabaseManager = nil;
    static dispatch_once_t predicate = 0;
    
    dispatch_once(&predicate, ^{
        _sharedDatabaseManager = [[self alloc] init];
    });
    return _sharedDatabaseManager;
}

- (void) dealloc {
    [self close];
}

- (id)init{
    
    self = [super init];
    if (self){
       ses_db = [NSUserDefaults standardUserDefaults];
       sqlsClass = [[BSAppSQL alloc] init];
        int state = [self initializeDBWithName:kDefaultDBName];
        if (state == -1) {
            NSLog(@"DB init failed");
        } else {
            NSLog(@"DB init success");
        }
  
    }

    return self;
}

/**
 * @@brief create database
 * @@param name: path contain database
 * @@return:
*/

- (void)DBCreate{

        for (int i = 0; i < [[sqlsClass allPropertyNames] count]; i ++) {            
            // create table with table name and and excute sql;
            NSString *_key = [[sqlsClass allPropertyNames] allKeys][i];
            NSString *_sql = [[sqlsClass allPropertyNames] valueForKey:_key];
            
            [self createTableWithTableName:_key :_sql];
        }

}

- (int32_t)getuserVersion:(FMDatabase *)db{
    int  version =  [db userVersion];
    return version;
}

- (void)setUserVersion:(int32_t)_version :(FMDatabase *)db{
    [db setUserVersion:_version];
}

- (BOOL)IsColumnExisted:(NSString *)sColumnName :(NSString *)sTableName :(FMDatabase *)db {
   return [db columnExists:sColumnName inTableWithName:sTableName];
}

/**
 * @@brief connect database
 * @@param name:
 * @@return: connect to database with name
*/
- (FMDatabaseQueue *)dbConnect{
    NSString *docp = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    _DBname = [docp stringByAppendingString:[NSString stringWithFormat:@"/%@",kDefaultDBName]];
    _queue =  [FMDatabaseQueue databaseQueueWithPath:_DBname];
   return _queue;
}

/**
 * @@brief: create table
 * @@param name: table name
 * @@return: create table
*/

- (void)createTableWithTableName:(NSString *)_tbName :(NSString *)_sql{

    if ([self IsTableExisted:_tbName]) {
        [self executeUpdate:[NSString stringWithFormat:@"DROP TABLE IF EXISTS `%@` ",[_tbName uppercaseString]]];
    }
    [self executeUpdate:_sql];
}

 - (void)executeQuery:(NSString *)sql queryResBlock:(void(^)(FMResultSet *set))queryResBlock{
     
     FMResultSet *set = [[BSAppDBManager sharedDatabaseManager].database executeQuery:sql];
     
     if(queryResBlock != nil) queryResBlock(set);
}
/**
 * @@brief : clear data in table
 * @@param name: table name
 * @@return:
 */
- (void)clearDataInTable:(NSString *)table{
    
    NSString *deleteSQL = [NSString stringWithFormat:@"delete from %@", table];
    [self executeUpdate:deleteSQL];

}

/**
 * @@brief drop table
 * @@param name:
 * @@return:
*/

- (void)dropTable:(NSString *)_tbName{
        if (![self executeUpdate:[NSString stringWithFormat:@" DROP TABLE IF EXISTS `%@` ",_tbName]]) {
            NSLog(@"Excute sql unsuccessfull");
        };
}

/**
 * @@brief check table is existed
 * @@param name: table name
 * @@return: table has existed: true, has not yet: false
*/

- (BOOL)IsTableExisted:(NSString *)sTableName {

    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) FROM sqlite_master WHERE type ='table' AND name = '%@'", [sTableName uppercaseString]];
    __block BOOL res = NO;
    [self executeQuery:sql queryResBlock:^(FMResultSet *set) {
        
        while ([set next]) {
            NSUInteger count = [set intForColumnIndex:0];
            res = count ==1;
        }
    }];
    
    return res;
}

- (long)countTable:(NSString *)table{
    
    NSString *alias = @"COUNT";
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) AS %@ FROM %@;",alias,table];
    
    __block long count = 0;
    
    [self executeQueryWithBlock:sql queryResBlock:^(FMResultSet *set) {
        while ([set next]) {
            count = [[set stringForColumn:alias] integerValue];
        }
    }];
    return count;
}

- (long)countItemsOnTable:(NSString *)_orderId{
    
    NSString *alias = @"COUNT";
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) AS %@ FROM 'ORDER_ITEM' WHERE 'OrderID' = %@;",alias,_orderId];
    
    __block long count = 0;
    
    [self executeQueryWithBlock:sql queryResBlock:^(FMResultSet *set) {
        while ([set next]) {
            count = [[set stringForColumn:alias] integerValue];
        }
    }];
    return count;
}

- (void) inDatabase:(void (^__strong)(void))block{
    
    [_queue inDatabase:^(FMDatabase *db) {
        [BSAppDBManager sharedDatabaseManager].database = db;
        block();
       [BSAppDBManager sharedDatabaseManager].database = nil;
    }];
    [self close];
}

- (void) inTransaction:(void (^)(void))block {
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [BSAppDBManager sharedDatabaseManager].database = db;
        block();
        [BSAppDBManager sharedDatabaseManager].database = nil;
    }];
    [self close];
}

- (BOOL)executeUpdate:(NSString *)sql{
    BOOL updateRes = [[BSAppDBManager sharedDatabaseManager].database executeUpdate:sql];
    return updateRes;
}

- (void)executeQueryWithParameter:(NSString *)sql :(NSArray *)_varList queryResBlock:(void(^)(FMResultSet *set))queryResBlock{

    FMResultSet *_myresult = [[BSAppDBManager sharedDatabaseManager].database executeQuery:sql withArgumentsInArray:_varList];
    if(queryResBlock != nil) queryResBlock(_myresult);
    
}

- (void)executeUpdateWithParameter:(NSString *)sql :(NSArray *)_varList {
     [[BSAppDBManager sharedDatabaseManager].database executeUpdate: sql withArgumentsInArray:_varList];
  //  NSLog(@"%@",[BSAppDBManager sharedDatabaseManager].database);
}

- (void)executeQueryWithBlock:(NSString *)sql queryResBlock:(void(^)(FMResultSet *set))queryResBlock{
    FMResultSet *set = [[BSAppDBManager sharedDatabaseManager].database executeQuery:sql];
    
    if(queryResBlock != nil) queryResBlock(set);
}

- (int) initializeDBWithName: (NSString *) name {
    if (!name) {
        return -1;
    }
    NSString * docp = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    _DBname = [docp stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
    [self dbConnect];
    return 1;
}

- (void)close {
    [_queue close];
}

///UpgradeDB

- (void)setupWorkingDatabase{
  
    NSString *pathDb = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    _DBname = [pathDb stringByAppendingString:[NSString stringWithFormat:@"/%@",kDefaultDBName]];
     _queue =  [FMDatabaseQueue databaseQueueWithPath:_DBname];
    NSLog(@"%@",_DBname);
        [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            
            [BSAppDBManager sharedDatabaseManager].database = db;
            if(![self IsTableExisted:TABLE_ORDER])  [self DBCreate];
            else return;
        }];
}

- (void)clearDataDB{

   // [[ISAppDBManager sharedDatabaseManager] inDatabase: ^{
    //    [[ISAppDBManager sharedDatabaseManager] clearDataInTable:TABLE_PURCHASEORDER];
    //    [[ISAppDBManager sharedDatabaseManager] clearDataInTable:TABLE_ITEM];
    //    [[ISAppDBManager sharedDatabaseManager] clearDataInTable:TABLE_INVOICE];

  //  }];
}



@end
