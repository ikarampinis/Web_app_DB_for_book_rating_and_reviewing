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
public class QuotesPK implements Serializable {

    @Basic(optional = false)
    @Column(name = "id")
    private int id;
    @Basic(optional = false)
    @Column(name = "user_username")
    private String userUsername;

    public QuotesPK() {
    }

    public QuotesPK(int id, String userUsername) {
        this.id = id;
        this.userUsername = userUsername;
    }
    
    public QuotesPK(String userUsername) {
        this.userUsername = userUsername;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserUsername() {
        return userUsername;
    }

    public void setUserUsername(String userUsername) {
        this.userUsername = userUsername;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) id;
        hash += (userUsername != null ? userUsername.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof QuotesPK)) {
            return false;
        }
        QuotesPK other = (QuotesPK) object;
        if (this.id != other.id) {
            return false;
        }
        if ((this.userUsername == null && other.userUsername != null) || (this.userUsername != null && !this.userUsername.equals(other.userUsername))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.QuotesPK[ id=" + id + ", userUsername=" + userUsername + " ]";
    }
    
}
