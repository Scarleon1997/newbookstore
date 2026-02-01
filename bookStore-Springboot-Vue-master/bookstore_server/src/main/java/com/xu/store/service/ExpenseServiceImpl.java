package com.xu.store.service;

import com.xu.store.entity.order.Expense;
import com.xu.store.mapper.ExpenseMapper;
import com.xu.store.service.imp.ExpenseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author: 许瑞仕
 * @date: 2025520 16:49
 * @description:
 */
@Service("expense")
public class ExpenseServiceImpl implements ExpenseService {

    @Autowired
    ExpenseMapper expenseMapper;

    @Override
    public int addExpense(Expense expense) {
        return expenseMapper.addExpense(expense);
    }
}
