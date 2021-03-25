GO
CREATE DATABASE Universidad
GO
USE Universidad
GO
CREATE TABLE [dbo].[Alumnos](
	[IdAlumno] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[NombreCompleto] [varchar](80) NOT NULL,
	[FechaNacimiento] [datetime] NOT NULL,
	[Edad] [int] NULL,
	[Matricula] [varchar](10) NOT NULL,
	[CorreoElectronico] [varchar](50) NOT NULL,
	[Genero] [bit] NOT NULL,
	[Carrera] [varchar](40) NOT NULL,
) 
GO
CREATE TABLE [dbo].[Materias](
	[IdMateria] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[NombreMateria] [varchar](50)  NOT NULL,
	[DescrMateria] [varchar](150) NOT NULL,
	[NoCreditos] [varchar](5) NOT NULL,
)
GO
CREATE TABLE [dbo].[AlumnoMateria](
	[Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[IdAlum] [int] FOREIGN KEY REFERENCES Alumnos NOT NULL,
	[IdMateria] [int] FOREIGN KEY REFERENCES Materias NOT NULL,
)
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[AlumnoMateria]  WITH CHECK ADD  CONSTRAINT [FK__AlumnoMat__IdAlu__300424B4] FOREIGN KEY([IdAlum])
REFERENCES [dbo].[Alumnos] ([IdAlumno])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AlumnoMateria] CHECK CONSTRAINT [FK__AlumnoMat__IdAlu__300424B4]
GO
ALTER TABLE [dbo].[AlumnoMateria]  WITH CHECK ADD  CONSTRAINT [FK__AlumnoMat__IdMat__30F848ED] FOREIGN KEY([IdMateria])
REFERENCES [dbo].[Materias] ([IdMateria])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AlumnoMateria] CHECK CONSTRAINT [FK__AlumnoMat__IdMat__30F848ED]
GO
/****** Object:  StoredProcedure [dbo].[AgregarAlumno]    Script Date: 25/03/2021 02:31:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AgregarAlumno](@NombreCompleto varchar(80), @FechaNacimiento datetime, @Matricula varchar(10), @CorreoElectronico varchar(50), @Genero bit, @Carrera varchar(40))
AS
BEGIN
	INSERT INTO Alumnos (NombreCompleto, FechaNacimiento, Matricula, CorreoElectronico, Genero, Carrera) VALUES (@NombreCompleto, @FechaNacimiento, @Matricula, @CorreoElectronico, @Genero, @Carrera)
END

GO
/****** Object:  StoredProcedure [dbo].[AgregarMateria]    Script Date: 25/03/2021 02:31:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AgregarMateria](@NombreMateria varchar(50), @DescrMateria varchar(150), @NoCreditos varchar(5))
AS
BEGIN
	INSERT INTO Materias (NombreMateria, DescrMateria, NoCreditos) VALUES (@NombreMateria, @DescrMateria, @NoCreditos)
END

GO
/****** Object:  StoredProcedure [dbo].[AgregarMateriaAlumno]    Script Date: 25/03/2021 02:31:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AgregarMateriaAlumno](@IdAlum int, @IdMateria int)
AS
BEGIN
	INSERT INTO AlumnoMateria (IdAlum, IdMateria) VALUES (@IdAlum, @IdMateria)
END

GO
/****** Object:  StoredProcedure [dbo].[ALUMNOMATERIASID]    Script Date: 25/03/2021 02:31:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ALUMNOMATERIASID](@IDAlumno int)
AS
BEGIN
	select A.IdAlumno, A.NombreCompleto, A.FechaNacimiento, A.Edad, A.Matricula, A.CorreoElectronico, A.Genero, A.Carrera, 
	am.Id, AM.IdMateria,M.NombreMateria 
	from Alumnos as A
	INNER JOIN AlumnoMateria AS AM
	ON A.IdAlumno=AM.IdAlum
	INNER JOIN Materias AS M 
	on AM.IdMateria= M.IdMateria
	WHERE AM.IdAlum=@IDAlumno

END
GO
/****** Object:  StoredProcedure [dbo].[BORRARALUMNOMATERIA]    Script Date: 25/03/2021 02:31:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[BORRARALUMNOMATERIA](@id int)
as
begin
	delete from [dbo].[AlumnoMateria] where [Id]=@id
end

GO
/****** Object:  StoredProcedure [dbo].[BORRARaLUMNOS]    Script Date: 25/03/2021 02:31:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[BORRARaLUMNOS](@id int)
as
begin
	delete from Alumnos where IdAlumno=@id
end


GO
/****** Object:  StoredProcedure [dbo].[BORRARMATERIA]    Script Date: 25/03/2021 02:31:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[BORRARMATERIA](@id int)
as
begin
	delete from Materias where IdMateria=@id
end


GO
/****** Object:  StoredProcedure [dbo].[EDITARALUMNO]    Script Date: 25/03/2021 02:31:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[EDITARALUMNO](@NombreCompleto varchar(80), @FechaNacimiento datetime, @Edad int, @Matricula varchar(10), @CorreoElectronico varchar(50), @Genero bit, @Carrera varchar(40),@Id int)
AS
BEGIN
	update Alumnos
	set	NombreCompleto=@NombreCompleto,
	FechaNacimiento=@FechaNacimiento,
	Edad=@Edad,
	Matricula=@Matricula,
	CorreoElectronico=@CorreoElectronico,
	Genero=@Genero,
	Carrera=@Carrera
	where IdAlumno=@Id
END

GO
/****** Object:  StoredProcedure [dbo].[EDITARMATERIAS]    Script Date: 25/03/2021 02:31:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EDITARMATERIAS](@NombreMateria varchar(50), @DescrMateria varchar(150), @NoCreditos varchar(5),@ID INT)
AS
BEGIN
	UPDATE Materias
	SET	NombreMateria=@NombreMateria,
	DescrMateria=@DescrMateria,
	NoCreditos=@NoCreditos
	WHERE IdMateria=@ID
END

GO
/****** Object:  StoredProcedure [dbo].[VERALUMNO]    Script Date: 25/03/2021 02:31:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[VERALUMNO]
as
begin
	SELECT * FROM Alumnos
end
GO
/****** Object:  StoredProcedure [dbo].[VERALUMNOxID]    Script Date: 25/03/2021 02:31:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[VERALUMNOxID](@id int)
as
begin
	SELECT * FROM Alumnos where IdAlumno=@id
end

GO
/****** Object:  StoredProcedure [dbo].[VERMATERIA]    Script Date: 25/03/2021 02:31:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[VERMATERIA]
as
begin
	SELECT * FROM Materias
end
GO
/****** Object:  StoredProcedure [dbo].[VERMATERIAAlUMNxID]    Script Date: 25/03/2021 02:31:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[VERMATERIAAlUMNxID](@id int,@IdAlu int)
as
begin
	select A.IdAlumno, A.NombreCompleto, 
	AM.Id, AM.IdMateria,M.NombreMateria 
	from Alumnos as A
	INNER JOIN AlumnoMateria AS AM
	ON A.IdAlumno=AM.IdAlum
	INNER JOIN Materias AS M 
	on AM.IdMateria= M.IdMateria
	WHERE AM.IdMateria=@id
	AND IdAlum=@IdAlu
end

GO
/****** Object:  StoredProcedure [dbo].[VERMATERIAxID]    Script Date: 25/03/2021 02:31:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[VERMATERIAxID](@id int)
as
begin
	SELECT * FROM Materias where IdMateria=@id
end
GO
CREATE TRIGGER [dbo].[TrigEdad]
ON				[dbo].[Alumnos]
FOR INSERT
AS
BEGIN
	DECLARE @IdAlumno int,@FechaNac datetime,@Edad int
	SELECT @IdAlumno=(SELECT MAX(IdAlumno) FROM Alumnos)
	SELECT @FechaNac=(SELECT FechaNacimiento from Alumnos where IdAlumno=@IdAlumno)
	SELECT @Edad=(select (cast(datediff(dd, @FechaNac ,GETDATE()) / 365.25 as int)))

	UPDATE Alumnos
	set Edad=@Edad
	where IdAlumno=@IdAlumno
END
