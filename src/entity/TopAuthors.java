/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author yiann
 */
@Entity
@Table(name = "top_authors")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TopAuthors.findAll", query = "SELECT t FROM TopAuthors t"),
    @NamedQuery(name = "TopAuthors.findById", query = "SELECT t FROM TopAuthors t WHERE t.id = :id"),
    @NamedQuery(name = "TopAuthors.findByName", query = "SELECT t FROM TopAuthors t WHERE t.name = :name"),
    @NamedQuery(name = "TopAuthors.findByPhoto", query = "SELECT t FROM TopAuthors t WHERE t.photo = :photo")})
public class TopAuthors implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "name")
    private String name;
    @Column(name = "photo")
    private String photo;

    public TopAuthors() {
    }

    public TopAuthors(Integer id) {
        this.id = id;
    }

    public TopAuthors(Integer id, String name) {
        this.id = id;
        this.name = name;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TopAuthors)) {
            return false;
        }
        TopAuthors other = (TopAuthors) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.TopAuthors[ id=" + id + " ]";
    }
    
}
