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

{ #category : #image }
ToExperiments class >> example_Smalltalk_ui_icons_withElements [

| column root vscrollBar container space |
	column := BlElement new
		          layout: BlLinearLayout vertical;
		          constraintsDo: [ :c | 
			          c horizontal fitContent.
			          c vertical fitContent ];
		          yourself.
	Smalltalk ui icons allIconNames do: [ :k | 
		| lab im row |
		im := (Smalltalk ui icons iconNamed: k) asElement.
		im constraintsDo: [ :c | c linear vertical alignCenter ].
		im border: (BlBorder paint: Color lightGray).
		lab := BlTextElement new text: k asString asRopedText.
		lab padding: (BlInsets all: 6).
		lab border: (BlBorder paint: Color lightGray).
		lab constraintsDo: [ :c | c linear vertical alignCenter ].
		row := BlElement new
			       layout: BlLinearLayout horizontal;
			       constraintsDo: [ :c | 
				       c horizontal fitContent.
				       c vertical fitContent ];
			       border: (BlBorder paint: Color lightGray);
			       outskirts: BlOutskirts outside;
			       yourself.
		row
			addChild: lab;
			addChild: im.
		column addChild: row ].

	root := column asScrollableElement.
	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets right: 2).
			c ignored horizontal alignRight.
			c ignored vertical alignBottom]. 
	vscrollBar attachTo: root.
	container := BlElement new
		          constraintsDo: [ :c | 
			          c horizontal matchParent.
			          c vertical matchParent ];
		          yourself.
	container addChild: root; addChild: vscrollBar.
	space := BlSpace new.
	space addChild: container.
	space show
]

{ #category : #'mouse drag' }
ToExperiments class >> example_drag [

	| e child p |
	e := BlElement new
		     background: Color red;
		     size: 500 @ 500.

	child := BlElement new
		         background: Color yellow;
		         size: 50 @ 50;
		         relocate: 20 @ 20.

	e addChild: child.

	child when: BlDragStartEvent do: [ :evt | 
		p := evt position - child position.
		evt consumed: true ].

	child
		when: BlDragEvent
		do: [ :evt | child relocate: evt position - p ].

	e openInNewSpace
]

{ #category : #'mouse drag' }
ToExperiments class >> example_drag2 [

	| e child |
	e := BlElement new
		     background: Color red;
		     size: 500 @ 500.

	child := BlElement new
		         background: Color yellow;
		         size: 50 @ 50;
		         relocate: 20 @ 20.

	e addChild: child.
	child addEventHandler: (BlPullHandler new ).

	e openInNewSpace
]

{ #category : #'mouse drag' }
ToExperiments class >> example_drag3 [

	| e child |
	e := BlElement new
		     background: Color red;
		     size: 50 @ 50;
			clipChildren: false.

	child := BlElement new
		         background: Color yellow;
		         size: 50 @ 50;
		         relocate: 200 @ 200.

	e addChild: child.
	child addEventHandler: (BlPullHandler new pullTarget: e; beVertical).

	e openInNewSpace
]

{ #category : #'mouse drag' }
ToExperiments class >> example_drag4 [

	| e child |
	e := ToFrame new.

	child := ToImage new
		         innerImage: (BlElement new
				          background: Color yellow;
				          size: 50 @ 50);
		         relocate: 200 @ 200.

	child addEventHandler: (BlPullHandler new pullTarget: e).

	e openInWorld.
	child openInWorld
]

{ #category : #frame }
ToExperiments class >> example_frame [

	| frame bar close fill fill2 expand title root bkg pullHandler |
	bkg := Color veryLightGray alpha: 0.2.
	frame := BlElement new
		         background: Color white;
		         size: 300 @ 100.
	frame geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	frame border: (BlBorder paint: bkg width: 3).

	fill := BlElement new
		        background: Color transparent;
		        height: 20;
		        constraintsDo: [ :c | c horizontal matchParent ].
	fill2 := BlElement new
		         background: Color transparent;
		         height: 20;
		         constraintsDo: [ :c | c horizontal matchParent ].
	bar := BlElement new
		       background: Color white;
		       constraintsDo: [ :c | 
			       c vertical fitContent.
			       c horizontal matchParent ].
	bar padding: (BlInsets all: 3).
	bar background: bkg.
	bar layout: (BlGridLayout horizontal cellSpacing: 2).
	bar border: (BlBorder paint: bkg width: 3).
	bar geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	pullHandler := BlPullHandler new pullTarget: frame.
	bar addEventHandler: pullHandler.
	
	close := ToButton new iconImage: Smalltalk ui theme windowCloseForm; labelText: 'close'.
	close whenClickedDo: [ frame removeFromParent ].
	close background: Color transparent.
	expand := ToButton new iconImage: Smalltalk ui theme windowMaximizeForm.
	expand whenClickedDo: [ 
		frame 
			relocate: 0@0; 
			size: frame parent size ].	

	title := ToLabel new
		         text: 'Frame';
		         background: Color transparent.
	bar addChild: close.
	bar addChild: fill.
	bar addChild: title.
	bar addChild: fill2.
	bar addChild: expand.

	root := BlElement new background: Color transparent; constraintsDo: [ :c | 
			       c vertical matchParent.
			       c horizontal matchParent ].

	frame layout: BlLinearLayout vertical.
	frame addChild: bar.
	frame addChild: root.
	frame openInNewSpace
]
