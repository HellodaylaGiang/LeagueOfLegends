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
            </head>

            <body>

                <!-- Navbar start -->
                <%@ include file="../layout/header.jsp" %>
                    <!-- Navbar End -->
                    <div style="margin-top: 400px;">
                        <h2 style="line-height: 100px; text-align: center; height: 100%;">Lịch sử mua hàng
                        </h2>
                    </div>

                    <!-- Champion Start-->

                    <c:if test="${empty orders}">
                        <h1 style="text-align: center;">Bạn chưa có đơn hàng lào!!</h1>
                        <div class="container-fluid  mt-100">
                            <div class="row">

                                <div class="col-md-12">

                                    <div class="card">
                                        <div class="card-body cart">
                                            <div class="col-sm-12 empty-cart-cls text-center">
                                                <img src="https://i.imgur.com/dCdflKN.png" width="130" height="130"
                                                    class="img-fluid mb-4 mr-3">
                                                <h4>Đặt hàng ngay thôi nào !!</h4>
                                            </div>
                                        </div>
                                    </div>


                                </div>

                            </div>

                        </div>
                    </c:if>

                    <c:if test="${not empty orders}">
                        <div class="container py-5">
                            <div class="table-responsive">

                                <c:forEach items="${orders}" var="o">
                                    <tr>
                                        <div
                                            style="display: flex; justify-content: center; margin-top: 40px; color: brown;">
                                            <p>Order Id: ${o.id}</p>
                                            <p> Tổng tiền:
                                                <fmt:formatNumber value="${o.totalPrice}" pattern="#,##0" />
                                                RP
                                            </p>

                                            <p>Số lượng:
                                                <c:set var="a" value="0" />
                                                <c:forEach items="${o.orderDetails}" var="od">
                                                    <c:set var="a" value="${a + od.quantity}" />
                                                </c:forEach>
                                                ${a}
                                            </p>
                                            </p>
                                            <p>Trạng thái: ${o.status}</p>
                                        </div>
                                    </tr>

                                    <tr>
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Image</th>
                                                    <th scope="col">Tên</th>
                                                    <th scope="col">Gía cả</th>
                                                    <th scope="col">Số lượng</th>
                                                    <th scope="col">Thành tiền</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${o.orderDetails}" var="od">

                                                    <tr>

                                                        <th scope="row">
                                                            <div class="d-flex align-items-center">
                                                                <a href="/client/product/${od.product.id}"
                                                                    target="_blank">
                                                                    <img src="/client/img/${od.product.image}"
                                                                        class="img-fluid me-5"
                                                                        style="width: auto; height: 80px; border-radius: 10px;"
                                                                        alt="">
                                                                </a>
                                                            </div>
                                                        </th>

                                                        <td>
                                                            <p class="mb-0 mt-4 text-danger">${od.product.name}</p>
                                                        </td>
                                                        <td style="width: 150px;">
                                                            <p class="mb-0 mt-4">
                                                                <fmt:formatNumber value="${od.price}" pattern="#,##0" />
                                                                RP
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <p class="mb-0 mt-4 text-danger">${od.quantity}</p>
                                                        </td>
                                                        <td>
                                                            <p class="mb-0 mt-4 text-danger">${od.quantity*od.price}
                                                            </p>
                                                        </td>
                                                    </tr>

                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </tr>

                                </c:forEach>
                                </tbody>
                            </div>
                        </div>
                    </c:if>

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

                    <style>
                        .img-fluid.me-5:hover {
                            scale: 1.05;
                            transition: 0.2s;
                        }

                        div p {
                            padding: 0 15px;
                        }
                    </style>
            </body>

            </html>