package com.Rydon.Model;

public class BicycleModel {
    private int bicycleId;
    private String location;
    private int conditionRating;
    private int modelId;
    private String imagePath;

    public BicycleModel() {}

    public BicycleModel(int bicycleId, String location, int conditionRating, int modelId, String imagePath) {
        this.bicycleId = bicycleId;
        this.location = location;
        this.conditionRating = conditionRating;
        this.modelId = modelId;
        this.imagePath = imagePath;
    }

    public int getBicycleId() {
        return bicycleId;
    }

    public void setBicycleId(int bicycleId) {
        this.bicycleId = bicycleId;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getConditionRating() {
        return conditionRating;
    }

    public void setConditionRating(int conditionRating) {
        this.conditionRating = conditionRating;
    }

    public int getModelId() {
        return modelId;
    }

    public void setModelId(int modelId) {
        this.modelId = modelId;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}
