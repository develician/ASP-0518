<%@ Page Title="" Language="C#" MasterPageFile="~/0601-master.Master" AutoEventWireup="true" CodeBehind="RegisterPage.aspx.cs" Inherits="_0511.Masters.RegisterPage" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script runat="server">
        protected void Register(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=tvseries; Integrated Security=False; uid=admin; pwd=admin1234");
            String SQL = "INSERT INTO Mydb.dbo.Member (UserID, Password, Name, Phone) VALUES(@UserID, @Password, @Name, @Phone)";
            SqlCommand cmd = new SqlCommand(SQL, conn);
            cmd.Parameters.AddWithValue("@UserID", IDTextBox.Text.ToString());
            cmd.Parameters.AddWithValue("@Password", PasswordTextBox.Text.ToString());
            cmd.Parameters.AddWithValue("@Name", NameTextBox.Text.ToString());
            cmd.Parameters.AddWithValue("@Phone", PhoneTextBox.Text.ToString());

            try
            {
                conn.Open();

                cmd.ExecuteNonQuery();

                Response.Redirect("/Masters/LoginPage.aspx");
            } catch(Exception exception)
            {
                Response.Write(exception.Message.ToString());
            }
            finally
            {
                conn.Close();
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="LoginForm">
        <div class="Contents">
            <div class="LoginLogo">
                회원가입
            </div>
            <div class="Line">
                <div class="Label">
                    아이디
                </div>
                <div class="InputWrapper">
                    <asp:TextBox runat="server" ID="IDTextBox" CssClass="Input" />
                </div>
            </div>
            <div class="Line">
                <div class="Label">
                    패스워드
                </div>
                <div class="InputWrapper">
                    <asp:TextBox runat="server" TextMode="Password" ID="PasswordTextBox" CssClass="Input" />
                </div>
            </div>
            <div class="Line">
                <div class="Label">
                    이름
                </div>
                <div class="InputWrapper">
                    <asp:TextBox runat="server" ID="NameTextBox" CssClass="Input" />
                </div>
            </div>
            <div class="Line">
                <div class="Label">
                    핸드폰번호
                </div>
                <div class="InputWrapper">
                    <asp:TextBox runat="server" ID="PhoneTextBox" CssClass="Input" />
                </div>
            </div>
            <div class="ButtonWrapper">
                <asp:Button ID="LoginButton" OnClick="Register" CssClass="LoginButton" Text="회원가입" runat="server" />
            </div>
            <div class="Description">
                이미 가입하셨나요? <a class="Link" href="/Masters/RegisterPage.aspx">로그인하러가기</a>
            </div>
        </div>
    </div>
</asp:Content>
