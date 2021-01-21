package entity;

import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Quotes.class)
public abstract class Quotes_ {

	public static volatile SingularAttribute<Quotes, String> quote;
	public static volatile SingularAttribute<Quotes, String> author;
	public static volatile SingularAttribute<Quotes, String> book;
	public static volatile SingularAttribute<Quotes, QuotesPK> quotesPK;
	public static volatile SingularAttribute<Quotes, User> user;

	public static final String QUOTE = "quote";
	public static final String AUTHOR = "author";
	public static final String BOOK = "book";
	public static final String QUOTES_PK = "quotesPK";
	public static final String USER = "user";

}

