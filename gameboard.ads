with JEWL.Simple_Windows; use JEWL.Simple_Windows;

--Define the game piece object
package GameBoard is
	-- GUI VARIABLES
	--Declare a frame of 1000 x 1000 pixels
	AppFrame					: Frame_Type 		:= Frame(1000,900,"Ada - Checkers",'Q');
	--Declare a point-type
	BoardLocation				: Point_Type 		:= (0,0);
	--Declare a canvas
	BoardCanvas					: Canvas_Type 		:= Canvas(AppFrame,BoardLocation,640,640,'C');
	--Declare buttons
	startGame					: Button_Type		:= Button(AppFrame,(750,60),100,50,"Start Game",'S');
	endGame						: Button_Type 		:= Button(AppFrame,(750,60),100,50,"End Game",'E');
	submitMove					: Button_Type 		:= Button(AppFrame,(400,710),100,50,"Submit Move",'M');
	--Declare labels for player/computer scores
	PlayerScorePrompt			: Label_Type 		:= Label(AppFrame,(700,200),100,50,"Player Score:",Left);
	PlayerScoreResult			: Label_Type 		:= Label(AppFrame,(800,200),100,50,"Player Result",Left);
	ComputerScorePrompt			: Label_Type 		:= Label(AppFrame,(700,400),150,50,"Computer Score:",Left);
	ComputerScoreResult			: Label_Type 		:= Label(AppFrame,(825,400),150,50,"Computer Result",Left);
	--Declare labels for who's move it is
	WhosMoveLabel				: Label_Type 		:= Label(AppFrame,(650,600),200,50,"Player starts the game.",Center);
	--Declare a basic menu
	MenuFile					: Menu_Type 		:= Menu(AppFrame,"File");
	MenuAbout					: Menu_Type 		:= Menu(AppFrame,"About");
	File_End_Game				: Menuitem_Type 	:= Menuitem(MenuFile,"End Game",'E');
	File_Exit					: Menuitem_Type 	:= Menuitem(MenuFile,"Exit Program",'Q');
	--Declare labels to get moves from the player
	PromptPieceToMove			: Label_Type 		:= Label(AppFrame,(50,700),200,25,"Choose a Piece to Move:",Right);
	PromptLocation				: Label_Type 		:= Label(AppFrame,(50,750),200,25,"Choose a Location to Move to:",Right);
	--Declare editboxes for text input
	InputPieceToMove			: Editbox_Type 		:= Editbox(AppFrame,(255,700),100,25,"");
	InputLocation				: Editbox_Type 		:= Editbox(AppFrame,(255,750),100,25,"");
	-- Labels for Timer
	Timer_Label_Sec    			: Label_Type	    := Label(AppFrame,(720,25),20,20,"0",Left);
	Timer_Label_Min    			: Label_Type   		:= Label(AppFrame,(700,25),20,20,"0",Left);

	-- This will cause the board and pieces to be drawn on the GUI
	procedure drawBoardGUI;
	procedure erasePiece(BoardCanvas: in out Canvas_Type; index: in Integer);
	procedure drawPiece(BoardCanvas: in out Canvas_Type; pointTemp: in Point_Type; player: in Integer);
	----------------------------------------------------
	----------------------------------------------------
	--------- The non GUI board components  ------------
	----------------------------------------------------
	----------------------------------------------------
	-- Timer Task definition
	task type Timer is -- can put entry points and stuff in here
		entry start;
		entry stop;
	end Timer;
	-- need to add entry points for like the individual player's total move time clock/counts
	-- need to add entry to start and stop the main/only timer
		
	--Create record type
	type Spot is record
		--Player 1 -> User -> Black Team -> 1/2 (2 for king)
		--Player 2 -> Computer -> Red Team -> 3/4 (4 for king)
		pieceValue: Integer range 0..4;
		--Value representing numerical location
		location: Integer range 1..32; --Matches index location of array
		--Value representing the (X,Y) coordinates where the checker is on the canvas
		point: Point_Type;
	end record;
	--Board Variable of 32 Spots
	board: array (1..32) of Spot;
	--Variable to hold the location of a jumped over piece to be removed
	removeChecker: Integer := 0;
	--Set up game board procedure
	procedure makeKing(newKing: Integer);
	function isValidMove(piece,location: Integer) return Boolean;
	function returnRemovedValue return Integer;
	--procedure isValidJump
	--function isValidKingMove
end GameBoard;