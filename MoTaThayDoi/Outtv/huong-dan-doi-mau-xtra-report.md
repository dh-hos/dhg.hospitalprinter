## Hướng dẫn thay đổi màu bệnh nhân trên tivi

### Bước 1: Tạo script để thay đổi màu changeColorBeforePrint (Sử dụng 1 trong 2 script sau)

-  Script áp dụng ngay cột trạng thái (các cột khác không có tác dụng)

```
private void changeColorBeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e) {
	try {
		DevExpress.XtraReports.UI.XRTableCell control = (DevExpress.XtraReports.UI.XRTableCell)sender;
		if (control.Text == "Mời nhận thuốc") {
			control.ForeColor = System.Drawing.Color.Red;
		} else {
			control.ForeColor = System.Drawing.Color.Gray;
		}
	} catch { }
}
```

-  Script áp dụng toàn bộ control thuộc dòng đang thể hiện

```
private void changeColorBeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e) {
	try {
		DevExpress.XtraReports.UI.XRTableCell control = (DevExpress.XtraReports.UI.XRTableCell)sender;
		var currentColumnValue = this.GetCurrentColumnValue("trangthai")+"";
		if (currentColumnValue == "Mời nhận thuốc") {
			control.ForeColor = System.Drawing.Color.Red;
		} else {
			control.ForeColor = System.Drawing.Color.Gray;
		}
	} catch { }
}
```

![Alt text](script-xtra-report/change-script-01.png)

### Bước 2: Chọn những control thay đổi màu

![Alt text](script-xtra-report/change-script-02.png)
