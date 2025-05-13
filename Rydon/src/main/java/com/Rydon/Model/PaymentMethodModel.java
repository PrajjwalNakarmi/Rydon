package com.Rydon.Model;



public class PaymentMethodModel {
    private int paymentMethodId;
    private String paymentType;

    public PaymentMethodModel() {}

    public PaymentMethodModel(int paymentMethodId, String paymentType) {
        this.paymentMethodId = paymentMethodId;
        this.paymentType = paymentType;
    }

    public int getPaymentMethodId() {
        return paymentMethodId;
    }

    public void setPaymentMethodId(int paymentMethodId) {
        this.paymentMethodId = paymentMethodId;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }
}

