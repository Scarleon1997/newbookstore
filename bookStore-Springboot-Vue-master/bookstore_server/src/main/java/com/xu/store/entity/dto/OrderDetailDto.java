package com.xu.store.entity.dto;

import com.xu.store.entity.book.Book;

/**
 * @author: 许瑞仕
 * @date: 2025522 10:35
 * @description: 订单明细类
 */
public class OrderDetailDto {
    private String orderId;//订单号
    private Book book; //图书
    private String num;//某本图书的下单数量
    private double price;//下单时候图书的单价

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "OrderDetailDto{" +
                "orderId='" + orderId + '\'' +
                ", book=" + book +
                ", num='" + num + '\'' +
                ", price=" + price +
                '}';
    }
}
