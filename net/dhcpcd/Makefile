COMMENT=	DHCPv4/IPv4LL/IPv6RS/DHCPv6 quad stack client

#V=		10.0.1
#DISTNAME=	dhcpcd-$V
#EXTRACT_SUFX=	.tar.xz

GH_ACCOUNT=	NetworkConfiguration
GH_PROJECT=	dhcpcd
GH_COMMIT=	6a369c6d7bb48c8747717ea6e92bd05a2cc96391
DISTNAME=	dhcpcd-10.0.1pl20230518

EPOCH=		0

CATEGORIES=	net

HOMEPAGE=	https://roy.marples.name/projects/dhcpcd
#MASTER_SITES=	https://github.com/NetworkConfiguration/dhcpcd/releases/download/v$V/

# BSD-2
PERMIT_PACKAGE=	Yes

# uses pledge()
WANTLIB += c

MAINTAINER=	Stuart Henderson <stu.ports@spacehopper.org>

CONFIGURE_STYLE= simple
CONFIGURE_ARGS=	--enable-privsep \
		--privsepuser=_dhcpcd \
		--prefix='${PREFIX}' \
		--sysconfdir='${SYSCONFDIR}' \
		--mandir='${PREFIX}/man' \
		--localstatedir='${LOCALSTATEDIR}'
FAKE_FLAGS=	SYSCONFDIR=${PREFIX}/share/examples/dhcpcd

.include <bsd.port.mk>
