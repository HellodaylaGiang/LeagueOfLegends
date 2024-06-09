<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8">
                <title>League Of Legends</title>
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


                <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
                    rel="stylesheet">

                <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">

            </head>

            <body data-aos="zoom-out">

                <!-- Navbar start -->
                <%@ include file="../layout/header.jsp" %>


                    <!-- Champion Start-->
                    <div class="container-fluid fruite py-5" style="background-color: #032b2b;">
                        <div class="container py-5" style="margin-top: 340px;">
                            <div class="tab-class text-center">
                                <div class="row g-4">
                                    <div class="col-lg-4 text-start">
                                        <h1>Champion</h1>
                                    </div>
                                    <div class="col-lg-8 text-end">
                                        <ul class="nav nav-pills d-inline-flex text-center mb-5">
                                            <li class="nav-item">
                                                <a href="/client-show-all-champion"
                                                    class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                        class="fa fa-home me-2 text-primary"></i>
                                                    All Champions
                                                </a>

                                                <a href="/"
                                                    class="btn border border-secondary rounded-pill px-3 text-primary">
                                                    <i class="fa fa-book me-2 text-primary"></i>
                                                    Pagination
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="tab-content">
                                    <div id="tab-1" class="tab-pane fade show p-0 active">
                                        <div class="row g-4">
                                            <div class="col-lg-12">
                                                <div class="row g-4">
                                                    <c:forEach items="${listProduct}" var="p">

                                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                                            <div class="rounded position-relative fruite-item">
                                                                <div class="fruite-img">
                                                                    <a href="/client/product/${p.id}" target="_blank">
                                                                        <img src="/client/img/${p.image}"
                                                                            class="img-fluid w-100 rounded-top" alt="">
                                                                    </a>
                                                                </div>
                                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                                    style="top: 10px; left: 10px;">${p.factory}</div>
                                                                <div
                                                                    class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                                    <h4 class="text-warning">${p.name}</h4>
                                                                    <p>${p.shortDesc}</p>
                                                                    <p
                                                                        style="color: #dd0785; font-size: 20px;font-weight: 600;">
                                                                        <fmt:formatNumber value="${p.price}"
                                                                            pattern="#,##0" /> RP
                                                                    </p>

                                                                    <div
                                                                        class="d-flex justify-content-between flex-lg-wrap">
                                                                        <p class="text-dark fs-5 fw-bold mb-0">
                                                                            ${p.target}
                                                                        </p>

                                                                        <form action="/add-product-to-card/${p.id}"
                                                                            method="post">
                                                                            <input type="hidden"
                                                                                name="${_csrf.parameterName}"
                                                                                value="${_csrf.token}" />

                                                                            <button
                                                                                class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                                    class="fa fa-shopping-bag me-2 text-primary"></i>
                                                                                Add to cart
                                                                            </button>
                                                                        </form>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </c:forEach>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- nav paginaion -->
                                <c:if test="${totalPages > 0}">

                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination justify-content-center d-flex" style="margin-top: 25px;">

                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="?page=${currentPage-1}"
                                                    aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                            <c:forEach begin="1" end="${totalPages}" varStatus="loop">

                                                <li class="page-item ${loop.index == currentPage ? 'active' : ''}">
                                                    <a class="page-link " href="?page=${loop.index}">${loop.index}
                                                    </a>
                                                </li>

                                            </c:forEach>
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="?page=${currentPage+1}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>

                                        </ul>
                                    </nav>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <!-- Champion End-->


                    <!-- Footer Start -->
                    <jsp:include page="../layout/footer.jsp" />
                    <!-- Footer End -->

                    <!-- Back to Top -->
                    <a href="top" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                            class="fa fa-arrow-up"></i></a>


                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                    <!-- Template Javascript -->
                    <script src="/client/js/main.js"></script>

                    <!-- AOS JS -->
                    <script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
                    <script>
                        // Khởi tạo AOS
                        AOS.init({
                            duration: 1200, // Thời gian hiệu ứng
                        });
                    </script>

            </body>

            </html>