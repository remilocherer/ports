GH_ACCOUNT =	google
GH_PROJECT =	boringssl
GH_COMMIT =	b92fcfdc17f3ad794c220a86f4ae6695d0a0fb61
DISTNAME =	boringssl-20230512
REVISION =	0

MASTER_SITES0 =	https://proxy.golang.org/

DISTFILES +=	${GH_DISTFILE}
# can't use GH_DISTFILE because EXTRACT_ONLY does not understand DISTFILES {}
EXTRACT_ONLY =	${DISTNAME}-${GH_COMMIT:C/(........).*/\1/}${EXTRACT_SUFX}

BORING_GOMOD +=	golang.org/x/crypto	v0.6.0
BORING_GOMOD +=	golang.org/x/net	v0.7.0
BORING_GOMOD +=	golang.org/x/sys	v0.5.0
BORING_GOMOD +=	golang.org/x/term	v0.5.0

.for _modpath _modver in ${BORING_GOMOD}
DISTFILES +=	go_modules/{}${_modpath}/@v/${_modver}.zip:0
DISTFILES +=	go_modules/{}${_modpath}/@v/${_modver}.mod:0
.endfor

WANTLIB += ${COMPILER_LIBCXX} c m

# C++14
COMPILER =		base-clang ports-gcc

MODULES =		devel/cmake
CONFIGURE_ARGS +=	-DCMAKE_INSTALL_PREFIX=${PREFIX}/eboringssl

BUILD_DEPENDS =		lang/go

TEST_ENV =		GOPROXY=file://${DISTDIR}/go_modules

FIX_CLEANUP_PERMISSIONS =	Yes

do-test:
	${SETENV} ${ALL_TEST_ENV} ninja -C ${WRKBUILD} -j ${MAKE_JOBS} run_tests

.include <bsd.port.mk>
