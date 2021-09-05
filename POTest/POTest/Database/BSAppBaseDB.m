//
//  Demo Butterfly
//
//  Created by Hanh on 11/10/15.
//  Copyright ©  BB. All rights reserved.
//

#import "BSAppBaseDB.h"
#import "Constants.h"

@implementation BSAppBaseDB

-(BOOL)hasColumnNamed:(FMResultSet *)resultSet :(NSString *)columnName{
    columnName = [columnName lowercaseString];
    return [resultSet.columnNameToIndexMap objectForKey:columnName] ? YES : NO;
}
-(NSString *)stringForColumn:(FMResultSet *)resultSet :(NSString *)columnName{
    NSString *result = @"";
    if([self hasColumnNamed:resultSet: columnName])
    {
        result = [resultSet stringForColumn:columnName];
        if (result == nil)
        {
            result = @"";
        }
    }
    return result;
}
- (long)longForColumn:(FMResultSet *)resultSet :(NSString *)columnName{
    long result = 0;
    if([self hasColumnNamed:resultSet: columnName])
    {
        result = [resultSet longForColumn:columnName];
        if (result == 0)
        {
            result = 0;
        }
    }
    return result;
}
-(NSString *)dateForColumn:(FMResultSet *)resultSet :(NSString *)columnName{
    NSString *result = DEFAULT_VALUE_DATE;
    if([self hasColumnNamed:resultSet: columnName])
    {

        result = [resultSet stringForColumn:columnName];
        if (result == nil)
        {
            result = DEFAULT_VALUE_DATE;
        }
    }
    return result;
}
@end
