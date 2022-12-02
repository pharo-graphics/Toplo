Class {
	#name : #ToSandBox,
	#superclass : #Object,
	#category : #'Toplo-Examples'
}

{ #category : #window }
ToSandBox class >> example_2RootFramesInOBlWorld [

	ToInnerWindow new
		title: 'Frame 1';
		openInWorld.
	ToInnerWindow new
		title: 'Frame 2';
		openInWorld
]

{ #category : #album }
ToSandBox class >> example_CodeEditorWithToAlbumModel [

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
	client := ToAlbumModel new.
	client styler: (BlRBTextStyler new classOrMetaClass: self class).
	client text: text copy.
	client withSaveCapability.
	client withLineNumbers.
	client whenSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: true ].
	client whenCancelRequestedDo: [ :cancelRequested | cancelRequested client text: text copy ].
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

	view := (ToAlbumModel new
		 withGhostText: ghost;
		 withLineNumbers;
		 withSaveCapability;
		 whenSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: true ];
		 withEditsFeedbackLayer) onWidget.

	view openInOBlSpace
]

{ #category : #album }
ToSandBox class >> example_EditorWithGhostTextWithToAlbumModel [

	| ghost view |
	ghost := ('Here is a GhostText' , String cr , 'visible only if the text is empty') asRopedText.
	ghost foreground: Color lightGray.
	ghost fontSize: 24.

	view := (ToAlbumModel new
		 withGhostText: ghost;
		 withLineNumbers;
		 withSaveCapability;
		 whenSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: true ];
		 withEditsFeedbackLayer) onWidget.

	view openInOBlSpace
]

{ #category : #window }
ToSandBox class >> example_Popup1 [

	| e p container but |
	container := ToInnerWindow new
		             relocate: 10 @ 10;
		             size: 400 @ 200;
		             yourself.
	e := ToElement new
		     background: Color lightGray;
		     size: 100 @ 100;
		     relocate: 50 @ 50.
	p := ToPopupWindow new
		     background: Color green;
		     widget: e.
	but := ToWidget new size: 50@90.
	but addDresser: ToButtonDefaultDresser new.
	but whenAnnouncement: ToButtonClickLaunchAction do: [ self inform: 'Click'. p close ]. 
	p addChild: but.
	p addEventHandler: (BlEventHandler
			 on: BlSpaceMouseDownOutsideEvent
			 do: [ :event | self inform: 'OUTSIDE'. p close ]).
	e addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :evt | 
				 p isAttachedToSceneGraph
					 ifFalse: [ p popupAtGlobalPosition: evt position ] ]).
	p addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :evt | self inform: 'CLICK'. p close ]).

	container addChild: e.
	container openInOBlSpace
]

{ #category : #image }
ToSandBox class >> example_Smalltalk_ui_icons [

	| column root vscrollBar container |
	column := BlElement new
		          layout: BlLinearLayout vertical;
		          constraintsDo: [ :c | 
			          c horizontal fitContent.
			          c vertical fitContent ];
		          yourself.
	Smalltalk ui icons allIconNames do: [ :k | 
		| lab im row |
		im := ToImage new innerImage: (Smalltalk ui icons iconNamed: k).
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
	container openInOBlSpace 
]

{ #category : #space }
ToSandBox class >> example_elementInPopupRoot [

	| e space |
	space := OBlSpace new.
	e := BlElement new background: Color blue; size: 50@50; yourself.
	space popupLayer addChild: e.
	e addEventHandler: (BlEventHandler
				on: BlClickEvent
				do: [ :evt | self inform: 'Clicked'  ]).
	space show
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

{ #category : #window }
ToSandBox class >> example_rootFrame1 [
	ToInnerWindow new title: 'Internal Frame example' ; openInOBlSpace 
]

{ #category : #'text field' }
ToSandBox class >> example_textField0 [

	| t |
	t := ToTextField new.
	t openInOBlSpace.
	t innerElement inspect
	
]

{ #category : #'text field' }
ToSandBox class >> example_textFieldWithGhostText [

	| t text |
	t := ToTextField new withSaveCapability.
	text := ''.
	t withGhostText: 'Enter to accept'.
	t text: text copy.
	t whenSaveRequestedDo: [ :saveRequested | 
		saveRequested client saveResult: true.
		text := saveRequested client text copy].
	t whenCancelRequestedDo: [ :cancelRequested | 
		cancelRequested client text: text copy ].
	t openInOBlSpace.

]

{ #category : #'text field' }
ToSandBox class >> example_textFieldWithLineWrapping [

	| t |
	t := ToTextField new withLineWrapping.
	t openInOBlSpace
]

{ #category : #'text field' }
ToSandBox class >> example_textFieldWithLineWrappingWithSaveCapability [

	| t |
	t := ToTextField new withLineWrapping; withSaveCapability.
	t openInOBlSpace
]

{ #category : #'text field' }
ToSandBox class >> example_textFieldWithSaveCapability [

	| t text |
	t := ToTextField new withSaveCapability; tooltipString: 'Return to accept'.
	text := ''.
	t text: text copy.
	t whenSaveRequestedDo: [ :saveRequested | 
		saveRequested client saveResult: true.
		text := saveRequested client text copy].
	t whenCancelRequestedDo: [ :cancelRequested | 
		cancelRequested client text: text copy ].
	t openInInnerWindow 
]

{ #category : #checkbox }
ToSandBox class >> example_to3statesCheckbox [

	| but |
	but := ToCheckboxModel new withIndeterminate.
	but onWidget openInOBlSpace
]

{ #category : #checkbox }
ToSandBox class >> example_to3statesRadioButton [

	| but |
	but := ToRadioButtonModel new withIndeterminate.
	but onWidget openInOBlSpace
]

{ #category : #button }
ToSandBox class >> example_toBasicButton0 [

	| but |
	but := ToGeneralButton new.
	but whenClickedDo: [ self inform: 'clicked' ].
	but openInOBlSpace
]

{ #category : #button }
ToSandBox class >> example_toBasicButton1 [

	| but |
	but := ToGeneralButton new.
	but addChild: (BlElement new
				 size: 30 @ 30;
				 yourself).
	but fitContent.
	but whenClickedDo: [ self inform: 'clicked' ].	
	but openInOBlSpace 
]

{ #category : #button }
ToSandBox class >> example_toBasicButton2 [

	| but lab |
	lab := ToLabel new text:
		       (('Button' asRopedText)
			        fontSize: 40;
			        yourself).
	but := ToGeneralButton new.
	but matchParent.
	but addChild: lab.
	but layout alignCenter.
	but whenClickedDo: [ self inform: 'clicked' ].
	but openInOBlSpace
]

{ #category : #button }
ToSandBox class >> example_toBasicButton3 [

	| but |
	but := ToButton new labelText: (('Button' asRopedText)
			        fontSize: 40;
			        yourself).
	but matchParent.
	but layout alignCenter.
	but whenClickedDo: [ self inform: 'clicked' ].
	but openInOBlSpace
]

{ #category : #button }
ToSandBox class >> example_toBasicButtonModel0 [

	| but |
	but := ToGeneralButtonModel new.
	but whenClickedDo: [ self inform: 'clicked' ].
	but onWidget openInOBlSpace
]

{ #category : #button }
ToSandBox class >> example_toBasicButtonModel1 [

	| but |
	but := ToGeneralButtonModel new.
	but widgetDo: [ :widget | 
		widget addChild: (BlElement new
				 size: 30 @ 30;
				 background: Color lightBlue;
				 yourself) ].
	but widgetDo: [ :widget | widget fitContent ].
	but whenClickedDo: [ self inform: 'clicked' ].
	but onWidget openInOBlSpace
]

{ #category : #button }
ToSandBox class >> example_toButton0 [

	| but |
	but := ToButton new.
	but  openInOBlSpace 
]

{ #category : #button }
ToSandBox class >> example_toButtonModel1 [

	| but |
	but := ToButtonModel new labelText: 'Button'.
	but whenClickedDo: [ self inform: 'clicked' ].
	but  onWidget openInOBlSpace
]

{ #category : #button }
ToSandBox class >> example_toButtonModelWithIconOnly [

	| but space |
	but := ToButtonModel new.
	but iconImage: (BlElement new
			 size: 60 @ 20;
			 yourself).
	but widgetDo: [ :widget | widget padding: (BlInsets all: 3) ].
	space := OBlSpace new.
	space addChild: but onWidget.
	space show
]

{ #category : #button }
ToSandBox class >> example_toButtonModelWithTextAndIconVertical [

	| but space |
	but := ToButtonModel new
		       beVertical;
		       beLabelFirst.
	but labelText: 'Button'.
	but iconImage: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself).
	but whenClickedDo: [ :ann | 
		ann widget horizontal: ann widget horizontal not ].
	space := OBlSpace new.
	space addChild: but onWidget.
	space show
]

{ #category : #button }
ToSandBox class >> example_toButtonOrientationChanger [

	| but space iconImage |
	but := ToButton new.
	but cellSpacing: 10.
	but border: (BlBorder paint: Color lightGray).
	but beIconFirst.
	but labelText: ('Button' asRopedText bold).
	iconImage := BlElement new size: 20@20; background: Color lightGray; yourself.
	but iconImage: iconImage.
	but whenClickedDo: [ :ann | 
		ann widget orientation: but orientation inverted].
	space := OBlSpace new.
	space addChild: but.
	"space host: BAOSWindowSDL2Host new."
	space show
]

{ #category : #button }
ToSandBox class >> example_toButtonWithIconOnly [

	| but space container |
	container := BlElement new size: 200@200; border: (BlBorder paint: Color gray); background: (Color gray alpha: 0.1).
	but := ToButton new.
	but iconImage: (BlElement new
			 size: 60 @ 20;
			 yourself).
	but padding: (BlInsets all: 3).
	but relocate: 30@30.
	container addChild: but.
	space := OBlSpace new.
	space addChild: container.
	space show
]

{ #category : #button }
ToSandBox class >> example_toButtonWithTextAndIconVertical [

	| but space |
	but := ToButton new
		       beVertical;
		       beLabelFirst.
	but labelText: 'Button'.
	but iconImage: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself).
	but whenClickedDo: [ :ann | 
		ann widget horizontal: ann widget horizontal not ].
	but border: (BlBorder paint: Color red width: 2).
	space := OBlSpace new.
	space addChild: but.
	space show
]

{ #category : #button }
ToSandBox class >> example_toButtonWithTextOnly [

	| but space |
	but := ToButton new.
	but labelText: 'Button'.
	but padding: (BlInsets all: 4).
	but whenClickedDo: [ self inform: 'clicked' ].

	space := OBlSpace new.
	space addChild: but.
	space show
]

{ #category : #button }
ToSandBox class >> example_toButtonWithTooltip [

	| but  |
	but := ToButton new.
	but tooltipContent: ('This is a button', String cr, 'so, click on me...') asRopedText. 
	but whenClickedDo: [ :ann | self inform: 'Button clicked' ].
	but size: 32@16.
	but openInInnerWindow 

]

{ #category : #checkbox }
ToSandBox class >> example_toCheckbox0 [

	| but |
	but := ToCheckboxModel new.
	but onWidget openInOBlSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxModelWithLabel [

	| but |
	but := ToCheckboxModel new labelText: 'Check me'.
	but onWidget openInOBlSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxModelWithLabel2 [

	| but |
	but := ToCheckboxModel new labelText: 'Check me'; beLabelFirst.
	but onWidget openInOBlSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxModelWithLabel3 [

	| but |
	but := ToCheckboxModel new labelText: 'Check me'; beVertical.
	but onWidget openInOBlSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithLabel [

	| but |
	but := ToCheckbox new labelText: 'Check me'.
	but cellSpacing: 5.

	but openInOBlSpace.
	but inspect
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithLabel2 [

	| but |
	but := ToCheckbox new labelText: 'Check me'; beLabelFirst.
	but openInOBlSpace 
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithToggleGroup [

	| group container |
	group := ToToggleGroup new.
	1 to: 4 do: [ :idx | 
		| chb |
		chb := ToCheckbox new
			       labelText: idx asString;
			       id: idx asString.
		chb icon margin: (BlInsets all: 3).
		chb label margin: (BlInsets all: 4).
		group add: chb ].

	group whenCheckedDo: [ :chb :previous | 
		self inform: 'checked: ' , chb id asString, ' (previous was: ', (previous ifNil: [ 'none' ] ifNotNil: [ previous id asString ]) ].
	group buttons first check.
	
	container := BlElement new.
	container constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	
	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChildren: group buttons.
	container openInOBlSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithToggleGroup2 [

	| group container |
	group := ToToggleGroup new.
	1 to: 4 do: [ :idx | 
		| chb |
		chb := ToRadioButton new
			       labelText: idx asString;
			       id: idx asString.
		chb icon margin: (BlInsets all: 3).
		chb label margin: (BlInsets all: 4).
		group add: chb ].
	container := BlElement new.
	container constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	container layout: BlLinearLayout horizontal.
	container layout cellSpacing: 5.
	container addChildren: group buttons.
	group whenCheckedDo: [ :chb :previous | 
		self inform: 'checked: ' , chb id asString, ' (previous was: ', (previous ifNil: [ 'none' ] ifNotNil: [ previous id asString ]) ].
	ToInnerWindow new in: [ :f | f addChild: container ]; openInWorld
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
	im := ToImage new innerImage: (BlElement new
		  size: 16 @ 16;
		  background: (Color green alpha: 0.5);
		  geometry: BlCircleGeometry new ).
	im inspect.
	im openInOBlSpace 
]

{ #category : #image }
ToSandBox class >> example_toImageViewModel0 [

	| im |
	im := ToImageModel new.
	im inspect.
	im onWidget openInOBlSpace 
]

{ #category : #image }
ToSandBox class >> example_toImageViewModel1 [

	| im |
	im := ToImageModel new innerImage: (BlElement new
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
	im := ToImageModel new innerImage: (Form dotOfSize: 40).
	im inspect.
	im onWidget openInOBlSpace 
]

{ #category : #image }
ToSandBox class >> example_toImageViewModel3 [

	| im |
	im := ToImageModel new innerImage: (Smalltalk ui icons iconNamed: #classIcon).
	im widgetDo: [:w | w border: (BlBorder paint: Color black width: 2)].
	im onWidget openInWorld
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
	lab hMatchParent.
	lab editable: true.
	lab layout alignCenter.
	lab border: (BlBorder paint: Color yellow width: 1).
	lab openInOBlSpace.
	lab inspect

]

{ #category : #label }
ToSandBox class >> example_toLabel3_bis [

	| model widget |
	model := ToLabelModel new.
	model text: ('This is a bold label' asRopedText
			 fontSize: 20;
			 bold;
			 foreground: Color gray;
			 yourself).
	model widgetDo: [ :label | 
		label hMatchParent.
		label background: Color lightBlue.
		label layout alignCenterRight.
		label border: (BlBorder paint: Color yellow width: 1) ].
	model editable: true.
	(widget := model onWidget) openInOBlSpace.
	widget inspect
]

{ #category : #label }
ToSandBox class >> example_toLabel3_bis2 [

	| model widget |
	model := ToLabelModel new beMultiLine.
	model text: ('This is a bold label' asRopedText
			 fontSize: 20;
			 bold;
			 foreground: Color gray;
			 yourself).
	model widgetDo: [ :label | 
		label hMatchParent.
		label background: Color lightBlue.
		label layout alignCenterRight.
		label border: (BlBorder paint: Color yellow width: 1) ].
	model editable: true.
	(widget := model onWidget) openInOBlSpace.
	widget inspect
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
	lab1 layout alignCenter.
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
	lab2 editable: true.

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
	model := ToLabelModel new.
	model text: ('' asRopedText fontSize: 24).
	model beMultiLine.
	model widgetDo: [ :widget | 
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
	lab1 layout alignCenter.
	lab2 layout alignCenter.
	lab1 innerElement layout alignCenter.
	lab2 innerElement layout alignCenter.
	lab1 editable: true.
	lab2 editable: true.
	container := BlElement new
		             layout: BlLinearLayout vertical;
		             constraintsDo: [ :c | 
			             c horizontal matchParent.
			             c vertical fitContent ].
	container addChildren: { 
			lab1.
			lab2 }.
	space := container openInOBlSpace
]

{ #category : #multistate }
ToSandBox class >> example_toMultiState1 [

	| but space |
	but := ToButton new.
	but states: { (ToToggleState new
			 buttonStencil: [ :button | 
				 button
					 iconImage: (BlElement new
							  size: 50 @ 30;
							  background: Color green);
					 labelText: 'Green' ];
			 endAnimation: [ 
				 BlOpacityAnimation new
					 duration: 500 milliSeconds;
					 opacity: 0;
					 yourself ];
			 beginAnimation: [ 
				 BlOpacityAnimation new
					 duration: 1000 milliSeconds;
					 opacity: 1;
					 yourself ];
			 yourself) }.
	space := OBlSpace new.
	space addChild: but.
	space show
]

{ #category : #multistate }
ToSandBox class >> example_toMultiStateWithBigBlue [

	| but |
	but := ToButton new.
	but states: { 
			(ToToggleState new
				 buttonStencil: [ :button | 
					 button
						 iconImage: (BlElement new
								  size: 400 @ 400;
								  background: Color blue);
						 labelText: 'Big blue' ];
				 yourself).
			(ToToggleState new
				 buttonStencil: [ :button | 
					 button
						 iconImage: (BlElement new
								  size: 20 @ 40;
								  background: Color green);
						 labelText: 'Green' ];
				 yourself).
			(ToToggleState new
				 buttonStencil: [ :button | 
					 button
						 iconImage: (BlElement new
								  size: 50 @ 50;
								  background: Color black);
						 labelText: 'Black' ];
				 yourself).
			(ToToggleState new
				 buttonStencil: [ :button | 
					 button
						 iconImage: (BlElement new
								  size: 100 @ 100;
								  background: Color yellow);
						 labelText: 'Yellow' ];
				 yourself) }.
	but openInOBlSpace
]

{ #category : #multistate }
ToSandBox class >> example_toMultiStateWithBigBlueWithAnimation [

	| but exitAnimation enterAnimation |
	exitAnimation := [ 
	                 BlOpacityAnimation new
		                 duration: 150 milliSeconds;
		                 opacity: 0;
		                 yourself ].
	enterAnimation := [ 
	                  BlOpacityAnimation new
		                  duration: 150 milliSeconds;
		                  opacity: 1;
		                  yourself ].

	but := ToButtonModel new.
	but states: { 
			(ToToggleState new
				 buttonStencil: [ :button | 
					 button
						 iconImage: (BlElement new
								  size: 100 @ 100;
								  background: Color blue);
						 labelText: ('Big blue' asRopedText fontSize: 24) ];
				 endAnimation: exitAnimation;
				 beginAnimation: enterAnimation;
				 yourself).
			(ToToggleState new
				 buttonStencil: [ :button | 
					 button
						 iconImage: (BlElement new
								  size: 100 @ 100;
								  background: Color green);
						 labelText: ('Green' asRopedText fontSize: 24) ];
				 endAnimation: exitAnimation;
				 beginAnimation: enterAnimation;
				 yourself).
			(ToToggleState new
				 buttonStencil: [ :button | 
					 button
						 iconImage: (BlElement new
								  size: 100 @ 100;
								  background: Color black);
						 labelText: ('Black' asRopedText fontSize: 24) ];
				 endAnimation: exitAnimation;
				 beginAnimation: enterAnimation;
				 yourself).
			(ToToggleState new
				 buttonStencil: [ :button | 
					 button
						 iconImage: (BlElement new
								  size: 100 @ 100;
								  background: Color yellow);
						 labelText: ('Yellow' asRopedText fontSize: 24) ];
				 endAnimation: exitAnimation;
				 beginAnimation: enterAnimation;
				 yourself) }.
	but onWidget openInOBlSpace
]

{ #category : #multistate }
ToSandBox class >> example_toMultiStateWithLabel [

	| but |
	but := ToButton new size: 70@35.
	but states: { 
			(ToToggleState new
				 buttonStencil: [ :button | 
					 button labelText: ('One' asRopedText fontSize: 24) ];
				 yourself).
			(ToToggleState new
				 buttonStencil: [ :button | 
					 button labelText: ('Two' asRopedText fontSize: 24) ];
				 yourself).
			(ToToggleState new
				 buttonStencil: [ :button | 
					 button labelText: ('Three' asRopedText fontSize: 24) ];
				 yourself) }.
	but openInWorld
]

{ #category : #checkbox }
ToSandBox class >> example_toRadioButton0 [

	| but |
	but := ToRadioButtonModel new.
	but onWidget openInOBlSpace
]

{ #category : #button }
ToSandBox class >> example_toWidgetAsButton0 [

	| but |
	but := ToWidget new.
	but addDresser: ToButtonDefaultDresser new.
	but whenAnnouncement: ToButtonClickLaunchAction do: [ self inform: 'Click' ]. 
	but background: Color blue.
	but size: 50@50.
	but  openInOBlSpace 
]

{ #category : #accessing }
ToSandBox class >> methodText [
	^ self  class sourceCodeAt: #example_CodeEditorWithToAlbumModel
]
