package entity;

import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(CommentsPK.class)
public abstract class CommentsPK_ {

	public static volatile SingularAttribute<CommentsPK, String> userHasBooksUserUsername;
	public static volatile SingularAttribute<CommentsPK, Long> id;
	public static volatile SingularAttribute<CommentsPK, String> userHasBooksBooksIsbn;

	public static final String USER_HAS_BOOKS_USER_USERNAME = "userHasBooksUserUsername";
	public static final String ID = "id";
	public static final String USER_HAS_BOOKS_BOOKS_ISBN = "userHasBooksBooksIsbn";

}

