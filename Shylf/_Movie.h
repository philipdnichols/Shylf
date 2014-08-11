// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Movie.h instead.

#import <CoreData/CoreData.h>


extern const struct MovieAttributes {
	__unsafe_unretained NSString *imageURL;
	__unsafe_unretained NSString *releaseDate;
	__unsafe_unretained NSString *thumbnailURL;
	__unsafe_unretained NSString *title;
} MovieAttributes;

extern const struct MovieRelationships {
} MovieRelationships;

extern const struct MovieFetchedProperties {
} MovieFetchedProperties;







@interface MovieID : NSManagedObjectID {}
@end

@interface _Movie : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MovieID*)objectID;





@property (nonatomic, strong) NSString* imageURL;



//- (BOOL)validateImageURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* releaseDate;



//- (BOOL)validateReleaseDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* thumbnailURL;



//- (BOOL)validateThumbnailURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;






@end

@interface _Movie (CoreDataGeneratedAccessors)

@end

@interface _Movie (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveImageURL;
- (void)setPrimitiveImageURL:(NSString*)value;




- (NSDate*)primitiveReleaseDate;
- (void)setPrimitiveReleaseDate:(NSDate*)value;




- (NSString*)primitiveThumbnailURL;
- (void)setPrimitiveThumbnailURL:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




@end
