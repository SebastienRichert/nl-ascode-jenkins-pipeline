FROM jenkins/jnlp-slave
USER root
COPY neoload_6_9_0_linux_x64.sh /tmp/nl.sh
RUN chmod a+x /tmp/nl.sh
RUN /tmp/nl.sh -q -dir /home/neoload/neoload -Vsys.installationTypeId=Controller -Vsys.component.Common\$Boolean=true -Vsys.component.Controller\$Boolean=true
