Class {
	#name : #ToSandBox,
	#superclass : #Object,
	#category : #'Toplo-examples'
}

{ #category : #accessing }
ToSandBox class >> embeddedFontsText [

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

{ #category : #album }
ToSandBox class >> example_CodeEditorWithToClient [

"
The Client is a defined by user class. 
ToAlbumBasicClient implement typical Album user with a styler.
It is a kind of model but without any association from the widget to the client (no reference to the client is stored in widget).
It can be used and subclassed to support comment and code editing, workspace implementation...
All the different kind of Album using should use the available basic client class or subclass it for specific purpose.
Here an example of a client for a method.
"

	| text album space client |
	text := self methodText asRopedText.
	album := ToAlbum new.
	client := ToAlbumBasicClient new onAlbum: album; yourself.	
	client styler: BlRBTextStyler new.
	client classOrMetaClass: self class.
	client text: text.
	"client inspect."
	"album editorElement viewModel inspect."
	album withLineNumbers.
	
	space := OBlSpace new.
	space root addChild: album.
	space show.
	^ album


]

{ #category : #album }
ToSandBox class >> example_EditorWithGhostText [

	| text album space client message |
	message := 'Here is a GhostText' , String cr , 'It is visible only in case of empty text', String cr, String cr.
	message := message , '- Cmd-shift-mouseDown to enter text editing' , String cr
	           , '- Cmd-Cr to accept text', String cr, '- Esc to cancel editing'.
	text := message asRopedText.
	text foreground: Color lightGray.
	text fontSize: 24.

	album := ToAlbum new.
	client := ToAlbumBasicClient new onAlbum: album; yourself.
	client text: ''.
	client withGhostText: text.
	album withLineNumbers.

	space := OBlSpace new.
	space root addChild: album.
	space show.
	^ album
]

{ #category : #label }
ToSandBox class >> example_toLabel3 [

	| lab |
	lab := ToLabel new text: ('This is a bold label' asRopedText fontSize: 20).
	lab textElement bold.
	lab background: Color lightBlue.
	lab textElement foreground: Color gray.
	lab editable: true.
	lab border: (BlBorder paint: Color yellow width: 1).
	lab openInOBlSpace
]

{ #category : #label }
ToSandBox class >> example_toLabel4 [

	| lab1 lab2 lab3 root |
	root := BlElement new constraintsDo: [ :c | 
		        c vertical fitContent.
		        c horizontal matchParent ].

	root layout: BlLinearLayout vertical.
	lab1 := ToLabel new text: ('' asRopedText fontSize: 14).
	lab1 viewModel editable: true.
	lab1 vFitContent.
	"lab1 withGhostText: 'cmd-shift-mouseDown to enter text editing - hit Cr to accept text or Esc to cancel'."
	lab1 hMatchParent.
	lab1 alignCenter.

	lab1 border: (BlBorder paint: Color red width: 1).
	root addChild: lab1.
	lab2 := ToLabel new text: (('This is a Text' , String cr , 'secondLine') asRopedText fontSize: 14).
	lab2 beMultiLine.
	lab2 vFitContent.
	lab2 hMatchParent.
	lab2 border: (BlBorder paint: Color red width: 1).
	lab2 viewModel editable: true.

	
	root addChild: lab2.
	lab3 := ToLabel new text: ('Third text' asRopedText fontSize: 14).
	lab3 border: (BlBorder paint: Color red width: 1).
	lab3 vFitContent.
	lab3 hMatchParent.
	root addChild: lab3.
	root openInOBlSpace
]

{ #category : #label }
ToSandBox class >> example_toLabel_Multiline1 [

	| lab |
	lab := ToLabel new text: ('This is a Text', String cr, 'secondLine').
	lab beMultiLine.
	lab openInOBlSpace 
]

{ #category : #label }
ToSandBox class >> example_toLabel_Multiline2_Centered [

	| lab space |
	lab := ToLabel new text: (('This is a Centered Text - size 20') asRopedText fontName: AeFontManager defaultCodeFontFamilyName; fontSize: 20).
	lab beMultiLine.
	lab alignCenter.
	lab fitContent.
	space := lab openInOBlSpace.
	space root layout: BlLinearLayout vertical alignCenter.
	
]

{ #category : #accessing }
ToSandBox class >> methodText [
	^ self  class sourceCodeAt: #example_CodeEditorWithToClient
]
