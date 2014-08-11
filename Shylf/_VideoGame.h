// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to VideoGame.h instead.

#import <CoreData/CoreData.h>


extern const struct VideoGameAttributes {
	__unsafe_unretained NSString *platform;
	__unsafe_unretained NSString *title;
} VideoGameAttributes;

extern const struct VideoGameRelationships {
} VideoGameRelationships;

extern const struct VideoGameFetchedProperties {
} VideoGameFetchedProperties;





@interface VideoGameID : NSManagedObjectID {}
@end

@interface _VideoGame : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (VideoGameID*)objectID;





@property (nonatomic, strong) NSString* platform;



//- (BOOL)validatePlatform:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;






@end

@interface _VideoGame (CoreDataGeneratedAccessors)

@end

@interface _VideoGame (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitivePlatform;
- (void)setPrimitivePlatform:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




@end
