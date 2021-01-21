package project_dao;

import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import entity.User;
import util.HibernateUtil;
import java.util.Base64;

public class UserDAO {
    
    public int addUser(User item) {
		Transaction transaction = null;
                User check = null;
		try(Session session = HibernateUtil.getSessionFactory().openSession()) {
                        
			transaction = session.beginTransaction();
                        
                        check = session.get(User.class, item.getUsername());
                        if(check != null){
                            return(1);
                        }
                        check = session.get(User.class, item.getEmail());
                        if(check != null){
                            return(2);
                        }
                        
			session.save(item);
			transaction.commit();
                        
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
                        return(3);
		}
                return(0);
	}
    
        public int check_username(User item){
            Transaction transaction = null;
            User check = null;
            try(Session session = HibernateUtil.getSessionFactory().openSession()) {

                    transaction = session.beginTransaction();

                    check = session.get(User.class, item.getUsername());
                    if(check == null){
                        //wrong username
                        return(1);
                    }
                    else{
                        if(!item.getPassword().equals(check.getPassword())){
                            //wrong password
                            return (2);
                        }
                    }
                    
                    transaction.commit();

            } catch (Exception e) {
                    if (transaction != null) {
                            transaction.rollback();
                    }
                    e.printStackTrace();
                    return(3);
            }
            return(0);
        }
        
        public String getUserImage(String id) {

		Transaction transaction = null;
		User user = null;
                String image = null;
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                    
			transaction = session.beginTransaction();
			user = session.get(User.class, id);
                        if(user.getImage()!=null){
                            image = Base64.getEncoder().encodeToString(user.getImage());
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
        
        public boolean uploadImage(byte[] image, String username) {

		Transaction transaction = null;
		User user = null;
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                    
			transaction = session.beginTransaction();
			user = session.get(User.class, username);
                        user.setImage(image);
                        session.update(user);
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
        
        public String[] getProfile(String id) {

		Transaction transaction = null;
		User user = null;
                String[] array = null;
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                    
			transaction = session.beginTransaction();
			user = session.get(User.class, id);
                        array = new String[9];
                        array[0] = user.getFirstname();
                        array[1] = user.getLastname();
                        array[2] = user.getUsername();
                        array[3] = user.getEmail();
                        array[4] = user.getPassword();
                        array[5] = "";
                        array[6] = user.getBirthday();
                        array[7] = user.getGender();
                        array[8] = user.getCountry();
			transaction.commit();
                        
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
		}
                
		return array;
	}
        
        public int updateUser(User user) {
		Transaction transaction = null;
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			transaction = session.beginTransaction();
                        
                        User old_user = session.get(User.class, user.getUsername());
                        
                        if(!old_user.getEmail().equals(user.getEmail())){
                            User check = session.get(User.class, user.getEmail());
                            if(check != null){
                                return(2);//already existing email
                            }
                        }
                        //session.evict(old_user);
                        old_user.setFirstname(user.getFirstname());
                        old_user.setLastname(user.getLastname());
                        old_user.setEmail(user.getEmail());
                        old_user.setPassword(user.getPassword());
                        old_user.setBirthday(user.getBirthday());
                        old_user.setGender(user.getGender());
                        old_user.setCountry(user.getCountry());
			session.update(old_user);
			transaction.commit();
		} catch (Exception e) {
                    if (transaction != null) {
                            transaction.rollback();
                    }
                    e.printStackTrace();
                    return (3);   
		}
            return (0);
	}
        
        
    
        public List<User> getAllUsers() {

		Transaction transaction = null;
		List<User> listOfProducts = null;
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			
			transaction = session.beginTransaction();
			listOfProducts = session.createQuery("from User").getResultList();
			transaction.commit();
                        
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
		}
		return listOfProducts;
	}
        
        public String[] getOtherProfile(String id) {

		Transaction transaction = null;
		User user = null;
                String[] array = null;
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                    
			transaction = session.beginTransaction();
			user = session.get(User.class, id);
                        array = new String[6];
                        array[0] = user.getFirstname();
                        array[1] = user.getLastname();
                        array[2] = user.getUsername();
                        array[3] = user.getBirthday();
                        array[4] = user.getGender();
                        array[5] = user.getCountry();
			transaction.commit();
                        
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
		}
                
		return array;
	}
}
