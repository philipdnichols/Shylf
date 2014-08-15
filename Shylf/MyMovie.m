#import "MyMovie.h"


@interface MyMovie ()

@end


@implementation MyMovie

+ (NSFetchRequest *)fetchAllWithGenre:(NSString *)genre
{
    return [MyMovie MR_requestAllSortedBy:@"title"
                                ascending:YES
                            withPredicate:[NSPredicate predicateWithFormat:@"ANY genres.name == %@", genre]];
}

- (void)deleteWithSuccess:(void(^)())success failure:(void(^)(NSError *error))failure
{
    [self MR_deleteEntity];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL succ, NSError *error) {
        if (!error) {
            success();
        } else {
            failure(error);
        }
    }];
}

@end
