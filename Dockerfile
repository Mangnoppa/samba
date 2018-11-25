# modified version of dperson/samba
FROM alpine
MAINTAINER Kevin Schneider <mangnoppa@googlemail.com>

# Install samba
RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add bash samba shadow tini && \
    adduser -D -G users -H -S -g 'Samba User' -h /tmp smbuser && \
    rm -rf /tmp/*

COPY additional_files/samba.sh /usr/bin/
COPY additional_files/smb.conf /etc/samba/smb.conf

EXPOSE 137/udp 138/udp 139 445

HEALTHCHECK --interval=60s --timeout=15s \
             CMD smbclient -L '\\localhost' -U '%' -m SMB3

VOLUME ["/etc/samba"]

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/samba.sh"]

# adduser --help
# Usage: adduser [OPTIONS] USER [GROUP]
#	-h DIR		Home directory
#	-g GECOS	GECOS field
#	-s SHELL	Login shell
#	-G GRP		Group
#	-S		Create a system user
#	-D		Don't assign a password
#	-H		Don't create home directory
#	-u UID		User id
#	-k SKEL		Skeleton directory (/etc/skel)
