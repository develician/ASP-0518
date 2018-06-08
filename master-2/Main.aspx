<%@ Page Title="" Language="C#" MasterPageFile="~/master-2/PageTemplate.master" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="_0511.master_2.Main" %>

<asp:Content runat="server" ContentPlaceHolderID="PageMain">
    <asp:SqlDataSource runat="server" ID="MyDataSource" ConnectionString="<%$ ConnectionStrings:MyDBConnectionString %>" SelectCommand="SELECT [serial_no], [writer], [title], [ref_id], [inner_id], [depth], [read_count], [del_flag], [reg_date] FROM [Board] ORDER BY [ref_id] DESC, [inner_id]"></asp:SqlDataSource>
    <asp:GridView runat="server" ID="MyGridView" AutoGenerateColumns="False" DataKeyNames="serial_no" DataSourceID="MyDataSource">
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
</asp:Content>