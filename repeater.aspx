<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="repeater.aspx.cs" Inherits="_0511.repeater" %>
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

            if(!Page.IsPostBack)
            {
                try
                {
                    conn.Open();
                    String sql = "SELECT * FROM Mydb.dbo.Member";
                    SqlCommand sqlCommand = new SqlCommand(sql, conn);

                    SqlDataReader rd = sqlCommand.ExecuteReader();

                    MyRepeater.DataSource = rd;
                    MyRepeater.DataBind();

                    rd.Close();

                } catch(Exception exception)
                {
                    Response.Write(exception.Message.ToString() + " 에러가 발생");
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        protected void tableButtonClick(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=MyDB; Integrated Security=False; uid=admin; pwd=admin1234");

            try
            {
                conn.Open();
                String sql = "SELECT * FROM Mydb.dbo.Member";
                SqlCommand sqlCommand = new SqlCommand(sql, conn);
                SqlDataReader rd = sqlCommand.ExecuteReader();

                TableRepeater.DataSource = rd;
                TableRepeater.DataBind();

                rd.Close();
            } catch(Exception exception)
            {
                Response.Write(exception.Message.ToString() + " 에러가 발생");
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
            <asp:Repeater ID="MyRepeater" runat="server">
                <HeaderTemplate>
                    <h2>List of Member table</h2>
                </HeaderTemplate>
                <ItemTemplate>
                    아이디: <%# Eval("UserID") %> <br />
                    암호: <%# Eval("Password") %> <br />
                    이름: <%# Eval("Name") %> <br />
                    연락처: <%# Eval("Phone") %> <hr />

                </ItemTemplate>
                <SeparatorTemplate>
                </SeparatorTemplate>
                <FooterTemplate>
                    <h2>End of Member table</h2>
                </FooterTemplate>
            </asp:Repeater>
        </div>
        <div>
            <asp:Button ID="Button1" runat="server" Text="테이블" OnClick="tableButtonClick"/>
            <asp:Repeater runat="server" ID="TableRepeater">
                
                <HeaderTemplate>
                    <table border="1">
                        <tr>
                            <td>아이디</td>
                            <td>이름</td>
                            <td>암호</td>
                            <td>연락처</td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("UserID") %></td>
                        <td><%# Eval("Name") %></td>
                        <td><%# Eval("Password") %></td>
                        <td><%# Eval("Phone") %></td>
                    </tr>
                </ItemTemplate>
                <SeparatorTemplate>
                    <tr>
                        <td colspan="4" style="background-color: blue; height: 1px">
                         
                        </td>
                    </tr>
                </SeparatorTemplate>
                <AlternatingItemTemplate>
                    <tr style="background-color: gray;">
                        <td><%# Eval("UserID") %></td>
                        <td><%# Eval("Name") %></td>
                        <td><%# Eval("Password") %></td>
                        <td><%# Eval("Phone") %></td>
                    </tr>
                </AlternatingItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
