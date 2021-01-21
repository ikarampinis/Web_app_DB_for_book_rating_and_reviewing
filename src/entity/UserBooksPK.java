/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 *
 * @author yiann
 */
@Embeddable
public class UserBooksPK implements Serializable {

    @Basic(optional = false)
    @Column(name = "user_username")
    private String userUsername;
    @Basic(optional = false)
    @Column(name = "books_isbn")
    private String booksIsbn;

    public UserBooksPK() {
    }

    public UserBooksPK(String userUsername, String booksIsbn) {
        this.userUsername = userUsername;
        this.booksIsbn = booksIsbn;
    }

    public String getUserUsername() {
        return userUsername;
    }

    public void setUserUsername(String userUsername) {
        this.userUsername = userUsername;
    }

    public String getBooksIsbn() {
        return booksIsbn;
    }

    public void setBooksIsbn(String booksIsbn) {
        this.booksIsbn = booksIsbn;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (userUsername != null ? userUsername.hashCode() : 0);
        hash += (booksIsbn != null ? booksIsbn.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UserBooksPK)) {
            return false;
        }
        UserBooksPK other = (UserBooksPK) object;
        if ((this.userUsername == null && other.userUsername != null) || (this.userUsername != null && !this.userUsername.equals(other.userUsername))) {
            return false;
        }
        if ((this.booksIsbn == null && other.booksIsbn != null) || (this.booksIsbn != null && !this.booksIsbn.equals(other.booksIsbn))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.UserBooksPK[ userUsername=" + userUsername + ", booksIsbn=" + booksIsbn + " ]";
    }
    
}
