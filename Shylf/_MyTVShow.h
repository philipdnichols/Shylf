// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MyTVShow.h instead.

#import <CoreData/CoreData.h>


extern const struct MyTVShowAttributes {
	__unsafe_unretained NSString *title;
} MyTVShowAttributes;

extern const struct MyTVShowRelationships {
} MyTVShowRelationships;

extern const struct MyTVShowFetchedProperties {
} MyTVShowFetchedProperties;




@interface MyTVShowID : NSManagedObjectID {}
@end

@interface _MyTVShow : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MyTVShowID*)objectID;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;






@end

@interface _MyTVShow (CoreDataGeneratedAccessors)

@end

@interface _MyTVShow (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




@end
