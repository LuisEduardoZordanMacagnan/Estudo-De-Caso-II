--1
CREATE PROCEDURE pRegistrarMatricula(v_EstudanteID IN NUMBER, v_CursoID IN NUMBER) IS
BEGIN
	INSERT INTO Matriculas 
    	(DataMatricula, Status, EstudanteID, CursoID)
	VALUES
		(SYSDATE, 'Ativo', v_EstudanteID, v_CursoID);
END pRegistrarMatricula;

--2
CREATE PROCEDURE pRegistrarAvaliacao (v_CursoID IN NUMBER, v_EstudanteID IN NUMBER, v_Nota IN DECIMAL, v_Comentario IN VARCHAR2) IS
BEGIN
	INSERT INTO Avaliacoes
		(Nota, Comentario, CursoID, EstudanteID)
	VALUES
		(v_Nota, v_Comentario, v_CursoID, v_EstudanteID);
END pRegistrarAvaliacao;

--3
CREATE PROCEDURE pAtualizarCurso (v_CursoID IN NUMBER, v_Nome IN VARCHAR2, v_Descricao IN VARCHAR2, v_InstrutorID IN NUMBER, v_Preco IN DECIMAL) IS
BEGIN
	UPDATE Cursos SET
        Nome=v_Nome,
        Descricao=v_Descricao,
    	Preco=v_Preco
	WHERE 
		CursoID = v_CursoID;
	DELETE FROM Instrui WHERE CursoID = v_CursoID;
	INSERT INTO Instrui VALUES (v_InstrutorID, v_CursoID);
END pAtualizarCurso;

--4
CREATE PROCEDURE pRemoverCurso (v_CursoID IN NUMBER) IS
BEGIN
    DELETE FROM Instrui WHERE CursoID = v_CursoID;
	DELETE FROM Cursos WHERE CursoID = v_CursoID;
END pRemoverCurso;

--5
CREATE PROCEDURE pCadastrarProfessor (v_Nome IN VARCHAR2, v_Especialidade IN VARCHAR2, v_Email IN VARCHAR2, v_CursoID IN NUMBER)
IS
    v_InstrutorID Instrutores.InstrutorID%TYPE;
BEGIN
	INSERT INTO Instrutores
		(Nome, Especialidade, Email)
	VALUES
		(v_Nome, v_Especialidade, v_Email)
    RETURNING InstrutorID INTO v_InstrutorID;
	INSERT INTO Instrui VALUES (v_InstrutorID, v_CursoID);
END pCadastrarProfessor;