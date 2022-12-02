### DHG.Hospital Printer - Thông tin cập nhật

<div align="center" style="font-size:xx-small">(✨: Chức năng mới,🐛: Chỉnh lỗi, #️⃣: Giải quyết công việc) </div>

##### [v3.22.1202.1]()

-  ✨: Thể hiện thanh toán QR đối với nhà thuốc (chỉ thể hiện trên tab chưa in)
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/92

##### [v3.22.1129.1]()

-  🐛: Fix lỗi sai số thứ tự khi bỏ chọn quầy phát thuốc mặc định
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/90

##### [v3.22.1121.1]()

-  ✨: Thêm phím nóng [F6] để hỗ trợ chức năng mời nhận thuốc
-  ✨: Thay đổi [hướng dẫn script hướng dẫn đổi màu trên tivi](../MoTaThayDoi/Outtv/huong-dan-doi-mau-xtra-report.md)
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/84

##### [v3.22.1029.1]()

-  ✨: Bổ sung thêm tùy chọn cho phép quản lý danh sách bệnh nhân BANT theo cấu hình kho cấp phát (cấu hình trên Danh mục Đối tượng trên module Admin)![](../MoTaThayDoi/HuongDan/bant-load-benhnhan-theokhocp-01.png)![](../MoTaThayDoi/HuongDan/bant-load-benhnhan-theokhocp-02.png)
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/78

##### [v3.22.1028.2]()

-  ✨: Cải tiến chức năng xuất xml để gửi BHXH khi in phiếu tại module Printer: chỉ xuất xml để gửi BHXH khi cấu hình số lượng trang in phiếu 01 lớn hơn 0, để tránh tình trạng gửi xml nhiều lần trường hợp đã in phiếu 01 ở Prescription
-  #️⃣: https://github.com/dh-hos/dhg.hospitalservices/issues/12

##### [v3.22.1028.1]()

-  ✨: Bổ sung chức năng chọn máy in khi in phiếu thứ tự phát thuốc ![](../MoTaThayDoi/HuongDan/outtv-option-chon-printer-in-so-thu-tu.png)
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/81

##### [v3.22.1020.2]()

-  🐛: Fix lỗi không in được phiếu 01 ![](../MoTaThayDoi/Errors/err-inphieu01.png)
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/79

##### [v3.22.1020.1]()

-  ✨: Xóa thông tin quầy phát thuốc và số thứ tự khi chọn bệnh nhân khác
-  🐛: Thêm chức năng xuất xml vào thư mục cấu hình trên admin khi in phiếu 01 đối với mabvbh=87190
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/77

##### [v3.22.1018.1]()

-  🐛: Lỗi không in được phiếu 01
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/76

##### [v3.22.1013.1]()

-  🐛: Không in được phiếu 01, nhưng vẫn thể hiện số thứ tự
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/54#issuecomment-1275772044
-  ✨: Thêm parameter donvi (Diễn giải quầy phát thuốc) thể hiện form in ra tivi ![](../MoTaThayDoi/Outtv/ThemPara-donvi-01.png)![](../MoTaThayDoi/Outtv/ThemPara-donvi-02.png)

##### [v3.22.1012.2]()

-  ✨: Bổ sung chức năng, in phiếu 01 trường hợp chọn option [Tất cả toa], với trạng thái bệnh nhân chưa in, vẫn in số thứ tự vào hệ thống thể hiện số thứ tự trên tivi
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/54#issuecomment-1274207510

##### [v3.22.1012.1]()

-  🐛: Fix lỗi không thể hiện được form thể hiện số thứ tự bệnh nhân ra tivi
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/73

##### [v3.22.0928.3]()

-  ✨: Cập nhật bản quyền đối với Mã BV 87190 - BỆNH VIỆN DA LIỄU ĐỒNG THÁP
-  #️⃣: https://github.com/dh-hos/DH.HIS/issues/4

##### [v3.22.0928.2]()

-  🐛: Sai thời gian in phiếu
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/64

##### [v3.22.0928.1]()

-  🐛: Lỗi In toa thuốc Than báo lỗi
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/58#issuecomment-1260306620

##### [v3.22.0927.6]()

-  ✨: Không thực hiện kiểm tra Cận lâm sàng chưa thực hiện đối với trường hợp xác nhận in phiếu của bệnh án ngoại trú thanh toán đợt (luôn cho phép xác nhận in)
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/61#issuecomment-1258979906
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/61

##### [v3.22.0927.5]()

-  ✨: Tính sai số phút giữa thời gian in phiếu và thời gian đăng ký khám bệnh khi thực hiện in phiếu 6556
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/64

##### [v3.22.0927.4]()

-  ✨: Thêm cấu hình để tắt cảnh báo bệnh nhân có phát sinh thu tiền (luôn cảnh báo, cảnh báo khi chi phí chưa thu, thu tiền rồi thì không cảnh báo) ![](../MoTaThayDoi/HuongDan/cauhinh-canhbao-chiphiphatsinh.png)
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/68

##### [v3.22.0927.3]()

-  🐛: Fix sai cảnh báo sai tiền đồng chi trả đối với bệnh nhân có chi phí thuộc nguồn khác
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/67

##### [v3.22.0927.2]()

-  🐛: https://github.com/dh-hos/dhg.hospitalprinter/issues/59#issuecomment-1258846397
-  ✨: Không thực hiện kiểm tra Cận lâm sàng chưa thực hiện đối với những cận lâm sàng không thuộc phạm vi thanh toán BHYT
-  ✨: Không thực hiện kiểm tra Cận lâm sàng chưa thực hiện đối với trường hợp xác nhận in phiếu của bệnh án ngoại trú thanh toán đợt (luôn cho phép xác nhận in)
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/61

##### [v3.22.0927.1]()

-  🐛: Thực hiện kiểm tra in phiếu 01 trước khi cập nhật ngày giờ in phiếu
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/59

##### [v3.22.0926.3]()

-  🐛: Fix cảnh báo sai số tiền bệnh nhân đồng chi trả
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/56

##### [v3.22.0926.2]()

-  🐛: Xử lý loại bỏ trùng TEN_BENH và TEN_BENH_KEM_THEO trên phiếu 6556
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/55

##### [v3.22.0926.1]()

-  ✨: Thêm chức năng xuất thông tin bệnh nhân ra tivi áp dụng trường hợp 1 kho có nhiều quầy phát thuốc [Hướng dẫn thực hiện](../MoTaThayDoi/XuatTTBenhnhanRaTivi.md)
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/54

##### [v3.22.0924.4]()

-  ✨: Thực hiện theo Mô tả thực hiện Thông tư 36/2021/TT-BYT
-  #️⃣: https://github.com/dh-hos/Mo-ta-he-thong/issues/12

##### [v3.22.0924.3]()

-  ✨: Thêm cấu hình để tắt cảnh báo bệnh nhân có nhiều toa thuốc (Hệ thống -> Cấu hình tham số -> Cảnh báo số lượng toa thuốc khi in phiếu KCB)
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/66

##### [v3.22.0924.2]()

-  ✨: Thêm cấu hình để tắt cảnh báo bệnh nhân có nhiều toa thuốc (Hệ thống -> Cấu hình tham số -> Cảnh báo số lượng toa thuốc khi in phiếu KCB)
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/66

##### [v3.22.0924.1]()

-  ✨: Thêm cấu hình để tắt cảnh báo bệnh nhân có nhiều toa thuốc (Hệ thống -> Cấu hình tham số -> Cảnh báo số lượng toa thuốc khi in phiếu KCB)
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/66

##### [v3.22.0722.1]()

-  🐛: Fix thông báo sai, khi bệnh nhân chưa tới ngưỡng thanh toán đồng chi trả
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/53

##### [v3.22.0721.1]()

-  🐛: Bổ sung license mabvbh=77150
-  #️⃣: https://github.com/dh-hos/DH.HIS/issues/2

##### [v3.22.0720.1]()

-  🐛: Fix lỗi không thể hiện cảnh báo có phát sinh đồng chi trả khi in phiếu 01
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/51

##### [v3.22.0719.1]()

-  🐛: Fix Bệnh án ngoại trú thanh toán theo đợt khi in bảng kê không trừ kho và đánh dấu đã in - Form in phiếu khám chữa bệnh mới
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/47

##### [v3.22.0708.2]()

-  🐛: Fix Printer in bảng kê bị treo thông báo đang xử lý in ấn đối với xác nhận bệnh án ngoại trú
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/46

##### [v3.22.0708.1]()

-  🐛: Fix Hóa đơn điện tử nhà thuốc khi vừa lập xong thì không in được
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/45

##### [v3.22.0706.1]()

-  🐛: [Hóa đơn điện tử nhà thuốc] không cho lập hóa đơn khi chưa hoàn thành phiếu thu
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/44
-  ✨: Xử lý Trường hợp bật cảnh báo cập nhật giờ kết thúc của hồ sơ, nếu không đồng ý cập nhật sẽ không tiếp tục in phiếu thanh toán

##### [v3.22.0705.1]()

-  🐛: Fix Hiển thị thông báo trống - chức năng in phiếu KCB
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/43

##### [v3.22.0704.1]()

-  ✨: Cải tiến tốc độ khi lưu chứng từ mới
-  🐛: Kiểm tra tránh trường hợp trùng đối với chứng từ đã lập phiếu thu (khi bắt đầu lưu chứng từ)
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/42

##### [v3.22.0703.1]()

-  ✨: Bổ sung chức năng kiểm tra ngày kết quả trong XML3 (NGAY_KQ) nếu lớn hơn thời gian kết thúc không cho phép in phiếu thanh toán.
-  #️⃣: https://github.com/dh-hos/Mo-ta-he-thong/issues/11

##### [v3.22.0701.1]()

-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/37
-  🐛: Toa xuất viện đã in vẫn hiển thị toa chưa in nhưng không thấy thuốc

##### [v3.22.0630.1]()

-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/41
-  🐛: khi in bảng kê đối tượng miễn phí báo lỗi

##### [v3.22.0623.6]()

-  ✨: Chỉnh cách tổng chi phí thuộc BHYT để tính MUC_HUONG không dựa vào TYLE_TT, tính trên tổng THANH_TIEN
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/20

##### [v3.22.0623.5]()

-  ✨: Bổ sung chức năng lập phiếu thu bằng printer đối với mabvbh: 92016
-  #️⃣: https://github.com/dh-hos/dhg.hospitalprinter/issues/39

##### [v3.22.0623.2]()

-  ✨ Fix lỗi không build file settup cho phiên bản 3.22.0623.1

##### [v3.22.0623.1]()

-  🐛 Fix cảnh báo kiểm tra đồng chi tra trước khi in
-  #️⃣ [#35](https://github.com/dh-hos/dhg.hospitalprinter/issues/35)
