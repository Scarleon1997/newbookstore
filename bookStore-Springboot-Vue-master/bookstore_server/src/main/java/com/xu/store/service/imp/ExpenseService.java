package com.xu.store.service.imp;

import com.xu.store.entity.order.Expense;
import org.springframework.stereotype.Service;

/**
 * @author: 许瑞仕
 * @date: 2025520 16:48
 * @description:
 */
@Service
public interface ExpenseService {
    int addExpense(Expense expense);
}
