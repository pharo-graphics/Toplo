Class {
	#name : #ToSandBox,
	#superclass : #Object,
	#category : #'Toplo-Examples'
}

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

	| text space client |
	text := self methodText asRopedText.
	client := ToAlbumViewModel new.
	client styler: (BlRBTextStyler new classOrMetaClass: self class).
	client text: text copy.
	client withSaveCapability.
	client withLineNumbers.
	client onSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: true ].
	client onCancelRequestedDo: [ :cancelRequested | cancelRequested client text: text copy ].
	"client inspect."
	space := OBlSpace new.
	space root addChild: client onWidget.
	space show.

]

{ #category : #album }
ToSandBox class >> example_EditorWithGhostText [

	| ghost view |
	ghost := ('Here is a GhostText' , String cr , 'visible only if the text is empty') asRopedText.
	ghost foreground: Color lightGray.
	ghost fontSize: 24.

	view := (ToAlbumViewModel new
		 onSaveRequestedDo: [ :announcement | announcement client saveResult: true ];
		 withGhostText: ghost;
		 withLineNumbers;
		 withSaveCapability;
		 onSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: true ];
		 withEditsFeedbackLayer) onWidget.

	view openInOBlSpace.
view viewModel inspect.
]

{ #category : #image }
ToSandBox class >> example_Smalltalk_ui_icons [

	| column |
	column := BlElement new
		          layout: BlLinearLayout vertical;
		          constraintsDo: [ :c | 
			          c horizontal fitContent.
			          c vertical fitContent ];
		          yourself.
	Smalltalk ui icons allIconNames do: [ :k | 
		| lab im row |
		im := ToImage new image: (Smalltalk ui icons iconNamed: k).
		im constraintsDo: [ :c | c linear vertical alignCenter ].
		im border: (BlBorder paint: Color lightGray).
		lab := ToLabel new text: k asString.
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

	column openInOBlSpace
]

{ #category : #stuffs }
ToSandBox class >> example_enterLeave [

	| e1 e2 space |
	e1 := BlElement new background: Color yellow; size: 100@60.
	e2 := BlElement new background: Color blue; preventMouseEvents.
	e1 when: BlMouseEnterEvent do: [ :event | e2 relocate: e1 bounds bottomRight. e1 space addChild: e2 ].
	e1 when: BlMouseLeaveEvent do: [ :event | e1 space removeChild: e2 ].
	space := OBlSpace new.
	space addChild: e1.
	space show
]

{ #category : #button }
ToSandBox class >> example_toButton0 [

	| but |
	but := ToButtonViewModel new.
	but openInOBlSpace
]

{ #category : #button }
ToSandBox class >> example_toButtonOritentaionDirectionChanger [

	| but space |
	but := ToButton new.
	but background: Color black.
	but border: (BlBorder paint: Color lightGray).
	but beIconFirst.
	but alignCenter.
	but labelText: ('Button' asRopedText foreground: Color white; bold).
	but iconImage: (BlElement new size: 20@20; background: Color lightGray; yourself).
	but layout cellSpacing: 4.
	but padding: (BlInsets all: 4).
	but action: [ 
		but labelFirst: but labelFirst not.
		but direction: but direction inverted.
		but orientation: but orientation inverted.
		"but alignCenter" ].
	but whenActionPerformedDo: [ self inform: 'Button action performed' ].
	space := OBlSpace new.
	space addChild: but.
	"space host: BAOSWindowSDL2Host new."
	space show
]

{ #category : #button }
ToSandBox class >> example_toButtonWithHelp [

	| but space |
	but := ToButton new.
	but help: ('This is a button', String cr, 'so, click on me...') asRopedText. 
	but action: [ self inform: 'Button clicked' ].
	but whenActionPerformedDo: [ self inform: 'Button action performed' ].
	but background: (Color red alpha: 0.3).
	but size: 32@16.
	space := OBlSpace new.
	space addChild: but.
	space show
]

{ #category : #image }
ToSandBox class >> example_toImage0 [

	| im |
	im := ToImage new.
	im inspect.
	im openInOBlSpace 
]

{ #category : #image }
ToSandBox class >> example_toImage1 [

	| im |
	im := ToImage new image: (BlElement new
		  size: 16 @ 16;
		  background: (Color green alpha: 0.5);
		  geometry: BlCircleGeometry new ).
	im inspect.
	im openInOBlSpace 
]

{ #category : #image }
ToSandBox class >> example_toImageViewModel0 [

	| im |
	im := ToImageViewModel new.
	im inspect.
	im onWidget openInOBlSpace 
]

{ #category : #image }
ToSandBox class >> example_toImageViewModel1 [

	| im |
	im := ToImageViewModel new image: (BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color gray width: 2);
		  background: (Color gray alpha: 0.1);
		  geometry: BlCircleGeometry new ).
	im inspect.
	im onWidget openInOBlSpace 
]

{ #category : #image }
ToSandBox class >> example_toImageViewModel2 [

	| im |
	im := ToImageViewModel new image: (Form dotOfSize: 40).
	im inspect.
	im onWidget openInOBlSpace 
]

{ #category : #image }
ToSandBox class >> example_toImageViewModel3 [

	| im |
	im := ToImageViewModel new image: (Smalltalk ui icons iconNamed: #classIcon).
	im widgetPerformOrDefer: [:w | w border: (BlBorder paint: Color black width: 2)].
	im onWidget openInOBlSpace
]

{ #category : #label }
ToSandBox class >> example_toLabel0 [

	| lab |
	lab := ToLabel new.
	lab inspect.
	lab border: (BlBorder paint: Color black).
	lab openInOBlSpace.

]

{ #category : #label }
ToSandBox class >> example_toLabel3 [

	| lab |
	lab := ToLabel new text: ('This is a bold label' asRopedText fontSize: 20; bold; foreground: Color gray; yourself).
	lab background: Color lightBlue.
	lab editable: true.
	lab alignCenter.
	lab border: (BlBorder paint: Color yellow width: 1).
	lab openInOBlSpace.

]

{ #category : #label }
ToSandBox class >> example_toLabel3_bis [

	| model widget |
	model := ToLabelViewModel new.
	model text: ('This is a bold label' asRopedText
			 fontSize: 20;
			 bold;
			 foreground: Color gray;
			 yourself).
	model widgetPerformOrDefer: [ :label | 
		label background: Color lightBlue.
		label alignCenter.
		label border: (BlBorder paint: Color yellow width: 1) ].
	model editable: true.
	(widget := model onWidget) openInOBlSpace	
]

{ #category : #label }
ToSandBox class >> example_toLabel4 [

	| lab1 lab2 lab3 root |
	root := BlElement new constraintsDo: [ :c | 
		        c vertical fitContent.
		        c horizontal matchParent ].

	root layout: BlLinearLayout vertical.
	lab1 := ToLabel new text:
		        ('Editable centered monoline label (cmd-shift-mousedown to edit then return or escape)'
			         asRopedText fontSize: 18).
	lab1 editable: true.
	lab1 vFitContent.
	lab1 hMatchParent.
	lab1 alignCenter.
	lab1 border: (BlBorder paint: Color lightGray width: 1).
	root addChild: lab1.

	lab2 := ToLabel new text:
		        (('Editable multiline label' , String cr , 'secondLine'
		          , String cr
		          , 'cmd-shift-mousedown to edit then cmd-return or escape)')
			         asRopedText fontSize: 18).
	lab2 beMultiLine.
	lab2 vFitContent.
	lab2 hMatchParent.
	lab2 border: (BlBorder paint: Color lightGray width: 1).
	lab2 viewModel editable: true.

	root addChild: lab2.
	lab3 := ToLabel new text:
		        ('Monoline label not editable' asRopedText fontSize: 18).
	lab3 border: (BlBorder paint: Color lightGray width: 1).
	lab3 vFitContent.
	lab3 hMatchParent.
	root addChild: lab3.
	root clipChildren: false.

	root openInOBlSpace
]

{ #category : #label }
ToSandBox class >> example_toLabel5 [

	| label root model |
	root := BlElement new constraintsDo: [ :c | 
		        c vertical fitContent.
		        c horizontal matchParent ].
	root layout: BlLinearLayout vertical.
	label := ToLabel new.
	model := ToLabelViewModel new.
	model text: ('' asRopedText fontSize: 24).
	model beMultiLine.
	model widgetPerformOrDefer: [ :widget | 
		widget vFitContent.
		widget hMatchParent.
		widget border: (BlBorder paint: Color red width: 1) ].
	model editable: true.
	label viewModel: model.
	root addChild: label.
	root openInOBlSpace
]

{ #category : #label }
ToSandBox class >> example_toLabelWithTime [

	| lab timeLab container anim |
	lab := ToLabel new text: ('Time: ' asRopedText
			        fontSize: 20;
			        foreground: Color gray;
			        yourself).
	container := BlElement new
		             layout: BlLinearLayout horizontal;
		             constraintsDo: [ :c | 
			             c horizontal matchParent.
			             c vertical matchParent ].
	container
		border: (BlBorder paint: Color lightGray width: 3);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].
	timeLab := ToLabel new.
	anim := BlRepeatedTaskAction new
		        delay: 1 second;
		        action: [ 
			        timeLab text: (DateAndTime now asString asRopedText
						         fontSize: 20;
						         foreground: Color gray) ].
	timeLab enqueueTask: anim.

	container addChildren: { 
			lab.
			timeLab }.
	container openInOBlSpace
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

	| lab1 lab2 space container |
	lab1 := ToLabel new
		        text: (('This is a Centered editable label' , String cr
			          , AeFontManager defaultFontFamilyName , ' size 20')
				         asRopedText
				         fontName: AeFontManager defaultFontFamilyName;
				         fontSize: 20);
		        border: (BlBorder paint: Color lightGray width: 1);
		        outskirts: BlOutskirts inside.
	lab2 := ToLabel new
		        text: (('This is a Centered editable label' , String cr
			          , AeFontManager defaultCodeFontFamilyName , ' size 20')
				         asRopedText
				         fontName: AeFontManager defaultCodeFontFamilyName;
				         fontSize: 20);
		        border: (BlBorder paint: Color lightGray width: 1);
		        outskirts: BlOutskirts inside.
	lab1 beMultiLine.
	lab2 beMultiLine.
	lab1 matchParent.
	lab2 matchParent.
	lab1 alignCenter.
	lab2 alignCenter.
	lab1 innerElement alignCenter.
	lab2 innerElement alignCenter.
	lab1 editable: true.
	lab2 editable: true.
	container := BlElement new
		             layout: BlLinearLayout vertical;
		             constraintsDo: [ :c | 
			             c horizontal matchParent.
			             c vertical matchParent ].
	container addChildren: { 
			lab1.
			lab2 }.
	space := container openInOBlSpace
]

{ #category : #accessing }
ToSandBox class >> methodText [
	^ self  class sourceCodeAt: #example_CodeEditorWithToClient
]
