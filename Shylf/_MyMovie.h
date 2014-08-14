// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MyMovie.h instead.

#import <CoreData/CoreData.h>


extern const struct MyMovieAttributes {
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *overview;
	__unsafe_unretained NSString *posterPath;
	__unsafe_unretained NSString *rating;
	__unsafe_unretained NSString *releaseDate;
	__unsafe_unretained NSString *runtime;
	__unsafe_unretained NSString *tagline;
	__unsafe_unretained NSString *title;
} MyMovieAttributes;

extern const struct MyMovieRelationships {
	__unsafe_unretained NSString *genres;
} MyMovieRelationships;

extern const struct MyMovieFetchedProperties {
} MyMovieFetchedProperties;

@class MyMovieGenre;










@interface MyMovieID : NSManagedObjectID {}
@end

@interface _MyMovie : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MyMovieID*)objectID;





@property (nonatomic, strong) NSNumber* identifier;



@property int16_t identifierValue;
- (int16_t)identifierValue;
- (void)setIdentifierValue:(int16_t)value_;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* overview;



//- (BOOL)validateOverview:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* posterPath;



//- (BOOL)validatePosterPath:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* rating;



@property float ratingValue;
- (float)ratingValue;
- (void)setRatingValue:(float)value_;

//- (BOOL)validateRating:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* releaseDate;



//- (BOOL)validateReleaseDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* runtime;



@property int16_t runtimeValue;
- (int16_t)runtimeValue;
- (void)setRuntimeValue:(int16_t)value_;

//- (BOOL)validateRuntime:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* tagline;



//- (BOOL)validateTagline:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *genres;

- (NSMutableSet*)genresSet;





@end

@interface _MyMovie (CoreDataGeneratedAccessors)

- (void)addGenres:(NSSet*)value_;
- (void)removeGenres:(NSSet*)value_;
- (void)addGenresObject:(MyMovieGenre*)value_;
- (void)removeGenresObject:(MyMovieGenre*)value_;

@end

@interface _MyMovie (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (int16_t)primitiveIdentifierValue;
- (void)setPrimitiveIdentifierValue:(int16_t)value_;




- (NSString*)primitiveOverview;
- (void)setPrimitiveOverview:(NSString*)value;




- (NSString*)primitivePosterPath;
- (void)setPrimitivePosterPath:(NSString*)value;




- (NSNumber*)primitiveRating;
- (void)setPrimitiveRating:(NSNumber*)value;

- (float)primitiveRatingValue;
- (void)setPrimitiveRatingValue:(float)value_;




- (NSDate*)primitiveReleaseDate;
- (void)setPrimitiveReleaseDate:(NSDate*)value;




- (NSNumber*)primitiveRuntime;
- (void)setPrimitiveRuntime:(NSNumber*)value;

- (int16_t)primitiveRuntimeValue;
- (void)setPrimitiveRuntimeValue:(int16_t)value_;




- (NSString*)primitiveTagline;
- (void)setPrimitiveTagline:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (NSMutableSet*)primitiveGenres;
- (void)setPrimitiveGenres:(NSMutableSet*)value;


@end
