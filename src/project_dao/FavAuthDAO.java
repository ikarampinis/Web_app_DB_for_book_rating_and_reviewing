/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package project_dao;

import entity.Comments;
import entity.FavAuthors;
import entity.FavAuthorsPK;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author yiann
 */
public class FavAuthDAO {
    public boolean addFavAuth(String user, String author) {
        Transaction transaction = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();
                
                FavAuthorsPK pk = new FavAuthorsPK(user);
                FavAuthors fav = new FavAuthors(pk, author);
                
                session.save(fav);
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
    
    public List getFavAuthList(String user) {
        Transaction transaction = null;
        List list;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();
                
                list = session.createQuery("SELECT f FROM FavAuthors f WHERE f.favAuthorsPK.userUsername = :userUsername").setParameter("userUsername", user).list();
                
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
    
    public boolean rmvFavAuth(String user, String author) {
        Transaction transaction = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();
                
                List list = session.createQuery("SELECT f FROM FavAuthors f WHERE f.favAuthorsPK.userUsername = :userUsername AND f.author = :author").setParameter("userUsername", user).setParameter("author", author).getResultList();
                if(list.isEmpty()){
                    return false;
                }
                
                session.remove(list.get(0));
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
    
    public boolean isFavAuth(String user, String author) {
        Transaction transaction = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();
                
                List list = session.createQuery("SELECT f FROM FavAuthors f WHERE f.favAuthorsPK.userUsername = :userUsername AND f.author = :author").setParameter("userUsername", user).setParameter("author", author).getResultList();
                if(list.isEmpty()){
                    return false;
                }
                
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
    
    public List getTwofav(String user) {
        Transaction transaction = null;
        List<FavAuthors> list;
        List<FavAuthors> newlist = new ArrayList<>();
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();
                
                list = session.createQuery("SELECT f FROM FavAuthors f WHERE f.favAuthorsPK.userUsername = :userUsername").setParameter("userUsername", user).list();
                if(list.isEmpty()){
                    return Collections.emptyList();
                }
               
                if(list.size() == 1 || list.size() == 2){
                    return list;
                }

                int random=0;
                Random rand = new Random();
                for(int i=0; i<2; i++){
                    random = rand.nextInt(list.size());
                    if(i == 1 && newlist.get(0) == list.get(random)){
                        i--;
                        continue;
                    }
                    newlist.add(list.get(random));
                }
                
                
                transaction.commit();

        } catch (Exception e) {
                if (transaction != null) {
                        transaction.rollback();
                }
                e.printStackTrace();
                return Collections.emptyList();
        }
        return newlist;
    }
}
