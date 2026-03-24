package com.xu.store.service;

import com.xu.store.entity.book.Book;
import com.xu.store.entity.dto.*;
import com.xu.store.entity.order.Expense;
import com.xu.store.entity.order.Order;
import com.xu.store.entity.order.OrderDetail;
import com.xu.store.entity.order.OrderStatusEnum;
import com.xu.store.mapper.BookMapper;
import com.xu.store.mapper.ExpenseMapper;
import com.xu.store.mapper.OrderMapper;
import com.xu.store.service.imp.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;

/**
 * @author: 许瑞仕
 * @date: 2025522 8:59
 * @description:
 */
@Service("orderService")
public class OrderServiceImpl implements OrderService {

    @Autowired
    OrderMapper orderMapper;

    @Autowired
    ExpenseMapper expenseMapper;

    @Autowired
    BookMapper bookMapper;

    public String initOrderId() {
        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
        String newDate=sdf.format(new Date());
        String result="";
        Random random=new Random();
        for(int i=0;i<6;i++){
            result+=random.nextInt(10);
        }
        return newDate+result;
    }


    @Transactional
    @Override
    public boolean addOrder(OrderInitDto orderInitDto) throws Exception {
        Order order = new Order();
        Date date = new Date();
        Timestamp timestamp = new Timestamp(date.getTime());
        String orderId = initOrderId();
        order.setOrderId(orderId);
        System.out.println("============orderInitDto.getAccount():==========="+orderInitDto.getAccount()+"============");
        order.setAccount(orderInitDto.getAccount());
        order.setAddressId(orderInitDto.getAddress().getId());//收货地址编号
        order.setOrderTime(timestamp);
        order.setOrderStatus(OrderStatusEnum.SUBMIT.getName());

        List<OrderDetail> orderDetailList = new ArrayList<>();
        for(OrderBookDto orderBookDto :orderInitDto.getBookList()){
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setBookId(orderBookDto.getId());
            orderDetail.setNum(orderBookDto.getNum());
            orderDetail.setPrice(orderBookDto.getPrice());
            orderDetail.setOrderId(orderId);
            orderDetailList.add(orderDetail);
            System.out.println("=====orderDetail.toString()====="+orderDetail.toString());
            
            // 原子更新库存，如果影响行数为0，说明库存不足
            int update = bookMapper.modifyBookStock(orderBookDto.getId(), orderBookDto.getNum());
            if(update < 1){
                System.out.println("=====库存不足========");
                throw new Exception("库存不足");
            }
            System.out.println("=============减去库存没有问题======================");
        }
        for(int i=0;i<orderDetailList.size();i++){
            System.out.println("=====orderDetailList[i]====="+orderDetailList.get(i));
        }
        System.out.println("=============初始化总的订单没有问题===========");
        orderMapper.addOrder(order);//添加总的订单
        System.out.println("============添加总的订单成功============");

        orderMapper.batchAddOrderDetail(orderDetailList);//批量添加订单明细
        System.out.println("==============添加订单明细成功==============");

        Expense expense = orderInitDto.getExpense();
        expense.setOrderId(orderId);
        expenseMapper.addExpense(expense);//订单订单费用到费用表中
        System.out.println("===========添加订单费用成功==============");
        return true;
    }

    @Override
    public int delOrder(int id) {
        return orderMapper.delOrder(id);
    }

    @Override
    public int userDelOrder(int id) {
        Order order = new Order();
        order.setId(id);
        order.setBeUserDelete(true);
        return orderMapper.modifyOrder(order);
    }

    @Override
    public int batchDelOrder(List<Integer> item) {
        return orderMapper.batchDelOrder(item);
    }

    @Override
    public int modifyOrderStatus(int id, String orderStatus) {
        Order order = new Order();
        order.setId(id);
        order.setOrderStatus(orderStatus);
        return orderMapper.modifyOrder(order);
    }

    @Transactional
    @Override
    public int deliverBook(int id, int logisticsCompany, String logisticsNum) {
        int result = orderMapper.modifyLogistics(id, logisticsCompany, logisticsNum);
        Order order = new Order();
        order.setId(id);
        order.setOrderStatus("已发货");
        orderMapper.modifyOrder(order);
        return 1;
    }

    @Override
    public OrderDto findOrderDto(int id) {
        OrderDto orderDto = new OrderDto();
        orderDto = orderMapper.findOrderDto(id);
        List<OrderDetailDto> orderDetailDtoList  = orderMapper.findOrderDetailDtoList(orderDto.getOrderId());
        for(int i=0;i<orderDetailDtoList.size();i++){
            System.out.println("======="+orderDetailDtoList.get(i).toString()+"=====");
        }
        orderDto.setOrderDetailDtoList(orderDetailDtoList);
        return orderDto;
    }

    @Override
    public List<OrderDetailDto> findOrderDetailDtoList(String orderId) {
        return orderMapper.findOrderDetailDtoList(orderId);
    }

    @Override
    public List<OrderDto> orderDtoList(String userId, int pageNum, int pageSize,String orderStatus,boolean beUserDelete) {
        pageNum = (pageNum-1)*pageSize;
        return orderMapper.orderDtoList(userId, pageNum, pageSize,orderStatus,beUserDelete);
    }

    @Override
    public int count(String userId,String orderStatus,boolean beUserDelete) {
        return orderMapper.count(userId,orderStatus,beUserDelete);
    }

    @Override
    public List<OrderStatistic> getOrderStatistic(String beginDate, String endDate) throws ParseException {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date = format.parse(beginDate);
        Date date1 = format.parse(endDate);

        return orderMapper.getOrderStatistic(new Timestamp(date.getTime()), new Timestamp(date1.getTime()));
    }
}
