# MoneyBook
국비 과정에서 익힌 웹 개발 흐름과 컴퓨터과학 전공 지식을 결합해, 브라우저 요청부터 데이터베이스 연동까지 웹 서비스의 기본 동작 원리를 단독으로 구현한 미니 프로젝트입니다.

## 🛠 개발 환경
- Language / Web: Java 21, JSP, HTML5 / CSS3
- WAS / DB: Apache Tomcat 11.0, MariaDB (JDBC 3.5.11)
- Tools: Eclipse, HeidiSQL

## ✨ 주요 기능
- 실시간 재무 요약: SQL `SUM()` 집계 함수를 활용해 총 수입, 총 지출, 현재 잔액 자동 계산
- 수입·지출 관리: 내역 등록(`INSERT`) 및 삭제(`DELETE`) 기능
- 월별 동적 조회: 특정 연·월(`YYYY-MM`) 선택 시 해당 기간 내역만 필터링 조회

## 🗂 프로젝트 구조
- `src/main/java/com/moneybook/DBConnection.java` : MariaDB 연결 관리
- `src/main/java/com/moneybook/MoneyDTO.java` : 가계부 데이터 객체
- `src/main/java/com/moneybook/MoneyDAO.java` : CRUD 및 집계 SQL 처리
- `src/main/webapp/index.jsp` : 메인 대시보드 및 입력·조회 화면
- `moneybook_db.sql` : 데이터베이스 및 테이블 생성 스크립트

## 🖥 실행 화면
<img width="303" height="181" alt="image" src="https://github.com/user-attachments/assets/b1edf399-791a-4170-8a93-40a25a93d193" />
<img width="303" height="181" alt="image" src="https://github.com/user-attachments/assets/ef1c20e5-72f9-40d4-a1c5-998e006fd1dd" />
<img width="303" height="181" alt="image" src="https://github.com/user-attachments/assets/1e2ad8f2-c5a8-4208-a797-1ae71abce4da" />
<img width="303" height="181" alt="image" src="https://github.com/user-attachments/assets/ed2f1f21-a049-424d-9e4b-1b5a3dff261c" />



