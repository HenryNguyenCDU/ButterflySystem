//
//  ISDBManager.h
//  SoapWebServiceDemo
//
//  Created by Henry Nguyen on 5/13/15.
//  Copyright (c)  Amogh Natu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"

@class FMDatabase;

@interface BSAppDBManager : NSObject{
    NSString * _DBname;
}

+ (instancetype)sharedDatabaseManager;
- (void) inDatabase:(void (^)(void))block;
- (void) inTransaction:(void (^)(void))block;
- (void) DBCreate;
- (void) close;

- (BOOL)executeUpdate:(NSString *)query;
- (void)executeUpdateWithParameter:(NSString *)sql :(NSArray *)_varList;
- (void)executeQuery:(NSString *)sql queryResBlock:(void(^)(FMResultSet *set))queryResBlock;
- (void)executeQueryWithParameter:(NSString *)sql :(NSArray *)_varList queryResBlock:(void(^)(FMResultSet *set))queryResBlock;

- (void)executeQueryWithBlock:(NSString *)sql queryResBlock:(void(^)(FMResultSet *set))queryResBlock;
- (void)clearDataInTable:(NSString *)table;
- (long)countTable:(NSString *)table;
- (long)countItemsOnTable:(NSString *)_orderId;
- (void)setupWorkingDatabase;
@property (weak, nonatomic) FMDatabase *database;
@property (strong, nonatomic) NSError *error;

@end
