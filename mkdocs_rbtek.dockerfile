FROM squidfunk/mkdocs-material
ADD user-requirements.txt
RUN pip install -r user-requirements.txt