<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="0518-1-table.aspx.cs" Inherits="_0511._0518_1_table" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script runat="server">
        protected void submit(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=MyDB; Integrated Security=False; uid=admin; pwd=admin1234");

            String userID = IDTextBox.Text;
            String password = passwordTextBox.Text;
            String name = nameTextBox.Text;
            String phone = phoneTextBox.Text;

            if(userID.Equals("") || password.Equals("") || name.Equals("") || phone.Equals(""))
            {
                Response.Write("모든 항목을 채워주세요.");
                return;
            }

            String sql = "INSERT INTO Mydb.dbo.Member (UserID, Password, Name, Phone) VALUES(@UserID, @Password, @Name, @Phone);";
            SqlCommand sqlCommand = new SqlCommand(sql, conn);
            sqlCommand.Parameters.AddWithValue("@UserID", IDTextBox.Text);
            sqlCommand.Parameters.AddWithValue("@Password", passwordTextBox.Text);
            sqlCommand.Parameters.AddWithValue("@Name", nameTextBox.Text);
            sqlCommand.Parameters.AddWithValue("@Phone", phoneTextBox.Text);



            try
            {
                conn.Open();

                sqlCommand.ExecuteNonQuery();

                resultLabel.Text = "값이 데이터베이스에 입력되었습니다.";
                IDTextBox.Text = "";
                nameTextBox.Text = "";
                passwordTextBox.Text = "";
                phoneTextBox.Text = "";
            } catch(Exception exception)
            {
                Response.Write(exception.Message.ToString() + " 에러가 발생");
            }
            finally
            {
                conn.Close();

            }

        }

        protected void cancel(object sender, EventArgs e)
        {
            IDTextBox.Text = "";
            nameTextBox.Text = "";
            passwordTextBox.Text = "";
            phoneTextBox.Text = "";
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="Table1" runat="server">
                <asp:TableRow runat="server">
                    <asp:TableCell runat="server">이름:  </asp:TableCell>
                    <asp:TableCell runat="server">
                        <asp:TextBox ID="nameTextBox" runat="server"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow runat="server">
                    <asp:TableCell runat="server">아이디:  </asp:TableCell>
                    <asp:TableCell runat="server">
                        <asp:TextBox ID="IDTextBox" runat="server"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow runat="server">
                    <asp:TableCell runat="server">암호:  </asp:TableCell>
                    <asp:TableCell runat="server">
                        <asp:TextBox ID="passwordTextBox" runat="server" TextMode="Password"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow runat="server">
                    <asp:TableCell runat="server">연락처:  </asp:TableCell>
                    <asp:TableCell runat="server">
                        <asp:TextBox ID="phoneTextBox" runat="server"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <asp:Button ID="confirmButton" runat="server" Text="확인" OnClick="submit" />
            <asp:Button ID="cancelButton" runat="server" Text="취소" OnClick="cancel"/>
            <asp:Label ID="resultLabel" runat="server" />
        </div>
    </form>
</body>
</html>
