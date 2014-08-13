// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MyVideoGame.h instead.

#import <CoreData/CoreData.h>


extern const struct MyVideoGameAttributes {
	__unsafe_unretained NSString *platform;
	__unsafe_unretained NSString *title;
} MyVideoGameAttributes;

extern const struct MyVideoGameRelationships {
} MyVideoGameRelationships;

extern const struct MyVideoGameFetchedProperties {
} MyVideoGameFetchedProperties;





@interface MyVideoGameID : NSManagedObjectID {}
@end

@interface _MyVideoGame : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MyVideoGameID*)objectID;





@property (nonatomic, strong) NSString* platform;



//- (BOOL)validatePlatform:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;






@end

@interface _MyVideoGame (CoreDataGeneratedAccessors)

@end

@interface _MyVideoGame (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitivePlatform;
- (void)setPrimitivePlatform:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




@end
