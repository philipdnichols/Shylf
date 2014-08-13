// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MyBook.h instead.

#import <CoreData/CoreData.h>


extern const struct MyBookAttributes {
	__unsafe_unretained NSString *author;
	__unsafe_unretained NSString *title;
} MyBookAttributes;

extern const struct MyBookRelationships {
} MyBookRelationships;

extern const struct MyBookFetchedProperties {
} MyBookFetchedProperties;





@interface MyBookID : NSManagedObjectID {}
@end

@interface _MyBook : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MyBookID*)objectID;





@property (nonatomic, strong) NSString* author;



//- (BOOL)validateAuthor:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;






@end

@interface _MyBook (CoreDataGeneratedAccessors)

@end

@interface _MyBook (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAuthor;
- (void)setPrimitiveAuthor:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




@end
