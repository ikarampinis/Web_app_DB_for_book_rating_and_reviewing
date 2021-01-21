package entity;

import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(UserBooksPK.class)
public abstract class UserBooksPK_ {

	public static volatile SingularAttribute<UserBooksPK, String> userUsername;
	public static volatile SingularAttribute<UserBooksPK, String> booksIsbn;

	public static final String USER_USERNAME = "userUsername";
	public static final String BOOKS_ISBN = "booksIsbn";

}

