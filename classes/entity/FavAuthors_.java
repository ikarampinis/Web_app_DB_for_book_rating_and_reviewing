package entity;

import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(FavAuthors.class)
public abstract class FavAuthors_ {

	public static volatile SingularAttribute<FavAuthors, String> author;
	public static volatile SingularAttribute<FavAuthors, FavAuthorsPK> favAuthorsPK;
	public static volatile SingularAttribute<FavAuthors, User> user;

	public static final String AUTHOR = "author";
	public static final String FAV_AUTHORS_PK = "favAuthorsPK";
	public static final String USER = "user";

}

