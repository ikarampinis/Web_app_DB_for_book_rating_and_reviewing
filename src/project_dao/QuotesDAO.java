/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package project_dao;

import entity.FavAuthors;
import entity.FavAuthorsPK;
import entity.Quotes;
import entity.QuotesPK;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author yiann
 */
public class QuotesDAO {
    public boolean addQuote(String user, String quote, String auth, String book) {
        Transaction transaction = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();
                
                QuotesPK pk = new QuotesPK(user);
                Quotes q = new Quotes(pk, auth, quote, book);
                
                session.save(q);
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
    
    public boolean rmvQuote(String user, String quote, String auth, String book) {
        Transaction transaction = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();
                
                List list = session.createQuery("SELECT q FROM Quotes q WHERE q.quotesPK.userUsername = :userUsername").setParameter("userUsername", user).getResultList();
                if(!list.isEmpty()){
                    Iterator it = list.iterator();
                    while(it.hasNext()){
                        Quotes curr = (Quotes) it.next();
                        if(curr.getQuote().equals(quote) && curr.getAuthor().equals(auth) && curr.getBook().equals(book)){
                            session.remove(curr);
                            break;
                        }
                    }
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
    
    public List getQuotes(String user) {
        Transaction transaction = null;
        List qlist;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();
                
                qlist = session.createQuery("SELECT q FROM Quotes q WHERE q.quotesPK.userUsername = :userUsername").setParameter("userUsername", user).getResultList();

                transaction.commit();

        } catch (Exception e) {
                if (transaction != null) {
                        transaction.rollback();
                }
                e.printStackTrace();
                return Collections.emptyList();
        }
        return qlist;
    }
}
