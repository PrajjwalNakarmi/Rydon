package com.Rydon.Model;


public class RentalsModel {
    private int rentalId;
    private String startTime;
    private String endTime;
    private String rentalStatus;
    private String createdAt;

    public RentalsModel() {}

    public RentalsModel(int rentalId, String startTime, String endTime, String rentalStatus, String createdAt) {
        this.rentalId = rentalId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.rentalStatus = rentalStatus;
        this.createdAt = createdAt;
    }

    public int getRentalId() {
        return rentalId;
    }

    public void setRentalId(int rentalId) {
        this.rentalId = rentalId;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getRentalStatus() {
        return rentalStatus;
    }

    public void setRentalStatus(String rentalStatus) {
        this.rentalStatus = rentalStatus;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}

