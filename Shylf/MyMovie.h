#import "_MyMovie.h"

@interface MyMovie : _MyMovie {}

+ (NSFetchRequest *)fetchAllWithGenre:(NSString *)genre;
+ (NSArray *)fetchAllWithIdentifier:(NSUInteger)identifier;
+ (NSArray *)fetchAllWithTitle:(NSString *)title;

- (void)saveWithSuccess:(void(^)())success failure:(void(^)(NSError *error))failure;
- (void)deleteWithSuccess:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
