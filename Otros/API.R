install.packages("plumber")
library(plumber)
library(RMySQL)
library(DBI)

#* Get Cantidad de muertes por covid en Lima Departamento segun la informacion de FALLECIDOS_COVID
#* @get   /fallecidos/covid/departamentos/lima
function(){
  driver=MySQL()
  host = "35.174.139.24"
  port = 3306
  user="admin"
  password="admin2020"
  dbname="COVID_DB"
  conexion<-dbConnect(drv=driver,host=host,port=port,username=user,password=password,dbname=dbname)
  q1<-dbGetQuery(conexion, "select DEPARTAMENTO.nombre, FALLECIDO_COVID.id from FALLECIDO_COVID
               INNER JOIN DEPARTAMENTO ON FALLECIDO_COVID.DEPARTAMENTO_id=DEPARTAMENTO.id
               where DEPARTAMENTO.nombre LIKE 'LIMA'")
  dbDisconnect(conexion)
  return(NROW(q1))
}

#* Get CANTIDAD DE FALLECIDOS POR COVID SEGUN CADA DEPARTAMENTO/ TABLA FALLECIDOS_COVID
#* @get   /fallecidos/covid/departamento
function(){
  driver=MySQL()
  host = "35.174.139.24"
  port = 3306
  user="admin"
  password="admin2020"
  dbname="COVID_DB"
  conexion<-dbConnect(drv=driver,host=host,port=port,username=user,password=password,dbname=dbname)
  q4 = dbGetQuery(conexion, "select DEPARTAMENTO.nombre, COUNT(FALLECIDO_COVID.id) from FALLECIDO_COVID 
                JOIN DEPARTAMENTO ON FALLECIDO_COVID.DEPARTAMENTO_id = DEPARTAMENTO.id
                GROUP BY DEPARTAMENTO.nombre")
  dbDisconnect(conexion)
  return(q4)
}


#* Get  CANTIDAD DE FALLECIDOS POR COVID SEGUN CADA ESTADO CIVIL/ TABLA FALLECIDOS_SINADEF
#* @get   /fallecidos/covid/estado_civil
function(){
  driver=MySQL()
  host = "35.174.139.24"
  port = 3306
  user="admin"
  password="admin2020"
  dbname="COVID_DB"
  conexion<-dbConnect(drv=driver,host=host,port=port,username=user,password=password,dbname=dbname)
  q5 = dbGetQuery(conexion, "select estado_civil, COUNT(id) as cantidad_fallecidos from FALLECIDO_SINADEF 
                GROUP BY estado_civil")
  dbDisconnect(conexion)
  return(q5) 
  
}

#* Get  CANTIDAD DE FALLECIDOS POR SEGUN CADA SEXO/ TABLA FALLECIDOS_SINADEF
#* @get   /fallecidos/total/sexo
function(){
  driver=MySQL()
  host = "35.174.139.24"
  port = 3306
  user="admin"
  password="admin2020"
  dbname="COVID_DB"
  conexion<-dbConnect(drv=driver,host=host,port=port,username=user,password=password,dbname=dbname)
  q6 = dbGetQuery(conexion, "select SEXO.sexo, COUNT(FALLECIDO_SINADEF.id) as cantidad_fallecidos from FALLECIDO_SINADEF
                INNER JOIN SEXO ON SEXO.id = FALLECIDO_SINADEF.SEXO_id GROUP BY SEXO.sexo")
  dbDisconnect(conexion)
  return(q6)
}

#* Get  CANTIDAD DE FALLECIDOS DEL 2017 AL 2020 / TABLA FALLECIDOS_SINADEF
#* @get   /fallecidos/total
function(){
  driver=MySQL()
  host = "35.174.139.24"
  port = 3306
  user="admin"
  password="admin2020"
  dbname="COVID_DB"
  conexion<-dbConnect(drv=driver,host=host,port=port,username=user,password=password,dbname=dbname)
  q7 = dbGetQuery(conexion, "select YEAR(FALLECIDO_SINADEF.fecha) as fecha, COUNT(id) as cantidad_fallecidos from FALLECIDO_SINADEF 
                GROUP BY YEAR(FALLECIDO_SINADEF.fecha)")
  dbDisconnect(conexion)
  return(q7) 
}

#* CANTIDAD DE RESULTADOS POSITIVOS DE COVID SEGUN SEXO / TABLA POSITIVO_COVID
#* @get   /postivios/covid/sexo
function(){
  driver=MySQL()
  host = "35.174.139.24"
  port = 3306
  user="admin"
  password="admin2020"
  dbname="COVID_DB"
  conexion<-dbConnect(drv=driver,host=host,port=port,username=user,password=password,dbname=dbname)
  q9 = dbGetQuery(conexion, "select SEXO.sexo, COUNT(POSITIVO_COVID.id) as cantidad_positivos from POSITIVO_COVID
                JOIN SEXO on SEXO.id = POSITIVO_COVID.SEXO_id
                group by SEXO.sexo")
  dbDisconnect(conexion)
  return(q9)
}

#* CANTIDAD DE FALLECIDOS/Covid DEL MES DE JUNIO LA PROVINCIA DE LLIMA / TABLA FALLECIDOS_COVID
#* @get   /fallecidos/covid/provincias/lima
function(){
  driver=MySQL()
  host = "35.174.139.24"
  port = 3306
  user="admin"
  password="admin2020"
  dbname="COVID_DB"
  conexion<-dbConnect(drv=driver,host=host,port=port,username=user,password=password,dbname=dbname)
  q10 = dbGetQuery(conexion, "SELECT SEXO.sexo, FALLECIDO_COVID.id, FALLECIDO_COVID.edad_declarada from FALLECIDO_COVID
                 JOIN SEXO ON SEXO.id = FALLECIDO_COVID.SEXO_id
                 JOIN PROVINCIA ON PROVINCIA.id = FALLECIDO_COVID.PROVINCIA_id
                 WHERE PROVINCIA.id = 1 AND MONTH(FALLECIDO_COVID.fecha_fallecimiento) = '6'")
  dbDisconnect(conexion)
  return(q10)
}


#* CANTIDAD DE FALLECIDOS POR COVID QUE NO FUERON EN EL DEPARTAMENTO DE LIMA, EL MES DE AGOSTO/ TABLA FALLECIDOS_COVID
#* @get   /fallecidos/covid/departamentos/menos/lima
function(){
  driver=MySQL()
  host = "35.174.139.24"
  port = 3306
  user="admin"
  password="admin2020"
  dbname="COVID_DB"
  conexion<-dbConnect(drv=driver,host=host,port=port,username=user,password=password,dbname=dbname)
  q11 = dbGetQuery(conexion, "select DEPARTAMENTO.nombre, COUNT(FALLECIDO_COVID.id) from FALLECIDO_COVID
                join DEPARTAMENTO on FALLECIDO_COVID.DEPARTAMENTO_id = DEPARTAMENTO.id
                where DEPARTAMENTO.nombre != 'LIMA' AND YEAR(FALLECIDO_COVID.fecha_fallecimiento) = '2020'
                AND MONTH(FALLECIDO_COVID.fecha_fallecimiento) = '8'
                group by DEPARTAMENTO.nombre")
  dbDisconnect(conexion)
  return(q11)
}


#* FALLECIDOS POR COVID DEL  DEPARTAMENTO DE LIMA EN EL MEZ DE JULIO
#* @get   /fallecidos/covid/mes/julio/lima
function(){
  driver=MySQL()
  host = "35.174.139.24"
  port = 3306
  user="admin"
  password="admin2020"
  dbname="COVID_DB"
  conexion<-dbConnect(drv=driver,host=host,port=port,username=user,password=password,dbname=dbname)
  q13 = dbGetQuery(conexion, "select DISTRITO.nombre, COUNT(FALLECIDO_COVID.id) from FALLECIDO_COVID
                JOIN DEPARTAMENTO on FALLECIDO_COVID.DEPARTAMENTO_id = DEPARTAMENTO.id
                JOIN DISTRITO ON FALLECIDO_COVID.DISTRITO_id = DISTRITO.id
                where DEPARTAMENTO.nombre = 'LIMA' AND YEAR(FALLECIDO_COVID.fecha_fallecimiento) = '2020'
                AND MONTH(FALLECIDO_COVID.fecha_fallecimiento) = '8'
                group by DISTRITO.nombre")
  dbDisconnect(conexion)
  return(q13)
}

#* FALLECIDOS POR COVID DEL  DEPARTAMENTO DE LIMA EN EL MEs DE JULIO 2019
#* @get   /fallecidos/covid/year/2019/mes/julio/lima
function(){
  driver=MySQL()
  host = "35.174.139.24"
  port = 3306
  user="admin"
  password="admin2020"
  dbname="COVID_DB"
  conexion<-dbConnect(drv=driver,host=host,port=port,username=user,password=password,dbname=dbname)
  q13 = dbGetQuery(conexion, "select DISTRITO.nombre, COUNT(FALLECIDO_COVID.id) from FALLECIDO_COVID
                JOIN DEPARTAMENTO on FALLECIDO_COVID.DEPARTAMENTO_id = DEPARTAMENTO.id
                JOIN DISTRITO ON FALLECIDO_COVID.DISTRITO_id = DISTRITO.id
                where DEPARTAMENTO.nombre = 'LIMA' AND YEAR(FALLECIDO_COVID.fecha_fallecimiento) = '2019'
                AND MONTH(FALLECIDO_COVID.fecha_fallecimiento) = '8'
                group by DISTRITO.nombre")
  dbDisconnect(conexion)
  return(q13)
}

#* FALLECIDOS POR COVID DEL  DEPARTAMENTO DE LIMA EN EL MEs DE JULIO 2020
#* @get   /fallecidos/covid/year/2020/mes/julio/lima
function(){
  driver=MySQL()
  host = "35.174.139.24"
  port = 3306
  user="admin"
  password="admin2020"
  dbname="COVID_DB"
  conexion<-dbConnect(drv=driver,host=host,port=port,username=user,password=password,dbname=dbname)
  q13 = dbGetQuery(conexion, "select DISTRITO.nombre, COUNT(FALLECIDO_COVID.id) from FALLECIDO_COVID
                JOIN DEPARTAMENTO on FALLECIDO_COVID.DEPARTAMENTO_id = DEPARTAMENTO.id
                JOIN DISTRITO ON FALLECIDO_COVID.DISTRITO_id = DISTRITO.id
                where DEPARTAMENTO.nombre = 'LIMA' AND YEAR(FALLECIDO_COVID.fecha_fallecimiento) = '2020'
                AND MONTH(FALLECIDO_COVID.fecha_fallecimiento) = '8'
                group by DISTRITO.nombre")
  dbDisconnect(conexion)
  return(q13)
}



