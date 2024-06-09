<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>Dashboard - SB Admin</title>
                <link href="/admin/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">

                <!-- header -->
                <%@ include file="../layout/header.jsp" %>


                    <!-- body -->
                    <div id="layoutSidenav">

                        <!-- sidebar -->
                        <jsp:include page="../layout/sidebar.jsp" />

                        <!-- content -->
                        <div id="layoutSidenav_content">
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Manage Orders</h1>
                                <li class="breadcrumb-item" style="list-style: none;"><a href="/admin">Dashboard</a>/
                                    Order</li>
                            </div>
                            <div class="container mt-5">
                                <div class="row">
                                    <div class="col-12 mx-auto">
                                        <div class="d-flex justify-content-between">
                                            <h3>Order Champions</h3>
                                        </div>
                                        </hr>
                                        <table class="table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th scope="col">ID</th>
                                                    <th scope="col">Total Price</th>
                                                    <th scope="col">User</th>
                                                    <th scope="col">Status</th>
                                                    <th scope="col">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${orders}" var="o">
                                                    <tr>
                                                        <td>${o.id}</td>
                                                        <td>
                                                            <fmt:formatNumber type="number" value="${o.totalPrice}" />
                                                            RP
                                                        </td>
                                                        <td>${o.user.fullName}</td>
                                                        <td>${o.status}</td>
                                                        <td>
                                                            <a href="/admin/order/${o.id}"
                                                                class="btn btn-success">View</a>
                                                            <a href="/admin/order/update/${o.id}"
                                                                class="btn btn-warning">Update</a>
                                                            <a href="/admin/order/delete/${o.id}"
                                                                class="btn btn-danger">Delete</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>

                                        <!-- nav paginaion -->

                                        <nav aria-label="Page navigation example">
                                            <ul class="pagination justify-content-center">

                                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                    <a class="page-link" href="/admin/order?page=${currentPage-1}"
                                                        aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                    </a>
                                                </li>
                                                <c:forEach begin="1" end="${totalPages}" varStatus="loop">

                                                    <li class="page-item ${loop.index == currentPage ? 'active' : ''}">
                                                        <a class="page-link "
                                                            href="/admin/order?page=${loop.index}">${loop.index}
                                                        </a>
                                                    </li>

                                                </c:forEach>
                                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                    <a class="page-link" href="/admin/order?page=${currentPage+1}"
                                                        aria-label="Next">
                                                        <span aria-hidden="true">&raquo;</span>
                                                    </a>
                                                </li>

                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>


                            <jsp:include page="../layout/footer.jsp" />

                        </div>

                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                        crossorigin="anonymous"></script>
                    <script src="/admin/js/scripts.js"></script>
            </body>

            </html>