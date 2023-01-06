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
	client withRowNumbers.
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
		 withRowNumbers;
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
		 withRowNumbers;
		 withSaveCapability;
		 whenSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: true ];
		 withEditsFeedbackLayer) onWidget.

	view openInOBlSpace
]

{ #category : #list }
ToSandBox class >> example_ListOneClass [

	| l |
	l := ToList new
		     nodeFactory: [ :cls | 
			     ToCheckNode new
				     labelText: cls name;
				     columnWidth: 25;
				     hMatchParent ].
	l list addAll: { Smalltalk globals allClasses first }.
	l openInOBlSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClasses [

	| l |
	l := ToList new.
	l list addAll: ((Smalltalk globals allClasses) collect: [:cls | cls name]).
	l openInOBlSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClasses3 [

	| l |
	l := ToList new nodeFactory: [ :cls |
					     | icn |
					     icn := cls hasComment
						            ifTrue: [ #class ]
						            ifFalse: [ #uncommentedClass ].
					     ToLabeledNode new
						     labelText: cls name;
						     element: (ToImage inner: (Smalltalk ui icons iconNamed: icn));
						     columnWidth: 20;
						     hMatchParent ].
	l list addAll: Smalltalk globals allClasses.
	l withRowNumbers.
	l openInInnerWindow 

]

{ #category : #list }
ToSandBox class >> example_ListWithAllClasses4 [

	| l |
	l := ToList new
		     nodeFactory: [ :cls | 
			     ToCheckNode new
				     labelText: cls name;
				     columnWidth: 25;
				     hMatchParent ].
	l list addAll: Smalltalk globals allClasses.
	l openInOBlSpace.

]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesAsButton [

	| l |
	l := ToList new nodeFactory: [ :cls | 
					     ToButton new
						     labelText: cls name;
						     hMatchParent ].
	l list addAll: Smalltalk globals allClasses.
	l openInOBlSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithOneString [

	| l |
	l := ToList new.
	l list addAll: { 'AAAAAA'}.
	l withRowNumbers.
	l openInOBlSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithRowNumbers [

	| l |
	l := ToList new
		     nodeFactory: [ :cls | 
			     ToCheckNode new
				     labelText: cls name;
				     columnWidth: 25;
				     hMatchParent ].
	l list addAll: Smalltalk globals allClasses.
	l withRowNumbers.
	l openInOBlSpace.

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
	but addDresser: ToButtonDresser new.
	but whenAnnouncement: ToButtonClickLaunchAction do: [ self inform: 'Click'. p close ]. 
	p addChild: but.
	p addEventHandler: (BlEventHandler
			 on: BlSpaceMouseDownOutsideEvent
			 do: [ :event | self inform: 'OUTSIDE']).
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

{ #category : #menu }
ToSandBox class >> example_menu1 [

	| menu sub subsub |
	menu := ToMenu new.
	menu layout cellSpacing: 5.
	menu globalColumnWidth: 22.
	menu label: (ToLabel new text: 'File').
	menu element: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #solidMenu)).
	menu addItem: (ToButtonMenuItem new
			 label: (ToLabel new text: 'Open file');
			 element: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #config))).
	menu addItem: (ToButtonMenuItem new label: (ToLabel new text: 'Export')).
	menu addSeparator.
	
	sub := ToMenu new label: (ToLabel new text: 'Save All').
	sub addItem: (ToButtonMenuItem new label: (ToLabel new text: 'Locally')).
	
	subsub := ToMenu new label: (ToLabel new text: 'Externally'); element: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #solidMenu)).
	subsub addItem: (ToButtonMenuItem new label: (ToLabel new text: 'Here')).

	sub addItem: subsub.
	
	menu addItem: sub.
	menu relocate: 10@10.
	menu openInInnerWindow
]

{ #category : #menu }
ToSandBox class >> example_menu2 [

	| menu  |
	menu := ToMenu new.
	menu label: (ToLabel text: 'File').
	menu addItem: (ToCheckMenuItem new label: (ToLabel text:'Align right'); beLabelFirst; beJustified).
	menu addItem: (ToCheckMenuItem new label: (ToLabel text:'Other'); beLabelFirst; columnWidth: 100).
	menu relocate: 10@10.
	menu openInNewSpace.
	
]

{ #category : #menu }
ToSandBox class >> example_menu2_2 [

	| menu  sub |
	menu := ToMenu new.
	menu element: (ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).
	
	sub := ToMenu new labelText: 'Save All'.
	sub addItem: (ToButtonMenuItem new labelText: 'Locally').
	menu addItem: sub.

	menu addItem: (ToButtonMenuItem new labelText: 'Export').
	menu addItem: (ToCheckMenuItem new labelText: 'Align right').
	menu addSeparator.
	
	menu relocate: 10@10.
	menu openInInnerWindow
]

{ #category : #menu }
ToSandBox class >> example_menu3 [

	| menu sub subsub |
	menu := ToMenu new.
	menu label: (ToLabel new text: 'File').
	menu columnWidth: 0.

	menu addItem: (ToButtonMenuItem new
			 labelText: 'Open file';
			 element: (ToImage inner: (Smalltalk ui icons iconNamed: #config))).
	menu addItem: (ToButtonMenuItem new labelText: 'Export').
	menu addItem: (ToCheckMenuItem new labelText: 'Align right').
	menu addSeparator.
	
	sub := ToMenu new labelText: 'Save All'.
	sub addItem: (ToButtonMenuItem new labelText: 'Locally').
	
	subsub := ToMenu new labelText: 'Externally'.
	subsub addItem: (ToButtonMenuItem new labelText: 'Here').

	sub addItem: subsub.
	
	menu addItem: sub.
	menu relocate: 10@10.
	menu openInInnerWindow
]

{ #category : #menu }
ToSandBox class >> example_menu4 [

	| menu sub subsub |
	menu := ToMenu new.
	menu labelText: 'File'.
	menu element: (ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).
	menu addItem: (ToButtonMenuItem new labelText: 'Open file').
	menu addItem: (ToButtonMenuItem new labelText: 'Export').
	menu addItem: (ToRadioMenuItem new labelText: 'Align right').
	menu addSeparator.
	
	sub := ToMenu new labelText: 'Save All'.
	sub addItem: (ToButtonMenuItem new labelText: 'Locally').
	
	subsub := ToMenu new labelText: 'Externally'; element: (ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).
	subsub addItem: (ToButtonMenuItem new labelText: 'Here').

	sub addItem: (subsub).
	
	menu addItem: sub.
	menu relocate: 10@10.
	menu openInInnerWindow
]

{ #category : #menu }
ToSandBox class >> example_menu5 [

	| menu sub subsub grp right center left |
	menu := ToMenu new.
	menu labelText: 'File'.
	menu addItem: (ToButtonMenuItem new labelText: 'Open file').

	menu addItem: (ToButtonMenuItem new labelText: 'Export').
	grp := ToCheckableGroup new.
	right := ToRadioMenuItem new labelText: 'Right'; id: #right.
	center := ToRadioMenuItem new labelText: 'Center'; id: #center.
	left := ToRadioMenuItem new labelText: 'Left'; id: #left.
	grp add: right.
	grp add: center.
	grp add: left.

	grp whenCheckedDo: [ :chb :previous | 
		self inform: 'checked: ' , chb id asSymbol , ' (previous was: '
			, (previous ifNil: [ 'none' ] ifNotNil: [ previous id asSymbol ]) ].

	center startChecked.

	menu addSeparator.
	menu addAllItems: grp buttons.
	menu addSeparator.

	sub := ToMenu new labelText: 'Save All'.
	sub addItem: (ToButtonMenuItem new labelText: 'Locally').

	subsub := ToMenu new
		          labelText: 'Externally'.
	subsub addItem: (ToButtonMenuItem new labelText: 'Here').

	sub addItem: subsub.

	menu addItem: sub.
	menu relocate: 10 @ 10.
	menu openInInnerWindow
]

{ #category : #menu }
ToSandBox class >> example_menu6 [

	| menu grp right center left textField sub th lbl |
	menu := ToMenu new.
	menu globalColumnWidth: 22.

	menu labelText: 'File'.
	menu addItem: (ToButtonMenuItem new
			 labelText: 'Open file';
			 whenClickedDo: [ self inform: 'Open file' ];
			 element: (ToImage inner: (Smalltalk ui icons iconNamed: #config))).

	menu addItem: (ToButtonMenuItem new
			 labelText: 'Export';
			 whenClickedDo: [ self inform: 'Export' ]).
	menu addItem: (ToButtonMenuItem new
			 labelText: 'Export';
			 columnWidth: 0;
			 whenClickedDo: [ self inform: 'Export' ]).

	grp := ToCheckableGroup new.
	right := ToRadioMenuItem new
		         labelText: 'Right';
		         id: #right.
	center := ToRadioMenuItem new
		          labelText: 'Center';
		          id: #center.
	left := ToRadioMenuItem new
		        labelText: 'Left';
		        id: #left.
	grp addAll: { 
			right.
			center.
			left }.

	grp whenCheckedDo: [ :chb :previous | 
		self inform: 'checked: ' , chb id asSymbol , ' (previous was: '
			, (previous ifNil: [ 'none' ] ifNotNil: [ previous id asSymbol ]) ].

	center startChecked.

	menu addSeparator.

	lbl := ToLabel new text: ('Radio button icon first' asRopedText
			        fontSize: 12;
			        foreground: (Color black alpha: 0.7)).
	menu addItem: (ToCustomMenuItem new
			 innerElement: lbl;
			 margin: (BlInsets
					  top: 2;
					  bottom: 4)).
	menu addAllItems: grp buttons.

	grp := ToCheckableGroup new.
	right := ToRadioMenuItem new
		         beLabelFirst;
		         columnWidth: 50;
		         labelText: 'Right';
		         id: #right.
	center := ToRadioMenuItem new
		          beLabelFirst;
		          columnWidth: 50;
		          labelText: 'Center';
		          id: #center.
	left := ToRadioMenuItem new
		        beLabelFirst;
		        columnWidth: 50;
		        labelText: 'Left';
		        id: #left.
	grp addAll: { 
			right.
			center.
			left }.

	grp whenCheckedDo: [ :chb :previous | 
		self inform: 'checked: ' , chb id asSymbol , ' (previous was: '
			, (previous ifNil: [ 'none' ] ifNotNil: [ previous id asSymbol ]) ].

	center startChecked.

	menu addSeparator.

	lbl := ToLabel new text: ('Radio button label first' asRopedText
			        fontSize: 12;
			        foreground: (Color black alpha: 0.7)).
	menu addItem: (ToCustomMenuItem new
			 innerElement: lbl;
			 margin: (BlInsets
					  top: 2;
					  bottom: 4)).
	menu addAllItems: grp buttons.

	grp := ToCheckableGroup new.
	right := ToRadioMenuItem new
		         beLabelFirst;
		         beJustified;
		         labelText: 'Right';
		         id: #right.
	center := ToRadioMenuItem new
		          beLabelFirst;
		          beJustified;
		          labelText: 'Center';
		          id: #center.
	left := ToRadioMenuItem new
		        beLabelFirst;
		        beJustified;
		        labelText: 'Left';
		        id: #left.
	grp addAll: { 
			right.
			center.
			left }.

	grp whenCheckedDo: [ :chb :previous | 
		self inform: 'checked: ' , chb id asSymbol , ' (previous was: '
			, (previous ifNil: [ 'none' ] ifNotNil: [ previous id asSymbol ]) ].

	center startChecked.

	menu addSeparator.
	lbl := ToLabel new text:
		       ('Radio buttons label first and justified' asRopedText
			        fontSize: 12;
			        foreground: (Color black alpha: 0.7)).
	menu addItem: (ToCustomMenuItem new
			 innerElement: lbl;
			 margin: (BlInsets
					  top: 2;
					  bottom: 4)).
	menu addAllItems: grp buttons.
	menu addSeparator.
	textField := ToTextField new
		             withLineWrapping;
		             width: 200;
		             withGhostText: 'Your name'.
	menu addItem: (ToCustomMenuItem new innerElement: textField).

	menu addSeparator.
	th := ToToggleButton new
		      labelText: 'Cheesecake';
		      beLabelFirst;
		      hMatchParent.
	menu addItem: (ToCustomMenuItem new innerElement: th).
	th := ToToggleButton new
		      labelText: 'Cheesecake';
				beLabelFirst;
		      hMatchParent.
	th columnWidth: 100.
	menu addItem: (ToCustomMenuItem new innerElement: th).
	th := ToToggleButton new
		      labelText: 'Cheesecake';
				beLabelFirst;
		      hMatchParent.
	th layout cellSpacing: 10.
	menu addItem: (ToCustomMenuItem new innerElement: th).
	th := ToToggleButton new
		      labelText: 'Cheesecake';
		      labelFirst: false;
		      hMatchParent.
	menu addItem: (ToCustomMenuItem new innerElement: th).
	th := ToToggleButton new
		      labelText: 'Cheesecake';
		      beVertical;
		      beLabelFirst;
		      hMatchParent.
	menu addItem: (ToCustomMenuItem new innerElement: th).
	menu addSeparator.
	lbl := ToLabel new text: ('Saving stuffs' asRopedText
			        fontSize: 12;
			        foreground: (Color black alpha: 0.7)).
	menu addItem: (ToCustomMenuItem new
			 innerElement: lbl;
			 margin: (BlInsets
					  top: 2;
					  bottom: 4)).
	sub := ToMenu new labelText: 'Save All'.
	sub columnWidth: 0.
	sub addItem: (ToButtonMenuItem new labelText: 'Locally').
	menu addItem: sub.

	menu relocate: 10 @ 10.
	menu openInInnerWindow
]

{ #category : #window }
ToSandBox class >> example_rootFrame1 [
	ToInnerWindow new title: 'Internal Frame example' ; openInOBlSpace 
]

{ #category : #choicebox }
ToSandBox class >> example_rootFrameWithChoiceBox [

	| win bar choicebox |
	win := ToInnerWindow new title: 'Choice box Example'.

	bar := ToMenuBar new
		       hMatchParent;
		       vFitContent.
	choicebox := ToChoiceBox new.
	choicebox addAllChoices: { 'OS-X'. 'Windows'. }.
	choicebox addSeparator.
	choicebox addItem: 'Linux'.
	"choicebox defaultChoice: 'Windows'."

	bar addChild: (choicebox tooltipString: 'Select your operating system').

	bar relocate: 0 @ 0.
	bar border: (BlBorder paint: Color lightGray).
	win root addChild: bar.
	win openInWorld
]

{ #category : #choicebox }
ToSandBox class >> example_rootFrameWithChoiceBox2 [

	| win bar choicebox |
	win := ToInnerWindow new title: 'Alexandrie host'.

	bar := ToMenuBar new
		       hMatchParent;
		       vFitContent.
	choicebox := ToChoiceBox new
		             hMatchParent;
		             beJustified.
	choicebox toTextConverter: [ :assoc | assoc key ].
	choicebox addAllChoices: { 
			('Morphic SDL' -> BAMorphicWindowHost).
			('Native SDL' -> BAOSWindowSDL2Host) }.
	choicebox defaultChoiceIndex: 2.
	choicebox whenSelectedChoiceChangedDo: [ 
		self inform: choicebox selectedItem value name ].

	bar addChild: (choicebox tooltipString: 'Select the Alexandrie host').

	bar relocate: 0 @ 0.
	bar border: (BlBorder paint: Color lightGray).
	win root addChild: bar.
	win openInWorld
]

{ #category : #'context menu + menubar' }
ToSandBox class >> example_rootFrameWithContextMenu [

	| win menu sub subsub bar textField |
	win := ToInnerWindow new title: 'Context menu Example'.
	menu := ToContextMenu new.
	menu globalColumnWidth: 22.
	menu addItem: (ToButtonMenuItem new
			 labelText: 'Open file';
			 element: (ToImage inner:  (Smalltalk ui icons iconNamed: #config))).
	menu addItem: (ToButtonMenuItem new labelText: 'Export').
	menu addSeparator.

	sub := ToMenu new labelText: 'Save All'.
	sub addItem: (ToButtonMenuItem new labelText: 'Locally').

	subsub := ToMenu new
		          labelText: 'Externally';
		          element: (ToImage inner:  (Smalltalk ui icons iconNamed: #solidMenu)).
	subsub addItem: (ToButtonMenuItem new labelText: 'Here').

	sub addItem: subsub.

	menu addItem: sub.

	win contextMenu: menu.

	bar := ToMenuBar new
		       hMatchParent;
		       vFitContent.
	bar addMenu: (ToMenu new
			 labelText: 'File';
			 tooltipString: 'file stuffs').
	bar addMenu: (ToMenu new
			 labelText: 'Edit';
			 tooltipString: 'editing stuffs').
	bar addFiller.
	textField := ToTextField new
		             withLineWrapping;
		             width: 200;
		             withGhostText: 'search...'.
	bar addChild: textField.
	bar addMenu: (ToMenu new
			 labelText: 'Help';
			 tooltipString: 'help stuffs').

	bar relocate: 0 @ 0.
	bar border: (BlBorder paint: Color black).
	win root addChild: bar.
	win openInWorld
]

{ #category : #'context menu + menubar' }
ToSandBox class >> example_rootFrameWithContextMenu_menubarVertical [

	| win menu sub subsub bar  |
	win := ToInnerWindow new title: 'Context menu Example'.
	menu := ToContextMenu new.
	menu globalColumnWidth: 22.
	menu addItem: (ToButtonMenuItem new
			 labelText: 'Open file';
			 element: (ToImage inner: (Smalltalk ui icons iconNamed: #config))).
	menu addItem: (ToButtonMenuItem new labelText: 'Export').
	menu addSeparator.

	sub := ToMenu new labelText: 'Save All'.
	sub addItem: (ToButtonMenuItem new labelText: 'Locally').

	subsub := ToMenu new
		          labelText: 'Externally';
		          element: (ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).
	subsub addItem: (ToButtonMenuItem new labelText: 'Here').

	sub addItem: subsub.

	menu addItem: sub.

	win contextMenu: menu.

	bar := ToMenuBar new
		       hMatchParent;
		       vFitContent.
	bar addMenu: (ToMenu new
			 labelText: 'File';
			 tooltipString: 'file stuffs').
	bar addMenu: (ToMenu new
			 labelText: 'Edit';
			 tooltipString: 'editing stuffs').
	bar addFiller.
	bar addSeparator.
	bar addMenu: (ToMenu new
			 labelText: 'Help';
			 tooltipString: 'help stuffs').

	bar relocate: 0 @ 0.
	bar beVertical.
	bar hFitContent.
	bar border: (BlBorder paint: Color black).
	win root addChild: bar.
	win openInWorld
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
ToSandBox class >> example_toAlbumAsButton [

	| but |
	but := ToAlbum new text: 'Hello world'; preventChildrenMouseEvents.
	but addDresser: ToButtonDresser new.
	but whenAnnouncement: ToButtonClickLaunchAction do: [ self inform: 'Click' ]. 
	but background: Color blue.
	but size: 300@100.
	but  openInOBlSpace  
]

{ #category : #button }
ToSandBox class >> example_toBasicButton0 [

	| but |
	but := ToGeneralButton new dresser: ToButtonDresser new.
	but whenClickedDo: [ self inform: 'clicked' ].
	but openInOBlSpace 
]

{ #category : #button }
ToSandBox class >> example_toBasicButton1 [

	| but |
	but := ToGeneralButton new dresser: ToButtonDresser new.
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
	but := ToGeneralButton new dresser: ToButtonDresser new.
	but matchParent.
	but addChild: lab.
	but layout alignCenter.
	but whenClickedDo: [ self inform: 'clicked' ].
	but openInOBlSpace 
]

{ #category : #button }
ToSandBox class >> example_toBasicButton3 [

	| but |
	but := ToButton new label: (ToLabel new text: (('Button' asRopedText)
			        fontSize: 40;
			        yourself)).
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
	but icon: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #solidMenu)).
	but widgetDo: [ :widget | widget padding: (BlInsets all: 3) ].
	space := OBlSpace new.
	space addChild: but onWidget.
	space show 
]

{ #category : #button }
ToSandBox class >> example_toButtonModelWithTextAndIconVertical [

	| but space wid |
	but := ToButtonModel new
		       beVertical;
		       beLabelFirst.
	but labelText: 'Button'.
	but element: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself).
	but whenClickedDo: [ :ann | 
		ann currentTarget horizontal: ann currentTarget horizontal not ].
	space := OBlSpace new.
	wid := but onWidget.
	wid layout cellSpacing: 10.
	space addChild: wid.
	space show 
]

{ #category : #button }
ToSandBox class >> example_toButtonOrientationChanger [

	| but space iconImage |
	but := ToButton new.
	but layout cellSpacing: 4.
	but padding: (BlInsets all: 3).
	but border: (BlBorder paint: Color lightGray).
	but labelText: 'Button' asRopedText bold.
	iconImage := BlElement new
		             size: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but element: iconImage.
	but whenClickedDo: [ :ann | 
		ann currentTarget orientation: but orientation inverted ].
	space := OBlSpace new.
	space addChild: but.
	space show 
]

{ #category : #button }
ToSandBox class >> example_toButtonOrientationChanger2 [

	| but space iconImage |
	but := ToButton new.
	but layout cellSpacing: 10.
	but labelFirst: true.
	but padding: (BlInsets all: 3).
	but border: (BlBorder paint: Color lightGray).
	but labelText: 'Button' asRopedText bold.
	iconImage := BlElement new
		             size: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but element: iconImage.
	but whenClickedDo: [ :ann | 
		ann currentTarget orientation: but orientation inverted ].
	space := OBlSpace new.
	space addChild: but.
	space show 
]

{ #category : #button }
ToSandBox class >> example_toButtonOrientationChanger3 [

	| but space iconImage |
	but := ToButton new.
	but columnWidth: 100.
	but labelFirst: true.
	but padding: (BlInsets all: 3).
	but border: (BlBorder paint: Color lightGray).
	but labelText: 'Button' asRopedText bold.
	iconImage := BlElement new
		             size: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but element: iconImage.
	but whenClickedDo: [ :ann | 
		ann currentTarget orientation: but orientation inverted ].
	space := OBlSpace new.
	space addChild: but.
	space show 
]

{ #category : #button }
ToSandBox class >> example_toButtonOrientationChanger4 [

	| but space iconImage |
	but := ToButton new hMatchParent.
	but beJustified.
	but padding: (BlInsets all: 3).
	but border: (BlBorder paint: Color lightGray).
	but labelText: 'Button' asRopedText bold.
	iconImage := BlElement new
		             size: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but element: iconImage.
	but whenClickedDo: [ :ann | 
		ann currentTarget orientation: but orientation inverted ].
	space := OBlSpace new.
	space addChild: but.
	space show 
]

{ #category : #button }
ToSandBox class >> example_toButtonOrientationChanger5 [

	| but space iconImage |
	but := ToButton new hMatchParent.
	but beJustified.
	but beLabelFirst.
	but padding: (BlInsets all: 3).
	but border: (BlBorder paint: Color lightGray).
	but labelText: 'Button' asRopedText bold.
	iconImage := BlElement new
		             size: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but element: iconImage.
	but whenClickedDo: [ :ann | 
		ann currentTarget orientation: but orientation inverted ].
	space := OBlSpace new.
	space addChild: but.
	space show 
]

{ #category : #button }
ToSandBox class >> example_toButtonWithIconOnly [

	| but space container |
	container := BlElement new size: 200@200; border: (BlBorder paint: Color gray); background: (Color gray alpha: 0.1).
	but := ToButton new.
	but element: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #solidMenu)).
	but element layout alignCenter.
	container addChild: but.
	space := OBlSpace new.
	space addChild: container.
	space show 
]

{ #category : #button }
ToSandBox class >> example_toButtonWithIconOnly2 [

	| but space container |
	container := BlElement new size: 200@200; border: (BlBorder paint: Color gray); background: (Color gray alpha: 0.1).
	but := ToButton new.
	but element: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #solidMenu)).
	but element layout alignCenter.
	container addChild: but.
	space := OBlSpace new.
	space addChild: container.
	space show 
]

{ #category : #button }
ToSandBox class >> example_toButtonWithTextAndIconHorizontal [

	| but space |
	but := ToButton new "cellSpacing: 2; padding: (BlInsets all: 4)".
	but labelText: 'Button'.
	but element: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself).
	but beLabelFirst.
	but layout cellSpacing: 10.
	but whenClickedDo: [ :ann | but element background: Color random ].
	space := OBlSpace new.
	space addChild: but.
	space show 
]

{ #category : #button }
ToSandBox class >> example_toButtonWithTextAndIconVertical [

	| but space |
	but := ToButton new padding: (BlInsets all: 4); beVertical.
	but labelText: 'Button'.
	but element: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself).
	but layout cellSpacing: 10.
	but whenClickedDo: [ :ann | but element background: Color random ].
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
ToSandBox class >> example_toCheckbox1 [

	| chb |
	chb := ToCheckbox new
		       columnWidth: 50;
		       labelText: '1';
		       id: 1 asString.
	"beLabelFirst;"
	chb openInInnerWindow
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckbox2 [

	| chb container |
	chb := ToCheckbox new "beLabelFirst;"
		       columnWidth: 50;
		       labelText: '1';
		       id: 1 asString.
	""
	container := BlElement new.
	container constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].

	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChild: chb.
	container openInOBlSpace
	
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
	but := ToCheckbox new labelText: 'Check me'.
	but layout cellSpacing: 10.
	but   openInOBlSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxModelWithLabel4 [

	| but |
	but := ToCheckboxModel new labelText: 'Check me'; beVertical.
	but onWidget openInOBlSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithLabel [

	| but |
	but := ToCheckbox new labelText: 'Check me'.
	but layout cellSpacing: 25.
	but whenCheckedDo: [ self inform: '+++ checked' ].
	but whenUncheckedDo: [ self inform: '--- unchecked' ].

	but openInOBlSpace.
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithLabel2 [

	| but |
	but := ToCheckbox new labelText: 'Check me'; beLabelFirst; startChecked.
	but whenCheckedDo: [ self inform: '+++ checked' ].
	but whenUncheckedDo: [ self inform: '--- unchecked' ].
	
	but openInOBlSpace 
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithToggleGroup [

	| group container buttons |
	group := ToCheckableGroup new.
	buttons := OrderedCollection new.
	1 to: 4 do: [ :idx | 
		| chb |
		chb := ToCheckbox new
			       beLabelFirst;
			       columnWidth: 50;
			       labelText: idx asString;
			       id: idx asString.
		buttons add: chb ].
	buttons second startChecked.
	group addAll: buttons.
	group whenCheckedDo: [ :chb :previous | 
		self inform: 'checked: ' , chb id asString , ' (previous was: '
			, (previous ifNil: [ 'none' ] ifNotNil: [ previous id asString ]) ].

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
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx | 
		| chb |
		chb := ToRadioButton new
			       beVertical;
			       labelText: idx asString;
			       id: idx asString.
		chb labelFirst: false.
		group add: chb ].
	group default: (group buttons second).
	container := ToElement new.
	container matchParent.
	container layout: BlLinearLayout horizontal.
	container layout cellSpacing: 2.
	container addChildren: group buttons.
	group whenCheckedDo: [ :chb :previous | 
		self inform: 'checked: ' , chb id asString , ' (previous was: '
			, (previous ifNil: [ 'none' ] ifNotNil: [ previous id asString ]) ].
	ToInnerWindow new
		in: [ :f | f addChild: container ];
		openInWorld
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithToggleGroupJustified [

	| group container buttons |
	group := ToCheckableGroup new.
	buttons := OrderedCollection new.
	1 to: 4 do: [ :idx | 
		| chb |
		chb := ToCheckbox new
			       beJustified;
			       hMatchParent;
			       beLabelFirst;
			       labelText: idx asString;
			       id: idx asString.
		buttons add: chb ].
	buttons second startChecked.
	group addAll: buttons.
	group whenCheckedDo: [ :chb :previous | 
		self inform: 'checked: ' , chb id asString , ' (previous was: '
			, (previous ifNil: [ 'none' ] ifNotNil: [ previous id asString ]) ].

	container := BlElement new.
	container constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].

	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChildren: group buttons.
	container openInOBlSpace
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
	lab isEditable: true.
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
	model isEditable: true.
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
	model isEditable: true.
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
	lab1 isEditable: true.
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
	lab2 isEditable: true.

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
	model isEditable: true.
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
	lab1 isEditable: true.
	lab2 isEditable: true.
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
	but := ToMultiStateButton new.
	but
		element: (ToImage inner: (BlElement new
				 size: 100 @ 100;
				 background: Color blue));
		labelText: ('Blue' asRopedText fontSize: 24).
	but setUpStatesWith: { (ToWidgetState new whenEnterDo: [ :ann | 
			 | anim |
			 ann state counter traceCr.
			 ann state counter isZero ifFalse: [ 
				 anim := BlOpacityAnimation new
					         duration: 500 milliSeconds;
					         opacity: 0;
					         yourself.
				 anim onFinishedDo: [ 
					 ann widget
						 opacity: 0;
						 addAnimation: (BlOpacityAnimation new
								  duration: 300 milliSeconds;
								  opacity: 1;
								  yourself) ].
				 ann widget addAnimation: anim ] ]) }.
	space := OBlSpace new.
	space addChild: but.
	space show
]

{ #category : #multistate }
ToSandBox class >> example_toMultiState2 [

	| but space |
	but := ToMultiStateButton new
		       clipChildren: false;
		       element: (ToImage inner:  (BlElement new
				        size: 100 @ 100;
				        background: Color blue));
		       labelText: ('Blue' asRopedText fontSize: 24).
	but setUpStatesWith: { (ToWidgetState new whenExitDo: [ :ann | 
			 | anim |
			 anim := (BlTransformAnimation scale: 4) absolute
				         duration: 100 milliSeconds;
				         yourself.
			 anim onFinishedDo: [ 
				 ann widget addAnimation: ((BlTransformAnimation scale: 1) absolute
						  duration: 100 milliSeconds;
						  yourself) ].
			 ann widget addAnimation: anim ]) }.
	space := OBlSpace new.
	but relocate: 100 @ 100.
	space addChild: but.
	space show
]

{ #category : #multistate }
ToSandBox class >> example_toMultiState2_v2_do_not_work_well [

	| but space |
	but := ToMultiStateButton new
		       clipChildren: false;
		       element: (ToImage inner:  (BlElement new
				        size: 100 @ 100;
				        background: Color blue));
		       labelText: ('Blue' asRopedText fontSize: 24).
	but setUpStatesWith: { (ToWidgetState new whenExitDo: [ :ann | 
			 | anim |
			 anim := BlSequentialAnimation withAll: { 
					         ((BlTransformAnimation scale: 4) absolute
						          duration: 100 milliSeconds;
						          yourself).
					         ((BlTransformAnimation scale: 1) absolute
						          duration: 100 milliSeconds;
						          yourself) }.
			 ann widget addAnimation: anim ]) }.
	space := OBlSpace new.
	but relocate: 100 @ 100.
	space addChild: but.
	space show
]

{ #category : #multistate }
ToSandBox class >> example_toMultiStateWithBigBlue [

	| but |
	but := ToMultiStateButton new.
	but setUpStatesWith: { 
			(ToWidgetState new
				 whenEnterDo: [ :ann | 
					 ann widget
						 element: (ToImage inner:  (BlElement new
								  size: 400 @ 400;
								  background: Color blue));
						 labelText: 'Big blue' ];
				 yourself).
			(ToWidgetState new name: #green;
				 whenEnterDo: [ :ann | 
					 ann widget
						 element: (ToImage inner:  (BlElement new
								  size: 20 @ 40;
								  background: Color green));
						 labelText: 'Green' ];
				 yourself).
			(ToWidgetState new
				 whenEnterDo: [ :ann | 
					 ann widget
						 element: (ToImage inner:  (BlElement new
								  size: 50 @ 50;
								  background: Color black));
						 labelText: 'Black' ];
				 yourself).
			(ToWidgetState new
				 whenEnterDo: [ :ann | 
					 ann widget
						 element: (ToImage inner:  (BlElement new
								  size: 100 @ 100;
								  background: Color yellow));
						 labelText: 'Yellow' ];
				 yourself) }.
	but startState: (but stateNamed: #green).
	but openInOBlSpace
]

{ #category : #multistate }
ToSandBox class >> example_toMultiStateWithBigBlueWithAnimation [

	| but exitAnimation enterAnimation |
	exitAnimation := [ 
	                 BlOpacityAnimation new
		                 duration: 300 milliSeconds;
		                 opacity: 0;
		                 yourself ].
	enterAnimation := [ 
	                  BlOpacityAnimation new
		                  duration: 150 milliSeconds;
		                  opacity: 1;
		                  yourself ].

	but := ToMultiStateButton new.
	but setUpStatesWith: { 
			(ToWidgetState new
				 whenEnterDo: [ :ann | 
					 | anim |
					 anim := exitAnimation value.
					 anim onFinishedDo: [ 
							 ann widget
								 element: (ToImage inner:  (BlElement new
										  size: 100 @ 100;
										  background: Color blue));
								 labelText: ('Blue' asRopedText fontSize: 24);
								 opacity: 0;
								 addAnimation: enterAnimation value ].
					 ann widget addAnimation: anim ];
				 yourself).
			(ToWidgetState new
				 whenEnterDo: [ :ann | 
					 | anim |
					 anim := exitAnimation value.
					 anim onFinishedDo: [ 
							 ann widget
								 element: (ToImage inner:  (BlElement new
										  size: 100 @ 100;
										  background: Color green));
								 labelText: ('Green' asRopedText fontSize: 24);
								 opacity: 0;
								 addAnimation: enterAnimation value ].
					 ann widget addAnimation: anim ];
				 yourself).
			(ToWidgetState new
				 whenEnterDo: [ :ann | 
					 | anim |
					 anim := exitAnimation value.
					 anim onFinishedDo: [ 
							 ann widget
								 element: (ToImage inner:  (BlElement new
										  size: 100 @ 100;
										  background: Color black));
								 labelText: ('Black' asRopedText fontSize: 24);
								 opacity: 0;
								 addAnimation: enterAnimation value ].
					 ann widget addAnimation: anim ];
				 yourself).
			(ToWidgetState new
				 whenEnterDo: [ :ann | 
					 | anim |
					 anim := exitAnimation value.
					 anim onFinishedDo: [ 
							 ann widget
								 element: (ToImage inner:  (BlElement new
										  size: 100 @ 100;
										  background: Color yellow));
								 labelText: ('Yellow' asRopedText fontSize: 24);
								 opacity: 0;
								 addAnimation: enterAnimation value ].
					 ann widget addAnimation: anim ]) }.
	but  openInOBlSpace
]

{ #category : #multistate }
ToSandBox class >> example_toMultiStateWithLabel [

	| but |
	but := ToMultiStateButton new size: 70 @ 35.
	but setUpStatesWith: { 
			(ToWidgetState new
				 name: #one;
				 whenEnterDo: [ :ann | 
					 ann widget labelText: ('One' asRopedText fontSize: 24) ];
				 yourself).
			(ToWidgetState new
				 name: #two;
				 whenEnterDo: [ :ann | 
					 ann widget labelText: ('Two' asRopedText fontSize: 24) ];
				 yourself).
			(ToWidgetState new
				 name: #three;
				 whenEnterDo: [ :ann | 
					 ann widget labelText: ('Three' asRopedText fontSize: 24) ];
				 yourself) }.
	but openInWorld.
	but startState: (but stateNamed: #three)
]

{ #category : #pair }
ToSandBox class >> example_toPairDirectionChanger [

	| but space iconImage |
	but := ToPairElement new.
	but layout cellSpacing: 4.
	but padding: (BlInsets all: 3).
	but border: (BlBorder paint: Color lightGray).
	but first: (ToLabel text: 'Pair' asRopedText bold).
	iconImage := BlElement new
		             size: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but second: iconImage.
	but when: BlClickEvent do: [ 
		but layout direction: but layout direction inverted.
		but requestLayout ].
	space := OBlSpace new.
	space addChild: but.
	space show
]

{ #category : #pair }
ToSandBox class >> example_toPairJustified1 [

	| but space iconImage |
	but := ToPairElement new.
	but layout cellSpacing: 4.
	but padding: (BlInsets all: 3).
	but border: (BlBorder paint: Color lightGray).
	but first: (ToLabel text: 'Pair' asRopedText bold).
	iconImage := BlElement new
		             size: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but second: iconImage.
	but when: BlClickEvent do: [ but orientation: but orientation inverted ].
	but beJustified.
	but hMatchParent.

	space := OBlSpace new.
	space addChild: but.
	space show
]

{ #category : #pair }
ToSandBox class >> example_toPairJustified2 [

	| but space iconImage |
	but := ToPairElement new.
	but layout cellSpacing: 4.
	but padding: (BlInsets all: 3).
	but border: (BlBorder paint: Color lightGray).
	but first: (ToLabel text: 'Pair' asRopedText bold).
	iconImage := BlElement new
		             size: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but second: iconImage.
	but when: BlClickEvent do: [ 
		but layout direction: but layout direction inverted.
		but requestLayout ].	but beJustified.
	but beJustified.
	but hMatchParent.

	space := OBlSpace new.
	space addChild: but.
	space show
]

{ #category : #pair }
ToSandBox class >> example_toPairOrientationChanger [

	| but space iconImage |
	but := ToPairElement new.
	but layout cellSpacing: 4.
	but padding: (BlInsets all: 3).
	but border: (BlBorder paint: Color lightGray).
	but first: (ToLabel text: 'Pair' asRopedText bold).
	iconImage := BlElement new
		             size: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but second: iconImage.
	but when: BlClickEvent do: [ but orientation: but orientation inverted ].
	space := OBlSpace new.
	space addChild: but.
	space show 
]

{ #category : #pair }
ToSandBox class >> example_toPairWithColumn1 [

	| but space iconImage |
	but := ToPairElement new.
	but layout cellSpacing: 4.
	but padding: (BlInsets all: 3).
	but border: (BlBorder paint: Color lightGray).
	but first: (ToLabel text: 'Pair' asRopedText bold).
	iconImage := BlElement new
		             size: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but second: iconImage.
	but columnWidth: 50.
	but when: BlClickEvent do: [ but orientation: but orientation inverted ].	
	but hMatchParent.
	space := OBlSpace new.
	space addChild: but.
	space show 
]

{ #category : #pair }
ToSandBox class >> example_toPairWithColumn2 [

	| but space iconImage |
	but := ToPairElement new.
	but layout cellSpacing: 4.
	but padding: (BlInsets all: 3).
	but border: (BlBorder paint: Color lightGray).
	but first: (ToLabel text: 'Pair' asRopedText bold).
	iconImage := BlElement new
		             size: 50 @ 20;
		             background: Color lightGray;
		             yourself.
	but second: iconImage.
	but columnWidth: 100.
	but when: BlClickEvent do: [ 
		but layout direction: but layout direction inverted.
		but requestLayout ].	
	but hMatchParent.
	space := OBlSpace new.
	space addChild: but.
	space show 
]

{ #category : #checkbox }
ToSandBox class >> example_toRadioButton0 [

	| but |
	but := ToRadioButton new.
	but openInOBlSpace
]

{ #category : #button }
ToSandBox class >> example_toWidgetAsButton0 [

	| but |
	but := ToWidget new.
	but addDresser: ToButtonDresser new.
	but whenAnnouncement: ToButtonClickLaunchAction do: [ self inform: 'Click' ]. 
	but background: Color blue.
	but size: 50@50.
	but  openInOBlSpace  
]

{ #category : #'toggle button' }
ToSandBox class >> example_toggle [

	| th tv win |
	th := ToToggleButton new labelText: 'Cheesecake'; beLabelFirst; padding: (BlInsets all: 3); hMatchParent.

	tv := ToToggleButton new beVertical; labelText: 'Cheesecake'; beLabelFirst; padding: (BlInsets all: 3); hMatchParent.
	tv check.

	th whenCheckedDo: [ :ann | ann traceCr ].
	th whenUncheckedDo: [ :ann | ann traceCr ].
	
	tv whenCheckedDo: [ :ann | ann traceCr ].
	tv whenUncheckedDo: [ :ann | ann traceCr ].

	win := ToInnerWindow new
		             relocate: 10 @ 10;
		             size: 400 @ 200;
		             yourself.
	win root layout: (BlLinearLayout vertical).
	win root addChildren: { th. tv }.
	win openInNewSpace 
]

{ #category : #accessing }
ToSandBox class >> methodText [
	^ self  class sourceCodeAt: #example_CodeEditorWithToAlbumModel
]
