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
                <title>Create champion</title>
                <link href="/admin/css/styles.css" rel="stylesheet" />

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");
                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL);
                            $("#avatarPreview").css({ "display": "block" });
                        });
                    });
                </script>

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
                            <h1 class="mt-4">Create champion</h1>
                            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                            <li class="breadcrumb-item">Champion</li>
                            <a class="btn btn-success" href="/admin/product">Back</a>

                        </div>
                        <div class="mt-5">
                            <div class="row">
                                <div class="col-md-6 col-12 mx-auto">
                                    <h3>Create a champion</h3>
                                    <hr />
                                    <form:form method="post" action="/admin/product/create" modelAttribute="newProduct"
                                        class="row" enctype="multipart/form-data">
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Name:</label>
                                            <form:input type="text" class="form-control" path="name" />
                                            <form:errors class="text-danger" path="name" />
                                        </div>
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Price:</label>
                                            <form:input type="number" class="form-control" path="price" />
                                            <form:errors class="text-danger" path="price" />
                                        </div>
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Detail description:</label>
                                            <form:input type="text" class="form-control" path="detailDesc" />
                                            <form:errors class="text-danger" path="detailDesc" />
                                        </div>
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Short description:</label>
                                            <form:input type="text" class="form-control" path="shortDesc" />
                                            <form:errors class="text-danger" path="shortDesc" />
                                        </div>

                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">From:</label>
                                            <form:select class="form-select" path="factory">
                                                <form:option value="NOXUS">NOXUS</form:option>
                                                <form:option value="HƯ KHÔNG">HƯ KHÔNG</form:option>
                                                <form:option value="DEMACIA">DEMACIA</form:option>
                                                <form:option value="SHURIMA">SHURIMA</form:option>
                                                <form:option value="IONIA">IONIA</form:option>
                                            </form:select>
                                        </div>
                                        <div class="mb-3 col-12">
                                            <label class="form-label">Category:</label>
                                            <form:select class="form-select" path="target">
                                                <form:option value="PHÁP SƯ">PHÁP SƯ</form:option>
                                                <form:option value="ĐẤU SĨ">ĐẤU SĨ</form:option>
                                                <form:option value="SÁT THỦ">SÁT THỦ</form:option>
                                                <form:option value="XẠ THỦ">XẠ THỦ</form:option>
                                            </form:select>
                                        </div>


                                        <div class="mb-3 col-12 col-md-6">
                                            <label for="avatarFile" class="form-label">Image::</label>
                                            <input class="form-control" type="file" id="avatarFile"
                                                accept=".png, .jpg, .jpeg" name="uploadFile" />
                                        </div>
                                        <div class="col-12 mb-3">
                                            <img style="max-height: 250px; display: none;" alt="avatar preview"
                                                id="avatarPreview" />
                                        </div>
                                        <div class="col-12 mb-5">
                                            <button type="submit" class="btn btn-primary">Create</button>
                                        </div>
                                    </form:form>
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