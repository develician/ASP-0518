<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="0518-2-updateTable.aspx.cs" Inherits="_0511._0518_2_updateTable" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Write("Page Loaded");

            if(!Page.IsPostBack)
            {
                SqlConnection conn = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=MyDB; Integrated Security=False; uid=admin; pwd=admin1234");

                String sql = "SELECT * FROM Mydb.dbo.Member";
                SqlCommand sqlCommand = new SqlCommand(sql, conn);

                //List<String> userIDs = new List<string>();



                try
                {
                    conn.Open();
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();

                    idList.DataSource = sqlDataReader;
                    idList.DataValueField = "UserID";
                    idList.DataTextField = "UserID";
                    idList.DataBind();



                    //while(sqlDataReader.Read())
                    //{
                    //    //userIDs.Add(sqlDataReader["UserID"].ToString());
                    //    ListItem idListItem = new ListItem();
                    //    idListItem.Text = sqlDataReader["UserID"].ToString();
                    //    idList.Items.Add(idListItem);

                    //}


                    sqlDataReader.Close();

                    SetUserInfo(sender, e);

                } catch(Exception exception)
                {
                    Response.Write(exception.Message.ToString() + " 에러 발생");
                }
                finally
                {

                    conn.Close();
                }




                //sql = "SEELCT * FROM Mydb.dbo.Member WHERE UserID=@UserID";

                //sqlCommand = new SqlCommand(sql, conn);
                //sqlCommand.Parameters.AddWithValue("@UserID", idList.SelectedValue);

                //conn.Open();
                //SqlDataReader rd = sqlCommand.ExecuteReader();

                //if(rd.Read())
                //{
                //    idLabel.Text = rd["UserID"].ToString();
                //    nameTextBox.Text = rd["Name"].ToString();
                //    passwordTextBox.Text = rd["Password"].ToString();
                //    phoneTextBox.Text = rd["Phone"].ToString();
                //}

            }
        }

        protected void MakeUpdate(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=MyDB; Integrated Security=False; uid=admin; pwd=admin1234");


            try
            {
                conn.Open();
                String sql = "UPDATE Mydb.dbo.Member SET Name = @Name, Password = @Password, Phone = @Phone WHERE UserID = @UserID";
                SqlCommand sqlCommand = new SqlCommand(sql, conn);
                sqlCommand.Parameters.AddWithValue("@UserID", idLabel.Text.ToString());
                sqlCommand.Parameters.AddWithValue("@Name", nameTextBox.Text.ToString());
                sqlCommand.Parameters.AddWithValue("@Password", passwordTextBox.Text.ToString());
                sqlCommand.Parameters.AddWithValue("@Phone", phoneTextBox.Text.ToString());
                sqlCommand.ExecuteNonQuery();

                resultLabel.Text = "정보가 업데이트 되었습니다.";
            } catch(Exception exception)
            {
                Response.Write(exception.Message.ToString() + " 에러 발생");
            }
            finally
            {
                conn.Close();
            }
        }

        protected void SetUserInfo(object sender, EventArgs e)
        {

            String selectedUserID = idList.SelectedItem.Text.ToString();

            SqlConnection conn = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=MyDB; Integrated Security=False; uid=admin; pwd=admin1234");
            conn.Open();

            String sql = "SELECT * FROM Mydb.dbo.Member WHERE UserID = @UserID";
            SqlCommand sqlCommand = new SqlCommand(sql, conn);
            sqlCommand.Parameters.AddWithValue("@UserID", idList.SelectedValue);
            SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();

            try
            {
                while (sqlDataReader.Read())
                {
                    idLabel.Text = sqlDataReader["UserID"].ToString();
                    nameTextBox.Text = sqlDataReader["Name"].ToString();
                    passwordTextBox.Text = sqlDataReader["Password"].ToString();
                    phoneTextBox.Text = sqlDataReader["Phone"].ToString();
                }
                sqlDataReader.Close();
            } catch(Exception exception)
            {
                Response.Write(exception.Message.ToString() + " 에러 발생");
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
            <h3>연결기반 수정 예제</h3>
            <asp:DropDownList ID="idList" runat="server" AutoPostBack="true" OnSelectedIndexChanged="SetUserInfo">
                
            </asp:DropDownList>
            <br />
            <asp:Table ID="Table1" runat="server">
                <asp:TableRow runat="server">
                    <asp:TableCell runat="server">아이디:  </asp:TableCell>
                    <asp:TableCell runat="server">
                        <asp:Label runat="server" ID="idLabel" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow runat="server">
                    <asp:TableCell runat="server">이름:  </asp:TableCell>
                    <asp:TableCell runat="server">
                        <asp:TextBox ID="nameTextBox" runat="server"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                
                <asp:TableRow runat="server">
                    <asp:TableCell runat="server">암호:  </asp:TableCell>
                    <asp:TableCell runat="server">
                        <asp:TextBox ID="passwordTextBox" runat="server" ></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow runat="server">
                    <asp:TableCell runat="server">연락처:  </asp:TableCell>
                    <asp:TableCell runat="server">
                        <asp:TextBox ID="phoneTextBox" runat="server"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:Button runat="server" ID="updateButton" Text="수정" OnClick="MakeUpdate"/>
            <br />
            <asp:Label runat="server" ID="resultLabel" />
        </div>
    </form>
</body>
</html>
