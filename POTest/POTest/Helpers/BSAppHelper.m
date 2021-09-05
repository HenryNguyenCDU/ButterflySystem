//
//  Demo Butterfly
//
//  Created by Henry Nguyen on 6/4/15.
//  Copyright (c)  BB. All rights reserved.
//

#import "BSAppHelper.h"
#import "BSAppDBManager.h"
#import "Constants.h"
#import "Util.h"


@implementation BSAppHelper

NSUserDefaults *defaults;

- (id)init{
    
    if (!(self = [super init])) {
        self = [super init];
        
    }
    return self;

}

+ (NSString *)returnConfigFilePathOfApplication{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths lastObject];

    return documentsDirectory;
}

/*
 Function: copy file from current path to destination path.
 @Param: current path and destination path
 .....
*/

+ (BOOL)copyFileFromCurrentPath:(NSString *)_currentPath toDestionation:(NSString *)_destPath{
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSError *error;
    
    if ([filemgr fileExistsAtPath:_destPath]) {
        [filemgr removeItemAtPath:_destPath error:&error];
        [filemgr copyItemAtPath: _currentPath toPath:_destPath error: NULL];
    }
    else{
        if ([filemgr copyItemAtPath: _currentPath toPath:_destPath error: NULL]  == true) {
            return true;
        }
        else{
            return false;
        }
    }
    
    return true;
}

/*
 Function: copy database file from user dir to document dir
 @Param:
 .....
*/

+ (void)DBCopy:(NSString *)_destPath{
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSError *error;
    NSString *_DBdestPath      = [_destPath stringByAppendingPathComponent:@"butterflySystems.db"];
    NSString *_currentPath     = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"butterflySystems.db"];

    if ([filemgr fileExistsAtPath:_DBdestPath]) {
       [filemgr removeItemAtPath:_DBdestPath error:&error];
    }
    //NSLog(@"Current:%@ - Dest: %@", _currentPath, _DBdestPath);
    [filemgr copyItemAtPath: _currentPath toPath:_DBdestPath error: &error];
    
}

@end
