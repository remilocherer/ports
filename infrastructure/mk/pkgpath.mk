# $OpenBSD: pkgpath.mk,v 1.12 2006/12/26 15:00:24 espie Exp $
# ex:ts=4 sw=4 filetype=make:
#	pkgpath.mk - 2003 Marc Espie
#	This file is in the public domain.

# definitions common to bsd.port.mk and bsd.port.subdir.mk

PORTSDIR_PATH ?= ${PORTSDIR}:${PORTSDIR}/mystuff
TMPDIR ?= /tmp
READMES_TOP ?= ${PORTSDIR}


.if !defined(PKGPATH)
PKGPATH != PORTSDIR_PATH=${PORTSDIR_PATH} \
	perl ${PORTSDIR}/infrastructure/mk/getpkgpath ${.CURDIR}
.endif
.if empty(PKGPATH)
PKGDEPTH =
.else
PKGDEPTH = ${PKGPATH:C|[^./][^/]*|..|g}/
.endif

# Code to invoke to split dir,-multi,flavor

_flavor_fragment = \
	unset FLAVOR SUBPACKAGE || true; \
	multi=''; flavor=''; space=''; sawflavor=false; \
	case "$$subdir" in \
	"") \
		echo 1>&2 ">> Broken dependency: empty directory $$extra_msg"; \
		exit 1;; \
	*,*) \
		IFS=,; first=true; \
		for i in $$subdir; do \
			if $$first; then \
				dir=$$i; first=false; \
			else \
				case X"$$i" in \
					X-*) \
						multi="$$i";; \
					*) \
						sawflavor=true; \
						flavor="$$flavor$$space$$i"; \
						space=' ';; \
				esac \
			fi; \
		done; \
		unset IFS;; \
	*) \
		dir=$$subdir;; \
	esac; \
	toset="PKGPATH=$$dir"; \
	case X$$multi in "X");; *) \
		toset="$$toset SUBPACKAGE=\"$$multi\"";; \
	esac; \
	if $$sawflavor; then \
		toset="$$toset FLAVOR=\"$$flavor\""; \
	fi; \
	IFS=:; found_dir=false; bases=${PORTSDIR_PATH}; \
	for base in $$bases; do \
	    cd $$base 2>/dev/null || continue; \
	    if [ -L $$dir ]; then \
		    echo 1>&2 ">> Broken dependency: $$base/$$dir is a symbolic link $$extra_msg"; \
		    exit 1; \
	    fi; \
	    if cd $$dir 2>/dev/null; then \
	    	found_dir=true; \
		break; \
	    fi; \
	done; unset IFS; \
	if ! $$found_dir; then \
	    echo 1>&2 ">> Broken dependency: $$dir non existent $$extra_msg"; \
	    exit 1; \
	fi

_depfile_fragment = \
	case X$${_DEPENDS_FILE} in \
		X) _DEPENDS_FILE=`mktemp /tmp/depends.XXXXXXXXX|| exit 1`; \
		export _DEPENDS_FILE; \
		trap "rm -f $${_DEPENDS_FILE}" 0 1 2 3 13 15;; \
	esac

HTMLIFY =	sed -e 's/&/\&amp;/g' -e 's/>/\&gt;/g' -e 's/</\&lt;/g'


REPORT_PROBLEM_LOGFILE ?=
.if !empty(REPORT_PROBLEM_LOGFILE)
REPORT_PROBLEM ?= echo "$$subdir ($@)">>${REPORT_PROBLEM_LOGFILE}
.else
REPORT_PROBLEM ?= exit 1
.endif

