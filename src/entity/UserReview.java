/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author yiann
 */
@Entity
@Table(name = "user_review")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "UserReview.findAll", query = "SELECT u FROM UserReview u"),
    @NamedQuery(name = "UserReview.findByUserUsername", query = "SELECT u FROM UserReview u WHERE u.userReviewPK.userUsername = :userUsername"),
    @NamedQuery(name = "UserReview.findByBooksIsbn", query = "SELECT u FROM UserReview u WHERE u.userReviewPK.booksIsbn = :booksIsbn"),
    @NamedQuery(name = "UserReview.findByRate", query = "SELECT u FROM UserReview u WHERE u.rate = :rate")})
public class UserReview implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected UserReviewPK userReviewPK;
    @Column(name = "rate")
    private Integer rate;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "userReview")
    private List<Comments> commentsList;
    @JoinColumn(name = "books_isbn", referencedColumnName = "isbn", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Books books;
    @JoinColumn(name = "user_username", referencedColumnName = "username", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private User user;

    public UserReview() {
    }

    public UserReview(UserReviewPK userReviewPK) {
        this.userReviewPK = userReviewPK;
    }

    public UserReview(String userUsername, String booksIsbn) {
        this.userReviewPK = new UserReviewPK(userUsername, booksIsbn);
    }

    public UserReviewPK getUserReviewPK() {
        return userReviewPK;
    }

    public void setUserReviewPK(UserReviewPK userReviewPK) {
        this.userReviewPK = userReviewPK;
    }

    public Integer getRate() {
        return rate;
    }

    public void setRate(Integer rate) {
        this.rate = rate;
    }

    @XmlTransient
    public List<Comments> getCommentsList() {
        return commentsList;
    }

    public void setCommentsList(List<Comments> commentsList) {
        this.commentsList = commentsList;
    }

    public Books getBooks() {
        return books;
    }

    public void setBooks(Books books) {
        this.books = books;
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
        hash += (userReviewPK != null ? userReviewPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UserReview)) {
            return false;
        }
        UserReview other = (UserReview) object;
        if ((this.userReviewPK == null && other.userReviewPK != null) || (this.userReviewPK != null && !this.userReviewPK.equals(other.userReviewPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.UserReview[ userReviewPK=" + userReviewPK + " ]";
    }
    
}
