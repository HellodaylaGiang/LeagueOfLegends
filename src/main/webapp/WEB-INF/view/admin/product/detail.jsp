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
            <title>Champion Detail</title>
            <!-- <link href="/admin/css/styles.css" rel="stylesheet" /> -->
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
                integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
                crossorigin="anonymous">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
                crossorigin="anonymous"></script>
        </head>

        <body>

            <nav class="navbar navbar-expand-lg bg-body-tertiaryx"
                style="height: 90px; background-color: #111; color: #f9f9f9;">
                <div class="container-fluid" style="width: 100%; height: 100%; padding: 0;">
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item active d-flex">
                                <img src="/client/img/riotlogo.png" alt=""
                                    style="width: 100%; height: 90px; margin: auto;">
                            </li>
                            <li class="nav-item active ms-5 d-flex">
                                <a class="nav-link text-warning fw-bold mx-auto" aria-current="page"
                                    style="margin: auto;" href="#">Trò
                                    chơi</a>
                            </li>
                            <li class="nav-item active ms-5 d-flex">
                                <a class="nav-link text-warning fw-bold mx-auto" style="margin: auto;"
                                    href="#">Tướng</a>
                            </li>
                            <li class="nav-item active dropdown ms-5 d-flex">
                                <a class="nav-link dropdown-toggle text-warning fw-bold" style="margin: auto;" href="#"
                                    role="button">
                                    Tin tức
                                </a>
                            </li>
                            <li class="nav-item active ms-5 d-flex">
                                <a class="nav-link text-warning fw-bold mx-auto" style="margin: auto;"
                                    href="#">Esports</a>
                            </li>
                            <li class="nav-item active ms-5 d-flex">
                                <a class="nav-link text-warning fw-bold mx-auto" style="margin: auto;" href="#">Hỗ
                                    trợ</a>
                            </li>
                        </ul>
                        <form class="d-flex" role="search">
                            <a class="btn btn-success" href="/admin/product">Back</a>
                        </form>
                    </div>
                </div>
            </nav>

            <div style="display: flex; background-color: aliceblue;">
                <div class="col-sm-6" style="display: flex;  position: relative; padding: 50px 0;">
                    <img src="/client/img/${product.image}" alt=""
                        style="border-radius: 10px; margin: auto; width: 80%;">

                    <h1
                        style="position: absolute; top: 315px; width: 100%; text-align: center; color: white; font-weight: bold; letter-spacing: 0.1rem; font-style: italic;">
                        ${product.shortDesc}
                    </h1>
                    <h1
                        style="position: absolute; top: 233px; width: 100%; text-align: center; color: white; font-weight: 700; letter-spacing: 0.1rem; font-style: italic; font-size: 70px;">
                        ${product.name}
                    </h1>
                </div>

                <div class="row col-md-6" style="padding: 20px 0;">
                    <p style="font-size: x-large; padding-top: 30px;">Vai trò:
                        <i class="fa-solid fa-wand-magic-sparkles"></i> ${product.target}
                        <br> ${product.detailDesc}
                    </p>
                </div>

            </div>

            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                crossorigin="anonymous"></script>
            <script src="js/scripts.js"></script>
        </body>

        </html>