<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />

    <div id="top" class="container-fluid" style="position: relative; padding: 0;">
        <video width="500" height="500" autoplay muted loop style="position: absolute; object-fit: cover; width: 100%;">
            <source src="/client/video/video.mp4">
        </video>
        <div class="container px-0" style="position: relative;">
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
                        <a href="/" class="nav-item nav-link active" style="font-size: 20px;">Home</a>
                        <a href="/admin" class="nav-item nav-link " style="font-size: 20px;">Admin</a>
                        <a href="/products" class="nav-item nav-link " style="font-size: 20px;">Filter Champion</a>
                    </div>
                    <div class="d-flex m-3 me-0">

                        <c:if test="${not empty pageContext.request.userPrincipal}">
                            <a href="/cart" class="position-relative me-4 my-auto; color: aquamarine;">
                                <i class="fa fa-shopping-bag fa-2x"></i>
                                <span
                                    class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                    style="top: -5px; left: 15px; height: 20px; min-width: 20px;" id="sumCart">
                                    ${sessionScope.sum}</span>
                            </a>
                            <div class="dropdown my-auto">
                                <a href="#" class="dropdown" role=" button" id="dropdownMenuLink"
                                    data-bs-toggle="dropdown" aria-expanded="false" data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                    <i class="fas fa-user fa-2x"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="dropdownMenuLink">
                                    <li class="d-flex align-items-center flex-column" style="min-width: 300px;">

                                        <!-- lấy ra session bên CustomSuccessHandle -->
                                        <img style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden;"
                                            src="/client/img/${sessionScope.avatar}" />
                                        <div class="text-center my-3 text-warning fs-2">
                                            <c:out value="${sessionScope.fullName}" />
                                        </div>

                                    </li>
                                    <li><a class="dropdown-item" href="/order-history">Lịch sử mua hàng</a></li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    <li>
                                        <form method="post" action="/logout">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <button class="dropdown-item">Đăng xuất</button>
                                        </form>
                                    </li>
                                </ul>
                            </div>
                        </c:if>

                        <c:if test="${empty pageContext.request.userPrincipal}">
                            <a href="/login" class="a-login position-relative me-4 my-auto">
                                Đăng nhập
                            </a>
                        </c:if>
                    </div>
                </div>
            </nav>
        </div>

    </div>