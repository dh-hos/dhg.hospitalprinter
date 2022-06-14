using Npgsql;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LibraryApp;

namespace DH2
{
    public static class Xml
    {
        /// <summary>
        /// Hàm hỗ trợ cập nhật trạng thái dinhsuat cho psdangky.dinhsuat và bnnoitru.dinhsuat sau khi thực hiện in phiếu 01 (khám ngoại trú) hoặc 
        /// sau khi thực hiện thao tác xuất viện (BA ngoại trú/nội trú).
        /// </summary>
        /// <param name="mabn">Mã bệnh nhân</param>
        /// <param name="makb">Mã khám bệnh</param>
        /// <param name="maba">Mã bệnh án (đối với khám ngoại trú thì truyền “”).</param>
        /// <param name="macc">Mã chữ cái thẻ BHYT</param>
        /// <param name="maicd">Tương ứng với psdangky.maicd (khám ngoại trú) hoặc bnnoitru.maicd (BA ngoại trú hoặc điều trị nội trú)</param>
        /// <param name="maicdp">Tương ứng với psdangky.maicdp (khám ngoại trú) hoặc bnnoitru.maicdp (BA ngoại trú hoặc điều trị nội trú)</param>
        /// <param name="tongtienbv">Tổng chi phí khám chữa bệnh (tương ứng với cột tổng tiền bệnh viện trên mẫu 6556)</param>
        /// <param name="tongtienbh">Tổng chi phí khám chữa bệnh BHYT (tương ứng với cột tổng tiền bảo hiểm trên mẫu 6556)</param>
        public static void UpdateDinhSuat(string mabn, string makb, string maba, string macc, string maicd, string maicdp, decimal tongtienbv, decimal tongtienbh)
        {
            try
            {
                int dinhsuat = 0;
                bool checkMaChuCai = checkMaCC(macc);
                if (checkMaChuCai)
                {
                    dinhsuat = 1;
                }
                else
                {
                    bool checkICD = checkMaICD(maicd, maicdp);
                    if (checkICD) dinhsuat = 1;
                }
                
                if (maba.Trim().Equals(""))
                {
                    // Khám ngoại trú
                    updateDinhSuatNgoaiTru(mabn, makb, dinhsuat, tongtienbv, tongtienbh);
                }
                else
                {
                    // BA ngoại hoặc nội trú
                    updateDinhSuatBenhAn(mabn, makb, maba, dinhsuat, tongtienbv, tongtienbh);
                }
            }
            catch (Exception ex)
            {
                MsgBoxAdv.Error("Lỗi trong quá trình cập nhật chi phí ngoài định suất/ngoài DRG!", ex);
            }
        }

        private static void updateDinhSuatNgoaiTru(string mabn, string makb, int dinhsuat, decimal tongtienbv, decimal tongtienbh)
        {
            string sql = " UPDATE current.psdangky SET dinhsuat = :dinhsuat, tongtienbv = :tongtienbv, tongtienbh = :tongtienbh " +
                         " WHERE mabn = :mabn AND makb = :makb ";
            object[,] paras = new object[,]
            {
                {"mabn",mabn},
                {"makb",makb},
                {"dinhsuat",dinhsuat},
                {"tongtienbv",tongtienbv},
                {"tongtienbh",tongtienbh}
            };
            NpgsqlHelper.ExecuteNonQuery(ClsConnection.conn, CommandType.Text, sql, CreateParameters.ParamArray(paras));
        }

        private static void updateDinhSuatBenhAn(string mabn, string makb, string maba, int dinhsuat, decimal tongtienbv, decimal tongtienbh)
        {
            string sql = " UPDATE current.bnnoitru SET dinhsuat = :dinhsuat, tongtienbv = :tongtienbv, tongtienbh = :tongtienbh " +
                         " WHERE mabn = :mabn AND makb = :makb AND maba = :maba ";
            object[,] paras = new object[,]
            {
                {"mabn",mabn},
                {"makb",makb},
                {"maba",maba},
                {"dinhsuat",dinhsuat},
                {"tongtienbv",tongtienbv},
                {"tongtienbh",tongtienbh}
            };
            NpgsqlHelper.ExecuteNonQuery(ClsConnection.conn, CommandType.Text, sql, CreateParameters.ParamArray(paras));
        }

        /// <summary>
        /// Hàm hỗ trợ cập nhật trạng thái dinhsuat cho chidinhcls.dinhsuat khi thực hiện chỉ định cận lâm sàng (áp dụng cho cả ngoại và nội trú)
        /// </summary>
        /// <param name="mabn">Mã bệnh nhân</param>
        /// <param name="makb">Mã khám bệnh</param>
        /// <param name="maba">Mã bệnh án (đối với khám ngoại trú thì truyền “”).</param>
        /// <param name="macls">Mã cận lâm sàng</param>
        /// <param name="ngaykcb">Thời gian chỉ định cận lâm sàng (tương ứng từ chidinhcls.ngaykcb)</param>
        public static void UpdateDinhSuatChiDinhCLS(string mabn, string makb, string maba, string macls, DateTime ngaykcb)
        {
            try
            {
                bool checkCLS = checkMaCLS(macls);
                if (checkCLS)
                {
                    string sql = " UPDATE current.chidinhcls SET dinhsuat = 1 " +
                                 " WHERE mabn = :mabn AND makb = :makb AND macls = :macls AND ngaykcb = :ngaykcb ";
                    object[,] paras = new object[,]
                    {
                        {"mabn",mabn},
                        {"makb",makb},
                        {"macls",macls},
                        {"ngaykcb",ngaykcb}
                    };
                    NpgsqlHelper.ExecuteNonQuery(ClsConnection.conn, CommandType.Text, sql, CreateParameters.ParamArray(paras));
                }
            }
            catch (Exception ex)
            {
                MsgBoxAdv.Error("Lỗi trong quá trình cập nhật chi phí ngoài định suất/ngoài DRG!", ex);
            }
        }

        /// <summary>
        /// Hàm hỗ trợ cập nhật trạng thái dinhsuat cho pshdxn.dinhsuat khi thực hiện ra đơn thuốc/VTYT (áp dụng cho cả ngoại và nội trú)
        /// </summary>
        /// <param name="mabn">Mã bệnh nhân</param>
        /// <param name="makb">Mã khám bệnh</param>
        /// <param name="maba">Mã bệnh án (đối với khám ngoại trú thì truyền “”).</param>
        /// <param name="sohd">Số hóa đơn</param>
        /// <param name="mahh">Mã hàng hóa</param>
        /// <param name="ngayhd">Ngày hóa đơn</param>
        /// <param name="loaixn">Loại xuất nhập</param>
        public static void UpdateDinhSuatHDXN(string mabn, string makb, string maba, string sohd, string mahh, DateTime ngayhd, string loaixn)
        {
            try
            {
                bool checkHangHoa = checkMaCLS(mahh);
                if (checkHangHoa)
                {
                    string sql = " UPDATE current.pshdxn SET dinhsuat = 1 " +
                                 " WHERE mabn = :mabn AND makh = :makh AND mahh = :mahh AND ngayhd::date = :ngayhd::date AND loaixn = :loaixn AND COALESCE(xoa,0) = 0 ";
                    if (maba.Trim().Equals(""))
                    {
                        object[,] para1 = new object[,]
                        {
                            {"mabn",mabn},
                            {"makh",makb},
                            {"mahh",mahh},
                            {"ngayhd",ngayhd},
                            {"loaixn",loaixn}
                        };
                        NpgsqlHelper.ExecuteNonQuery(ClsConnection.conn, CommandType.Text, sql, CreateParameters.ParamArray(para1));
                    }
                    else
                    {
                        object[,] para2 = new object[,]
                        {
                            {"mabn",mabn},
                            {"makh",maba},
                            {"mahh",mahh},
                            {"ngayhd",ngayhd},
                            {"loaixn",loaixn}
                        };
                        NpgsqlHelper.ExecuteNonQuery(ClsConnection.conn, CommandType.Text, sql, CreateParameters.ParamArray(para2));
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBoxAdv.Error("Lỗi trong quá trình cập nhật chi phí ngoài định suất/ngoài DRG!", ex);
            }
        }

        private static bool checkMaCLS(string macls)
        {
            bool result = false;
            string sql = " SELECT EXISTS " +
                         " ( " +
                         "      SELECT  macls " +
                         "      FROM    current.dinhsuat " +
                         "      WHERE   COALESCE(loai, 0) = 0 AND macls = :macls " +
                         " ) ";
            result = bool.Parse("" + NpgsqlHelper.ExecuteScalar(ClsConnection.conn, CommandType.Text, sql, new NpgsqlParameter("macls", macls)));

            return result;
        }

        private static bool checkMaHH(string mahh)
        {
            bool result = false;
            string sql = " SELECT EXISTS " +
                         " ( " +
                         "      SELECT  mahh " +
                         "      FROM    current.dinhsuat " +
                         "      WHERE   COALESCE(loai, 0) = 3 AND mahh = :mahh " +
                         " ) ";
            result = bool.Parse("" + NpgsqlHelper.ExecuteScalar(ClsConnection.conn, CommandType.Text, sql, new NpgsqlParameter("mahh", mahh)));

            return result;
        }

        /// <summary>
        /// Kiểm tra trạng thái ngoài định suất/ngoài DRG. Giá trị trả về: [0] Không phải; [1] Phải.
        /// </summary>
        /// <param name="value">Giá trị cần kiểm tra</param>
        /// <param name="loai">0: Cận lâm sàng; 1: Thuốc/VTYT/...</param>
        /// <returns>Giá trị trả về: [0] Không phải; [1] Phải.</returns>
        public static int CheckDinhSuat(string value, int loai)
        {
            int result = 0;
            try
            {
                string sql = " SELECT EXISTS " +
                             " ( " +
                             "      SELECT  mahh " +
                             "      FROM    current.dinhsuat " +
                             "      WHERE   COALESCE(loai, 0) = 3 AND mahh = :mahh " +
                             " ) ";
                bool test = false;
                if (loai == 1)
                {
                    test = bool.Parse("" + NpgsqlHelper.ExecuteScalar(ClsConnection.conn, CommandType.Text, sql, new NpgsqlParameter("mahh", value)));
                    if (test) result = 1;
                }
                else
                {
                    sql = " SELECT EXISTS " +
                         " ( " +
                         "      SELECT  macls " +
                         "      FROM    current.dinhsuat " +
                         "      WHERE   COALESCE(loai, 0) = 0 AND macls = :macls " +
                         " ) ";
                    test = bool.Parse("" + NpgsqlHelper.ExecuteScalar(ClsConnection.conn, CommandType.Text, sql, new NpgsqlParameter("macls", value)));
                    if (test) result = 1;
                }
            }
            catch (Exception ex)
            {
                MsgBoxAdv.Error("Lỗi trong quá trình kiểm tra trạng thái ngoài định suất/ngoài DRG!", ex);
            }
            return result;
        }

        private static bool checkMaCC(string macc)
        {
            bool result = false;
            string sql = " SELECT EXISTS " +
                         " ( " +
                         "      SELECT  macc " +
                         "      FROM    current.dinhsuat " +
                         "      WHERE   COALESCE(loai, 0) = 2 AND macc = :macc " +
                         " ) ";
            result = bool.Parse("" + NpgsqlHelper.ExecuteScalar(ClsConnection.conn, CommandType.Text, sql, new NpgsqlParameter("macc", macc.ToUpper())));
            
            return result;
        }

        private static bool checkMaICD(string maicd, string maicdp)
        {
            bool result = false;

            string stMaICD = maicd + ";" + maicdp;
            stMaICD = xuLyTrungMaICD(stMaICD);

            if (!stMaICD.Equals(""))
            {
                stMaICD = stMaICD.Replace(";", "','");
                stMaICD = "'" + stMaICD + "'";
                string sql = " SELECT EXISTS " +
                             " ( " +
                             "      SELECT  maicd " +
                             "      FROM    current.dinhsuat " +
                             "      WHERE   COALESCE(loai, 0) = 1 AND maicd IN (" + stMaICD + ")" +
                             " ) ";
                result = bool.Parse("" + NpgsqlHelper.ExecuteScalar(ClsConnection.conn, CommandType.Text, sql));
            }
            return result;
        }

        private static string xuLyTrungMaICD(string maicd)
        {
            string result = "";

            string stTemp = maicd;
            stTemp = stTemp.Replace(" ", "");

            string[] arrTemp = stTemp.Split(';');
            
            if (arrTemp.GetLength(0) > 0)
            {
                stTemp = "";
                string[] arrTemp2 = arrTemp.Distinct<String>().ToArray();
                stTemp = arrTemp2[0];
                for (int i = 1; i < arrTemp2.GetLength(0); i++)
                {
                    if (!arrTemp2[i].Trim().Equals(""))
                    {
                        stTemp = stTemp.Trim() + ";" + arrTemp2[i].Trim();
                    }
                }
            }

            result = stTemp;

            return result;
        }
    }
}
