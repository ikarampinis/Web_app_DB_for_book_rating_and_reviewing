package entity;

import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Upcoming.class)
public abstract class Upcoming_ {

	public static volatile SingularAttribute<Upcoming, String> name;
	public static volatile SingularAttribute<Upcoming, byte[]> photo;
	public static volatile SingularAttribute<Upcoming, Integer> id;

	public static final String NAME = "name";
	public static final String PHOTO = "photo";
	public static final String ID = "id";

}

