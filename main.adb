--Checkers main program
with Ada.Text_IO; use Ada.Text_IO;
with GameBoard; use GameBoard;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with JEWL.Simple_Windows; use JEWL.Simple_Windows;
with Computer; use Computer;

procedure main is

	timeKeeper					: Timer;    	           -- will cause an instance of the timer task to exist, do not make more than one
	-- Variables
	gameOver					: Boolean  		:= False;  -- Set to true when game is over
	xFinder, yFinder			: Integer  		:= 0;
	playerTurn					: Integer 		:= 1;      -- 1 or 2 represents which player's turn it is (1-User, 2-Computer)
	playerScore, computerScore	: Integer 		:= 0;      -- Scores are 0 by default, Score of 12 wins
	spotIndex1, spotIndex2		: Integer		:= 0;
	firstClick, secondClick		: Point_Type;
begin
   --Loop through frame
	while Valid(AppFrame) loop
		--End game button is not visible
		endGame.Hide;
		startGame.Show; --Start button is visible
		--Submit button is not visible until the game has actually started
		submitMove.Hide;
		--calls JEWL functions from the gameboard package to init the GUI
		-- game wont start until S button is pressed
		loop 
			case Next_Command is
				-- begin playing
				
				when 'S' =>
					--Begin timer
					timeKeeper.start;
					--Remove start button and display end button
					startGame.Hide;
					endGame.Show;
					submitMove.Show;
					drawBoardGUI;
					exit;
				when 'Q' =>
					Close(AppFrame);
					exit;
				when others => null;
			end case;
		end loop;

		while gameOver = False loop
			case Next_Command is

				
				when 'C' =>
					while spotIndex1 = 0 loop
						xFinder   := 0;
						yFinder   := 0;
						firstClick := Start_Point(BoardCanvas);
						while xFinder <= firstClick.x loop
							xFinder := xFinder + 80;
							spotIndex1 := spotIndex1 + 1;
						end loop;
						while yFinder <= firstClick.y loop
							yFinder := yFinder + 80;
							if yFinder > 80 then
								spotIndex1 := spotIndex1 + 8;
							end if;
						end loop;
						if spotIndex1 mod 2 = 1 OR board(spotIndex1).pieceValue = 0 then
							spotIndex1 := 0;
						end if;
					end loop; --spotIndex1 now holds the array index of the piece to move
					if spotIndex2 = 0 then--This is the beginning of the second click(place to move to)
						case Next_Command is
							when 'C' =>
								while spotIndex2 = 0 loop
									xFinder   := 0;
									yFinder   := 0;
									secondClick := Start_Point(BoardCanvas);
									while xFinder <= secondClick.x loop
										xFinder := xFinder + 80;
										spotIndex2 := spotIndex2 + 1;
									end loop;
									while yFinder <= secondClick.y loop
										yFinder := yFinder + 80;
										if yFinder > 80 then
											spotIndex2 := spotIndex2 + 8;
										end if;
									end loop;
									if spotIndex2 mod 2 = 1 OR board(spotIndex2).pieceValue = 0 then
										spotIndex2 := 0;
									end if;
								end loop; --spotIndex1 now holds the array index of the piece to move	
							when others =>
								put("second click botched");
						end case;
					end if; -- spotIndex2 now holds the array index of the spot to attempt to move to
					put(Integer'Image(spotIndex1));
					put(Integer'Image(spotIndex2));
				
					-- when 'M' =>
					-- if playerTurn = 1 then
						-- if Next_Command = 'M' then
							-- pieceToMove := Integer'Value(Get_Text(InputPieceToMove));
							-- locationToMoveTo := Integer'Value(Get_Text(InputLocation));
							-- if board(pieceToMove).pieceValue = 1 or board(pieceToMove).pieceValue = 3 then
								-- if isValidMove(pieceToMove,locationToMoveTo) = True then
									-- --Move piece
									-- board(locationToMoveTo).pieceValue := board(pieceToMove).pieceValue;
									-- --Draw piece in new location
									-- Set_Fill(BoardCanvas,Red);
									-- Draw_Circle(BoardCanvas,board(locationToMoveTo).point,25);
									-- --Remove piece from old location
									-- board(pieceToMove).pieceValue := 0;
									-- --Remove piece from location on gui
									-- Set_Fill(BoardCanvas,Black);
									-- Draw_Rectangle(BoardCanvas,(board(pieceToMove).point.X - 40,board(pieceToMove).point.Y - 40),80,80);
									-- --Check if a piece was jumped over
									-- if returnRemovedValue > 0 then
										-- --A piece was jumped over
										-- Set_Fill(BoardCanvas,Black);
										-- Draw_Rectangle(BoardCanvas,(board(returnRemovedValue).point.X - 40,board(returnRemovedValue).point.Y - 40),80,80);
										-- --Increase player's score
										-- playerScore := playerScore + 1;
									-- end if;
								-- else
									-- Set_Text(WhosMoveLabel,"Invalid location choice.");
									-- --Put_Line("Invalid location choice.");
								-- end if;
							-- elsif board(pieceToMove).pieceValue = 2 or board(pieceToMove).pieceValue = 4 then --Computer's piece
								-- --Put_Line("That is not your piece.");
								-- Set_Text(WhosMoveLabel,"That is not your piece.");
							-- else
								-- --Put_Line("There is no piece at that location.");
								-- Set_Text(WhosMoveLabel,"There is no piece at that location.");
							-- end if;
						-- end if;
						-- playerTurn := 2;
					-- elsif playerTurn = 2 then
						-- --Determine piece to move
						-- --Determine location to move to
						-- generateMove;
						-- pieceToMove := generatePiece;
						-- locationToMoveTo := generateLocation;
						-- --Check team of piece to make sure it belongs to player
						-- if board(pieceToMove).pieceValue = 2 then --correct piece
							-- --Put("Enter Location to Move to: ");
							-- --Get(locationToMoveTo);

							-- if isValidMove(pieceToMove,locationToMoveTo) = True then
								-- --Move piece
								-- board(locationToMoveTo).pieceValue := board(pieceToMove).pieceValue;

								-- --Draw piece in new location
								-- Set_Fill(BoardCanvas,White);
								-- Draw_Circle(BoardCanvas,board(locationToMoveTo).point,25);

								-- --Remove piece from old location
								-- board(pieceToMove).pieceValue := 0;

								-- --Remove piece from location on GUI
								-- Set_Fill(BoardCanvas,Black);
								-- Draw_Rectangle(BoardCanvas,(board(pieceToMove).point.X - 40,board(pieceToMove).point.Y - 40),80,80);

								-- --Check if a piece was jumped over
								-- if returnRemovedValue > 0 then
									-- --A piece was jumped over
									-- Set_Fill(BoardCanvas,Black);
									-- Draw_Rectangle(BoardCanvas,(board(returnRemovedValue).point.X - 40,board(returnRemovedValue).point.Y - 40),80,80);

									-- --Increase computer's score
									-- computerScore := computerScore + 1;
								-- end if;
							-- else
							-- --Put_Line("Invalid location choice.");
							-- Set_Text(WhosMoveLabel,"Invalid location choice.");
							-- end if;
						-- elsif board(pieceToMove).pieceValue = 1 or board(pieceToMove).pieceValue = 3 then --player's pieces
							-- --Put_Line("That is not your piece.");
							-- Set_Text(WhosMoveLabel,"That is not your piece.");
						-- else --empty space
							-- --Put_Line("There is no piece at that location.");
							-- Set_Text(WhosMoveLabel,"There is no piece at that location.");
						-- end if;
						-- playerTurn := 1;
					-- end if;
				when 'E' =>
					gameOver := True;
					timeKeeper.stop;
					Set_Text(WhosMoveLabel,"Game Over");
				when others =>
					--Display scores in labels
					Set_Text(PlayerScoreResult,Integer'Image(playerScore));
					Set_Text(ComputerScoreResult,Integer'Image(computerScore));
					--Display whose turn it is
					if playerTurn = 1 then
						Set_Text(WhosMoveLabel,"It's your Turn!");
					elsif playerTurn = 2 then
						Set_Text(WhosMoveLabel,"Computer's Turn!");
					end if;
			end case;
			
			
			-- Check for end game conditions
			if playerScore = 12 then
				Put_Line("Player Wins!");
				gameOver := True;
			elsif computerScore = 12 then
				Put_Line("Computer Wins!");
				gameOver := True;
			end if;
		end loop; -- main game loop
	end loop; -- frame loop
end main;
