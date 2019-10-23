FROM registry.redhat.io/rhel8/nodejs-10 as builder
 
USER root
 
ENV NG_CLI_ANALYTICS=ci
COPY . webapp
RUN cd webapp && \
    npm install && \
    node_modules/@angular/cli/bin/ng build --output-path dist --prod
 
 
FROM registry.redhat.io/rhel8/nginx-114
COPY --from=builder /opt/app-root/src/webapp/dist .
CMD ["/bin/sh", "-c", "$STI_SCRIPTS_PATH/run"]