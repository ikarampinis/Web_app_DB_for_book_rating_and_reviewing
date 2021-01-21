package project_dao;

import entity.UserReview;
import entity.UserReviewPK;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class ViewDAO {
    public boolean addReview(String user, String isbn, String rate) {
        Transaction transaction = null;
        UserReview check = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();

                UserReviewPK pk = new UserReviewPK(user, isbn);
                UserReview userreview = new UserReview(pk);

                check = session.get(UserReview.class, pk);
                if(check == null){
                    userreview.setRate(Integer.parseInt(rate));
                    session.save(userreview);
                }
                else{
                    if(Integer.parseInt(rate)!=0){
                        check.setRate(Integer.parseInt(rate));
                        session.update(check);
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
    
    public int bookRating(String user, String isbn) {
            Transaction transaction = null;
            UserReview check = null;
            int final_rate = 0; 
            try(Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();

                UserReviewPK pk = new UserReviewPK(user, isbn);

                check = session.get(UserReview.class, pk);
                if(check == null){
                    return (-1);
                }
                else{
                    final_rate = check.getRate();
                }

                transaction.commit();

        } catch (Exception e) {
                if (transaction != null) {
                        transaction.rollback();
                }
                e.printStackTrace();
                return -2;
        }
        if(final_rate == 0){
            return (-1);
        }
        else{
            return final_rate;
        }
    }
    
    public List getTopRated(String user) {
        Transaction transaction = null;
        UserReview curr = null, selected=null;
        List total_list = new ArrayList();
        List top_rated_list = new ArrayList();
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();

                total_list = session.createQuery("SELECT u FROM UserReview u WHERE u.userReviewPK.userUsername = :userUsername").setParameter("userUsername", user).list();
                for(int k=0; k<3; k++){
                    int max = 0;
                    Iterator<UserReview> it = total_list.iterator();
                    while(it.hasNext()){
                        curr = it.next();
                        if(max < curr.getRate()){
                            max = curr.getRate();
                            selected = curr;
                        }
                    }
                    if(max == 0 && k==0){
                        return null;
                    }
                    else if(max==0){
                        break;
                    }
                    else{
                        total_list.remove(selected);
                    }
                    top_rated_list.add(selected);
                }
                
                transaction.commit();

        } catch (Exception e) {
                if (transaction != null) {
                        transaction.rollback();
                }
                e.printStackTrace();
                return null;
        }
        return top_rated_list;
    }
}
