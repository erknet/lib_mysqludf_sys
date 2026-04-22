ARG MARIADB_VESION=12.2.2
FROM mariadb:${MARIADB_VESION}

WORKDIR /lib_mysqludf_sys

COPY . .

RUN mkdir -p /build2 && \
    sed -i 's/__WIN__/__NOT_DEFINED__/g' lib_mysqludf_sys.c && \
    apt-get update && apt-get install -y git gcc libmariadbd-dev && \
    gcc -Wall -I/usr/include/mariadb/server -I/usr/include/mariadb -I/usr/include/mariadb/server/private -I. -shared lib_mysqludf_sys.c -o /build2/lib_mariaudf_sys.so && \
    chmod 644 /build2/lib_mariaudf_sys.so

CMD ["cp", "/build2/lib_mariaudf_sys.so", "/build/lib_mariaudf_sys.so"]