/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

/**
 *
 * @author hp
 */
public class Reply {
    
    private String did;
    private String content;
    private long createdAt;
    private String id, tid;
    
    public Reply() {
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

    public void setTid(String tid) {
        this.tid = tid;
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

    public String getTid() {
        return tid;
    }
    
    
}
