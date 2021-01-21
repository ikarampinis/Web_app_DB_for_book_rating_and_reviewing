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
@Table(name = "user_books")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "UserBooks.findAll", query = "SELECT u FROM UserBooks u"),
    @NamedQuery(name = "UserBooks.findByUserUsername", query = "SELECT u FROM UserBooks u WHERE u.userBooksPK.userUsername = :userUsername"),
    @NamedQuery(name = "UserBooks.findByBooksIsbn", query = "SELECT u FROM UserBooks u WHERE u.userBooksPK.booksIsbn = :booksIsbn"),
    @NamedQuery(name = "UserBooks.findByWantRead", query = "SELECT u FROM UserBooks u WHERE u.wantRead = :wantRead"),
    @NamedQuery(name = "UserBooks.findByReadNow", query = "SELECT u FROM UserBooks u WHERE u.readNow = :readNow"),
    @NamedQuery(name = "UserBooks.findByFinished", query = "SELECT u FROM UserBooks u WHERE u.finished = :finished")})
public class UserBooks implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected UserBooksPK userBooksPK;
    @Basic(optional = false)
    @Column(name = "want_read")
    private int wantRead;
    @Basic(optional = false)
    @Column(name = "read_now")
    private int readNow;
    @Basic(optional = false)
    @Column(name = "finished")
    private int finished;
    @JoinColumn(name = "books_isbn", referencedColumnName = "isbn", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Books books;
    @JoinColumn(name = "user_username", referencedColumnName = "username", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private User user;

    public UserBooks() {
    }

    public UserBooks(UserBooksPK userBooksPK) {
        this.userBooksPK = userBooksPK;
    }

    public UserBooks(UserBooksPK userBooksPK, int wantRead, int readNow, int finished) {
        this.userBooksPK = userBooksPK;
        this.wantRead = wantRead;
        this.readNow = readNow;
        this.finished = finished;
    }

    public UserBooks(String userUsername, String booksIsbn) {
        this.userBooksPK = new UserBooksPK(userUsername, booksIsbn);
    }

    public UserBooksPK getUserBooksPK() {
        return userBooksPK;
    }

    public void setUserBooksPK(UserBooksPK userBooksPK) {
        this.userBooksPK = userBooksPK;
    }
    
    public void setStatus(int wantread, int readnow, int finished){
        this.wantRead = wantread;
        this.readNow = readnow;
        this.finished = finished;
    }

    public int getWantRead() {
        return wantRead;
    }

    public void setWantRead(int wantRead) {
        this.wantRead = wantRead;
    }

    public int getReadNow() {
        return readNow;
    }

    public void setReadNow(int readNow) {
        this.readNow = readNow;
    }

    public int getFinished() {
        return finished;
    }

    public void setFinished(int finished) {
        this.finished = finished;
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
        hash += (userBooksPK != null ? userBooksPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UserBooks)) {
            return false;
        }
        UserBooks other = (UserBooks) object;
        if ((this.userBooksPK == null && other.userBooksPK != null) || (this.userBooksPK != null && !this.userBooksPK.equals(other.userBooksPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.UserBooks[ userBooksPK=" + userBooksPK + " ]";
    }
    
}
