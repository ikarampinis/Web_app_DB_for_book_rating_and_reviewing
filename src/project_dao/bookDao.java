package project_dao;

import org.hibernate.Session;
import org.hibernate.Transaction;
import entity.Books;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Random;
import util.HibernateUtil;

public class bookDao {
    
    public int addBook(Books item) {
        Transaction transaction = null;
        Books check = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();

                check = session.get(Books.class, item.getIsbn());
                if(check != null){
                    if(!item.getImage().equals(check.getImage())){
                        check.setImage(item.getImage());
                        session.update(check);
                        transaction.commit();
                    }
                    return(0);
                }

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
    
    public String[] getbook(String isbn) {
        Transaction transaction = null;
        Books check = null;
        String[] array = new String[6];
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();

                check = session.get(Books.class, isbn);
                if(check == null){
                    return null;
                }
                
                array[0]=check.getIsbn();
                array[1]=check.getAuthor();
                array[2]=check.getTitle();
                array[3]=String.valueOf(check.getRatings());
                array[4]=String.valueOf(check.getRatingCounter());
                array[5]=check.getImage();
                if(!array[5].equals("http://inf-server.inf.uth.gr/~ikarampinis/bookNotFound.png")){
                    array[5] = array[5]+"&printsec=frontcover&img=1&zoom=1&source=gbs_api";
                }
                
                transaction.commit();

        } catch (Exception e) {
                if (transaction != null) {
                        transaction.rollback();
                }
                e.printStackTrace();
                return null;
        }
        return array;
    }
    
    public boolean updateRate(String isbn, int rating, int NumOfRatings) {
        Transaction transaction = null;
        Books check = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();

                check = session.get(Books.class, isbn);
                if(check == null){
                    return false;
                }
                
                check.setRatings(rating);
                check.setRatingCounter(NumOfRatings);
                
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
    
    public Books[] getListofBooks() {
        Transaction transaction = null;
        Books[] array = new Books[10];
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();
                
                List list = session.createQuery("SELECT b FROM Books b").getResultList();
                
                List newlist= new ArrayList<>();
                
                if(list.size() > 50){
                    list = session.createQuery("SELECT g FROM Books g ORDER BY g.ratingCounter DESC").getResultList();
                    for(int k=0; k<50; k++){
                        newlist.add(list.get(k));
                    }
                }
                else{
                    newlist = list;
                }
                
                int random;
                Random rand = new Random();
                for(int k=0; k<10; k++){
                    random = rand.nextInt(newlist.size());
                    int i=0;
                    for(i=0; i<k; i++){
                        if(array[i] == (Books)newlist.get(random)){
                            break;
                        }
                    }
                    if(i != k){
                        k--;
                        continue;
                    }
                    array[k] = (Books)newlist.get(random);
                }
                
                transaction.commit();

        } catch (Exception e) {
                if (transaction != null) {
                        transaction.rollback();
                }
                e.printStackTrace();
                return null;
        }
        return array;
    }
    
    public List getEditorsPicks() {
        Transaction transaction = null;
        List newlist;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();
                
                List list = session.createQuery("SELECT b FROM Books b WHERE b.editorsPicks = :editorsPicks").setParameter("editorsPicks", 1).getResultList();
                
                newlist = list;
                
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
    
    public List getEditorsPicks(int edit) {
        Transaction transaction = null;
        List newlist;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                transaction = session.beginTransaction();
                List list =null;
                
                if(edit == 1){
                    list = session.createQuery("SELECT b FROM Books b WHERE b.editorsPicks = :editorsPicks").setParameter("editorsPicks", 1).getResultList();
                }
                else if(edit == 2){
                    list = session.createQuery("SELECT b FROM Books b WHERE b.editorsPicks = :editorsPicks").setParameter("editorsPicks", 2).getResultList();
                }
                else if(edit == 3){
                    list = session.createQuery("SELECT b FROM Books b WHERE b.editorsPicks = :editorsPicks").setParameter("editorsPicks", 3).getResultList();
                }
                
                
                newlist = list;
                
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
