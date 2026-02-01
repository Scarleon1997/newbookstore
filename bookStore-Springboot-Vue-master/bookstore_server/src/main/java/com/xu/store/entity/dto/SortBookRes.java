package com.xu.store.entity.dto;
import com.xu.store.entity.book.Book;

import java.util.List;

/**
 * @author: 许瑞仕
 * @date: 2025520 15:50
 * @description: 某一个子分类的和这个子分类所包含的14本图书
 */
public class SortBookRes {
     private int sortId;
     private String sortName;
     private List<Book> bookList;

    public int getSortId() {
        return sortId;
    }

    public void setSortId(int sortId) {
        this.sortId = sortId;
    }

    public String getSortName() {
        return sortName;
    }

    public void setSortName(String sortName) {
        this.sortName = sortName;
    }

    public List<Book> getBookList() {
        return bookList;
    }

    public void setBookList(List<Book> bookList) {
        this.bookList = bookList;
    }

    @Override
    public String toString() {
        return "SortAndBook{" +
                "sortId=" + sortId +
                ", sortName='" + sortName + '\'' +
                ", bookList=" + bookList +
                '}';
    }
}
