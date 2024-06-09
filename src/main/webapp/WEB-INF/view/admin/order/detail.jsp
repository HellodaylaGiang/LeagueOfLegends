<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
                    <meta name="author" content="Hỏi Dân IT" />
                    <title>Detail Order - Hỏi Dân IT</title>
                    <link href="/admin/css/styles.css" rel="stylesheet" />


                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />
                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Orders</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                        <li class="breadcrumb-item"><a href="/admin/order">Order</a></li>
                                        <li class="breadcrumb-item active">View detail</li>
                                    </ol>
                                    <div class="mt-5">
                                        <div class="row">
                                            <div class="col-12 mx-auto">
                                                <div class="d-flex justify-content-between">
                                                    <h3>Order detail with id = ${id}</h3>
                                                </div>

                                                <hr />

                                                <div class="table-responsive">
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th scope="col">Sản phẩm</th>
                                                                <th scope="col">Tên</th>
                                                                <th scope="col">Giá cả</th>
                                                                <th scope="col">Số lượng</th>
                                                                <th scope="col">Thành tiền</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:if test="${ empty orderDetails}">
                                                                <tr>
                                                                    <td colspan="6">
                                                                        Không có sản phẩm trong giỏ hàng
                                                                    </td>
                                                                </tr>
                                                            </c:if>
                                                            <c:forEach var="orderDetail" items="${orderDetails}">

                                                                <tr>
                                                                    <th scope="row">
                                                                        <div class="d-flex align-items-center">
                                                                            <a href="/client/product/${orderDetail.product.id}"
                                                                                target="_blank">
                                                                                <img src="/client/img/${orderDetail.product.image}"
                                                                                    class="img-fluid me-5"
                                                                                    style="width: 110px; height: auto; border-radius: 10px;"
                                                                                    alt="">
                                                                            </a>

                                                                        </div>
                                                                    </th>
                                                                    <td>
                                                                        <p class="mb-0 mt-4">
                                                                            ${orderDetail.product.name}
                                                                        </p>
                                                                    </td>
                                                                    <td>
                                                                        <p class="mb-0 mt-4">
                                                                            <fmt:formatNumber type="number"
                                                                                value="${orderDetail.price}" /> RP
                                                                        </p>
                                                                    </td>
                                                                    <td>
                                                                        <div class="input-group quantity mt-4"
                                                                            style="width: 100px;">
                                                                            <input type="text"
                                                                                class="form-control form-control-sm text-center border-0"
                                                                                value="${orderDetail.quantity}">
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <p class="mb-0 mt-4"
                                                                            data-cart-detail-id="${orderDetail.id}">
                                                                            <fmt:formatNumber type="number"
                                                                                value="${orderDetail.price * orderDetail.quantity}" />
                                                                            RP
                                                                        </p>
                                                                    </td>
                                                                </tr>


                                                            </c:forEach>

                                                        </tbody>
                                                    </table>
                                                    <ul class="list-group">
                                                        <li class="list-group-item disabled">Thông tin nhận
                                                            hàng</li>
                                                        <li class="list-group-item">Địa chỉ:
                                                            ${order.receiverAddress}</li>
                                                        <li class="list-group-item">Tên người nhận:
                                                            ${order.receiverName}</li>
                                                        <li class="list-group-item">Số ĐT:
                                                            ${order.receiverPhone}
                                                        </li>
                                                    </ul>
                                                </div>


                                                <a href="/admin/order" class="btn btn-success mt-3">Back</a>
                                            </div>

                                        </div>

                                    </div>
                                </div>
                            </main>
                            <jsp:include page="../layout/footer.jsp" />
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                        crossorigin="anonymous"></script>
                    <script src="/js/scripts.js"></script>

                    <style>
                        .img-fluid.me-5:hover {
                            scale: 1.05;
                            transition: 0.2s;
                        }
                    </style>

                </body>

                </html>