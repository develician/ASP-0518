<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dbConnection.aspx.cs" Inherits="_0511.dbConnection" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script runat="server">
        protected void dbConnection(Object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=MyDB; Integrated Security=False; uid=admin; pwd=admin1234");
            String sql = "SELECT * FROM Member";
            SqlCommand command = new SqlCommand(sql, conn);


            SqlDataReader rd;
            try
            {
                conn.Open();
                Response.Write("서버버전: " + conn.ServerVersion.ToString() + "\n 연결상태: " + conn.State.ToString());

                rd = command.ExecuteReader();
                Label1.Text = "";
                while (rd.Read())
                {
                    Label1.Text += String.Format("{0}, {1}, {2}, {3}<br/>", rd["UserID"], rd["Password"], rd["Name"], rd["Phone"]);

                }
                rd.Close();

            }
            catch (Exception exception) {
                Response.Write("오류: " + exception.Message);
            }
            finally
            {

                conn.Close();
            }

        }

        protected void cartConnection(Object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=MyDB; Integrated Security=False; uid=admin; pwd=admin1234");
            String sql = "SELECT * FROM Cart1";
            SqlCommand command = new SqlCommand(sql, conn);


            SqlDataReader rd;
            try
            {
                conn.Open();
                Response.Write("서버버전: " + conn.ServerVersion.ToString() + "\n 연결상태: " + conn.State.ToString());

                rd = command.ExecuteReader();
                Label1.Text = "";
                while (rd.Read())
                {
                    Label1.Text += String.Format("{0}, {1}, {2}, {3}<br/>", rd["CartID"], rd["UserID"], rd["ItemName"], rd["Qty"], rd["Price"]);

                }
                rd.Close();

            }
            catch (Exception exception) {
                Response.Write("오류: " + exception.Message);
            }
            finally
            {

                conn.Close();
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>데이터 베이스 연동 실습</h2>
            <asp:Button runat="server" ID="DBConnectButton" Text="Member보기" OnClick="dbConnection"/>
            <asp:Button runat="server" ID="CartButton" Text="Cart보기" OnClick="cartConnection"/>
            <hr />
            <asp:Label runat="server" Text="" ID="Label1"/>
        </div>
    </form>
</body>
</html>
