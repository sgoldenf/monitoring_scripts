FROM alpine

WORKDIR /project/

COPY *.sh .
COPY utils/* ./utils/
COPY test_combined_logs/* ./test_combined_logs/

RUN apk add --no-cache bash; \
    chmod +x *.sh; \
    chmod +x utils/*

ENTRYPOINT ["/bin/bash"]
