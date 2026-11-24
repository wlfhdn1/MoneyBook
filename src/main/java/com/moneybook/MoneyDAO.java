package com.moneybook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MoneyDAO {

    // 1. 내역 추가 (INSERT)
    public void insertMoney(MoneyDTO dto) throws Exception {
        String sql = "INSERT INTO money_book (type, category, amount, memo, reg_date) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getType());
            pstmt.setString(2, dto.getCategory());
            pstmt.setInt(3, dto.getAmount());
            pstmt.setString(4, dto.getMemo());
            pstmt.setString(5, dto.getRegDate());
            pstmt.executeUpdate();
        }
    }

    // 2. 전체 또는 특정 월(YYYY-MM) 목록 조회 (SELECT)
    public List<MoneyDTO> getMoneyList(String month) throws Exception {
        List<MoneyDTO> list = new ArrayList<>();
        boolean hasMonth = (month != null && !month.trim().isEmpty());
        String sql = hasMonth
                ? "SELECT * FROM money_book WHERE DATE_FORMAT(reg_date, '%Y-%m') = ? ORDER BY reg_date DESC, id DESC"
                : "SELECT * FROM money_book ORDER BY reg_date DESC, id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            if (hasMonth) {
                pstmt.setString(1, month);
            }
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    MoneyDTO dto = new MoneyDTO();
                    dto.setId(rs.getInt("id"));
                    dto.setType(rs.getString("type"));
                    dto.setCategory(rs.getString("category"));
                    dto.setAmount(rs.getInt("amount"));
                    dto.setMemo(rs.getString("memo"));
                    dto.setRegDate(rs.getString("reg_date"));
                    list.add(dto);
                }
            }
        }
        return list;
    }

    // 3. 수입 또는 지출 총합 계산 (SUM)
    public int getTotalByType(String type, String month) throws Exception {
        boolean hasMonth = (month != null && !month.trim().isEmpty());
        String sql = hasMonth
                ? "SELECT IFNULL(SUM(amount), 0) FROM money_book WHERE type = ? AND DATE_FORMAT(reg_date, '%Y-%m') = ?"
                : "SELECT IFNULL(SUM(amount), 0) FROM money_book WHERE type = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, type);
            if (hasMonth) {
                pstmt.setString(2, month);
            }
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // 4. 내역 삭제 (DELETE)
    public void deleteMoney(int id) throws Exception {
        String sql = "DELETE FROM money_book WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }
}