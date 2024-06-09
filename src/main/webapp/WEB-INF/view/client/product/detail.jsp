<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8">
                <title>${p.name} - Champion</title>
                <meta content="width=device-width, initial-scale=1.0" name="viewport">
                <meta content="" name="keywords">
                <meta content="" name="description">

                <!-- Google Web Fonts -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet">

                <!-- Icon Font Stylesheet -->
                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <!-- Libraries Stylesheet -->
                <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


                <!-- Customized Bootstrap Stylesheet -->
                <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                <!-- Template Stylesheet -->
                <link href="/client/css/style.css" rel="stylesheet">

                <link rel="stylesheet" href="/client/css/slick.css" type="text/css" />
                <link rel="stylesheet" href="/client/css/templatemo-style.css">
            </head>

            <body>

                <!-- header -->
                <div class="container-fluid" style="padding: 0;">
                    <div class="container px-0">
                        <nav class="navbar navbar-light navbar-expand-xl">
                            <a href="/" class="navbar-brand">
                                <h1 class="text-primary display-6">Liên Minh Huyền Thoại</h1>
                            </a>
                            <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarCollapse">
                                <span class="fa fa-bars text-primary"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarCollapse">
                                <div class="navbar-nav mx-auto">
                                    <a href="/" class="nav-item nav-link active"
                                        style="font-size: 20px; color: yellow;">Home</a>
                                    <a href="/admin" class="nav-item nav-link "
                                        style="font-size: 20px; color: yellow;">Admin</a>
                                    <a href="/products" class="nav-item nav-link "
                                        style="font-size: 20px; color: yellow;">Filter
                                        Champion</a>
                                </div>

                                <div class="d-flex m-3 me-0">

                                    <c:if test="${not empty pageContext.request.userPrincipal}">
                                        <a href="/cart" class="position-relative me-4 my-auto">
                                            <i class="fa fa-shopping-bag fa-2x"></i>
                                            <span
                                                class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                                style="top: -5px; left: 15px; height: 20px; min-width: 20px;"
                                                id="sumCart">
                                                ${sessionScope.sum}</span>
                                        </a>
                                        <div class="dropdown my-auto">
                                            <a href="#" class="dropdown" role="button" id="dropdownMenuLink"
                                                data-bs-toggle="dropdown" aria-expanded="false"
                                                data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="fas fa-user fa-2x"></i>
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end p-4" style="background-color: unset;
                                        border: 2px solid antiquewhite;" aria-labelledby="dropdownMenuLink">
                                                <li class="d-flex align-items-center flex-column"
                                                    style="min-width: 300px;">

                                                    <!-- lấy ra session bên CustomSuccessHandle -->
                                                    <img style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden;"
                                                        src="/client/img/${sessionScope.avatar}" />
                                                    <div class="text-center my-3 text-warning fs-2">
                                                        <c:out value="${sessionScope.fullName}" />
                                                    </div>

                                                </li>
                                                <li><a class="dropdown-item" href="/order-history">Lịch sử mua hàng</a>
                                                </li>
                                                <li>
                                                    <hr class="dropdown-divider">
                                                </li>
                                                <li>
                                                    <form method="post" action="/logout">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                        <button class="dropdown-item">Đăng xuất</button>
                                                    </form>
                                                </li>
                                            </ul>
                                        </div>
                                    </c:if>

                                    <c:if test="${empty pageContext.request.userPrincipal}">
                                        <a href="/lognin" class="position-relative me-4 my-auto">
                                            Đăng nhập
                                        </a>
                                    </c:if>

                                </div>
                            </div>
                        </nav>
                    </div>

                </div>


                <!-- Single Product Start -->
                <div class="container-fluid">
                    <div class="container">
                        <div class="row g-4 mb-5">
                            <div class="col-lg-8 col-xl-9">
                                <div class="row g-4">
                                    <div class="col-lg-6">
                                        <div class="border rounded">
                                            <a href="#">
                                                <img src="/client/img/${p.image}" class="img-fluid rounded" alt="Image">
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <h4 class="fw-bold mb-3 text-warning">${p.name}</h4>
                                        <p class="mb-3">Vai trò: ${p.target}</p>
                                        <h5 class="fw-bold mb-3 text-warning">
                                            <fmt:formatNumber value="${p.price}" pattern="#,##0" /> RP
                                        </h5>
                                        <div class="d-flex mb-4">
                                            <i class="fa fa-star text-secondary"></i>
                                            <i class="fa fa-star text-secondary"></i>
                                            <i class="fa fa-star text-secondary"></i>
                                            <i class="fa fa-star text-secondary"></i>
                                            <i class="fa fa-star"></i>
                                        </div>
                                        <p class="mb-4">${p.shortDesc}</p>
                                        <p class="mb-4">${p.detailDesc}</p>

                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                </div>

                <!-- Hero Start -->
                <div class="container-fluid mb-5" style="width: 65%;">
                    <div class="container">
                        <div class="row g-5 align-items-center">
                            <div class="col-md-12 col-lg-12">
                                <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
                                    <div class="carousel-inner" role="listbox">
                                        <h1 style="padding-bottom: 10px; color: #f3e1ca;">Trang phục hiện có</h1>
                                        <div class="carousel-item active rounded">
                                            <img src="/client/imgskin/${img.img1}"
                                                class="img-fluid w-100 h-100 bg-secondary rounded" alt="First slide">
                                            <a href="#" class="btn px-4 py-2 text-white rounded" style="position: absolute;
                                                        top: 75%; left: 50%;
                                                        transform: translate(-50%, -50%);font-size: 25px;
                                                       ">
                                                ${img.imgName1}</a>
                                        </div>

                                        <div class="carousel-item rounded">
                                            <img src="/client/imgskin/${img.img2}"
                                                class="img-fluid w-100 h-100 bg-secondary rounded" alt="First slide">
                                            <a href="#" class="btn px-4 py-2 text-white rounded" style="position: absolute;
                                                        top: 75%; left: 50%;
                                                        transform: translate(-50%, -50%);font-size: 25px;
                                                       ">
                                                ${img.imgName2}</a>
                                        </div>

                                        <div class="carousel-item rounded">
                                            <img src="/client/imgskin/${img.img3}"
                                                class="img-fluid w-100 h-100 bg-secondary rounded" alt="First slide">
                                            <a href="#" class="btn px-4 py-2 text-white rounded" style="position: absolute;
                                                        top: 75%; left: 50%;
                                                        transform: translate(-50%, -50%);font-size: 25px;
                                                       ">
                                                ${img.imgName3}</a>
                                        </div>

                                        <div class="carousel-item rounded">
                                            <img src="/client/imgskin/${img.img4}"
                                                class="img-fluid w-100 h-100 bg-secondary rounded" alt="First slide">
                                            <a href="#" class="btn px-4 py-2 text-white rounded" style="position: absolute;
                                                        top: 75%; left: 50%;
                                                        transform: translate(-50%, -50%);font-size: 25px;
                                                       ">
                                                ${img.imgName4}</a>
                                        </div>

                                    </div>
                                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselId"
                                        data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button" data-bs-target="#carouselId"
                                        data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Skill Start -->

                <video autoplay muted loop id="bg-video">
                    <source src="/client/video/templateskill.mp4" type="video/mp4">
                </video>
                <div class="page-container">
                    <!-- Header -->
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="cd-slider-nav">
                                    <nav class="navbar navbar-expand-lg" id="tm-nav">
                                        <a class="navbar-brand" href="#" style="margin-left: 80px;">Kĩ Năng</a>
                                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#navbar-supported-content"
                                            aria-controls="navbarSupportedContent" aria-expanded="false"
                                            aria-label="Toggle navigation">
                                            <span class="navbar-toggler-icon"></span>
                                        </button>
                                        <div class="collapse navbar-collapse" id="navbar-supported-content">
                                            <ul class="navbar-nav mb-2 mb-lg-0">
                                                <li class="nav-item selected">
                                                    <a class="nav-link" aria-current="page" href="#0" data-no="1">Nội
                                                        tại</a>
                                                    <div class="circle"></div>
                                                </li>

                                                <li class="nav-item">
                                                    <a class="nav-link" href="#0" data-no="3">Q</a>
                                                    <div class="circle"></div>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" href="#0" data-no="4">W</a>
                                                    <div class="circle"></div>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" href="#0" data-no="5">E</a>
                                                    <div class="circle"></div>
                                                </li>

                                                <li class="nav-item">
                                                    <a class="nav-link" href="#0" data-no="6">R</a>
                                                    <div class="circle"></div>
                                                </li>
                                            </ul>
                                        </div>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Body -->
                    <div class="container-fluid tm-content-container">
                        <ul class="cd-hero-slider mb-0 py-5">
                            <li class="px-3" data-page-no="1">
                                <div class="page-left">
                                    <div class="d-flex position-relative tm-border-top tm-border-bottom intro-container"
                                        style="justify-content: space-around;">
                                        <div class="intro-left">
                                            <h2 class="mb-4 text-warning">
                                                <img src="/client/imgskill/${i.getIimage()}" alt="Image"
                                                    class="img-fluid intro-img-1"
                                                    style="width: 55px; height: 55px; margin-right: 10px;">
                                                Nội tại: ${i.getIname()}
                                            </h2>
                                            <p class="mb-4 text-warning">
                                                ${i.getIdesc()}
                                            </p>
                                        </div>
                                        <div class="intro-right d-flex" style="border: 3px solid #8b8b7b;"
                                            style="border: 3px solid #8b8b7b;">
                                            <video autoplay muted loop style="width: 425px; height: auto;">
                                                <source src="/client/videoskill/${i.getIvideo()}">
                                            </video>
                                        </div>
                                        <div class="circle intro-circle-1"></div>
                                        <div class="circle intro-circle-2"></div>
                                        <div class="circle intro-circle-3"></div>
                                        <div class="circle intro-circle-4"></div>
                                    </div>
                                </div>
                            </li>

                            <li data-page-no="3" class="px-3">
                                <div class="page-left">
                                    <div class="d-flex position-relative tm-border-top tm-border-bottom intro-container"
                                        style="justify-content: space-around;">
                                        <div class="intro-left">
                                            <h2 class="mb-4 text-warning">
                                                <img src="/client/imgskill/${q.getQimage()}" alt="Image"
                                                    class="img-fluid intro-img-1"
                                                    style="width: 55px; height: 55px; margin-right: 10px;">
                                                Q: ${q.getQname()}
                                            </h2>
                                            <p class="mb-4 text-warning">
                                                ${q.getQdesc()}
                                            </p>
                                        </div>
                                        <div class="intro-right d-flex" style="border: 3px solid #8b8b7b;">
                                            <video autoplay muted loop style="width: 425px; height: auto;">
                                                <source src="/client/videoskill/${q.getQvideo()}">
                                            </video>
                                        </div>
                                        <div class="circle intro-circle-1"></div>
                                        <div class="circle intro-circle-2"></div>
                                        <div class="circle intro-circle-3"></div>
                                        <div class="circle intro-circle-4"></div>
                                    </div>
                                </div>
                            </li>
                            <li data-page-no="4">
                                <div class="page-left">
                                    <div class="d-flex position-relative tm-border-top tm-border-bottom intro-container"
                                        style="justify-content: space-around;">
                                        <div class="intro-left">
                                            <h2 class="mb-4 text-warning">
                                                <img src="/client/imgskill/${w.getWimage()}" alt="Image"
                                                    class="img-fluid intro-img-1"
                                                    style="width: 55px; height: 55px; margin-right: 10px;">
                                                W: ${w.getWname()}
                                            </h2>
                                            <p class="mb-4 text-warning">
                                                ${w.getWdesc()}
                                            </p>
                                        </div>
                                        <div class="intro-right d-flex" style="border: 3px solid #8b8b7b;">
                                            <video autoplay muted loop style="width: 425px; height: auto;">
                                                <source src="/client/videoskill/${w.getWvideo()}">
                                            </video>
                                        </div>
                                        <div class="circle intro-circle-1"></div>
                                        <div class="circle intro-circle-2"></div>
                                        <div class="circle intro-circle-3"></div>
                                        <div class="circle intro-circle-4"></div>
                                    </div>
                                </div>
                            </li>
                            <li data-page-no="5">
                                <div class="page-left">
                                    <div class="d-flex position-relative tm-border-top tm-border-bottom intro-container"
                                        style="justify-content: space-around;">
                                        <div class="intro-left">
                                            <h2 class="mb-4 text-warning">
                                                <img src="/client/imgskill/${e.getEimage()}" alt="Image"
                                                    class="img-fluid intro-img-1"
                                                    style="width: 55px; height: 55px; margin-right: 10px;">
                                                E: ${e.getEname()}
                                            </h2>
                                            <p class="mb-4 text-warning">
                                                ${e.getEdesc()}
                                            </p>
                                        </div>
                                        <div class="intro-right d-flex" style="border: 3px solid #8b8b7b;">
                                            <video autoplay muted loop style="width: 425px; height: auto;">
                                                <source src="/client/videoskill/${e.getEvideo()}">
                                            </video>
                                        </div>
                                        <div class="circle intro-circle-1"></div>
                                        <div class="circle intro-circle-2"></div>
                                        <div class="circle intro-circle-3"></div>
                                        <div class="circle intro-circle-4"></div>
                                    </div>
                                </div>
                            </li>

                            <li data-page-no="6">
                                <div class="page-left">
                                    <div class="d-flex position-relative tm-border-top tm-border-bottom intro-container"
                                        style="justify-content: space-around;">
                                        <div class="intro-left">
                                            <h2 class="mb-4 text-warning">
                                                <img src="/client/imgskill/${r.getRimage()}" alt="Image"
                                                    class="img-fluid intro-img-1"
                                                    style="width: 55px; height: 55px; margin-right: 10px;">
                                                R: ${r.getRname()}
                                            </h2>
                                            <p class="mb-4 text-warning">
                                                ${r.getRdesc()}
                                            </p>
                                        </div>
                                        <div class="intro-right d-flex" style="border: 3px solid #8b8b7b;">
                                            <video autoplay muted loop style="width: 425px; height: auto;">
                                                <source src="/client/videoskill/${r.getRvideo()}">
                                            </video>
                                        </div>
                                        <div class="circle intro-circle-1"></div>
                                        <div class="circle intro-circle-2"></div>
                                        <div class="circle intro-circle-3"></div>
                                        <div class="circle intro-circle-4"></div>
                                    </div>

                                </div>
                            </li>
                        </ul>
                    </div>

                </div>
                <!-- Preloader, https://ihatetomatoes.net/create-custom-preloading-screen/ -->
                <div id="loader-wrapper">
                    <div id="loader"></div>
                    <div class="loader-section section-left"></div>
                    <div class="loader-section section-right"></div>
                </div>
                <script src="/client/js/bootstrap.min.js"></script>
                <script src="/client/js/slick.js"></script>
                <script src="/client/js/jquery-3.5.1.min.js"></script>
                <script src="/client/js/templatemo-script.js"></script>



                <!-- Footer Start -->
                <jsp:include page="../layout/footer.jsp" />
                <!-- Footer End -->

                <!-- Copyright Start -->
                <div class="container-fluid copyright bg-dark py-4">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                                <span class="text-light"><a href="#"><i
                                            class="fas fa-copyright text-light me-2"></i>Your
                                        Site Name</a>, All right reserved.</span>
                            </div>
                            <div class="col-md-6 my-auto text-center text-md-end text-white">
                                <!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
                                <!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
                                <!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
                                Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a>
                                Distributed
                                By <a class="border-bottom" href="https://themewagon.com">ThemeWagon</a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Copyright End -->



                <!-- Back to Top -->
                <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                        class="fa fa-arrow-up"></i></a>


                <!-- JavaScript Libraries -->

                <script src="/client/lib/easing/easing.min.js"></script>
                <script src="/client/lib/waypoints/waypoints.min.js"></script>
                <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                <!-- Template Javascript -->
                <script src="/client/js/main.js"></script>
            </body>

            </html>