package entity;

import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(UserBooks.class)
public abstract class UserBooks_ {

	public static volatile SingularAttribute<UserBooks, Integer> wantRead;
	public static volatile SingularAttribute<UserBooks, Books> books;
	public static volatile SingularAttribute<UserBooks, Integer> readNow;
	public static volatile SingularAttribute<UserBooks, UserBooksPK> userBooksPK;
	public static volatile SingularAttribute<UserBooks, Integer> finished;
	public static volatile SingularAttribute<UserBooks, User> user;

	public static final String WANT_READ = "wantRead";
	public static final String BOOKS = "books";
	public static final String READ_NOW = "readNow";
	public static final String USER_BOOKS_PK = "userBooksPK";
	public static final String FINISHED = "finished";
	public static final String USER = "user";

}

