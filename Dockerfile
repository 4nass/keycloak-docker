FROM quay.io/keycloak/keycloak:12.0.4

WORKDIR /opt/jboss/keycloak/standalone/configuration

# IMPORT CA Certs in the Truststore
COPY certs .
USER root
RUN echo import BaltimoreCyberTrustRoot && \
	keytool -v -importcert -alias BaltimoreCyberTrustRoot -file BaltimoreCyberTrustRoot-2025.crt -keystore truststore.jks -trustcacerts -storepass password -noprompt && \
	echo import USERTrust-RSA-Certification-Authority && \
	keytool -v -importcert -alias USERTrust-RSA-Certification-Authority -file USERTrust-RSA-Certification-Authority-2038.crt -keystore truststore.jks -trustcacerts -storepass password -noprompt && \ 
	echo import Sectigo && \
	keytool -v -importcert -alias Sectigo -file Sectigo-2038.crt -keystore truststore.jks -trustcacerts -storepass password -noprompt && \
	echo import DigiCert-Global-Root-CA && \
	keytool -v -importcert -alias DigiCert-Global-Root-CA -file DigiCert-Global-Root-CA-2031.crt -keystore truststore.jks -trustcacerts -storepass password -noprompt && \
	echo import DigiCert-Global-Root-G2 && \
	keytool -v -importcert -alias DigiCert-Global-Root-G2 -file DigiCert-Global-Root-G2-2038.crt -keystore truststore.jks -trustcacerts -storepass password -noprompt && \ 
	echo import DST-Root-CA-X3 && \
	keytool -v -importcert -alias DST-Root-CA-X3 -file DST-Root-CA-X3-2021.crt -keystore truststore.jks -trustcacerts -storepass password -noprompt && \
	echo import GlobalSign-Root-CA-R1 && \
	keytool -v -importcert -alias GlobalSign-Root-CA-R1 -file GlobalSign-Root-CA-R1-2028.crt -keystore truststore.jks -trustcacerts -storepass password -noprompt && \
	echo import GlobalSign-Root-CA-R2 && \
	keytool -v -importcert -alias GlobalSign-Root-CA-R2 -file GlobalSign-Root-CA-R2-2021.crt -keystore truststore.jks -trustcacerts -storepass password -noprompt && \
	echo import GlobalSign-Root-CA-R3 && \
	keytool -v -importcert -alias GlobalSign-Root-CA-R3 -file GlobalSign-Root-CA-R3-2029.crt -keystore truststore.jks -trustcacerts -storepass password -noprompt && \
	echo import CAIntermediaire.GlobalSign && \
	keytool -v -importcert -alias CAIntermediaire.GlobalSign -file CAIntermediaire.GlobalSign-2024.crt -keystore truststore.jks -trustcacerts -storepass password -noprompt 

USER jboss
WORKDIR /opt/jboss/keycloak/

# DEPLOY Keycloak Extensions
COPY /extensions/*.*ar standalone/deployments/
RUN true
