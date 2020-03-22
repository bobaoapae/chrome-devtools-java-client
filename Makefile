MVN=mvn
RM=rm
JAVA=java
CP=cp
RUN_JAR=$(JAVA) -jar

PROTOCOL_PARSER_DIR=cdt-protocol-parser
JAVA_PROTOCOL_BUILDER_DIR=cdt-java-protocol-builder
JAVA_PROTOCOL_BUILDER_JAR="$(JAVA_PROTOCOL_BUILDER_DIR)/target/cdt-java-protocol-builder.jar"
PROTOCOL_PARSER=cdt-protocol-parser

JAVA_CLIENT_DIR=cdt-java-client
JAVA_CLIENT_PACKAGE=com/github/kklisura/cdt/protocol

PACKAGE_NAME=com.github.kklisura.cdt.protocol
JS_PROTOCOL_JSON_FILE=./js_protocol.json
BROWSER_PROTOCOL_JSON_FILE=./browser_protocol.json

EXAMPLES_DIR=cdt-examples

install-cdt-java-protocol-parser:
	# Building and install cdt-protocol-parser project...
	$(CP) $(JS_PROTOCOL_JSON_FILE) "./$(PROTOCOL_PARSER)/src/test/resources/js_protocol.json"
	$(CP) $(BROWSER_PROTOCOL_JSON_FILE) "./$(PROTOCOL_PARSER)/src/test/resources/browser_protocol.json"
	$(MVN) --file "$(PROTOCOL_PARSER_DIR)/" clean install

build-cdt-java-protocol-builder: install-cdt-java-protocol-parser
	# Building cdt-java-protocol-builder project...
	$(MVN) --file "$(JAVA_PROTOCOL_BUILDER_DIR)/" clean package

compile-cdt-java-client:
	# Compiling cdt-java-client project...
	$(MVN) --file "$(JAVA_CLIENT_DIR)/" clean compile install deploy -Prelease

clean-cdt-java-protocol-builder:
	# Cleaning cdt-java-protocol-builder project...
	$(MVN) --file "$(JAVA_PROTOCOL_BUILDER_DIR)/" clean

clean-cdt-java-client:
	# Cleaning cdt-java-client project...
	$(MVN) --file "$(JAVA_CLIENT_DIR)/" clean

clean-previous-protocol:
	# Cleaning previous protocol...
	$(RM) -rf $(JAVA_CLIENT_DIR)/src/main/java/$(JAVA_CLIENT_PACKAGE)/types
	$(RM) -rf $(JAVA_CLIENT_DIR)/src/main/java/$(JAVA_CLIENT_PACKAGE)/events
	$(RM) -rf $(JAVA_CLIENT_DIR)/src/main/java/$(JAVA_CLIENT_PACKAGE)/commands

upgrade-protocol: build-cdt-java-protocol-builder clean-previous-protocol
	$(RUN_JAR) $(JAVA_PROTOCOL_BUILDER_JAR) --base-package="$(PACKAGE_NAME)" \
		--output=./$(JAVA_CLIENT_DIR)/ \
		--js-protocol=$(JS_PROTOCOL_JSON_FILE) \
		--browser-protocol=$(BROWSER_PROTOCOL_JSON_FILE) \

update-protocol: upgrade-protocol compile-cdt-java-client
	# Updated protocol on cdt-java-client

sonar-analysis:
	# Running sonar analysis
	cd $(JAVA_PROTOCOL_BUILDER_DIR)/ && make sonar-analysis
	cd $(JAVA_CLIENT_DIR)/ && make sonar-analysis

verify:
	# Running unit tests
	cd $(JAVA_PROTOCOL_BUILDER_DIR)/ && make verify
	cd $(JAVA_CLIENT_DIR)/ && make verify
	$(MVN) --file "$(JAVA_CLIENT_DIR)/" clean install && \
	  $(MVN) --file "$(EXAMPLES_DIR)/" clean compile

download-latest-protocol:
	curl -o browser_protocol.json https://raw.githubusercontent.com/ChromeDevTools/devtools-protocol/master/json/browser_protocol.json
	curl -o js_protocol.json https://raw.githubusercontent.com/ChromeDevTools/devtools-protocol/master/json/js_protocol.json
