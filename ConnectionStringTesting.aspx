<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConnectionStringTesting.aspx.cs" Inherits="_0511.ConnectionStringTesting" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:MyDBConnectionString %>" SelectCommand="SELECT [serial_no], [writer], [title], [ref_id], [inner_id], [depth], [read_count], [del_flag], [reg_date] FROM [Board] ORDER BY [ref_id] DESC, [inner_id]"></asp:SqlDataSource>
            <asp:GridView runat="server" ID="MyGridView" AutoGenerateColumns="False" DataKeyNames="serial_no" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="serial_no" HeaderText="serial_no" InsertVisible="False" ReadOnly="True" SortExpression="serial_no" />
                    <asp:BoundField DataField="writer" HeaderText="writer" SortExpression="writer" />
                    <asp:BoundField DataField="title" HeaderText="title" SortExpression="title" />
                    <asp:BoundField DataField="ref_id" HeaderText="ref_id" SortExpression="ref_id" />
                    <asp:BoundField DataField="inner_id" HeaderText="inner_id" SortExpression="inner_id" />
                    <asp:BoundField DataField="depth" HeaderText="depth" SortExpression="depth" />
                    <asp:BoundField DataField="read_count" HeaderText="read_count" SortExpression="read_count" />
                    <asp:BoundField DataField="del_flag" HeaderText="del_flag" SortExpression="del_flag" />
                    <asp:BoundField DataField="reg_date" HeaderText="reg_date" SortExpression="reg_date" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
