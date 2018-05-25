<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="0525-gridview.aspx.cs" Inherits="_0511._0525_gridview" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
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
            }
        }

        protected void BindList()
        {
            SqlConnection conn = new SqlConnection("Data Source=.\\SQLEXPRESS; Initial Catalog=MyDB; Integrated Security=False; uid=admin; pwd=admin1234");
            String sql = "SELECT * FROM Mydb.dbo.Member;";
            SqlCommand cmd = new SqlCommand(sql, conn);

            try
            {
                conn.Open();

                //SqlDataReader rd = cmd.ExecuteReader();
                //MyGridView.DataSource = rd;
                //MyGridView.DataBind();
                //rd.Close();

                SqlDataAdapter ad = new SqlDataAdapter();
                ad.SelectCommand = cmd;

                DataSet ds = new DataSet();
                ad.Fill(ds);
                MyGridView.DataSource = ds;
                MyGridView.DataBind();

            } catch(Exception exception)
            {
                Response.Write(exception.Message.ToString() + " 에러 발생");
            } finally
            {
                conn.Close();
            }
        }

        protected void MyGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            MyGridView.PageIndex = e.NewPageIndex;
            BindList();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView 
                runat="server" 
                ID="MyGridView"
                EnableModelValidation="True"
                AutoGenerateColumns="false"
                AllowPaging="true"
                PageSize="3"
                OnPageIndexChanging="MyGridView_PageIndexChanging"
                AllowSorting="true"
                >
                <Columns>
                    <asp:BoundField DataField="UserID" HeaderText="아이디"/>
                    <asp:BoundField DataField="Name" HeaderText="이름"/>
                    <asp:BoundField DataField="Password" HeaderText="암호"/>
                    <asp:BoundField DataField="Phone" HeaderText="연락처"/>

                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
