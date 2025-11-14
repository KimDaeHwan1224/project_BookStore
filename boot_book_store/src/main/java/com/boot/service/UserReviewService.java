package com.boot.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.boot.dao.UserReviewDAO;
import com.boot.dao.BookBuyDAO; // 구매 DAO 추가
import com.boot.dto.UserReviewDTO;
import com.boot.dto.BookBuyDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserReviewService {

    private final UserReviewDAO userReviewDAO;
    private final BookBuyDAO bookBuyDAO; // BookBuyDAO 주입

    // 리뷰 작성
    @Transactional
    public void writeReview(UserReviewDTO reviewDTO) {
        // 먼저 사용자가 책을 구매했는지 확인
        boolean purchased = bookBuyDAO.selectPurchaseListByUserId(reviewDTO.getUser_id())
                                        .stream()
                                        .anyMatch(b -> b.getBook_id() == reviewDTO.getBook_id());
        if (!purchased) {
            throw new RuntimeException("구매한 책만 리뷰를 작성할 수 있습니다.");
        }

        userReviewDAO.insertReview(reviewDTO);
        
        
    }

    // 특정 도서의 리뷰 목록 조회
    public List<UserReviewDTO> getReviewsByBookId(Long bookId) {
        return userReviewDAO.findReviewsByBookId(bookId);
    }

    // 사용자가 해당 책을 구매했는지 확인 (컨트롤러에서 JSP용)
    public boolean hasPurchasedBook(String userId, int bookId) {
        List<BookBuyDTO> purchases = bookBuyDAO.selectPurchaseListByUserId(userId);
        return purchases.stream().anyMatch(b -> b.getBook_id() == bookId);
    }
}
