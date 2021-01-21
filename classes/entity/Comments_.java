package entity;

import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Comments.class)
public abstract class Comments_ {

	public static volatile SingularAttribute<Comments, String> date;
	public static volatile SingularAttribute<Comments, CommentsPK> commentsPK;
	public static volatile SingularAttribute<Comments, String> comment;
	public static volatile SingularAttribute<Comments, UserReview> userReview;

	public static final String DATE = "date";
	public static final String COMMENTS_PK = "commentsPK";
	public static final String COMMENT = "comment";
	public static final String USER_REVIEW = "userReview";

}

