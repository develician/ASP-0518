<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="select.aspx.cs" Inherits="_0511.select" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script runat="server">
        protected void select(Object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=MyDB; Integrated Security=False; uid=admin; pwd=admin1234");
            String sql = "SELECT * FROM Member WHERE UserID=@UserID";

            SqlCommand command = new SqlCommand(sql, conn);
            command.Parameters.AddWithValue("@UserID", TextBox1.Text);

            conn.Open();



            SqlDataReader rd = command.ExecuteReader();
            Label1.Text = "";


            int i = 0;
            while(rd.Read())
            {
                Label1.Text +=  String.Format("{0}, {1}, {2}, {3}<br/>", rd["UserID"], rd["Password"], rd["Name"], rd["Phone"]);
                i++;

            }
            if(i == 0)
            {
                Response.Write("찾을 데이터가 없습니다.");
            }




            rd.Close();
            conn.Close();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>찾을 회원의 ID를 입력하세요.</h1>
            <asp:TextBox ID="TextBox1" runat="server" /> 
            <br />
            <asp:Button ID="Button1" runat="server" Text="검색" OnClick="select"/>
            <hr />
            <asp:Label ID="Label1" runat="server" Text="" />
        </div>
    </form>
</body>
</html>
