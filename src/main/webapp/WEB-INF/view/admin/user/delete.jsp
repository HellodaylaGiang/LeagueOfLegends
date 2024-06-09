<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>User Delete</title>
                <link href="/admin/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">

                <!-- header -->
                <jsp:include page="../layout/header.jsp" />

                <!-- body -->
                <div id="layoutSidenav">

                    <!-- sidebar -->
                    <jsp:include page="../layout/sidebar.jsp" />

                    <!-- content -->
                    <div id="layoutSidenav_content">
                        <div class="container-fluid px-4">
                            <h1 class="mt-4">Delete User</h1>
                            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        </div>
                        <div class="container mt-5">
                            <div class="row">
                                <div class="col-md-6 col12 mx-auto">
                                    <h3>Delete a user id = ${id}</h3>
                                    <a class="btn btn-success" href="/admin/user">Back</a>

                                    <hr />
                                </div>
                                <form:form action="/admin/user/delete" method="post" modelAttribute="newUser">
                                    <div class="mb-3" style="display: none;">
                                        <label class="form-label">ID: </label>
                                        <form:input value="${id}" type="text" class="form-control" path="id" />
                                    </div>
                                    <button class="btn btn-warning">Confirm</button>
                                </form:form>
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