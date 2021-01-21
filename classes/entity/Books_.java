package entity;

import javax.annotation.processing.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Books.class)
public abstract class Books_ {

	public static volatile SingularAttribute<Books, Integer> editorsPicks;
	public static volatile SingularAttribute<Books, String> image;
	public static volatile ListAttribute<Books, UserReview> userReviewList;
	public static volatile ListAttribute<Books, UserBooks> userBooksList;
	public static volatile SingularAttribute<Books, String> author;
	public static volatile SingularAttribute<Books, Integer> ratings;
	public static volatile SingularAttribute<Books, Integer> ratingCounter;
	public static volatile SingularAttribute<Books, String> isbn;
	public static volatile SingularAttribute<Books, String> title;

	public static final String EDITORS_PICKS = "editorsPicks";
	public static final String IMAGE = "image";
	public static final String USER_REVIEW_LIST = "userReviewList";
	public static final String USER_BOOKS_LIST = "userBooksList";
	public static final String AUTHOR = "author";
	public static final String RATINGS = "ratings";
	public static final String RATING_COUNTER = "ratingCounter";
	public static final String ISBN = "isbn";
	public static final String TITLE = "title";

}

