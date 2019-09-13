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
public class Doctor {
    
    private String username, password;
    private String fullname, email;
    private String awards, qualifications, professions;
    private int experience;
    private String id;
    
    private boolean isAdmin;
    
    public Doctor() {}
    
    public Doctor(String username, String password, String fullname, String email) {
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.email = email;
    }

    public void setIsAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }
    
    public boolean getIsAdmin() {
        return isAdmin;
    }

    public void setExperience(int experience) {
        this.experience = experience;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getExperience() {
        return experience;
    }

    public String getId() {
        return id;
    }


    public void setAwards(String awards) {
        this.awards = awards;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setProfessions(String professions) {
        this.professions = professions;
    }

    public void setQualifications(String qualifications) {
        this.qualifications = qualifications;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getAwards() {
        return awards;
    }

    public String getEmail() {
        return email;
    }

    public String getFullname() {
        return fullname;
    }

    public String getPassword() {
        return password;
    }

    public String getProfessions() {
        return professions;
    }

    public String getQualifications() {
        return qualifications;
    }

    public String getUsername() {
        return username;
    }

    @Override
    public String toString() {
        return this.username + " " + this.password;
    }
    
    
    
    
    
}
