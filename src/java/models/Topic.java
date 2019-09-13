/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.util.Date;

/**
 *
 * @author hp
 */
public class Topic {
    
    private String id;
    private String title, content;
    private long createdAt;
    private String did;
    private String categories;
    private String tags;
    private int views;

    public void setViews(int views) {
        this.views = views;
    }

    public int getViews() {
        return views;
    }
    
    
    
    public Topic() {
    }

    public void setCategories(String categories) {
        this.categories = categories;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setCreatedAt(long createdAt) {
        this.createdAt = createdAt;
    }

    public void setDid(String did) {
        this.did = did;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCategories() {
        return categories;
    }

    public String getContent() {
        return content;
    }

    public long getCreatedAt() {
        return createdAt;
    }

    public String getDid() {
        return did;
    }

    public String getId() {
        return id;
    }

    public String getTags() {
        return tags;
    }

    public String getTitle() {
        return title;
    }
    
    
    
}
