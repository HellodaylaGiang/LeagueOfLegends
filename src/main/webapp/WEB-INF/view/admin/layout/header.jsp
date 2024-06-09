<%@page contentType="text/html" pageEncoding="UTF-8" %>

    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <!-- Navbar Brand-->
        <a class="navbar-brand ps-3" href="/admin">League Of Legends</a>

        <!-- Sidebar Toggle-->
        <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i
                class="fas fa-bars"></i></button>

        <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarCollapse">
            <span class="fa fa-bars text-primary"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="navbar-nav mx-auto">
                <a href="/" class="nav-item nav-link active">Home</a>
            </div>

            <div class="navbar-nav mx-auto text-warning">
                <c:out value="${pageContext.request.userPrincipal.name}" />
            </div>
        </div>

        <!-- Navbar-->
        <div class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown"
                aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>

            <div class="dropdown my-auto">
                <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="navbarDropdown">

                    <li class="d-flex align-items-center flex-column" style="min-width: 300px;">
                        <img style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden;"
                            src="/client/img/Azir_0.png" />
                        <div class="text-center my-3">
                            <c:out value="${pageContext.request.userPrincipal.name}" />
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
                </ul>
            </div>
    </nav>