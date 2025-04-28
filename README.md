# Automación de WordPress con Vagrant y Puppet

Este repositorio contiene una configuración para desplegar automáticamente un entorno de desarrollo de WordPress usando **Vagrant** y **Puppet**.

## Explicación

**Youtube:** https://www.youtube.com/watch?v=iUAwnBE-MDI

## Requisitos

Antes de empezar, asegúrate de tener instalados los siguientes programas en tu sistema:

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
- Git

## Instrucciones

### 1. Clona este repositorio:

   ```
   git clone https://github.com/SebastianVeloza/puppet_wp.git
   cd tu-repositorio
   ```
### 2. Inicia Vagrant para crear y configurar la máquina virtual:

```
vagrant up
```
Una vez finalizado el proceso, puedes acceder al sitio de WordPress desde tu navegador en la dirección: http://localhost:8080.

### Personalización
Puedes modificar las configuraciones como el nombre de la base de datos, usuario, contraseña, etc., editando los archivos en los módulos Puppet correspondientes.

### Solución de Problemas
Si encuentras errores al ejecutar vagrant up, asegúrate de que todos los programas necesarios están instalados correctamente.

Puedes usar vagrant destroy para eliminar y volver a crear la máquina virtual si algo sale mal.
