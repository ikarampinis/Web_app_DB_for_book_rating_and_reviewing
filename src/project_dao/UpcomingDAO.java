package project_dao;

import entity.Upcoming;
import java.util.Base64;
import java.util.Collections;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;


public class UpcomingDAO {
    
    public List<Upcoming> upcomingbooks(){
        Transaction transaction = null;
        List list;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();
                
                list = session.createQuery("SELECT u FROM Upcoming u").getResultList();
                
                transaction.commit();

        } catch (Exception e) {
                if (transaction != null) {
                        transaction.rollback();
                }
                e.printStackTrace();
                return Collections.emptyList();
        }
        return list;
    }
    
    public String getImage(int id){
        Transaction transaction = null;
		Upcoming book = null;
                String image = null;
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                    
			transaction = session.beginTransaction();
			book = session.get(Upcoming.class, id);
                        if(book.getPhoto()!=null){
                            image = Base64.getEncoder().encodeToString(book.getPhoto());
                        }
			transaction.commit();
                        
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
		}
                
		return image;
    }
}
