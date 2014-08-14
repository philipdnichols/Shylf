// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MyMovieGenre.h instead.

#import <CoreData/CoreData.h>


extern const struct MyMovieGenreAttributes {
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *name;
} MyMovieGenreAttributes;

extern const struct MyMovieGenreRelationships {
	__unsafe_unretained NSString *movies;
} MyMovieGenreRelationships;

extern const struct MyMovieGenreFetchedProperties {
} MyMovieGenreFetchedProperties;

@class MyMovie;




@interface MyMovieGenreID : NSManagedObjectID {}
@end

@interface _MyMovieGenre : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MyMovieGenreID*)objectID;





@property (nonatomic, strong) NSNumber* identifier;



@property int16_t identifierValue;
- (int16_t)identifierValue;
- (void)setIdentifierValue:(int16_t)value_;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) MyMovie *movies;

//- (BOOL)validateMovies:(id*)value_ error:(NSError**)error_;





@end

@interface _MyMovieGenre (CoreDataGeneratedAccessors)

@end

@interface _MyMovieGenre (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (int16_t)primitiveIdentifierValue;
- (void)setPrimitiveIdentifierValue:(int16_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (MyMovie*)primitiveMovies;
- (void)setPrimitiveMovies:(MyMovie*)value;


@end
