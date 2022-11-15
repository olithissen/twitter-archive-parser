FROM python:3.11.0-slim

RUN mkdir /app

COPY *.py /app

VOLUME [ "/data" ]

CMD mkdir -p /data/output && \
    cp /app/*.py /data && \
    cd /data && \
    echo "Installing 'requests'" && \
    python -m pip install requests && \
    echo "Starting parser.py" && \
    python parser.py && \
    echo "Maybe starting download_better_images.py ...?" && \
    if [ $BETTER_IMAGES=="y" ]; then yes | python download_better_images.py; fi && \
    mv *.md /data/output && \
    mv /data/media /data/output/media && \
    rm /data/*.py