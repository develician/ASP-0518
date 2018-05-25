<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="0525-gridview-2.aspx.cs" Inherits="_0511._0525_gridview_2" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script runat="server">

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindList();
                //시작시 Data Bind(GridView)
            }

        }
        protected void BindList()
        {
            // Bind시킨다 (GridView)

            SqlConnection conn = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=MyDB; Integrated Security=False; uid=admin; pwd=admin1234");
            String sql = "SELECT UserID, Password, Name, Phone FROM Mydb.dbo.Member;";
            SqlCommand cmd = new SqlCommand(sql, conn);

            // DB연결부

            try
            {
                conn.Open();
                // DB를 연다

                SqlDataReader rd = cmd.ExecuteReader();
                MyGridView.DataSource = rd;
                MyGridView.DataBind();
                rd.Close();

                // Reader로 DB에서 SQL에 따라 읽고 reader를 닫는다.
            } catch(Exception exception)
            {
                Response.Write(exception.Message.ToString() + " 에러 발생");
                // 에러 발생시 처리부
            } finally
            {
                conn.Close();
                // Connection 을 닫는다.
            }
        }

        protected void MyGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            // 편집 버튼을 누를시 처리부

            MyGridView.EditIndex = e.NewEditIndex;

            // 다시 바인딩 시켜 내용도 다시 보여준다.
            BindList();
        }

        protected void UpdateMember(String UserID, String Password, String Name, String Phone)
        {
            // 실제 Update를 실행하는 처리부
            SqlConnection conn = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=MyDB; Integrated Security=False; uid=admin; pwd=admin1234");
            String sql = "UPDATE Mydb.dbo.Member SET Password=@Password, Name=@Name, Phone=@Phone WHERE UserID = @UserID";
            SqlCommand cmd = new SqlCommand(sql, conn);
            // Parameter를 연동해준다.
            cmd.Parameters.AddWithValue("@Password", Password);
            cmd.Parameters.AddWithValue("@Name", Name);
            cmd.Parameters.AddWithValue("@Phone", Phone);
            cmd.Parameters.AddWithValue("@UserID", UserID);

            try
            {
                // DB를 연결
                conn.Open();
                // 쿼리문 실행
                cmd.ExecuteNonQuery();

            } catch(Exception exception)
            {
                // 에러처리부
                Response.Write(exception.Message.ToString() + " 에러 발생");
            }
            finally
            {
                // Connection 닫기
                conn.Close();
            }

        }

        protected void MyGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Update버튼을 눌렀을시 정보들을 가져와 변수에 저장
            String UserID = MyGridView.DataKeys[e.RowIndex].Value.ToString();
            String Password = e.NewValues["Password"].ToString();
            String Name = e.NewValues["Name"].ToString();
            String Phone = e.NewValues["Phone"].ToString();
            // update함수 실행
            UpdateMember(UserID, Password, Name, Phone);
            // Edit인덱스를 -1로 하여 선택되지 않게 한다.
            MyGridView.EditIndex = -1;
            // 바인드 시켜 다시 데이터 렌더
            BindList();



        }

        protected void MyGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // 딜리트 시킬때 PK인 UserID를 변수에 저장
            String UserID = MyGridView.DataKeys[e.RowIndex].Value.ToString();
            // Delete함수 실행
            DeleteMember(UserID);
            // 다시 bind시켜 데이터를 보여준다
            BindList();
        }

        protected void DeleteMember(String UserID)
        {
            // 실제 DB와 연동하여 Delete하는 실행부
            SqlConnection conn = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=MyDB; Integrated Security=False; uid=admin; pwd=admin1234");
            String sql = "DELETE FROM Mydb.dbo.Member WHERE UserID=@UserID";
            SqlCommand cmd = new SqlCommand(sql, conn);
            // Parameter 연동
            cmd.Parameters.AddWithValue("@UserID", UserID);

            try
            {
                // 커넥션 열기
                conn.Open();
                // 쿼리문 실행
                cmd.ExecuteNonQuery();

            } catch(Exception exception)
            {
                // 에러처리
                Response.Write(exception.Message.ToString() + " 에러 발생");
            }
            finally
            {
                // 커넥션 닫기
                conn.Close();
            }
        }

        protected void MyGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            // 편집을 취소했을시 선택된 행이 없도록 -1로 인덱스를 맞춘다.
            MyGridView.EditIndex = -1;
            // 다시 바인드하여 데이터 렌더
            BindList();
        }

        protected void MyGridView_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            // 선택된 인덱스가 달라졌을때, 선택한 회원의 아이디를 바꿔준다.
            SelectedMember.Text = MyGridView.DataKeys[e.NewSelectedIndex].Value.ToString();
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>선택한 회원 : <asp:Label ID="SelectedMember" runat="server"></asp:Label></h2>

            <asp:GridView 
                ID="MyGridView" runat="server"
                AutoGenerateColumns="false"
                DataKeyNames="UserID"
                OnRowEditing="MyGridView_RowEditing"
                OnRowUpdating="MyGridView_RowUpdating"
                OnRowDeleting="MyGridView_RowDeleting"
                OnRowCancelingEdit="MyGridView_RowCancelingEdit"
                OnSelectedIndexChanging="MyGridView_SelectedIndexChanging"
               >
                <Columns>
                    <asp:CommandField ShowEditButton="true" 
                        ShowSelectButton="true"
                        ShowDeleteButton="true"
                        HeaderText="명령" />
                    <asp:BoundField DataField="UserID" ReadOnly="False" HeaderText="아이디" />
                    <asp:BoundField DataField="Password" ReadOnly="False" HeaderText="암호" />
                    <asp:BoundField DataField="Name" ReadOnly="False" HeaderText="이름" />
                    <asp:BoundField DataField="Phone" ReadOnly="False" HeaderText="연락처" />
                </Columns>
                <SelectedRowStyle BackColor="Silver" />
            </asp:GridView>
        </div>
    </form>
</body>
</html>
