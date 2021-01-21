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
import javax.persistence.JoinColumns;
import javax.persistence.Lob;
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
@Table(name = "comments")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Comments.findAll", query = "SELECT c FROM Comments c"),
    @NamedQuery(name = "Comments.findById", query = "SELECT c FROM Comments c WHERE c.commentsPK.id = :id"),
    @NamedQuery(name = "Comments.findByDate", query = "SELECT c FROM Comments c WHERE c.date = :date"),
    @NamedQuery(name = "Comments.findByUserHasBooksUserUsername", query = "SELECT c FROM Comments c WHERE c.commentsPK.userHasBooksUserUsername = :userHasBooksUserUsername"),
    @NamedQuery(name = "Comments.findByUserHasBooksBooksIsbn", query = "SELECT c FROM Comments c WHERE c.commentsPK.userHasBooksBooksIsbn = :userHasBooksBooksIsbn")})
public class Comments implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected CommentsPK commentsPK;
    @Basic(optional = false)
    @Lob
    @Column(name = "comment")
    private String comment;
    @Basic(optional = false)
    @Column(name = "date")
    private String date;
    @JoinColumns({
        @JoinColumn(name = "user_has_books_user_username", referencedColumnName = "user_username", insertable = false, updatable = false),
        @JoinColumn(name = "user_has_books_books_isbn", referencedColumnName = "books_isbn", insertable = false, updatable = false)})
    @ManyToOne(optional = false)
    private UserReview userReview;

    public Comments() {
    }

    public Comments(CommentsPK commentsPK) {
        this.commentsPK = commentsPK;
    }

    public Comments(CommentsPK commentsPK, String comment, String date) {
        this.commentsPK = commentsPK;
        this.comment = comment;
        this.date = date;
    }

    public Comments(long id, String userHasBooksUserUsername, String userHasBooksBooksIsbn) {
        this.commentsPK = new CommentsPK(id, userHasBooksUserUsername, userHasBooksBooksIsbn);
    }

    public CommentsPK getCommentsPK() {
        return commentsPK;
    }

    public void setCommentsPK(CommentsPK commentsPK) {
        this.commentsPK = commentsPK;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public UserReview getUserReview() {
        return userReview;
    }

    public void setUserReview(UserReview userReview) {
        this.userReview = userReview;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (commentsPK != null ? commentsPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Comments)) {
            return false;
        }
        Comments other = (Comments) object;
        if ((this.commentsPK == null && other.commentsPK != null) || (this.commentsPK != null && !this.commentsPK.equals(other.commentsPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Comments[ commentsPK=" + commentsPK + " ]";
    }
    
}
