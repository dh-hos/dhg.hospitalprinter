## Hướng dẫn thay đổi màu bệnh nhân trên tivi

### Bước 1: Tạo script để thay đổi màu changeColorBeforePrint

-  Script áp dụng toàn bộ ngay cột trạng thái (chỉ đúng khi thay đổi ngay cột trạng thái)

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

-  Script áp dụng toàn bộ row (chỉ đúng khi thay đổi ngay cột trạng)

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
