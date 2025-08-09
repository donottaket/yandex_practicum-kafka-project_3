FROM grafana/grafana:10.4.3
RUN grafana-cli plugins install grafana-piechart-panel
COPY ./config.ini /etc/grafana/grafana.ini
COPY ./provisioning/datasources /etc/grafana/provisioning/datasources
COPY ./provisioning/dashboards  /etc/grafana/provisioning/dashboards
COPY ./dashboards               /var/lib/grafana/dashboards