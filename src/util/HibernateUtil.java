package util;

import entity.*;
import java.util.Properties;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;


public class HibernateUtil {
	private static SessionFactory sessionFactory;

	public static SessionFactory getSessionFactory() {
		if (sessionFactory == null) {
			try {
				Configuration configuration = new Configuration();

				// Hibernate settings equivalent to hibernate.cfg.xml's properties
				Properties settings = new Properties();
				settings.put(Environment.DRIVER, "com.mysql.cj.jdbc.Driver");
				settings.put(Environment.URL, "jdbc:mysql://localhost:3306/bookway");
				settings.put(Environment.USER, "root");
				settings.put(Environment.PASS, "mysql");
				settings.put(Environment.DIALECT, "org.hibernate.dialect.MySQL5Dialect");

				settings.put(Environment.SHOW_SQL, "true");

				settings.put(Environment.CURRENT_SESSION_CONTEXT_CLASS, "thread");

				settings.put(Environment.HBM2DDL_AUTO, "update");

				configuration.setProperties(settings);
				configuration.addAnnotatedClass(User.class);
                                configuration.addAnnotatedClass(Books.class);
                                configuration.addAnnotatedClass(Comments.class);
                                configuration.addAnnotatedClass(CommentsPK.class);
                                configuration.addAnnotatedClass(UserBooks.class);
                                configuration.addAnnotatedClass(UserBooksPK.class);
                                configuration.addAnnotatedClass(UserReview.class);
                                configuration.addAnnotatedClass(UserReviewPK.class);
                                configuration.addAnnotatedClass(TopAuthors.class);
                                configuration.addAnnotatedClass(FavAuthors.class);
                                configuration.addAnnotatedClass(Quotes.class);
                                configuration.addAnnotatedClass(FavAuthorsPK.class);
                                configuration.addAnnotatedClass(QuotesPK.class);
                                configuration.addAnnotatedClass(Upcoming.class);
                                
				ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
						.applySettings(configuration.getProperties()).build();
				System.out.println("Hibernate Java Config serviceRegistry created");
				sessionFactory = configuration.buildSessionFactory(serviceRegistry);
				return sessionFactory;

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return sessionFactory;
	}
}
