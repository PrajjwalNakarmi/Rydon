package com.Rydon.Model;



public class ReviewModel {
    private int reviewId;
    private int rating;
    private String comments;
    private String reviewDate;

    public ReviewModel() {}

    public ReviewModel(int reviewId, int rating, String comments, String reviewDate) {
        this.reviewId = reviewId;
        this.rating = rating;
        this.comments = comments;
        this.reviewDate = reviewDate;
    }

    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(String reviewDate) {
        this.reviewDate = reviewDate;
    }
}
