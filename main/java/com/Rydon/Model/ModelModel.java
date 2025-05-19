package com.Rydon.Model;

public class ModelModel {
    private int modelId;
    private String modelName;
    private String category;
    private Double hourlyRate; // Changed to Double to handle null values

    public ModelModel() {}

    public ModelModel(int modelId, String modelName, String category, Double hourlyRate) {
        this.modelId = modelId;
        this.modelName = modelName;
        this.category = category;
        this.hourlyRate = hourlyRate;
    }

    public int getModelId() {
        return modelId;
    }

    public void setModelId(int modelId) {
        this.modelId = modelId;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Double getHourlyRate() {
        return hourlyRate;
    }

    public void setHourlyRate(Double hourlyRate) {
        this.hourlyRate = hourlyRate;
    }
}