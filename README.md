# Marina API

- **Docker image:** [vaninah/marina-app (146 MB)](https://hub.docker.com/r/vaninah/marina-app)  
    - Size shown on Docker Hub (compressed): `52.2 MB`
    - Local size after pulling (uncompressed): `146 MB`

- **API URL:** `POST https://marina-app-lijn.onrender.com/marina`
- **Example of payload:**
```json
{
    "laza": "(a&b | c)->d <->~e"
}
```

# Wanna run the project locally? Easy!
- Pull the Docker image:

```bash
docker pull vaninah/marina-app
```
- Run the container

```bash
docker run -p 5000:5000 vaninah/marina-app
```
