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

                            <c:if test="${empty listCartDetail}">
                                <h1 style="text-align: center;">Giỏ hàng chưa có sản phẩm nào</h1>
                                <div class="container-fluid  mt-100">
                                    <div class="row">

                                        <div class="col-md-12">

                                            <div class="card">
                                                <div class="card-body cart">
                                                    <div class="col-sm-12 empty-cart-cls text-center">
                                                        <img src="https://i.imgur.com/dCdflKN.png" width="130"
                                                            height="130" class="img-fluid mb-4 mr-3">
                                                        <h3><strong>Your Cart is Empty</strong></h3>
                                                    </div>
                                                </div>
                                            </div>


                                        </div>

                                    </div>

                                </div>
                            </c:if>

                            <c:if test="${not empty listCartDetail}">
                                <h1 style="text-align: center;">Cart</h1>
                                <div class="container py-5">
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Champions</th>
                                                    <th scope="col">Name</th>
                                                    <th scope="col">Price</th>
                                                    <th scope="col">Quantity</th>
                                                    <th scope="col">Total</th>
                                                    <th scope="col">Handle</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${listCartDetail}" var="c" varStatus="status">

                                                    <tr>
                                                        <th scope="row">
                                                            <div class="d-flex align-items-center">
                                                                <a href="/client/product/${c.product.id}"
                                                                    target="_blank">
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

                                                            <div class="input-group quantity mt-4"
                                                                style="width: 100px;">
                                                                <div class="input-group-btn">
                                                                    <button
                                                                        class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                                        <i class="fa fa-minus"></i>
                                                                    </button>
                                                                </div>
                                                                <input type="text"
                                                                    class="form-control form-control-sm text-center border-0"
                                                                    value="${c.quantity}" data-cart-detail-id="${c.id}"
                                                                    data-cart-detail-price="${c.price}"
                                                                    data-cart-detail-index="${status.index}">
                                                                <div class="input-group-btn">
                                                                    <button
                                                                        class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                                        <i class="fa fa-plus"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td style="width: 150px;">
                                                            <p class="mb-0 mt-4" data-cart-detail-id="${c.id}">
                                                                <fmt:formatNumber value="${c.quantity*c.price}"
                                                                    pattern="#,##0" /> RP
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <a href="/cart/delete/${c.id}"
                                                                class="btn btn-md rounded-circle bg-light border mt-4">
                                                                <i class="fa fa-times text-danger"></i>
                                                            </a>
                                                        </td>
                                                    </tr>

                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <div class="row g-4 justify-content-end">
                                        <div class="col-8"></div>
                                        <div class="col-sm-8 col-md-7 col-lg-6 col-xl-4">
                                            <div class="bg-light rounded">
                                                <div class="p-4">
                                                    <h1 class="display-6 mb-4">Thông tin đơn hàng
                                                    </h1>
                                                    <div class="d-flex justify-content-between mb-4">
                                                        <h5 class="mb-0 me-4">Tạm tính:</h5>
                                                        <p data-cart-total-price="${totalPrice}">
                                                            <fmt:formatNumber value="${totalPrice}" pattern="#,##0" />
                                                            RP
                                                        </p>
                                                    </div>
                                                    <div class="d-flex justify-content-between">

                                                    </div>
                                                    <div
                                                        class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                                        <h5 class="mb-0 ps-4 me-4">Tổng tiền</h5>
                                                        <p class="mb-0 pe-4" data-cart-total-price="${totalPrice}">
                                                            <fmt:formatNumber value="${totalPrice}" pattern="#,##0" />
                                                            RP
                                                        </p>
                                                    </div>

                                                    <form:form action="/confirm-checkout" method="post"
                                                        modelAttribute="cart">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                        <div style="display: none;">
                                                            <c:forEach var="cartDetail" items="${cart.cartDetails}"
                                                                varStatus="status">
                                                                <div class="mb-3">
                                                                    <div class="form-group">
                                                                        <label>Id:</label>
                                                                        <form:input class="form-control" type="text"
                                                                            value="${cartDetail.id}"
                                                                            path="cartDetails[${status.index}].id" />
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label>Quantity:</label>
                                                                        <form:input class="form-control" type="text"
                                                                            value="${cartDetail.quantity}"
                                                                            path="cartDetails[${status.index}].quantity" />
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                        <button
                                                            class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4">Xác
                                                            nhận thanh toán
                                                        </button>
                                                    </form:form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                            </c:if>


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