<%@ Page Title="" Language="C#" MasterPageFile="~/0601-master.Master" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="_0511.Masters.LoginPage" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script runat="server">
        protected void Login(object sender, EventArgs e)
        {

            SqlConnection conn = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=tvseries; Integrated Security=False; uid=admin; pwd=admin1234");
            String SQL = "SELECT * FROM Mydb.dbo.Member WHERE UserID = @UserID";
            SqlCommand cmd = new SqlCommand(SQL, conn);
            cmd.Parameters.AddWithValue("@UserID", IDTextBox.Text.ToString());
            //cmd.Parameters.AddWithValue("@Password", PasswordTextBox.Text.ToString());

            if (IDTextBox.Text == "" || PasswordTextBox.Text == "")
            {
                ErrorLabel.Text = "아이디 혹은 비밀번호를 입력해주세요.";
                ErrorLabel.Visible = true;
                return;
            }

            try
            {
                conn.Open();

                SqlDataReader rd = cmd.ExecuteReader();

                int count = 0;
                while (rd.Read())
                {
                    if (rd["Password"].ToString() != PasswordTextBox.Text)
                    {
                        ErrorLabel.Text = "일치하지 않는 비번입니다.";
                        ErrorLabel.Visible = true;
                        rd.Close();
                        return;
                    }
                    count++;
                }

                if (count == 0)
                {
                    ErrorLabel.Text = "없는 아이디입니다.";
                    ErrorLabel.Visible = true;
                    rd.Close();
                    return;
                }



                
                
                Response.Redirect("/Masters/HomePage.aspx");
                rd.Close();
               
            }
            catch (Exception exception)
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
                로그인
            </div>
            <asp:Label runat="server" ID="ErrorLabel" CssClass="ErrorLabel" Text="Error" Visible="False">
                
            </asp:Label>
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
            <div class="ButtonWrapper">
                <asp:Button ID="LoginButton" OnClick="Login" CssClass="LoginButton" Text="로그인" runat="server" />
            </div>
            <div class="Description">
                아직 가입하지 않았나요? <a class="Link" href="/Masters/RegisterPage.aspx">가입하러가기</a>
            </div>
        </div>
    </div>
</asp:Content>
