# 1️⃣ Instalar PostgreSQL en Ubuntu
Abre una terminal (`Ctrl + Alt + T`) y ejecuta:

```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
```

# 2️⃣ Iniciar y Habilitar el Servicio
Asegúrate de que PostgreSQL esté en ejecución:

```bash
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

Verifica su estado con:

```bash
sudo systemctl status postgresql
```
# 3️⃣ Acceder a PostgreSQL
Por defecto, PostgreSQL crea un usuario llamado postgres. Para acceder a la consola, usa:

```bash
sudo -u postgres psql
```

Deberías ver algo como:

`makefile`
```bash
postgres=#
```
¡Ya estás dentro del shell de PostgreSQL!
# 1️⃣ Instalar PostgreSQL en Ubuntu
Abre una terminal (`Ctrl + Alt + T`) y ejecuta:

```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
```

# 2️⃣ Iniciar y Habilitar el Servicio
Asegúrate de que PostgreSQL esté en ejecución:

```bash
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

Verifica su estado con:

```bash
sudo systemctl status postgresql
```
# 3️⃣ Acceder a PostgreSQL
Por defecto, PostgreSQL crea un usuario llamado postgres. Para acceder a la consola, usa:

```bash
sudo -u postgres psql
```

Deberías ver algo como:

`makefile`
```bash
postgres=#
```
¡Ya estás dentro del shell de PostgreSQL! 👍👍👍
: