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
@Table(name = "quotes")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Quotes.findAll", query = "SELECT q FROM Quotes q"),
    @NamedQuery(name = "Quotes.findById", query = "SELECT q FROM Quotes q WHERE q.quotesPK.id = :id"),
    @NamedQuery(name = "Quotes.findByUserUsername", query = "SELECT q FROM Quotes q WHERE q.quotesPK.userUsername = :userUsername")})
public class Quotes implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected QuotesPK quotesPK;
    @Basic(optional = false)
    @Lob
    @Column(name = "author")
    private String author;
    @Basic(optional = false)
    @Lob
    @Column(name = "quote")
    private String quote;
    @Basic(optional = false)
    @Lob
    @Column(name = "book")
    private String book;
    @JoinColumn(name = "user_username", referencedColumnName = "username", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private User user;

    public Quotes() {
    }

    public Quotes(QuotesPK quotesPK) {
        this.quotesPK = quotesPK;
    }

    public Quotes(QuotesPK quotesPK, String author, String quote, String book) {
        this.quotesPK = quotesPK;
        this.author = author;
        this.quote = quote;
        this.book = book;
    }

    public Quotes(int id, String userUsername) {
        this.quotesPK = new QuotesPK(id, userUsername);
    }

    public QuotesPK getQuotesPK() {
        return quotesPK;
    }

    public void setQuotesPK(QuotesPK quotesPK) {
        this.quotesPK = quotesPK;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getQuote() {
        return quote;
    }

    public void setQuote(String quote) {
        this.quote = quote;
    }

    public String getBook() {
        return book;
    }

    public void setBook(String book) {
        this.book = book;
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
        hash += (quotesPK != null ? quotesPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Quotes)) {
            return false;
        }
        Quotes other = (Quotes) object;
        if ((this.quotesPK == null && other.quotesPK != null) || (this.quotesPK != null && !this.quotesPK.equals(other.quotesPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Quotes[ quotesPK=" + quotesPK + " ]";
    }
    
}
