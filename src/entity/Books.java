/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
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
@Table(name = "books")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Books.findAll", query = "SELECT b FROM Books b"),
    @NamedQuery(name = "Books.findByIsbn", query = "SELECT b FROM Books b WHERE b.isbn = :isbn"),
    @NamedQuery(name = "Books.findByAuthor", query = "SELECT b FROM Books b WHERE b.author = :author"),
    @NamedQuery(name = "Books.findByTitle", query = "SELECT b FROM Books b WHERE b.title = :title"),
    @NamedQuery(name = "Books.findByEditorsPicks", query = "SELECT b FROM Books b WHERE b.editorsPicks = :editorsPicks"),
    @NamedQuery(name = "Books.findByRatings", query = "SELECT b FROM Books b WHERE b.ratings = :ratings"),
    @NamedQuery(name = "Books.findByRatingCounter", query = "SELECT b FROM Books b WHERE b.ratingCounter = :ratingCounter")})
public class Books implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "isbn")
    private String isbn;
    @Basic(optional = false)
    @Column(name = "author")
    private String author;
    @Basic(optional = false)
    @Column(name = "title")
    private String title;
    @Basic(optional = false)
    @Column(name = "editorsPicks")
    private int editorsPicks;
    @Basic(optional = false)
    @Column(name = "ratings")
    private int ratings;
    @Basic(optional = false)
    @Column(name = "rating_counter")
    private int ratingCounter;
    @Basic(optional = false)
    @Lob
    @Column(name = "image")
    private String image;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "books")
    private List<UserReview> userReviewList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "books")
    private List<UserBooks> userBooksList;

    public Books() {
    }

    public Books(String isbn) {
        this.isbn = isbn;
    }

    public Books(String isbn, String author, String title, int editorsPicks, int ratings, int ratingCounter, String image) {
        this.isbn = isbn;
        this.author = author;
        this.title = title;
        this.editorsPicks = editorsPicks;
        this.ratings = ratings;
        this.ratingCounter = ratingCounter;
        this.image = image;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getEditorsPicks() {
        return editorsPicks;
    }

    public void setEditorsPicks(int editorsPicks) {
        this.editorsPicks = editorsPicks;
    }

    public int getRatings() {
        return ratings;
    }

    public void setRatings(int ratings) {
        this.ratings = ratings;
    }

    public int getRatingCounter() {
        return ratingCounter;
    }

    public void setRatingCounter(int ratingCounter) {
        this.ratingCounter = ratingCounter;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @XmlTransient
    public List<UserReview> getUserReviewList() {
        return userReviewList;
    }

    public void setUserReviewList(List<UserReview> userReviewList) {
        this.userReviewList = userReviewList;
    }

    @XmlTransient
    public List<UserBooks> getUserBooksList() {
        return userBooksList;
    }

    public void setUserBooksList(List<UserBooks> userBooksList) {
        this.userBooksList = userBooksList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (isbn != null ? isbn.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Books)) {
            return false;
        }
        Books other = (Books) object;
        if ((this.isbn == null && other.isbn != null) || (this.isbn != null && !this.isbn.equals(other.isbn))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Books[ isbn=" + isbn + " ]";
    }
    
}
