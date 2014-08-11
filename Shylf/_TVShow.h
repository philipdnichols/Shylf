// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TVShow.h instead.

#import <CoreData/CoreData.h>


extern const struct TVShowAttributes {
	__unsafe_unretained NSString *title;
} TVShowAttributes;

extern const struct TVShowRelationships {
} TVShowRelationships;

extern const struct TVShowFetchedProperties {
} TVShowFetchedProperties;




@interface TVShowID : NSManagedObjectID {}
@end

@interface _TVShow : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TVShowID*)objectID;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;






@end

@interface _TVShow (CoreDataGeneratedAccessors)

@end

@interface _TVShow (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




@end
