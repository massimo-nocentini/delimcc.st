tests
wwwF: x

	^ self
		  amb: #( 6 4 2 8 )
		  in: [ :p | self amb: #( 2 4 5 4 1 ) in: [ :q | x + p + q ] ]