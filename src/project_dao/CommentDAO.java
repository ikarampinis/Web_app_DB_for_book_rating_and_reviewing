package project_dao;

import org.hibernate.Session;
import org.hibernate.Transaction;
import entity.Comments;
import entity.CommentsPK;
import java.util.ArrayList;
import java.util.List;
import util.HibernateUtil;

public class CommentDAO {
    public int addComment(Comments item) {
        Transaction transaction = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();
                session.save(item);
                transaction.commit();

        } catch (Exception e) {
                if (transaction != null) {
                        transaction.rollback();
                }
                e.printStackTrace();
                return(1);
        }
        return(0);
    }
    
    public boolean rmvComment(CommentsPK pk) {
        Transaction transaction = null;
        
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();
                Comments check = session.get(Comments.class, pk);
                session.remove(check);
                transaction.commit();

        } catch (Exception e) {
                if (transaction != null) {
                        transaction.rollback();
                }
                e.printStackTrace();
                return false;
        }
        return true;
    }
    
    public List<Comments> getComments(String isbn) {
        Transaction transaction = null;
        List list = new ArrayList<Comments>();
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

            transaction = session.beginTransaction();

            list = session.createQuery("SELECT c FROM Comments c WHERE c.commentsPK.userHasBooksBooksIsbn = :userHasBooksBooksIsbn").setParameter("userHasBooksBooksIsbn", isbn).list();

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
