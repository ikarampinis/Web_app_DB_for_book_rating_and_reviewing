package project_dao;

import entity.TopAuthors;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class TopAuthorsDAO {
    
    public List<TopAuthors> getTopAuthors(){
        Transaction transaction = null;
        List list = new ArrayList<TopAuthors>();
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

            transaction = session.beginTransaction();

            list = session.createQuery("SELECT t FROM TopAuthors t").list();

            transaction.commit();

        } catch (Exception e) {
            if (transaction != null) {
                    transaction.rollback();
            }
            e.printStackTrace();
            return null;
        }
        return list;
    }
}
