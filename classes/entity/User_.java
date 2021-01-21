package entity;

import javax.annotation.processing.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(User.class)
public abstract class User_ {

	public static volatile SingularAttribute<User, String> birthday;
	public static volatile SingularAttribute<User, byte[]> image;
	public static volatile SingularAttribute<User, String> country;
	public static volatile SingularAttribute<User, String> firstname;
	public static volatile SingularAttribute<User, String> gender;
	public static volatile ListAttribute<User, Quotes> quotesList;
	public static volatile SingularAttribute<User, String> lastname;
	public static volatile ListAttribute<User, UserReview> userReviewList;
	public static volatile SingularAttribute<User, String> password;
	public static volatile ListAttribute<User, FavAuthors> favAuthorsList;
	public static volatile ListAttribute<User, UserBooks> userBooksList;
	public static volatile SingularAttribute<User, String> email;
	public static volatile SingularAttribute<User, String> username;

	public static final String BIRTHDAY = "birthday";
	public static final String IMAGE = "image";
	public static final String COUNTRY = "country";
	public static final String FIRSTNAME = "firstname";
	public static final String GENDER = "gender";
	public static final String QUOTES_LIST = "quotesList";
	public static final String LASTNAME = "lastname";
	public static final String USER_REVIEW_LIST = "userReviewList";
	public static final String PASSWORD = "password";
	public static final String FAV_AUTHORS_LIST = "favAuthorsList";
	public static final String USER_BOOKS_LIST = "userBooksList";
	public static final String EMAIL = "email";
	public static final String USERNAME = "username";

}

