/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author yiann
 */
@Entity
@Table(name = "fav_authors")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "FavAuthors.findAll", query = "SELECT f FROM FavAuthors f"),
    @NamedQuery(name = "FavAuthors.findById", query = "SELECT f FROM FavAuthors f WHERE f.favAuthorsPK.id = :id"),
    @NamedQuery(name = "FavAuthors.findByAuthor", query = "SELECT f FROM FavAuthors f WHERE f.author = :author"),
    @NamedQuery(name = "FavAuthors.findByUserUsername", query = "SELECT f FROM FavAuthors f WHERE f.favAuthorsPK.userUsername = :userUsername")})
public class FavAuthors implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected FavAuthorsPK favAuthorsPK;
    @Basic(optional = false)
    @Column(name = "author")
    private String author;
    @JoinColumn(name = "user_username", referencedColumnName = "username", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private User user;

    public FavAuthors() {
    }

    public FavAuthors(FavAuthorsPK favAuthorsPK) {
        this.favAuthorsPK = favAuthorsPK;
    }

    public FavAuthors(FavAuthorsPK favAuthorsPK, String author) {
        this.favAuthorsPK = favAuthorsPK;
        this.author = author;
    }

    public FavAuthors(int id, String userUsername) {
        this.favAuthorsPK = new FavAuthorsPK(id, userUsername);
    }

    public FavAuthorsPK getFavAuthorsPK() {
        return favAuthorsPK;
    }

    public void setFavAuthorsPK(FavAuthorsPK favAuthorsPK) {
        this.favAuthorsPK = favAuthorsPK;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (favAuthorsPK != null ? favAuthorsPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof FavAuthors)) {
            return false;
        }
        FavAuthors other = (FavAuthors) object;
        if ((this.favAuthorsPK == null && other.favAuthorsPK != null) || (this.favAuthorsPK != null && !this.favAuthorsPK.equals(other.favAuthorsPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.FavAuthors[ favAuthorsPK=" + favAuthorsPK + " ]";
    }
    
}
