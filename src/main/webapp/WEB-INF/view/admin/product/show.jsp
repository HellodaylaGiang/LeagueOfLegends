<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                            <h1 class="mt-4">Manage Champions</h1>
                            <li class="breadcrumb-item" style="list-style: none;"><a href="/admin">Dashboard</a>/
                                Product</li>
                        </div>
                        <div class="container mt-5">
                            <div class="row">
                                <div class="col-12 mx-auto" style="height: 500px; border: 2px solid black;">
                                    <div class="d-flex justify-content-between">
                                        <h3>Table Champions</h3>
                                        <a class="btn btn-primary" href="/admin/product/create1">Creater a champion</a>
                                    </div>
                                    </hr>
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th scope="col">ID</th>
                                                <th scope="col">Name</th>
                                                <th scope="col">Price</th>
                                                <th scope="col">Category</th>
                                                <th scope="col">Short Desc</th>
                                                <th scope="col">Image</th>
                                                <th scope="col">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${products}" var="product">
                                                <tr>
                                                    <td>${product.id}</td>
                                                    <td>${product.name}</td>
                                                    <td>${product.price} RP</td>
                                                    <td>${product.target}</td>
                                                    <td>${product.shortDesc}</td>
                                                    <td>
                                                        <img style="width: 80px; border-radius: 5px;"
                                                            src="/client/img/${product.image}" alt="">
                                                    </td>
                                                    <td>

                                                        <a href="/admin/product/${product.id}"
                                                            class="btn btn-success">View</a>

                                                        <c:if test="${product.id > 18}">
                                                            <a href="/admin/product/update/${product.id}"
                                                                class="btn btn-warning">Update</a>
                                                            <a href="/admin/product/delete/${product.id}"
                                                                class="btn btn-danger">Delete</a>
                                                        </c:if>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                    <!-- nav paginaion -->

                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination justify-content-center">

                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="/admin/product?page=${currentPage-1}"
                                                    aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                            <c:forEach begin="1" end="${totalPages}" varStatus="loop">

                                                <li class="page-item ${loop.index == currentPage ? 'active' : ''}">
                                                    <a class="page-link "
                                                        href="/admin/product?page=${loop.index}">${loop.index}
                                                    </a>
                                                </li>

                                            </c:forEach>
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="/admin/product?page=${currentPage+1}"
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
                <script src="js/scripts.js"></script>

        </body>

        </html>