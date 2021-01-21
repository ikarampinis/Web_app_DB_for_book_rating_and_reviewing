package entity;

import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(UserReviewPK.class)
public abstract class UserReviewPK_ {

	public static volatile SingularAttribute<UserReviewPK, String> userUsername;
	public static volatile SingularAttribute<UserReviewPK, String> booksIsbn;

	public static final String USER_USERNAME = "userUsername";
	public static final String BOOKS_ISBN = "booksIsbn";

}

