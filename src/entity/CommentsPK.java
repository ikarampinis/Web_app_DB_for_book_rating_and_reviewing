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
public class CommentsPK implements Serializable {

    @Basic(optional = false)
    @Column(name = "id")
    private long id;
    @Basic(optional = false)
    @Column(name = "user_has_books_user_username")
    private String userHasBooksUserUsername;
    @Basic(optional = false)
    @Column(name = "user_has_books_books_isbn")
    private String userHasBooksBooksIsbn;

    public CommentsPK() {
    }

    public CommentsPK(long id, String userHasBooksUserUsername, String userHasBooksBooksIsbn) {
        this.id = id;
        this.userHasBooksUserUsername = userHasBooksUserUsername;
        this.userHasBooksBooksIsbn = userHasBooksBooksIsbn;
    }
    
    public CommentsPK(String userHasBooksUserUsername, String userHasBooksBooksIsbn) {
        this.userHasBooksUserUsername = userHasBooksUserUsername;
        this.userHasBooksBooksIsbn = userHasBooksBooksIsbn;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUserHasBooksUserUsername() {
        return userHasBooksUserUsername;
    }

    public void setUserHasBooksUserUsername(String userHasBooksUserUsername) {
        this.userHasBooksUserUsername = userHasBooksUserUsername;
    }

    public String getUserHasBooksBooksIsbn() {
        return userHasBooksBooksIsbn;
    }

    public void setUserHasBooksBooksIsbn(String userHasBooksBooksIsbn) {
        this.userHasBooksBooksIsbn = userHasBooksBooksIsbn;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) id;
        hash += (userHasBooksUserUsername != null ? userHasBooksUserUsername.hashCode() : 0);
        hash += (userHasBooksBooksIsbn != null ? userHasBooksBooksIsbn.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CommentsPK)) {
            return false;
        }
        CommentsPK other = (CommentsPK) object;
        if (this.id != other.id) {
            return false;
        }
        if ((this.userHasBooksUserUsername == null && other.userHasBooksUserUsername != null) || (this.userHasBooksUserUsername != null && !this.userHasBooksUserUsername.equals(other.userHasBooksUserUsername))) {
            return false;
        }
        if ((this.userHasBooksBooksIsbn == null && other.userHasBooksBooksIsbn != null) || (this.userHasBooksBooksIsbn != null && !this.userHasBooksBooksIsbn.equals(other.userHasBooksBooksIsbn))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.CommentsPK[ id=" + id + ", userHasBooksUserUsername=" + userHasBooksUserUsername + ", userHasBooksBooksIsbn=" + userHasBooksBooksIsbn + " ]";
    }
    
}
