recursive descent
piece
	"<piece> ::= <atom> | <atom>* | <atom>+ | <atom>?"
	| atom errorMessage |
	errorMessage := ' nullable closure'.
	atom := self atom.
	lookahead = $* ifTrue: 
		[self next.
		atom isNullable ifTrue: [self signalParseError: errorMessage].
		^RxsPiece new initializeStarAtom: atom].
	lookahead = $+ ifTrue: 
		[self next.
		atom isNullable ifTrue: [self signalParseError: errorMessage].
		^RxsPiece new initializePlusAtom: atom].
	lookahead = $? ifTrue: 
		[self next.
		atom isNullable ifTrue: [self signalParseError: errorMessage].
		^RxsPiece new initializeOptionalAtom: atom].
	^RxsPiece new initializeAtom: atom