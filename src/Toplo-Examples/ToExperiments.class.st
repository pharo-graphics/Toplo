Class {
	#name : #ToExperiments,
	#superclass : #Object,
	#category : #'Toplo-Examples-Experiments'
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

{ #category : #tree }
ToExperiments class >> example_ClassTree [

	| tree childrenHook pane |
	pane := self newTreePane.
	tree := pane childWithId: #treeElement.
	childrenHook := [ :aClass | aClass subclasses ].

	tree dataAccessor add: (ToExTreeDataWrapper new
			 dataAccessor: tree dataAccessor;
			 wrapped: ToElement;
			 childrenHook: childrenHook;
			 yourself).
			
	pane openInInnerWindow
]

{ #category : #'drag and drop' }
ToExperiments class >> example_DragAndDropWithLinearLayout [

	| container red blue space |
	container := ToPane new id: #container.
	container border: Color black.
	container matchParent.
	container layout: BlLinearLayout new.
	container initializeAsPasteUp.

	red := ToElement new id: #red.
	red extent: 100 asPoint.
	red background: Color red.
	blue := ToElement new id: #blue.
	blue extent: 50 asPoint.
	blue background: Color blue.

	container addChildren: {
			red.
			blue }.
	space := BlSpace new.
	space root addChild: container.
	space show.

	blue
		addEventHandlerOn: BlDragEnterEvent
		do: [ :event | blue border: (BlBorder paint: Color yellow width: 5) ].
	blue
		addEventHandlerOn: BlDragLeaveEvent
		do: [ :event | blue border: BlBorder empty ]
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
		           addChildren:
			           (l collect: [ :w | w asElement editorMeasurement ]).
	element openInSpace
]

{ #category : #elements }
ToExperiments class >> example_ExperimentForMultilineLabel0 [

	| element l |
	l := ToTextScissor new cut:
		     ('This is a text' asRopedText fontSize: 20).

	element := BlElement new
		           layout: AlbLineFlowLayout new;
		           constraintsDo: [ :c |
			           c horizontal matchParent.
			           c vertical fitContent ];
		           addChildren:
			           (l collect: [ :w | w asElement editorMeasurement ]).
	element border: (BlBorder paint: Color gray width: 1).
	element openInSpace
]

{ #category : #elements }
ToExperiments class >> example_ExperimentForMultilineLabel2 [

	| element l |
	l := ToTextScissor new cut: 'Default font and size' asRopedText
		     , ('Source code pro 40 bold' asRopedText
				      fontSize: 40;
				      fontName: 'Source code pro';
				      bold) , (' Default font 30' asRopedText fontSize: 30).

	element := BlElement new
		           layout: AlbLineFlowLayout new;
		           constraintsDo: [ :c |
			           c horizontal matchParent.
			           c vertical fitContent ];
		           addChildren:
			           (l collect: [ :w | w asElement editorMeasurement ]).
	element openInSpace
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

	root openInSpace
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

	root openInSpace
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
				               addChildren:
					               (cutted collect: [ :w |
							                w asElement editorMeasurement ]).
			root addChild: lineElement ] ].

	root openInSpace
]

{ #category : #frame }
ToExperiments class >> example_FlowLayoutHorizontal [

	| frame left right fill |
	frame := BlElement new
		         background: Color gray;
		         extent: 300 @ 100;
		         layout: BlLinearLayout horizontal;
		         constraintsDo: [ :c |
				         c horizontal matchParent.
				         c vertical fitContent ].
	"frame layout cellSpacing: 10."
	left := BlElement new
		        background: Color blue;
		        width: 100;
		        constraintsDo: [ :c | c frame horizontal alignLeft ].

	fill := BlElement new
		        background: Color yellow;
		        height: 20;
		        width: 200;
		        constraintsDo: [ :c |
				        c minWidth: 50.
				        c flow newLine: false.
				        c flow vertical alignCenter.
				        c linear vertical alignCenter ].

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
		         extent: 300 @ 100;
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

{ #category : #tree }
ToExperiments class >> example_IntegerTree [

	| tree nbItems rand childrenHook pane |
	nbItems := 50000.
	rand := Random new.
	pane := self newTreePane.
	tree := pane childWithId: #treeElement.
	childrenHook := [ :anInteger |
	                | nb |
	                nb := rand nextIntegerBetween: 0 and: 4.
	                1 to: nb ].

	tree dataAccessor addAll: ((1 to: nbItems) collect: [ :anInteger |
			 ToExTreeDataWrapper new
				 dataAccessor: tree dataAccessor;
				 wrapped: anInteger;
				 childrenHook: childrenHook;
				 yourself ]).

	pane openInInnerWindow
]

{ #category : #frame }
ToExperiments class >> example_LinearLayout [

	| frame left right fill |
	frame := BlElement new
		         background: Color gray;
		         extent: 300 @ 100;
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
				        c horizontal matchParent.
				        c minWidth: 50 ].
	fill
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :ann | fill width traceCr ].
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

	| win cpt root |
	root := BlElement new
		         background: Color lightGray;
		         layout: (BlLinearLayout vertical);
		         border: (BlBorder paint: Color gray);
		         constraintsDo: [ :c |
			         c horizontal fitContent.
			         c vertical fitContent ].
	cpt := 0.
	3 timesRepeat: [
		| left right fill menuItem labeledIcon |
		cpt := cpt + 20.
		menuItem := BlElement new
			        layout: (BlLinearLayout horizontal);
			        constraintsDo: [ :c |
				        c horizontal matchParent.
				        c vertical fitContent ].
		labeledIcon := ToElement new hMatchParent; vFitContent; layout: BlLinearLayout horizontal.
		left := BlElement new
			          id: #middle;
			          background: Color blue;
			          width: 10.
		fill := BlElement new
			         id: #fill;
			         background: Color yellow;
			         height: 15;
			         constraintsDo: [ :c |
				         c horizontal matchParent.
				         c vertical matchParent ].
		right := BlElement new
			         id: #right;
			         background: Color red;
			         width: 10 + cpt.
		labeledIcon addChild: left.
		labeledIcon addChild: fill.
		labeledIcon addChild: right.

		menuItem addChild: labeledIcon.
		root addChild: menuItem ].
	
	win := ToElement new layout: BlFrameLayout new.
	win fitContent.
	win addChild: root.

	win openInSpace
]

{ #category : #frame }
ToExperiments class >> example_LinearLayoutFillWithMatchParent [

	| frame left right fill |
	frame := BlElement new
		         background: Color gray;
		         extent: 300 @ 100;
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
				        c horizontal matchParent.
				        c minWidth: 50 ].
	fill
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :ann | fill width traceCr ].
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
ToExperiments class >> example_LinearLayoutWithLabels [

	| frame |
	frame := ToElement new
		         extent: 300 @ 100;
		         layout: BlLinearLayout new;
		         constraintsDo: [ :c |
				         c horizontal matchParent.
				         c vertical fitContent ].
	1 to: 5 do: [ :idx |
			frame addChild: (ToLabel new
					 text: idx asString;
					 background: Color random;
					 fitContent;
					 border: (BlBorder paint: Color black width: 1);
					 yourself) ].
	frame firstChild width: 60.
	frame openInNewSpace
]

{ #category : #'drag and drop' }
ToExperiments class >> example_PasteUpPane [

	| container red blue space |
	container := ToPane new id: #container.
	container border: Color black.
	container matchParent.
	container layout: BlBasicLayout new.
	container initializeAsPasteUp.

	red := ToElement new id: #red.
	red extent: 100 asPoint.
	red background: Color red.
	blue := ToElement new id: #blue.
	blue extent: 50 asPoint.
	blue background: Color blue.

	container addChildren: {
			red.
			blue }.
	space := BlSpace new.
	space root addChild: container.
	space show.

	blue
		addEventHandlerOn: BlDragEnterEvent
		do: [ :event | blue border: (BlBorder paint: Color yellow width: 5) ].
	blue
		addEventHandlerOn: BlDragLeaveEvent
		do: [ :event | blue border: BlBorder empty ]
]

{ #category : #'drag and drop' }
ToExperiments class >> example_PasteUpWithPlaceHolder [

	| container red blue pred pblue space phpane |
	container := ToPane new id: #container.
	container border: Color black.
	container layout: BlBasicLayout new.
	container matchParent.
	container placeholderBuilder: [ :placeholder :e |
			placeholder preventMeAndChildrenMouseEvents.
			phpane := placeholder.
			phpane layout: BlBasicLayout new ].
	container showPlaceholder.

	red := ToElement new id: #red.
	red extent: 100 asPoint.
	red background: Color red.
	blue := ToElement new id: #blue.
	blue extent: 50 asPoint.
	blue background: Color blue.

	container addChildren: {
			red.
			blue }.
	space := BlSpace new.
	space root addChild: container.
	space show.

	container addEventHandlerOn: BlDragStartEvent do: [ :event |
			| dragged |
			event consume.
			dragged := container findMouseEventTargetAt: event position.
			(dragged notNil and: [ dragged ~= container ]) ifTrue: [
					pred := event position - dragged position.
					container detachChild: dragged.
					phpane attachChild: dragged ] ].

	container addEventHandlerOn: BlDragEvent do: [ :event |
			event consume.
			phpane hasChildren ifTrue: [
					| dragged |
					dragged := phpane firstChild.
					dragged position: event position - pred ] ].

	container addEventHandlerOn: BlDragEndEvent do: [ :event |
			event consume.
			phpane hasChildren ifTrue: [
					| dragged |
					dragged := phpane firstChild.
					dragged position: event position - pred.
					phpane detachChild: dragged.
					container attachChild: dragged ] ].

	blue addEventHandlerOn: BlDragStartEvent do: [ :event |
			pblue := event position - blue position.
			event consume ].
	blue addEventHandlerOn: BlDragEvent do: [ :event |
			event consume.
			blue position: event position - pblue.
			blue forceLayout ].
	blue addEventHandlerOn: BlDragEndEvent do: [ :event | event consume ].

	blue
		addEventHandlerOn: BlDragEnterEvent
		do: [ :event | blue border: (BlBorder paint: Color yellow width: 5) ].
	blue
		addEventHandlerOn: BlDragLeaveEvent
		do: [ :event | "red addEventHandlerOn: BlDragEnterEvent do: [ :event | event consume. red background: Color random ].
red addEventHandlerOn: BlDragLeaveEvent do: [ :event | event consume. red background: Color red ].
"
			blue border: BlBorder empty ]
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
	space := BlSpace new.
	space root addChild: container.
	space show
]

{ #category : #elements }
ToExperiments class >> example_TextFlowWithBlElements [

	| element |
	element := BlElement new
		           layout: (AlbLineFlowLayout new lineSpacing: 10);
		           constraintsDo: [ :c |
				           c minWidth: 50.
				           c horizontal matchParent.
				           c vertical matchParent ];
		           addChildren: (20 timesCollect: [
						            | anAnimation |
						            anAnimation := BlSequentialAnimation new.
						            anAnimation add:
								            (BlTransformAnimation scale: 2) absolute.
						            anAnimation add:
								            (BlTransformAnimation scale: 0.5) absolute.
						            anAnimation beInfinite.
						            BlElement new
							            extent: 50 @ 20;
							            margin: (BlInsets all: 4);
							            background: (Color random alpha: 0.5);
							            addAnimation: anAnimation ]).
	element openInSpace
]

{ #category : #elements }
ToExperiments class >> example_TextFlowWithBlElements2 [

	| element |
	element := BlElement new
		           layout: BlLinearLayout new;
		           constraintsDo: [ :c |
				           c minWidth: 50.
				           c horizontal matchParent.
				           c vertical matchParent ];
		           addChildren: (20 timesCollect: [
						            | anAnimation e parent |
						            anAnimation := BlSequentialAnimation new.
						            anAnimation add:
								            (BlTransformAnimation scale: 2) absolute.
						            anAnimation add:
								            (BlTransformAnimation scale: 0.5) absolute.
						            anAnimation beInfinite.
						            parent := BlElement new
							                      layout:
								                      (BlWrapAroundChildrenLayout new
									                       addLayout: BlBasicNodeBasedLayout new);
							                      constraintsDo: [ :c |
									                      c horizontal fitContent.
									                      c vertical fitContent ];
							                      background: (Color gray alpha: 0.2).
						            e := BlElement new
							                 extent: 50 @ 20;
							                 margin: (BlInsets all: 4);
							                 background: (Color random alpha: 0.5);
							                 addAnimation: anAnimation.
						            parent
							            addChild: e;
							            yourself ]).
	element openInNewSpace
]

{ #category : #collapse }
ToExperiments class >> example_collapse1 [

	| container opened bgPaint openedAnimation collapsed closedAnimation openCollapsedBlock bar collapsedChild |
	container := BlElement new
		             layout: BlLinearLayout vertical;
		             constraintsDo: [ :c |
				             c horizontal fitContent.
				             c vertical fitContent ];
		             yourself.

	opened := true.

	bgPaint := BlLinearGradientPaint vertical
		           from: Color lightGreen
		           to: Color lightRed.


	openedAnimation := BlNumberTransition new
		                   from: 0;
		                   to: 150;
		                   duration: 0.2 second;
		                   onStepDo: [ :point | collapsed height: 0 + point ].
	closedAnimation := BlNumberTransition new
		                   from: 0;
		                   to: 150;
		                   duration: 0.2 second;
		                   onStepDo: [ :point |
			                   collapsed height: 150 - point + 0.01 ].

	openCollapsedBlock := [
		                      opened
			                      ifTrue: [
			                      collapsed addAnimation: openedAnimation copy ]
			                      ifFalse: [
			                      collapsed addAnimation: closedAnimation copy ] ].

	bar := BlElement new
		       background: Color lightBlue;
		       extent: 250 @ 50;
		       addEventHandlerOn: BlClickEvent do: [ :e |
				       e consume.
				       opened := opened not.
				       openCollapsedBlock value ];
		       yourself.

	collapsed := BlElement new
		             background: bgPaint;
		             extent: 250 @ 150;
		             border: (BlBorderBuilder new
				              paint: Color red;
				              width: 3;
				              dashed;
				              build);
		             yourself.

	collapsedChild := BlElement new
		                  background: Color purple;
		                  size: 50 @ 100;
		                  position: 50 asPoint;
		                  yourself.
	collapsed addChild: collapsedChild.

	container addChild: bar.
	container addChild: collapsed.
	container border: (BlBorder paint: Color black width: 3).
	container background: Color red.
	container padding: (BlInsets all: 3).
	container openInSpace
]

{ #category : #'mouse drag' }
ToExperiments class >> example_drag [

	| e child p |
	e := BlElement new
		     background: Color red;
		     extent: 500 @ 500.

	child := BlElement new
		         background: Color yellow;
		         extent: 50 @ 50;
		         position: 20 @ 20.

	e addChild: child.

	child addEventHandlerOn: BlDragStartEvent do: [ :evt |
			p := evt position - child position.
			evt consume ].

	child
		addEventHandlerOn: BlDragEvent
		do: [ :evt | child position: evt position - p ].

	e openInSpace
]

{ #category : #'mouse drag' }
ToExperiments class >> example_drag2 [

	| e child |
	e := BlElement new
		     background: Color red;
		     extent: 500 @ 500.

	child := BlElement new
		         background: Color yellow;
		         extent: 50 @ 50;
		         position: 20 @ 20.

	e addChild: child.
	child addEventHandler: BlPullHandler new.

	e openInNewSpace
]

{ #category : #'mouse drag' }
ToExperiments class >> example_drag3 [

	| e child |
	e := BlElement new
		     background: Color red;
		     extent: 50 @ 50;
		     clipChildren: false;
		     yourself.

	child := BlElement new
		         background: Color yellow;
		         extent: 50 @ 50;
		         position: 200 @ 200;
		         yourself.

	e addChild: child.
	child addEventHandler: (BlPullHandler new
			 target: e;
			 beVertical;
			 yourself).

	e openInNewSpace
]

{ #category : #'mouse drag' }
ToExperiments class >> example_drag4 [

	| e child |
	e := ToInnerWindow new.

	child := ToImage new
		         innerImage: (BlElement new
				          background: Color yellow;
				          extent: 50 @ 50);
		         position: 200 @ 200;
		         yourself.

	child addEventHandler: (BlPullHandler new
			 target: e;
			 yourself).

	e openInInnerWindow.
	child openInInnerWindow
]

{ #category : #elements }
ToExperiments class >> example_elements_sandbox [

	| sp root child1 child2 |
	root := BlElement new background: Color cyan.
	child1 := BlElement new background: Color yellow.
	child2 := BlElement new background: Color gray.
	root layout: BlLinearLayout vertical.
	root addChild: child1.
	root addChild: child2.
	root constraintsDo: [ :c |
			c horizontal fitContent .
			c vertical fitContent ].
	sp := BlSpace new.
	sp root addChild: root.
	sp show
]

{ #category : #stuffs }
ToExperiments class >> example_enterLeave [

	| e1 e2 space |
	e1 := BlElement new
		      background: Color yellow;
		      extent: 100 @ 60.
	e2 := BlElement new
		      background: Color blue;
		      preventMouseEvents.
	e1 addEventHandlerOn: BlMouseEnterEvent do: [ :event |
			e2 position: e1 bounds bottomRight.
			e1 space root addChild: e2 ].
	e1
		addEventHandlerOn: BlMouseLeaveEvent
		do: [ :event | e1 space root removeChild: e2 ].
	space := BlSpace new.
	space root addChild: e1.
	space show
]

{ #category : #frame }
ToExperiments class >> example_frame [

	| frame bar close fill fill2 expand title root bkg pullHandler |
	bkg := Color veryLightGray alpha: 0.2.
	frame := BlElement new
		         background: Color white;
		         extent: 300 @ 100.
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
	pullHandler := BlPullHandler new
		               target: frame;
		               yourself.
	bar addEventHandler: pullHandler.

	close := ToButton new
		         iconImage: Smalltalk ui theme windowCloseForm;
		         labelText: 'close'.
	close clickAction: [ frame removeFromParent ].
	close background: Color transparent.
	expand := ToButton new iconImage:
		          Smalltalk ui theme windowMaximizeForm.
	expand clickAction: [
			frame
				position: 0 @ 0;
				size: frame parent size ].

	title := ToLabel new
		         text: 'Frame';
		         background: Color transparent.
	bar addChild: close.
	bar addChild: fill.
	bar addChild: title.
	bar addChild: fill2.
	bar addChild: expand.

	root := BlElement new
		        background: Color transparent;
		        constraintsDo: [ :c |
				        c vertical matchParent.
				        c horizontal matchParent ].

	frame layout: BlLinearLayout vertical.
	frame addChild: bar.
	frame addChild: root.
	frame openInNewSpace
]

{ #category : #'linear layout' }
ToExperiments class >> example_linearLayoutWithChildAlign [

	| parent child |
	parent := ToElement new.
	child := ToElement new.
	parent layout: BlLinearLayout new.
	parent layout alignCenterRight.
	child extent: 50 @ 30.
	child layout: BlLinearLayout new.
	parent addChild: child.
	child background: Color yellow.
	parent background: Color blue.
	parent hMatchParent.
	parent vFitContent.
	parent openInSpace
]

{ #category : #frame }
ToExperiments class >> example_mouseEvent_descending_bubbling [

	| gray blue yellow world |
	yellow := ToInnerWindow new
		          extent: 450 @ 500;
		          in: [ :w | w root background: Color yellow ];
		          position: 50 @ 50.
	blue := ToInnerWindow new
		        in: [ :w | w root background: Color blue ];
		        extent: 200 @ 200;
		        position: 150 @ 50;
		        yourself.
	gray := ToInnerWindow new
		        in: [ :w | w root background: Color gray ];
		        size: 100 @ 100;
		        position: 50 @ 50.
	world := BlSpace new.

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
	blue root addChild: gray.
	yellow root addChild: blue.
	world root addChild: yellow.
	world show
]

{ #category : #rotation }
ToExperiments class >> example_rotation [

	| space container expected handle button count |
	space := BlSpace new.

	container := BlElement new
		             extent: 200 @ 200;
		             border: (BlBorder paint: Color lightRed width: 3);
		             position: 200 @ 200;
		             clipChildren: false.

	container layout: BlBasicLayout new.

	expected := BlElement new
		            background: Color lightGreen;
		            extent: 50 @ 100;
		            border: (BlBorder paint: Color orange width: 3).
	container addChild: expected.

	handle := BlElement new
		          background: (Color lightBlue asBlBackground opacity: 0.5);
		          extent: 100 @ 50;
		          border: (BlBorder paint: Color red width: 3).

	container addChild: handle.
	button := BlElement new.
	button layout: BlFrameLayout new.
	button addChild:
		(BlTextElement text: 'Click to rotate by 90' asRopedText).
	button padding: (BlInsets all: 5).
	button border: (BlBorder paint: Color gray).
	button constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	count := 0.
	button addEventHandlerOn: BlClickEvent do: [
			count := count + 1.
			handle transformDo: [ :t |
					t normalizedOrigin: 0.25 @ 0.5.
					t rotateBy: count * 90 ] ].
	space root addChild: button.
	space root addChild: container.

	space show
]

{ #category : #rotation }
ToExperiments class >> example_rotationAnimation [

	| space container expected handle count anim |
	space := BlSpace new.

	container := BlElement new
		             extent: 200 @ 200;
		             border: (BlBorder paint: Color lightRed width: 3);
		             position: 50 @ 50;
		             clipChildren: false.

	container layout: BlBasicLayout new.

	expected := BlElement new
		            background: Color lightGreen;
		            extent: 50 @ 100;
		            border: (BlBorder paint: Color orange width: 3).
	container addChild: expected.

	handle := BlElement new
		          background: (Color lightBlue asBlBackground opacity: 0.5);
		          extent: 100 @ 50;
		          border: (BlBorder paint: Color red width: 3).

	container addChild: handle.
	space root addChild: container.

	space show.
	count := 0.
	anim := BlRepeatedTaskAction new
		        delay: 300 milliSeconds;
		        action: [
				        handle transformDo: [ :t |
							        count := count + 1.
							        t normalizedOrigin: 0.25 @ 0.5.
							        t rotateBy: 10 * count ] ].
	handle enqueueTask: anim
]

{ #category : #space }
ToExperiments class >> example_space [

	| space |
	space := BlSpace new
		         position: 2000 @ 1000;
		         "toBack;"
					resizable: false;
		         borderless: true;
		         extent: 50 @ 50.
	space root background: Color red.
	space show
]

{ #category : #frame }
ToExperiments class >> example_testTwoChildrenOnOppositeSidesWithSpan [

	<gtExample>
	| parent left span right |
	parent := BlElement new.
	parent background: (Color gray alpha: 0.3).
	parent layout: BlLinearLayout horizontal.
	parent constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	left := BlElement new.
	left background: (Color red alpha: 0.3).
	left border: (BlBorder paint: Color red width: 1).
	left margin: (BlInsets all: 5).
	left constraintsDo: [ :c |
		c horizontal exact: 200.
		c vertical exact: 50.
		c grid vertical alignCenter.
		c grid horizontal alignLeft ].
	span := BlElement new.
	span border: (BlBorder builder dashed
			 width: 1;
			 paint: Color gray;
			 build).
	span margin: (BlInsets all: 5).
	span constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	right := BlElement new.
	right margin: (BlInsets all: 5).
	right background: (Color blue alpha: 0.3).
	right border: (BlBorder paint: Color blue width: 1).
	right constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 30.
		c linear vertical alignCenter ].
	parent addChildren: {
			left.
			span.
			right }.
	^ parent openInSpace
]

{ #category : #multistate }
ToExperiments class >> example_toScaling [

	| space container |
	container := ToElement new
		             layout: BlLinearLayout vertical;
		             border: (BlBorder paint: Color black);
		             fitContent;
		             clipChildren: false.
	"constraintsDo: [ :c | c accountTransformation ];"
	container layout cellSpacing: 5.
	container addChild: (ToButton new
			 constraintsDo: [ :c | c accountTransformation ];
			 clipChildren: false;
			 iconImage: (BlElement new
					  extent: 100 @ 100;
					  background: Color blue);
			 labelText: ('Blue' asRopedText fontSize: 24);
			 transformDo: [ :d |
					 d
						 topLeftOrigin;
						 scaleBy: 3.0 ]).
	container addChild: (ToButton new
			 constraintsDo: [ :c | c accountTransformation ];
			 clipChildren: false;
			 iconImage: (BlElement new
					  constraintsDo: [ :c | c accountTransformation ];
					  extent: 100 @ 100;
					  background: Color red);
			 labelText: ('red' asRopedText fontSize: 24);
			 transformDo: [ :d |
					 d
						 topLeftOrigin;
						 scaleBy: 2.0 ]).
	space := BlSpace new.
	container position: 100 @ 100.
	space root addChild: container.
	space show
]

{ #category : #'toogle button' }
ToExperiments class >> example_toggle_sliding [

	| toggle track but left right slideB slide |
	toggle := ToElement new
		          vFitContent;
		          background: Color lightBlue;
		          "padding: (BlInsets all: 2);"border:
			          (BlBorder paint: Color blue);
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 14);
		          layout: BlLinearLayout horizontal.
	track := ToElement new
		         fitContent;
		         layout: BlLinearLayout horizontal.
	left := BlElement new
		        extent: 17 @ 14;
		        background: Color gray;
		        margin: (BlInsets left: 5 right: 5).
	but := BlElement new
		       extent: 14 @ 14;
		       geometry: BlCircleGeometry new;
		       background: Color green.
	right := BlElement new
		         size: 17 @ 14;
		         background: Color gray;
		         margin: (BlInsets left: 5 right: 5).
	track addChildren: {
			left.
			but.
			right }.

	toggle width:
		toggle padding left + toggle padding right + but requestedWidth
		+ (left requestedWidth + left margin left + left margin right max:
				 right requestedWidth + right margin left + right margin right).
	toggle addChild: track.

	slide := 0.
	slideB := [
		          (left requestedWidth max: right requestedWidth)
		          - toggle padding left - toggle padding right
		          + left margin right + left margin left "+ right margin left + right margin right" ].
	slide := slideB value.
	track transformDo: [ :aTransform |
		aTransform translateBy: slide negated @ 0 ].

	toggle addEventHandlerOn: BlClickEvent do: [
			slide := slide isZero
				         ifTrue: [ slideB value ]
				         ifFalse: [ 0 ].
			slide traceCr.
			track transformDo: [ :aTransform |
				aTransform translateBy: slide negated @ 0 ] ].

	toggle openInSpace
]

{ #category : #'toogle button' }
ToExperiments class >> example_toggle_sliding_with_animation1 [

	| root toggle track but left right slide |
	root := ToElement new
		        fitContent;
		        border: (BlBorder paint: Color black);
		        padding: (BlInsets all: 2);
		        layout: BlFrameLayout new.
	toggle := ToElement new
		          vFitContent;
		          layout: BlLinearLayout horizontal.
	track := ToElement new
		         fitContent;
		         border: (BlBorder paint: Color black);
		         layout: BlLinearLayout horizontal.
	left := BlElement new
		        extent: 30 @ 14;
		        background: Color veryLightGray;
		        margin: (BlInsets left: 5 right: 5).
	but := BlElement new
		       extent: 14 @ 14;
		       position: left requestedWidth @ 0;
		       background: Color green;
		       border: (BlBorder paint: Color black).
	right := BlElement new
		         extent: 20 @ 14;
		         background: Color pink.
	track addChildren: {
			left.
			but.
			right }.

	toggle width: but requestedWidth
		+ (left requestedWidth + left margin left + left margin right max:
				 right requestedWidth + right margin left + right margin right).
	toggle addChild: track.

	"slide := ((left requestedWidth max: right requestedWidth) - toggle padding left - toggle padding right) ."
	"track transformDo: [ :aTransform | aTransform translateBy: slide  @ 0 ]."
	slide := 0.
	slide := (left requestedWidth max: right requestedWidth)
	         - toggle padding left - toggle padding right.
	track transformDo: [ :aTransform |
		aTransform translateBy: slide negated @ 0 ].
	slide := slide isZero
		         ifTrue: [
				         (left requestedWidth max: right requestedWidth)
				         - toggle padding left - toggle padding right ]
		         ifFalse: [ 0 ].
	slide := left requestedWidth - toggle padding left
	         - toggle padding right. "+ left margin left + left margin right"

	toggle addEventHandlerOn: BlClickEvent do: [
			slide traceCr.
			track addAnimation: (BlTransformAnimation new
					 duration: 200 milliSeconds;
					 transformDo: [ :b | b translateBy: slide @ 0 ]).
			slide := slide * -1 ].
	root addChild: toggle.
	root openInSpace
]

{ #category : #'toogle button' }
ToExperiments class >> example_toggle_with_animation [

	| btn track lab |
	track := ToElement new
		         geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		         border: (BlBorder paint: Color veryLightGray);
		         layout: BlLinearLayout horizontal;
		         padding: (BlInsets all: 3);
		         vFitContent;
		         hExact: 40.
	track layout alignCenterLeft.
	lab := ToLabel new text: 'Off'.
	btn := ToElement new
		       geometry: BlEllipseGeometry new;
		       background: Color veryLightGray;
		       extent: 16 @ 16;
		       position: 3 @ 3.
	track addChild: btn.
	track addChild: lab.
	track openInSpace.
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
	parent effect:
		(BlGaussianShadowEffect
			 color: Color black
			 width: 15
			 offset: 0 asPoint).
	parent constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	parent clipChildren: true.

	parent border: (BlBorder paint: Color black width: 2).
	"parent outskirts: (BlOutskirts centered)."
	parent background: (Color gray alpha: 0.6).
	parent padding: (BlInsets all: 15).
	parent margin: (BlInsets all: 10).

	child := BlElement new extent: 50 @ 30.
	child layout: BlFrameLayout new.
	child background: (Color red alpha: 0.3).
	child margin: (BlInsets all: 3).
	child padding: (BlInsets all: 5).
	child border: (BlBorder paint: Color red width: 1).
	child outskirts: BlOutskirts inside.
	child addChild: (BlElement new
			 background: Color yellow;
			 extent: 40 @ 40).

	child2 := BlElement new size: 250 @ 100.
	child2 layout: BlFrameLayout new.
	child2 background: (Color blue alpha: 0.3).
	child2 margin: (BlInsets all: 3).
	child2 padding: (BlInsets all: 5).
	child2 border: (BlBorder paint: Color blue width: 1).
	child2 outskirts: BlOutskirts inside.
	child2 addChild: (BlElement new
			 background: Color yellow;
			 size: 40 @ 40).

	parent addChild: child.
	parent addChild: child2.
	parent addEventHandler: (BlEventHandler
			 on: BlMouseEnterEvent
			 do: [ 'Enter' traceCr ]).
	parent addEventHandler: (BlEventHandler
			 on: BlMouseLeaveEvent
			 do: [ 'Leave' traceCr ]).
	child addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [
					 child2 hasParent
						 ifTrue: [ child2 removeFromParent ]
						 ifFalse: [ parent addChild: child2 ] ]).

	top := ToElement new fitContent.
	top clipChildren: true.
	top addChild: parent.
	top layout: BlFrameLayout new.
	top border: (BlBorder paint: Color green width: 2).
	top position: 15 @ 15.
	^ top openInInnerWindow
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
	^ parent openInSpace 
]

{ #category : #rotation }
ToExperiments class >> example_verticalLabel [

	((ToLabel new text: 'AAAA') transformDo: [ :t |
			 t normalizedOrigin: 0.5 @ 1.
			 t rotateBy: 270 ])
		border: (BlBorder paint: Color gray);
		openInSpace
]

{ #category : #label }
ToExperiments class >> labelWithForegroundWithGradient [ 

	<script>
	| l |
	l := ToAttributedLabel new.
	l background: ((BlLinearGradientPaint direction: 0 @ 1)
				from: Color red
				to: Color blue).
	l text: 'AZERTYUIOP'.
	l openInSpace 
]

{ #category : #tree }
ToExperiments class >> newTreeElement [

	| tree |
	tree := ToListElement new.
	tree withRowNumbers.

	tree nodeBuilder: [ :node :anExWrapper :holder |
		| align triplet arrowIcon arrowButton iconContainer hasChildren |
		align := anExWrapper level * 25.
		triplet := ToTripletElement new.
		triplet horizontal: true.
		triplet middleElement:
			(ToLabel new text: anExWrapper wrapped asString).
		arrowIcon := ToImage new.
		hasChildren := anExWrapper hasChildren.
		hasChildren ifTrue: [
			| arrowTk |
			arrowTk := anExWrapper isExpanded
				           ifTrue: [ #'iconic-arrow-down' ]
				           ifFalse: [ #'iconic-arrow-right' ].
			arrowIcon innerImage: (tree valueOfTokenNamed: arrowTk) ].
		arrowIcon
			size: 18 asPoint;
			id: #arrow.
		iconContainer := ToElement new
			                 fitContent;
			                 yourself.
		iconContainer layout: BlLinearLayout horizontal.
		iconContainer addChild: (ToElement new size: align @ 0).
		arrowButton := ToButton new
			       icon: arrowIcon;
			       yourself.
		arrowButton addAllStamps: #( #iconic #borderless ).
		iconContainer addChild: arrowButton.
		triplet startInterspace: 10.
		triplet startElement: iconContainer.
		hasChildren ifTrue: [
			arrowButton clickAction: [ 
				| newArrowTk |
				anExWrapper toggle.
				newArrowTk := anExWrapper isExpanded
					              ifTrue: [ #'iconic-arrow-down' ]
					              ifFalse: [ #'iconic-arrow-right' ].
				arrowIcon innerImage: (tree valueOfTokenNamed: newArrowTk) ] ].
		triplet hMatchParent.
		node addChild: triplet ].
	
	^ tree
]

{ #category : #tree }
ToExperiments class >> newTreePane [

	| tree inspectBtn showStatisticsBtn disabox menuPane pane |
	tree := self newTreeElement.
	tree id: #treeElement.
	inspectBtn := ToMenuItem new labelText: 'Inspect'.
	showStatisticsBtn := ToMenuItem new labelText: 'Statistics'.
	disabox := ToCheckMenuItem new label: (ToLabel text: 'Disable').

	menuPane := ToMenuPane new.
	menuPane hMatchParent.
	menuPane addItem: inspectBtn.
	menuPane addItem: showStatisticsBtn.
	menuPane addItem: disabox.

	inspectBtn clickAction: [ tree space root inspect ].
	disabox clickAction: [ tree disabled: disabox isChecked ].
	showStatisticsBtn clickAction: [ 
		tree space showStatisticsWindow ].

	pane := ToPane vertical matchParent.
	pane addChild: menuPane.
	pane addChild: tree.

	^ pane
]
