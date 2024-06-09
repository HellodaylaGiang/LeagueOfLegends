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
                            <h1 class="mt-4">Manage Users</h1>
                            <li class="breadcrumb-item" style="list-style: none;"><a href="/admin">Dashboard</a>/ User
                            </li>
                        </div>
                        <div class="container mt-5">
                            <div class="row">
                                <div class="col-12 mx-auto">
                                    <div class="d-flex justify-content-between">
                                        <h3>Table User</h3>
                                        <a class="btn btn-primary" href="/admin/user/create">Creater User</a>
                                    </div>
                                    </hr>
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th scope="col">ID</th>
                                                <th scope="col">Email</th>
                                                <th scope="col">Full Name</th>
                                                <th scope="col">Role</th>
                                                <th scope="col">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${users}" var="user">
                                                <tr>
                                                    <td>${user.id}</td>
                                                    <td>${user.email}</td>
                                                    <td>${user.fullName}</td>
                                                    <td>${user.role.name}</td>
                                                    <td>
                                                        <a href="/admin/user/${user.id}"
                                                            class="btn btn-success">View</a>
                                                        <a href="/admin/user/update/${user.id}"
                                                            class="btn btn-warning">Update</a>
                                                        <a href="/admin/user/delete/${user.id}"
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
                                                <a class="page-link" href="/admin/user?page=${currentPage-1}"
                                                    aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                            <c:forEach begin="1" end="${totalPages}" varStatus="loop">

                                                <li class="page-item ${loop.index == currentPage ? 'active' : ''}">
                                                    <a class="page-link "
                                                        href="/admin/user?page=${loop.index}">${loop.index}
                                                    </a>
                                                </li>

                                            </c:forEach>
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="/admin/user?page=${currentPage+1}"
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