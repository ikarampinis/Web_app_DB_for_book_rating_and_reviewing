package entity;

import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(TopAuthors.class)
public abstract class TopAuthors_ {

	public static volatile SingularAttribute<TopAuthors, String> name;
	public static volatile SingularAttribute<TopAuthors, String> photo;
	public static volatile SingularAttribute<TopAuthors, Integer> id;

	public static final String NAME = "name";
	public static final String PHOTO = "photo";
	public static final String ID = "id";

}

