## 1. Giới Thiệu

### Mục Đích Của Tài Liệu

Tài liệu kỹ thuật này được thiết kế nhằm cung cấp cái nhìn chi tiết về các thành phần kiến trúc và cơ chế hoạt động của
Game Con Rắn, được phát triển sử dụng Flutter và Flame. Tài liệu này đóng vai trò như một hướng dẫn toàn diện cho các
lập trình viên, nhóm kiểm thử và quản lý dự án tham gia vào dự án, đảm bảo mọi người hiểu rõ về thiết kế và chức năng
của game.

### Mô Tả Game

Game Con Rắn là phiên bản hiện đại của trò chơi di động cổ điển, nơi người chơi điều khiển một con rắn, hướng dẫn nó ăn
các mục xuất hiện ngẫu nhiên trên màn hình. Mỗi mục được ăn sẽ khiến con rắn dài ra, làm tăng độ khó của trò chơi khi
tốc độ của rắn tăng lên và nguy cơ va chạm với chính nó tăng cao. Mục tiêu là sống sót càng lâu càng tốt trong khi cố
gắng ghi điểm cao nhất bằng cách ăn thật nhiều mục mà không va chạm vào ranh giới của khu vực chơi hoặc chính con rắn.

### Đối Tượng Mục Tiêu

Tài liệu này dành cho các đối tượng sau:

- **Nhóm Phát Triển**: Cung cấp sự hiểu biết rõ ràng về các thành phần và cơ chế của trò chơi để hỗ trợ việc phát triển
  và bảo trì sau này.
- **Nhóm Đảm Bảo Chất Lượng**: Giúp xây dựng kế hoạch kiểm thử toàn diện và hiểu rõ luồng trò chơi và các thành phần của
  nó để kiểm thử hiệu quả.
- **Các Bên Liên Quan Dự Án**: Cung cấp cái nhìn sâu sắc về thành phần kỹ thuật của trò chơi để đưa ra quyết định tốt
  hơn và giám sát dự án.

### Tổng Quan Tài Liệu

Các phần tiếp theo của tài liệu này sẽ chi tiết từng thành phần chính của Game Con Rắn:

- **Tổng Quan về Trò Chơi**: Mô tả ngắn gọn về cơ chế chơi và mục tiêu của trò chơi.
- **Chi Tiết Thành Phần**: Phân tích chi tiết các thành phần chính của trò chơi bao gồm Con Rắn, Khối Rắn, và Nền.
- **Chi Tiết Triển Khai**: Mô tả kỹ thuật về các chiến lược và công nghệ được sử dụng.
- **Kiểm Thử và Xác Nhận**: Các phương pháp được áp dụng để đảm bảo chức năng và hiệu suất của trò chơi.

## 2. Tổng Quan về Trò Chơi

Game Con Rắn là một trò chơi giải trí kinh điển, nơi người chơi điều khiển một con rắn đang không ngừng mọc dài qua việc
ăn các mục tiêu xuất hiện ngẫu nhiên trên màn hình. Với mỗi mục tiêu được ăn, con rắn sẽ dài thêm một khối, và tốc độ
của rắn cũng sẽ tăng lên. Mục tiêu của trò chơi là điều khiển con rắn sao cho không va chạm vào chính nó hoặc ranh giới
của màn hình trò chơi, đồng thời cố gắng ăn thật nhiều mục tiêu để đạt điểm số cao.

### Mục Tiêu của Trò Chơi

- **Sinh Tồn**: Người chơi cần điều khiển con rắn tránh va chạm vào chính nó hoặc các vật cản trên màn hình.
- **Điểm Số**: Điểm số được tính dựa trên số mục tiêu mà rắn ăn được. Mỗi mục tiêu ăn được sẽ cộng thêm điểm vào tổng số
  điểm của người chơi.
- **Thử Thách**: Trò chơi sẽ trở nên khó khăn hơn khi con rắn dài ra và di chuyển nhanh hơn.

### Luật Chơi

- Con rắn di chuyển liên tục qua các hướng được người chơi điều khiển (lên, xuống, trái, phải).
- Nếu rắn va chạm vào chính nó hoặc ranh giới của màn hình, trò chơi sẽ kết thúc.
- Mục tiêu sẽ xuất hiện ngẫu nhiên trên màn hình và sẽ biến mất sau một khoảng thời gian nếu không được ăn.

## 3. Chi Tiết Thành Phần

### Con Rắn (Snake)

- **Cấu Trúc**: Con rắn được tạo từ nhiều khối nối tiếp nhau, mỗi khối đại diện cho một phần của cơ thể rắn.
- **Hành Vi**: Con rắn di chuyển liên tục theo hướng được người chơi chỉ định và sẽ tự động tăng kích thước khi ăn được
  mục tiêu.
- **Logic Xử Lý Va Chạm**: Hệ thống cần phát hiện va chạm giữa đầu rắn và các phần khác của cơ thể, cũng như va chạm với
  ranh giới màn hình để kết thúc trò chơi.

### Khối Rắn (SnakeBlock)

- **Thiết Kế**: Mỗi khối của rắn là một đơn vị hình vuông với kích thước cố định.
    - Thông tin của mỗi khối bao gồm:
        - vị trí (x, y)
        - Khối trước
        - Khối sau
        - Hướng di chuyển.
- **Tích Hợp**: Các khối liên kết với nhau và di chuyển như một đơn thể khi con rắn di chuyển trên màn hình.

### Thức ăn (Food)

- **Thiết Kế**: Mục tiêu xuất hiện ngẫu nhiên và không trùng với vị trí của các khối rắn.

### Nền (Background)

- **Thiết Kế**: Nền của trò chơi

### Event Bus
- **Thiết Kế**: Event Bus là một cơ chế để giao tiếp giữa các thành phần trong trò chơi. Các thành phần có thể gửi và
  nhận các sự kiện thông qua Event Bus.

### Game

- **Thiết Kế**: Game chứa các thành phần chính của trò chơi và quản lý việc hiển thị và cập nhật trạng thái của trò
  chơi.

Mỗi thành phần này có vai trò quan trọng trong việc định hình trải nghiệm chơi game và đều được thiết kế để làm nổi bật
tính tương tác và giải trí của trò chơi.
