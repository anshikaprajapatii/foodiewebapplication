﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Users.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="Foodie.Menu" %>

<%@ Import Namespace="Foodie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- food section -->

    <section class="food_section layout_padding">
        <div class="container">
            <div class="heading_container heading_center">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>
                <h2>Our Menu</h2>
            </div>

            <br />
            <div class="heading_center heading_container">
                <div class="row">
                    <div class="col-md-4 col-lg-6">
                        <asp:TextBox ID="txtPinCode" runat="server" CssClass="form-control" Width="250px" placeholder="Enter Pin Code"></asp:TextBox>
                    </div>
                    <div class="col-md-4 col-lg-6">
                        <asp:LinkButton ID="searchByArea" runat="server" CssClass="btn btn-dark pl-5 pr-5 rounded-pill" ForeColor="White" OnClick="searchByArea_Click" Text="Search"></asp:LinkButton>
                    </div>
                </div>
            </div>

            <ul class="filters_menu">
                <li class="active" data-filter="*" data-id="0">All</li>
                <asp:Repeater ID="rCategory" runat="server">
                    <ItemTemplate>
                        <li data-filter=".<%# Eval("Name").ToString().ToLower() %>" data-id="<%# Eval("CategoryId") %>"><%# Eval("Name") %></li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>

            <div class="filters-content">
                <div class="row grid">
                    <asp:Repeater ID="rProducts" runat="server" OnItemCommand="rProducts_ItemCommand">
                        <ItemTemplate>
                            <div class="col-sm-6 col-lg-4 all <%# Eval("Name").ToString().ToLower() %>">
                                <div class="box">
                                    <div>
                                        <div class="img-box">
                                            <img src="<%# Utils.GetImageUrl(Eval("ImageUrl")) %>" alt="">
                                        </div>
                                        <div class="detail-box">
                                            <h5>
                                                <%# Eval("Name") %>
                                            </h5>
                                            <p>
                                                <%# Eval("Description") %>
                                            </p>
                                            <div class="options">
                                                <h6>
                                                    <%# Eval("Price") %>
                                                </h6>
                                                <asp:LinkButton ID="btnAddToCart" runat="server" CommandName="addToCart" CommandArgument='<%# Eval("ProductId") %>'>
                                                <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 456.029 456.029" style="enable-background: new 0 0 456.029 456.029;" xml:space="preserve">
                                                    <g>
                                                        <g>
                                                            <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
                         c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                                                        </g>
                                                    </g>
                                                    <g>
                                                        <g>
                                                            <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
                         C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
                         c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
                         C457.728,97.71,450.56,86.958,439.296,84.91z" />
                                                        </g>
                                                    </g>
                                                    <g>
                                                        <g>
                                                            <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
                         c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" />
                                                        </g>
                                                    </g>
                                                    <g>
                                                    </g>
                                                    <g>
                                                    </g>
                                                    <g>
                                                    </g>
                                                    <g>
                                                    </g>
                                                    <g>
                                                    </g>
                                                    <g>
                                                    </g>
                                                    <g>
                                                    </g>
                                                    <g>
                                                    </g>
                                                    <g>
                                                    </g>
                                                    <g>
                                                    </g>
                                                    <g>
                                                    </g>
                                                    <g>
                                                    </g>
                                                    <g>
                                                    </g>
                                                    <g>
                                                    </g>
                                                    <g>
                                                    </g>
                                                </svg>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <%--  <div class="btn-box">
                <a href="#">View More</a>
            </div>--%>
        </div>
    </section>

    <!-- end food section -->

</asp:Content>
