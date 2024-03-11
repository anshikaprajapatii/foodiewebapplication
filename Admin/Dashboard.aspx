<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Foodie.Admin.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-body">
        <div class="page-wrapper">
            <div class="page-body">
                <div class="row">
                    <div class="col-sm-6 col-xl-3">
                        <div class="card widget-card-1">
                            <div class="card-block-small">
                                <i class="icofont icofont-muffin bg-c-blue card1-icon"></i>
                                <span class="text-c-blue f-w-600">Categories</span>
                                <h4><% Response.Write(Session["category"]);  %></h4>
                                <div>
                                    <span class="f-left m-t-10 text-muted">
                                        <a href="Category.aspx">
                                            <i class="text-c-blue f-16 icofont icofont-eye-alt m-r-10"></i>
                                            View Details
                                        </a>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                     <div class="col-sm-6 col-xl-3">
                        <div class="card widget-card-1">
                            <div class="card-block-small">
                                <i class="icofont icofont-box bg-c-pink card1-icon"></i>
                                <span class="text-c-pink f-w-600">Products</span>
                                <h4><% Response.Write(Session["product"]);  %></h4>
                                <div>
                                    <span class="f-left m-t-10 text-muted">
                                        <a href="Product.aspx">
                                            <i class="text-c-pink f-16 icofont icofont-eye-alt m-r-10"></i>
                                            View Details
                                        </a>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                     <div class="col-sm-6 col-xl-3">
                        <div class="card widget-card-1">
                            <div class="card-block-small">
                                <i class="icofont icofont-spoon-and-fork bg-c-green card1-icon"></i>
                                <span class="text-c-green f-w-600">Total Orders</span>
                                <h4><% Response.Write(Session["order"]);  %></h4>
                                <div>
                                    <span class="f-left m-t-10 text-muted">
                                        <a href="OrderStatus.aspx">
                                            <i class="text-c-green f-16 icofont icofont-eye-alt m-r-10"></i>
                                            View Details
                                        </a>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                     <div class="col-sm-6 col-xl-3">
                        <div class="card widget-card-1">
                            <div class="card-block-small">
                                <i class="icofont icofont-truck-loaded bg-c-orenge card1-icon"></i>
                                <span class="text-c-orenge f-w-600">Delivered Orders</span>
                                <h4><% Response.Write(Session["delivered"]);  %></h4>
                                <div>
                                    <span class="f-left m-t-10 text-muted">
                                        <a href="OrderStatus.aspx">
                                            <i class="text-c-orenge f-16 icofont icofont-eye-alt m-r-10"></i>
                                            View Details
                                        </a>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                     <div class="col-sm-6 col-xl-3">
                        <div class="card widget-card-1">
                            <div class="card-block-small">
                                <i class="icofont icofont-delivery-time bg-c-yellow card1-icon"></i>
                                <span class="text-c-yellow f-w-600">Pending Orders</span>
                                <h4><% Response.Write(Session["pending"]);  %></h4>
                                <div>
                                    <span class="f-left m-t-10 text-muted">
                                        <a href="OrderStatus.aspx">
                                            <i class="text-c-yellow f-16 icofont icofont-eye-alt m-r-10"></i>
                                            View Details
                                        </a>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                     <%--<div class="col-sm-6 col-xl-3">
                        <div class="card widget-card-1">
                            <div class="card-block-small">
                                <i class="icofont icofont-money-bag bg-c-lite-green card1-icon"></i>
                                <span class="text-c-lite-green f-w-600">Sold Amount</span>
                                <h4><% Response.Write(Session["soldAmount"]);  %></h4>
                                <div>
                                    <span class="f-left m-t-10 text-muted">
                                        <a href="Report.aspx">
                                            <i class="text-c-lite-green f-16 icofont icofont-eye-alt m-r-10"></i>
                                            View Details
                                        </a>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>--%>

                     <div class="col-sm-6 col-xl-3">
                        <div class="card widget-card-1">
                            <div class="card-block-small">
                                <i class="icofont icofont-user bg-c-lite-green card1-icon"></i>
                                <span class="text-c-lite-green f-w-600">Users</span>
                                <h4><% Response.Write(Session["user"]);  %></h4>
                                <div>
                                    <span class="f-left m-t-10 text-muted">
                                        <a href="Users.aspx">
                                            <i class="text-c-lite-green f-16 icofont icofont-eye-alt m-r-10"></i>
                                            View Details
                                        </a>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                     <div class="col-sm-6 col-xl-3">
                        <div class="card widget-card-1">
                            <div class="card-block-small">
                                <i class="icofont icofont-question-circle bg-c-blue card1-icon"></i>
                                <span class="text-c-blue f-w-600">Feedbacks</span>
                                <h4><% Response.Write(Session["contact"]);  %></h4>
                                <div>
                                    <span class="f-left m-t-10 text-muted">
                                        <a href="Contacts.aspx">
                                            <i class="text-c-blue f-16 icofont icofont-eye-alt m-r-10"></i>
                                            View Details
                                        </a>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
