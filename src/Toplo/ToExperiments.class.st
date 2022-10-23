Class {
	#name : #ToExperiments,
	#superclass : #Object,
	#category : #'Toplo-Examples'
}

{ #category : #accessing }
ToExperiments class >> embeddedFontsText [

	"
AeFontSlant: normal italic oblique.
AeFontWeight: black bold extraBlack extraBold extraLight light medium normal semiBold semiLight thin
AeFontStretch: condensed expanded extraCondensed extraExpanded normal semiCondensed semiExpanded ultraCondensed ultraExpanded 
"

	| aManager allSlants allWeights allStreches text allChars |
	allChars := 'azertyuiopqsdfghjklmwxcvbn' , String cr , 'AZERTYUIOPQSDFGHJKLMWXCVBN' , String cr , '1234567890'
	            , String cr , '@&é"''[(§è!çà)]-#°_¨*%£+/*.?' , String cr , '~^$`ù=:;,~|'.
	"AeFontManager resetGlobalInstance."
	aManager := AeFontManager globalInstance .
	allSlants := { 
		             BlFontSlant normal.
		             BlFontSlant italic.
		             BlFontSlant oblique }.
	allWeights := { 
		              BlFontWeight normal.
		              BlFontWeight light.
		              BlFontWeight extraLight.
		              BlFontWeight medium.
		              BlFontWeight bold.
		              BlFontWeight semiBold.
		              BlFontWeight extraBold.
		              BlFontWeight black.
		              BlFontWeight extraBlack.
		              BlFontWeight thin }.
	allStreches := { 
		               BlFontStretch normal.
		               BlFontStretch condensed.
		               BlFontStretch semiCondensed.
		               BlFontStretch extraCondensed.
		               BlFontStretch ultraCondensed.
		               BlFontStretch expanded.
		               BlFontStretch semiExpanded.
		               BlFontStretch extraExpanded.
		               BlFontStretch ultraExpanded }.

	text := '' asRopedText.
	aManager familyNames do: [ :fname | 
		allSlants do: [ :slant | 
			allWeights do: [ :weight | 
				allStreches do: [ :strech | 
					(aManager
						 detectFamilyName: fname
						 slant: (AeFontSlant perform: slant name asSymbol)
						 weight: (AeFontWeight perform: weight name asSymbol)
						 stretch: (AeFontStretch perform: strech name asSymbol)
						 ifNone: [  ]) in: [ :face | 
						face ifNotNil: [ 
							| fontBuilder t |
							fontBuilder := BlTextFontAndStyleBuilder new.
							fontBuilder familyName: fname.
							fontBuilder fontSize: 18.
							fontBuilder fontStretch: strech.
							fontBuilder fontWeight: weight.
							fontBuilder fontSlant: slant.
							t := allChars copy asRopedText.
							fontBuilder font applyOnText: t.
							text := text, (String cr , String cr , String cr , fname , ' slant: ' , slant name , ' weight: ' , weight name
							         , ' strech: ' , strech name , ' ' , String cr , String cr) asRopedText , t ] ] ] ] ] ].
	^ text
]

{ #category : #elements }
ToExperiments class >> example_ExperimentForMultilineLabel [

	| element l |
	l := ToTextScissor new cut: String loremIpsum asRopedText.

	element := BlElement new
		           layout: AlbLineFlowLayout new;
		           constraintsDo: [ :c | 
			           c horizontal matchParent.
			           c vertical fitContent ];
		           addChildren: (l collect: [ :w | w asElement editorMeasurement ]).
	element openInOBlSpace
]

{ #category : #elements }
ToExperiments class >> example_ExperimentForMultilineLabel0 [

	| element l |
	l := ToTextScissor new cut: ('This is a text' asRopedText fontSize: 20).

	element := BlElement new
		           layout: AlbLineFlowLayout new;
		           constraintsDo: [ :c | 
			           c horizontal matchParent.
			           c vertical fitContent ];
		           addChildren: (l collect: [ :w | w asElement editorMeasurement ]).
	element border: (BlBorder paint: Color gray width: 1).
	element inspect.
	element openInOBlSpace
]

{ #category : #elements }
ToExperiments class >> example_ExperimentForMultilineLabel2 [

	| element l |
	l := ToTextScissor new cut: (('Default font and size' asRopedText, ('Source code pro 40 bold' asRopedText fontSize: 40; fontName: 'Source code pro'; bold) 
	 , (' Default font 30' asRopedText fontSize: 30))).

	element := BlElement new
		           layout: AlbLineFlowLayout new;
		           constraintsDo: [ :c | 
			           c horizontal matchParent.
			           c vertical fitContent ];
		           addChildren: (l collect: [ :w | w asElement editorMeasurement ]).
	element openInOBlSpace
]

{ #category : #elements }
ToExperiments class >> example_ExperimentForMultilineLabel3 [

	| root text itor |
	text := 'Default font and size' asRopedText , String cr asRopedText , ('Source code pro 40 bold' asRopedText
		         fontSize: 40;
		         fontName: 'Source code pro';
		         bold) , String cr asRopedText , (' Default font 30' asRopedText fontSize: 30).

	root := BlElement new
		        constraintsDo: [ :c | 
			        c vertical matchParent.
			        c horizontal matchParent ];
		        layout: BlLinearLayout vertical.

	itor := text iterator.
	[ itor hasNext ] whileTrue: [ 
		itor nextLineIndicesDo: [ :aLineStart :aLineEnd :aLineDelimiterEnd | 
			| sub cutted lineElement |
			sub := text from: aLineStart to: aLineEnd.
			cutted := ToTextScissor new cut: sub.
			lineElement := BlElement new
				               layout: AlbLineFlowLayout new;
				               constraintsDo: [ :c | 
					               c horizontal matchParent.
					               c vertical fitContent ];
				               addChildren: (cutted collect: [ :w | w asElement editorMeasurement ]).
			root addChild: lineElement ] ].

	root openInOBlSpace
]

{ #category : #elements }
ToExperiments class >> example_ExperimentForMultilineLabel4 [

	| root text itor |
	text := self embeddedFontsText.

	root := BlElement new
		        constraintsDo: [ :c | 
			        c vertical fitContent.
			        c horizontal fitContent ];
		        layout: BlLinearLayout vertical.
	itor := text iterator.
	[ itor hasNext ] whileTrue: [ 
		itor nextLineIndicesDo: [ :aLineStart :aLineEnd :aLineDelimiterEnd | 
			| sub cutted lineElement |
			sub := text from: aLineStart to: aLineEnd.
			cutted := ToTextScissor new cut: sub.
			cutted ifEmpty: [ 
				cutted := Array with:
					          (BlText empty attributes: sub iterator attributes) ].
			lineElement := BlElement new
				               layout: AlbLineFlowLayout new;
				               constraintsDo: [ :c | 
					               c horizontal matchParent.
					               c vertical fitContent ];
				               addChildren:
					               (cutted collect: [ :w | 
							                w asElement editorMeasurement ]).
			root addChild: lineElement ] ].

	root openInOBlSpace
]

{ #category : #elements }
ToExperiments class >> example_ExperimentForMultilineLabel5 [

	| root text itor |
	text := self embeddedFontsText.

	root := BlElement new
		        constraintsDo: [ :c | 
			        c vertical fitContent.
			        c horizontal fitContent ];
		        layout: BlLinearLayout vertical alignCenter.
	itor := text iterator.
	[ itor hasNext ] whileTrue: [ 
		itor nextLineIndicesDo: [ :aLineStart :aLineEnd :aLineDelimiterEnd | 
			| sub cutted lineElement |
			sub := text from: aLineStart to: aLineEnd.
			cutted := ToTextScissor new cut: sub.
			cutted ifEmpty: [ 
				cutted := Array with:
					          (BlText empty attributes: sub iterator attributes) ].
			lineElement := BlElement new
				               layout: BlFlowLayout new;
				               constraintsDo: [ :c | 
					               c horizontal fitContent.
					               c vertical fitContent ];
				               addChildren: (cutted collect: [ :w | w asElement editorMeasurement ]).
			root addChild: lineElement ] ].

	root openInOBlSpace
]
