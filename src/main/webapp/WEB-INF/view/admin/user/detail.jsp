<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>User Detail</title>
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
                    <h1 class="mt-4">User Detail</h1>
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                </div>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <div class="d-flex justify-content-between">
                                <h3>User Detail ${id}</h3>
                            </div>
                            </hr>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Full Name</th>
                                        <th scope="col">Address</th>
                                        <th scope="col">Phone</th>
                                        <th scope="col">Role</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>${user.id}</td>
                                        <td>${user.email}</td>
                                        <td>${user.fullName}</td>
                                        <td>${user.address} </td>
                                        <td>${user.phone} </td>
                                        <td>${user.role.name} </td>
                                    </tr>
                                </tbody>
                            </table>
                            <h1>Image: </h1>
                            <img style="width: 300px; height: 300px;" src="/client/img/${user.avatar}" alt="">
                            <a class="btn btn-success" href="/admin/user">Back</a>
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