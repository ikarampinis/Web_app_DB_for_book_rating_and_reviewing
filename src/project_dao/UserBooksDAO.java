package project_dao;

import entity.UserBooks;
import entity.UserBooksPK;
import entity.UserReview;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class UserBooksDAO {
    public boolean addWantToRead(String user, String isbn) {
        Transaction transaction = null;
        UserBooks check = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();

                UserBooksPK pk = new UserBooksPK(user, isbn);
                UserBooks userbook = new UserBooks(pk);

                check = session.get(UserBooks.class, pk);
                if(check != null){
                    return false;
                }
                
                userbook.setStatus(1,0,0);
                session.save(userbook);
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
    
    public boolean addReadNow(String user, String isbn) {
        Transaction transaction = null;
        UserBooks check = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();

                UserBooksPK pk = new UserBooksPK(user, isbn);
                UserBooks userbook = new UserBooks(pk);

                check = session.get(UserBooks.class, pk);
                if(check == null){
                    return false;
                }
                
                check.setStatus(0,1,0);
                session.update(check);
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
    
    public boolean addFinished(String user, String isbn) {
        Transaction transaction = null;
        UserBooks check = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();

                UserBooksPK pk = new UserBooksPK(user, isbn);
                UserBooks userbook = new UserBooks(pk);

                check = session.get(UserBooks.class, pk);
                if(check == null){
                    return false;
                }
                
                check.setStatus(0,0,1);
                session.update(check);
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
    
    public boolean RemoveFromList(String user, String isbn) {
        Transaction transaction = null;
        UserBooks check = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();

                UserBooksPK pk = new UserBooksPK(user, isbn);
                UserBooks userbook = new UserBooks(pk);

                check = session.get(UserBooks.class, pk);
                if(check == null){
                    return false;
                }
                
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
    
    public List getWantToReadList(String user) {
        Transaction transaction = null;
        List total_list;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();

                total_list = session.createQuery("SELECT u FROM UserBooks u WHERE u.userBooksPK.userUsername = :userUsername AND u.wantRead = :wantRead").setParameter("userUsername", user).setParameter("wantRead", 1).getResultList();
                
                
                transaction.commit();

        } catch (Exception e) {
                if (transaction != null) {
                        transaction.rollback();
                }
                e.printStackTrace();
                return Collections.emptyList();
        }

        return total_list;
    }
    
    public List getReadNowList(String user) {
        Transaction transaction = null;
        List total_list;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();

                total_list = session.createQuery("SELECT u FROM UserBooks u WHERE u.userBooksPK.userUsername = :userUsername AND u.readNow = :readNow").setParameter("userUsername", user).setParameter("readNow", 1).getResultList();
                
                transaction.commit();

        } catch (Exception e) {
                if (transaction != null) {
                        transaction.rollback();
                }
                e.printStackTrace();
                return Collections.emptyList();
        }
        return total_list;
    }
    
    public List getFinishedList(String user) {
        Transaction transaction = null;
        List total_list;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();

                total_list = session.createQuery("SELECT u FROM UserBooks u WHERE u.userBooksPK.userUsername = :userUsername AND u.finished = :finished").setParameter("userUsername", user).setParameter("finished", 1).getResultList();
                
                transaction.commit();

        } catch (Exception e) {
                if (transaction != null) {
                        transaction.rollback();
                }
                e.printStackTrace();
                return Collections.emptyList();
        }
        return total_list;
    }
    
    public int FindStatus(String user, String isbn) {
        Transaction transaction = null;
        UserBooks check = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();

                check = session.get(UserBooks.class, new UserBooksPK(user, isbn));
                if(check == null){
                    return 0;
                }
                
                if(check.getWantRead() == 1){
                    return 1;
                }
                
                if(check.getReadNow() == 1){
                    return 2;
                }
                
                transaction.commit();

        } catch (Exception e) {
                if (transaction != null) {
                        transaction.rollback();
                }
                e.printStackTrace();
                return -1;
        }
        return 3;
    }
}
