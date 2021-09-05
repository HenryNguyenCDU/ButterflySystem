
//  Copyright © . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"

@interface BSAppBaseDB : NSObject
-(BOOL)hasColumnNamed:(FMResultSet *)resultSet :(NSString *)columnName;
-(NSString *)stringForColumn:(FMResultSet *)resultSet :(NSString *)columnName;
-(long)longForColumn:(FMResultSet *)resultSet :(NSString *)columnName;
-(NSString *)dateForColumn:(FMResultSet *)resultSet :(NSString *)columnName;
@end
