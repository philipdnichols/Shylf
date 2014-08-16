#import "MyMovie.h"
#import "UIImage+IO.h"


@interface MyMovie ()

@end


@implementation MyMovie

+ (NSFetchRequest *)fetchAllWithGenre:(NSString *)genre
{
    return [MyMovie MR_requestAllSortedBy:@"title"
                                ascending:YES
                            withPredicate:[NSPredicate predicateWithFormat:@"ANY genres.name == %@", genre]];
}

+ (NSArray *)fetchAllWithIdentifier:(NSUInteger)identifier
{
    return [MyMovie MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"identifier == %d", identifier]];
}

+ (NSArray *)fetchAllWithTitle:(NSString *)title
{
    return [MyMovie MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"title == %@" , title]];
}

- (void)saveWithSuccess:(void(^)())success failure:(void(^)(NSError *error))failure
{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL succ, NSError *error) {
        if (!error) {
            success();
        } else {
            failure(error);
        }
    }];
}

- (void)deleteWithSuccess:(void(^)())success failure:(void(^)(NSError *error))failure
{
    [self MR_deleteEntity];
    
    [UIImage deleteFromDiskWithFilePathURL:[NSURL fileURLWithPath:self.thumbnailFileURL]];
    [UIImage deleteFromDiskWithFilePathURL:[NSURL fileURLWithPath:self.posterFileURL]];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL succ, NSError *error) {
        if (!error) {
            success();
        } else {
            failure(error);
        }
    }];
}

@end
