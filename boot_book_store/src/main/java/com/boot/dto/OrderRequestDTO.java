package com.boot.dto;

import lombok.Data;
import java.util.List;

@Data
public class OrderRequestDTO {
    private List<OrderItemDto> items;

    @Data
    public static class OrderItemDto {
        private int book_id;
        private int quantity;
        private int purchase_price; // 각 아이템의 총 구매금액
    }
}
