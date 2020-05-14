# Docker container with OpenRefine and the RDF Extension

Current version: OpenRefine 3.3 with RDF Extension 1.2.0

Example of use with the following `docker-compose.yml`:

```yaml
version: '3'
services:
  openrefine:
    image: rogargon/openrefine-rdf
    container_name: openrefine
    ports:
      - "3333:3333"
    volumes:
      - ./data:/data
```
