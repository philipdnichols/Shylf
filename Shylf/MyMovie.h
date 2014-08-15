#import "_MyMovie.h"

@interface MyMovie : _MyMovie {}

+ (NSFetchRequest *)fetchAllWithGenre:(NSString *)genre;

- (void)deleteWithSuccess:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
