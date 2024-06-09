<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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

                        <!-- Cart Page Start -->
                        <div class="container-fluid py-5" style="margin-top: 390px;">

                            <div class="container py-5">
                                <div class="mb-3">
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="/">Home</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Thông tin thanh toán
                                            </li>
                                        </ol>
                                    </nav>
                                </div>

                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">Champions</th>
                                                <th scope="col">Name</th>
                                                <th scope="col">Price</th>
                                                <th scope="col">Quantity</th>
                                                <th scope="col">Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listCartDetail}" var="c">

                                                <tr>
                                                    <th scope="row">
                                                        <div class="d-flex align-items-center">
                                                            <a href="/client/product/${c.product.id}" target="_blank">
                                                                <img src="/client/img/${c.product.image}"
                                                                    class="img-fluid me-5"
                                                                    style="width: auto; height: 80px; border-radius: 10px;"
                                                                    alt="">
                                                            </a>
                                                        </div>
                                                    </th>
                                                    <td>
                                                        <p class="mb-0 mt-4 text-danger">${c.product.name}</p>
                                                    </td>
                                                    <td>
                                                        <p class="mb-0 mt-4">
                                                            <fmt:formatNumber value="${c.price}" pattern="#,##0" />
                                                            RP
                                                        </p>
                                                    </td>
                                                    <td>
                                                        <div class="input-group quantity mt-4" style="width: 100px;">

                                                            <input type="text"
                                                                class="form-control form-control-sm text-center border-0"
                                                                value="${c.quantity}" data-cart-detail-id="${c.id}"
                                                                data-cart-detail-price="${c.price}"
                                                                data-cart-detail-index="${status.index}">

                                                        </div>
                                                    </td>
                                                    <td style="width: 150px;">
                                                        <p class="mb-0 mt-4" data-cart-detail-id="${c.id}">
                                                            <fmt:formatNumber value="${c.quantity*c.price}"
                                                                pattern="#,##0" /> RP
                                                        </p>
                                                    </td>

                                                </tr>

                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <c:if test="${!not empty cartDetails}">
                                    <form:form action="/place-order" method="post" modelAttribute="cart">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <div class="mt-5 row g-4 justify-content-start">
                                            <div class="col-12 col-md-6">
                                                <div class="p-4 ">
                                                    <h5>Thông Tin Người Nhận
                                                    </h5>
                                                    <div class="row">
                                                        <div class="col-12 form-group mb-3">
                                                            <label>Tên người nhận</label>
                                                            <input class="form-control" name="receiverName" required />
                                                        </div>
                                                        <div class="col-12 form-group mb-3">
                                                            <label>Địa chỉ người nhận</label>
                                                            <input class="form-control" name="receiverAddress"
                                                                required />
                                                        </div>
                                                        <div class="col-12 form-group mb-3">
                                                            <label>Số điện thoại</label>
                                                            <input class="form-control" name="receiverPhone" required />
                                                        </div>
                                                        <div class="mt-4">
                                                            <i class="fas fa-arrow-left"></i>
                                                            <a href="/cart">Quay lại giỏ hàng</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <div class="bg-light rounded">
                                                    <div class="p-4">
                                                        <h1 class="display-6 mb-4">Thông Tin <span
                                                                class="fw-normal">Thanh
                                                                Toán</span>
                                                        </h1>

                                                        <div class="d-flex justify-content-between">
                                                            <h5 class="mb-0 me-4">Phí vận chuyển</h5>
                                                            <div class="">
                                                                <p class="mb-0">0 đ</p>
                                                            </div>
                                                        </div>
                                                        <div class="mt-3 d-flex justify-content-between">

                                                        </div>
                                                    </div>
                                                    <div
                                                        class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                                        <h5 class="mb-0 ps-4 me-4">Tổng số tiền</h5>
                                                        <p class="mb-0 pe-4" data-cart-total-price="${totalPrice}">
                                                            <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                                        </p>
                                                    </div>

                                                    <button
                                                        class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4">
                                                        Xác nhận thanh toán
                                                    </button>

                                                </div>
                                            </div>
                                        </div>
                                    </form:form>
                                </c:if>

                            </div>


                        </div>
                        <!-- Cart Page End -->


                        <!-- Footer Start -->
                        <jsp:include page="../layout/footer.jsp" />
                        <!-- Footer End -->


                        <!-- JavaScript Libraries -->
                        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
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
                        </style>
                </body>

                </html>