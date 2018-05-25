<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="0525-datalist.aspx.cs" Inherits="_0511._0525_datalist" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=MyDB; Integrated Security=False; uid=admin; pwd=admin1234");
            String sql = "SELECT * FROM Mydb.dbo.Member;";
            SqlCommand sqlCommand = new SqlCommand(sql, conn);

            try
            {
                conn.Open();

                SqlDataReader rd = sqlCommand.ExecuteReader();

                DataList1.DataSource = rd;
                DataList1.DataBind();

                rd.Close();
                
            } catch(Exception exception)
            {
                Response.Write(exception.Message.ToString() + " 에러 발생");
            }finally
            {
                conn.Close();
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Data List Control Example</h2>
            <asp:DataList runat="server" ID="DataList1" RepeatColumns="3" RepeatDirection="Horizontal">
                <ItemTemplate>
                    아이디: <%# Eval("UserID") %><br />
                    암호: <%# Eval("Password") %><br />
                    이름: <%# Eval("Name") %><br />
                    연락처: <%# Eval("Phone") %><br />

                </ItemTemplate>
                <AlternatingItemTemplate>
                    <div style="background-color: silver">
                        아이디: <%# Eval("UserID") %><br />
                        암호: <%# Eval("Password") %><br />
                        이름: <%# Eval("Name") %><br />
                        연락처: <%# Eval("Phone") %><br />
                    </div>
                </AlternatingItemTemplate>
            </asp:DataList>
        </div>
    </form>
</body>
</html>
