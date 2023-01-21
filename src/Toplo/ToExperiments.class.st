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

{ #category : #frame }
ToExperiments class >> example_FlowLayoutHorizontal [

	| frame left right fill |
	frame := BlElement new
		         background: Color gray;
		         size: 300 @ 100;
		         layout: BlFlowLayout horizontal;
		         constraintsDo: [ :c | 
			         c horizontal matchParent.
			         c vertical fitContent ].
	frame layout cellSpacing: 10.
	left := BlElement new
		        background: Color blue;
		        width: 100;
		        constraintsDo: [ :c | c frame horizontal alignLeft ].

	fill := BlElement new
		        background: Color yellow;
		        height: 20; width: 200;
		        constraintsDo: [ :c | c minWidth: 50. c flow  newLine: false. c flow vertical alignCenter ].
			
	right := BlElement new
		         background: Color red;
		         width: 100;
		         constraintsDo: [ :c | c frame horizontal alignRight ].

	frame addChild: left.
	frame addChild: fill.
	frame addChild: right.
	frame openInNewSpace
]

{ #category : #frame }
ToExperiments class >> example_FrameLayout [

	| frame left right fill |
	frame := BlElement new
		         background: Color gray;
		         size: 300 @ 100;
		         layout: BlFrameLayout new;
		         constraintsDo: [ :c | 
			         c horizontal matchParent.
			         c vertical fitContent ].

	left := BlElement new
		        background: Color blue;
		        width: 100;
		        constraintsDo: [ :c | c frame horizontal alignLeft ].
	fill := BlElement new
		        background: Color yellow;
		        height: 20;
		        constraintsDo: [ :c | 
			        c frame horizontal alignCenter.
			        c minWidth: 50 ].
	right := BlElement new
		         background: Color red;
		         width: 100;
		         constraintsDo: [ :c | c frame horizontal alignRight ].

	frame addChild: left.
	frame addChild: fill.
	frame addChild: right.
	frame openInNewSpace
]

{ #category : #frame }
ToExperiments class >> example_LinearLayout [

	| frame left right fill |
	frame := BlElement new
		         background: Color gray;
		         size: 300 @ 100;
		         layout: BlLinearLayout new;
		         constraintsDo: [ :c | 
			         c horizontal matchParent.
			         c vertical fitContent ].

	left := BlElement new
		        background: Color blue;
		        width: 100;
		        constraintsDo: [ :c | c frame horizontal alignLeft ].

	fill := BlElement new
		        background: Color yellow;
		        height: 20;
		        constraintsDo: [ :c | 
			        c horizontal
				        matchParent.
				      c minWidth: 50 ].
	fill when: BlElementExtentChangedEvent do: [ :ann | fill width traceCr ].
	right := BlElement new
		         background: Color red;
		         width: 100;
		         constraintsDo: [ :c | c frame horizontal alignRight ].

	frame addChild: left.
	frame addChild: fill.
	frame addChild: right.
	frame openInNewSpace
]

{ #category : #frame }
ToExperiments class >> example_LinearLayoutFillWithFitContent [

	| frame cpt |
	frame := BlElement new
		         background: Color lightGray;
		         layout: (BlLinearLayout vertical cellSpacing: 2);
		         border: (BlBorder paint: Color gray);
		         constraintsDo: [ :c | 
			         c horizontal fitContent.
			         c vertical fitContent ].
	cpt := 0.
	3 timesRepeat: [ 
		| left middle right fill1 fill2 node |
		cpt := cpt + 20.
		node := BlElement new
			        layout: (BlLinearLayout horizontal cellSpacing: 2);
			        constraintsDo: [ :c | 
				        c horizontal matchParent.
				        c vertical fitContent ].
		left := BlElement new
			        id: #left;
			        background: Color blue;
			        width: 10.
		middle := BlElement new
			        id: #left;
			        background: Color yellow;
			        width: 10 + cpt.
		fill1 := BlElement new
			        id: #fill;
			        background: Color white;
			        height: 15;
			        constraintsDo: [ :c | 
				        c horizontal matchParent.
				        c vertical matchParent ].
		fill2 := BlElement new
			        id: #fill;
			        background: Color white;
			        height: 15;
			        constraintsDo: [ :c | 
				        c horizontal matchParent.
				        c vertical matchParent ].
		right := BlElement new
			         id: #right;
			         background: Color red;
			         width: 14.
		node addChild: left.
"		node addChild: fill1.
"		node addChild: middle.
		node addChild: fill2.
		node addChild: right.
		frame addChild: (BlElement new
		background: (Color pink);
			        constraintsDo: [ :c | 
				        c horizontal matchParent.
				        c vertical exact: 5 ]).

		frame addChild: node ].
	

	frame openInOBlSpace
]

{ #category : #frame }
ToExperiments class >> example_LinearLayoutFillWithMatchParent [

	| frame left right fill |
	frame := BlElement new
		         background: Color gray;
		         size: 300 @ 100;
		         layout: BlLinearLayout new;
		         constraintsDo: [ :c | 
			         c horizontal matchParent.
			         c vertical fitContent ].
	frame layout cellSpacing: 10.
	left := BlElement new
		        background: Color blue;
		        width: 100;
		        constraintsDo: [ :c | c frame horizontal alignLeft ].

	fill := BlElement new
		        background: Color yellow;
		        height: 20;
		        constraintsDo: [ :c | 
			        c horizontal
				        matchParent.
				      c minWidth: 50 ].
	fill when: BlElementExtentChangedEvent do: [ :ann | fill width traceCr ].
	right := BlElement new
		         background: Color red;
		         width: 100;
		         constraintsDo: [ :c | c frame horizontal alignRight ].

	frame addChild: left.
	frame addChild: fill.
	frame addChild: right.
	frame openInNewSpace
]

{ #category : #image }
ToExperiments class >> example_Smalltalk_all_classes [

| column root vscrollBar container space |
	column := BlElement new
		          layout: BlLinearLayout vertical;
		          constraintsDo: [ :c | 
			          c horizontal matchParent.
			          c vertical fitContent ];
		          yourself.
	1 timesRepeat: [ 
	Object allSubclassesDo: [ :cls | 
		| lab |
		lab := ToLabel new text: cls name asRopedText.
		column addChild: lab ] ].

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
	space := OBlSpace new.
	space addChild: container.
	space show
]

{ #category : #image }
ToExperiments class >> example_Smalltalk_ui_icons_withElements [

| column root vscrollBar container space |
	column := BlElement new
		          layout: BlLinearLayout vertical;
		          constraintsDo: [ :c | 
			          c horizontal matchParent.
			          c vertical fitContent ];
		          yourself.
	1 timesRepeat: [ 
	Smalltalk ui icons allIconNames do: [ :k | 
		| lab im row |
		im := (Smalltalk ui icons iconNamed: k) asElement.
		im constraintsDo: [ :c | c linear vertical alignCenter ].
		lab := BlTextElement new text: k asString asRopedText.
		lab padding: (BlInsets all: 6).
		lab constraintsDo: [ :c | c linear vertical alignCenter ].
		row := BlElement new
			       layout: BlLinearLayout horizontal;
					padding: (BlInsets all: 5);
			       constraintsDo: [ :c | 
				       c horizontal matchParent.
				       c vertical fitContent ];
			       border: (BlBorder paint: (Color veryLightGray alpha: 0.4));
			       yourself.
		row
			addChild: lab;
			addChild: im.
		column addChild: row ] ].

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
	space := OBlSpace new.
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
	e := ToInnerWindow new.

	child := ToImage new
		         innerImage: (BlElement new
				          background: Color yellow;
				          size: 50 @ 50);
		         relocate: 200 @ 200.

	child addEventHandler: (BlPullHandler new pullTarget: e).

	e openInWorld.
	child openInWorld
]

{ #category : #stuffs }
ToExperiments class >> example_enterLeave [

	| e1 e2 space |
	e1 := BlElement new background: Color yellow; size: 100@60.
	e2 := BlElement new background: Color blue; preventMouseEvents.
	e1 when: BlMouseEnterEvent do: [ :event | e2 relocate: e1 bounds bottomRight. e1 space addChild: e2 ].
	e1 when: BlMouseLeaveEvent do: [ :event | e1 space removeChild: e2 ].
	space := OBlSpace new.
	space addChild: e1.
	space show
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

{ #category : #frame }
ToExperiments class >> example_mouseEvent_descending_bubbling [

	| gray blue yellow world |
	yellow := ToInnerWindow new
		          size: 450 @ 500;
		          in: [ :w | w root background: Color yellow ];
		          relocate: 50 @ 50.
	blue := ToInnerWindow new
		        in: [ :w | w root background: Color blue ];
		        size: 200 @ 200;
		        relocate: 150 @ 50;
		        yourself.
	gray := ToInnerWindow new
		        in: [ :w | w root background: Color gray ];
		        size: 100 @ 100;
		        relocate: 50 @ 50.
	world := ToManager world.

	world root addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :evt | 
				 ('bubbling world' , evt localPosition asString , ' '
				  , evt position asString , ' ' , evt screenPosition asString)
					 traceCr ]).
	gray addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :evt | 
				 ('bubbling gray' , evt localPosition asString , ' '
				  , evt position asString , ' ' , evt screenPosition asString)
					 traceCr ]).
	yellow addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :evt | 
				 ('bubbling yellow' , evt localPosition asString , ' '
				  , evt position asString , ' ' , evt screenPosition asString)
					 traceCr ]).
	blue addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :evt | 
				 ('bubbling blue' , evt localPosition asString , ' '
				  , evt position asString , ' ' , evt screenPosition asString)
					 traceCr ]).
	world root addEventFilter: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :evt | 
				 ('descending world' , evt localPosition asString , ' '
				  , evt position asString , ' ' , evt screenPosition asString)
					 traceCr ]).
	gray addEventFilter: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :evt | 
				 ('descending gray' , evt localPosition asString , ' '
				  , evt position asString , ' ' , evt screenPosition asString)
					 traceCr ]).
	yellow addEventFilter: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :evt | 
				 ('descending yellow' , evt localPosition asString , ' '
				  , evt position asString , ' ' , evt screenPosition asString)
					 traceCr ]).
	blue addEventFilter: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :evt | 
				 ('descending blue' , evt localPosition asString , ' '
				  , evt position asString , ' ' , evt screenPosition asString)
					 traceCr ]).
	blue addChild: gray.
	yellow addChild: blue.
	world addChild: yellow.
	world show
]

{ #category : #'popup strategy' }
ToExperiments class >> example_strategy [

	| win blue red  |

	win := ToInnerWindow new id: #win; 
		         background: Color gray;
		         size: 500 @ 400;
					relocate: 100@100.

	blue := ToElement new id: #blue;
		        background: Color blue;
		        size: 50@50.
		
	red := ToElement new id: #red;
		        background: Color red;
				relocate: 100@75;
		        size: 50@50.

	win addChild: red.
	win addChild: blue. 
	blue constraintsDo: [ :c | c ignoreByLayout  ].
	blue anchorLeft: red leftAnchor + 10.
	blue anchorTop: red topAnchor + 10.
	blue anchorBottom: red bottomAnchor - 10.
	blue anchorRight: red rightAnchor - 10.

	win openInOBlSpace.
	win relocate: 100@30.
	

]

{ #category : #frame }
ToExperiments class >> example_testTwoChildrenOnOppositeSidesWithSpan [
	<gtExample>
	| parent left span right |
	parent := BlElement new.
	parent background: (Color gray alpha: 0.3).
	parent layout: BlLinearLayout horizontal.
	parent
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].
	left := BlElement new.
	left background: (Color red alpha: 0.3).
	left border: (BlBorder paint: Color red width: 1).
	left margin: (BlInsets all: 5).
	left
		constraintsDo: [ :c | 
			c horizontal exact: 200.
			c vertical exact: 50.
			c grid vertical alignCenter.
			c grid horizontal alignLeft ].
	span := BlElement new.
	span
		border:
			(BlBorder builder dashed
				width: 1;
				paint: Color gray;
				build).
	span margin: (BlInsets all: 5).
	span
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	right := BlElement new.
	right margin: (BlInsets all: 5).
	right background: (Color blue alpha: 0.3).
	right border: (BlBorder paint: Color blue width: 1).
	right
		constraintsDo: [ :c | 
			c horizontal exact: 300.
			c vertical exact: 30.
			c linear vertical alignCenter ].
	parent
		addChildren:
			{left.
			span.
			right}.
	^ parent openInOBlSpace 
]

{ #category : #multistate }
ToExperiments class >> example_toScaling [

	| space container |
	container := ToElement new constraintsDo: [ :c | c accountTransformation ];
		             layout: BlLinearLayout vertical;
		             border: (BlBorder paint: Color black);
		             fitContent;
		             clipChildren: false.
	container layout cellSpacing: 5.
	container addChild: ((ToButton new
	constraintsDo: [ :c | c accountTransformation ];
			 clipChildren: false;
			 iconImage: (BlElement new
					  size: 100 @ 100;
					  background: Color blue);
			 labelText: ('Blue' asRopedText fontSize: 24);
			 transformDo: [ :d | 
				 d
					 topLeftOrigin;
					 scaleBy: 3.0 ]))  .
	container addChild: (ToButton new constraintsDo: [ :c | c accountTransformation ];
			 clipChildren: false;
			 iconImage: (BlElement new constraintsDo: [ :c | c accountTransformation ];
					  size: 100 @ 100;
					  background: Color red);
			 labelText: ('red' asRopedText fontSize: 24);
			 transformDo: [ :d | 
				 d
					 topLeftOrigin;
					 scaleBy: 2.0 ])  .
	space := OBlSpace new.
	container relocate: 100 @ 100.
	space addChild: container.
	space show
]

{ #category : #'animate toogle button' }
ToExperiments class >> example_toggle_with_animation [

	| btn track lab |
	track := ToElement new
		         geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		         border: (BlBorder paint: Color veryLightGray);
					layout: BlLinearLayout horizontal;
					padding: (BlInsets all: 3);
		         vFitContent; hExact: 40.
	track layout alignCenterLeft.
	lab := ToLabel new text: 'Off'.
	btn := ToElement new
		       geometry: BlEllipseGeometry new;
		       background: Color veryLightGray;
		       size: 16 @ 16;
		       relocate: 3 @ 3.
	track addChild: btn.
	track addChild: lab.
	track openInOBlSpace.
	btn addAnimation: (BlParallelAnimation withAll: { 
				 (BlTransformAnimation new
					  duration: 3000 milliSeconds;
					  transformDo: [ :b | b translateBy: 18 @ 0 ]).
				 (BlColorTransition new
					  duration: 3000 milliSeconds;
					  from: Color veryLightGray;
					  to: Color black;
					  onStepDo: [ :aColor :anElement | 
						  anElement background: aColor.
						  anElement parent border: (BlBorder paint: aColor) ]) })
]

{ #category : #frame }
ToExperiments class >> example_twoChildrenInPolygon [

	| top parent child child2 |
	parent := ToPolyElement new layout: BlLinearLayout vertical.
	parent
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
	parent clipChildren: false.

	parent border: (BlBorder paint: Color black width: 2).
	"parent outskirts: (BlOutskirts centered)."
	parent background: (Color gray alpha: 0.3).
	parent padding: (BlInsets all: 15).
	"parent margin: (BlInsets all: 10)."
	
	child := BlElement new size: 50@30.
	child layout: BlFrameLayout new.
	child background: (Color red alpha: 0.3).
	child margin: (BlInsets all: 3).
	child padding: (BlInsets all: 5).
	child border: (BlBorder paint: Color red width: 1).
	child outskirts: (BlOutskirts inside).
	"child addChild: (BlElement new background: Color yellow; size: 40@40)."

	child2 := BlElement new size: 250@100.
	child2 layout: BlFrameLayout new.
	child2 background: (Color blue alpha: 0.3).
	child2 margin: (BlInsets all: 3).
	child2 padding: (BlInsets all: 5).
	child2 border: (BlBorder paint: Color blue width: 1).
	child2 outskirts: (BlOutskirts inside).
	"child2 addChild: (BlElement new background: Color yellow; size: 40@40)."
	
	parent addChild: child.
	parent addChild: child2.
	
	top := ToElement new fitContent.
	"top clipChildren: false."
	top addChild: parent.
	top layout: BlFrameLayout new.
	top border: (BlBorder paint: Color green width: 2).
	top relocate: 15@15.
	^ top openInOBlSpace
]

{ #category : #frame }
ToExperiments class >> example_twoChildrenMatchParentInFitContent [
	| parent child child2 |
	parent := BlElement new.
	parent layout: BlLinearLayout vertical.
	parent background: (Color gray alpha: 0.3).
	parent padding: (BlInsets all: 25).
	parent
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
	child := BlTextElement new.
	child text: ('Hello world haba' asRopedText fontSize: 40).
	child background: (Color red alpha: 0.3).
	child margin: (BlInsets all: 5).
	child border: (BlBorder paint: Color red width: 1).
	child
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	child2 := BlTextElement new.
	child2 text: ('Hello' asRopedText fontSize: 15).
	child2 background: (Color blue alpha: 0.3).
	child2 margin: (BlInsets all: 5).
	child2 border: (BlBorder paint: Color blue width: 1).
	child2
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	parent addChild: child.
	parent addChild: child2.
	parent forceLayout.
	^ parent openInOBlSpace 
]
