package entity;

import javax.annotation.processing.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(UserReview.class)
public abstract class UserReview_ {

	public static volatile ListAttribute<UserReview, Comments> commentsList;
	public static volatile SingularAttribute<UserReview, Books> books;
	public static volatile SingularAttribute<UserReview, Integer> rate;
	public static volatile SingularAttribute<UserReview, UserReviewPK> userReviewPK;
	public static volatile SingularAttribute<UserReview, User> user;

	public static final String COMMENTS_LIST = "commentsList";
	public static final String BOOKS = "books";
	public static final String RATE = "rate";
	public static final String USER_REVIEW_PK = "userReviewPK";
	public static final String USER = "user";

}

