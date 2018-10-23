#!/bin/sh



if [ $# -eq 0 ]; then
	
	# default values from alpine init.d
	RRDCACHED_PID=${RRDCACHED_PID:-"/run/rrdcached/rrdcached.pid"}
	RRDCACHED_SOCKET=${RRDCACHED_SOCKET:-"unix:/run/rrdcached/rrdcached.sock"}
	RRDCACHED_JOURNAL=${RRDCACHED_JOURNAL:-"/var/lib/rrdcached/journal/"}
	RRDCACHED_DB=${RRDCACHED_DB:-"/var/lib/rrdcached/db/"}
	RDDCACHED_FORCE_FLUSH=true

	# default for container
	RDDCACHED_GID="rrdcached"
	RDDCACHED_UID="rrdcached"
	RRDCACHED_FOREGROUND=true
	RRDCACHED_LISTEN_ALL=true

	# -a <size>     Memory allocation chunk size. Default is 1.
	RRDCACHED_CHUNK_SIZE=${RRDCACHED_CHUNK_SIZE:+"-a ${RRDCACHED_CHUNK_SIZE}"}

	# -B            Restrict file access to paths within -b <dir>
	RRDCACHED_RESTRICT_DIR=${RRDCACHED_RESTRICT_DIR:+"-B"}

	# -b <dir>      Base directory to change to.
	RRDCACHED_DB=${RRDCACHED_DB:+"-b ${RRDCACHED_DB}"}

	# -F            Always flush all updates at shutdown
	RDDCACHED_FORCE_FLUSH=${RDDCACHED_FORCE_FLUSH:+"-F"}

	# -f <seconds>  Interval in which to flush dead data.
	RRDCACHED_FLUSH_TIMEOUT=${RRDCACHED_FLUSH_TIMEOUT:+"-f ${RRDCACHED_FLUSH_TIMEOUT}"}

	# -G <group>    Unprivileged group used when running.
	RDDCACHED_GID=${RDDCACHED_GID:+"-G ${RDDCACHED_GID}"}

	# -g            Do not fork and run in the foreground.
	RRDCACHED_FOREGROUND=${RRDCACHED_FOREGROUND:+"-g"}

	# -j <dir>      Directory in which to create the journal files.
	RRDCACHED_JOURNAL=${RRDCACHED_JOURNAL:+"-j ${RRDCACHED_JOURNAL}"}

	# -L            Open sockets on all INET interfaces using default port.
	RRDCACHED_LISTEN_ALL=${RRDCACHED_LISTEN_ALL:+"-L"}

	# -l <address>  Socket address to listen to.
	#               Default: unix:/tmp/rrdcached.sock
	RRDCACHED_SOCKET=${RRDCACHED_SOCKET:+"-l ${RRDCACHED_SOCKET}"}

	# -m <mode>     File permissions (octal) of all following UNIX sockets
	RRDCACHED_MASK=${RRDCACHED_MASK:+"-m ${RRDCACHED_MASK}"}

	# -O            Do not allow CREATE commands to overwrite existing
	#               files, even if asked to.
	RRDCACHED_NO_OVERWRITE=${RRDCACHED_NO_OVERWRITE:+"-O"}

	# -P <perms>    Sets the permissions to assign to all following sockets
	RRDCACHED_PERMS=${RRDCACHED_PERMS:+"-P ${RRDCACHED_PERMS}"}

	# -p <file>     Location of the PID-file.
	RRDCACHED_PID=${RRDCACHED_PID:+"-p ${RRDCACHED_PID}"}

	# -R            Allow recursive directory creation within -b <dir>
	RRDCACHED_ALLOW_RECURSIVE=${RRDCACHED_ALLOW_RECURSIVE:+"-R"}

	# -s <id|name>  Group owner of all following UNIX sockets
	#               (the socket will also have read/write permissions for that group)
	RRDCACHED_GROUP_OWNER=${RRDCACHED_GROUP_OWNER:+"-s ${RRDCACHED_GROUP_OWNER}"}

	# -t <threads>  Number of write threads.
	RRDCACHED_THREADS=${RRDCACHED_THREADS:+"-t ${RRDCACHED_THREADS}"}

	# -U <user>     Unprivileged user account used when running.
	RRDCACHED_UID=${RRDCACHED_UID:+"-U ${RRDCACHED_UID}"}

	# -V <LOGLEVEL> Max syslog level to log with, with LOG_DEBUG being
	#               the maximum and LOG_EMERG minimum; see syslog.h
	RRDCACHED_LOGLEVEL=${RRDCACHED_LOGLEVEL:+"-V ${RRDCACHED_LOGLEVEL}"}

	# -w <seconds>  Interval in which to write data.
	RRDCACHED_WRITE_TIMEOUT=${RRDCACHED_WRITE_TIMEOUT:+"-w ${RRDCACHED_WRITE_TIMEOUT}"}

	# -z <delay>    Delay writes up to <delay> seconds to spread load
	RRDCACHED_JITTER=${RRDCACHED_JITTER:+"-z ${RRDCACHED_JITTER}"}

	CMD="/usr/sbin/rrdcached \
		${RRDCACHED_PID} \
		${RRDCACHED_UID} \
		${RRDCACHED_GID} \
		${RRDCACHED_FOREGROUND} \
		${RRDCACHED_JOURNAL} \
		${RRDCACHED_FLUSH_TIMEOUT} \
		${RDDCACHED_FORCE_FLUSH} \
		${RRDCACHED_DB} \
		${RRDCACHED_RESTRICT_DIR} \
		${RRDCACHED_ALLOW_RECURSIVE} \
		${RRDCACHED_WRITE_TIMEOUT} \
		${RRDCACHED_JITTER} \
		${RRDCACHED_CHUNK_SIZE} \
		${RRDCACHED_LISTEN_ALL} \
		${RRDCACHED_NO_OVERWRITE} \
		${RRDCACHED_THREADS} \
		${RRDCACHED_LOGLEVEL} \
		${RRDCACHED_PERMS} \
		${RRDCACHED_GROUP_OWNER} \
		${RRDCACHED_MASK} \
		${RRDCACHED_SOCKET} \
	"
else
	CMD="$@"
fi

echo "${CMD}"

exec ${CMD}
