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

{ #category : #combobox }
ToSandBox class >> example_BasicComboBox [

	| win combo |
	win := ToInnerWindow new title: 'Combo box Example'.
	combo := ToComboBox new.
	combo data addAll: (Smalltalk globals allClasses collect: [ :cls | cls name ]).
	win root addChild: combo.
	win openInWorld
]

{ #category : #combobox }
ToSandBox class >> example_BasicComboBoxWith5Elements [

	| win combo |
	win := ToInnerWindow new title: 'Combo box Example'.
	combo := ToComboBox new.
	combo data addAll: ((1 to: 5) collect: [:i | '#', i asString]).
	win root addChild: combo.
	win openInWorld
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

	| text model menu |
	text := self methodText asRopedText.
	model := ToAlbumModel new.
	model styler: (BlRBTextStyler new classOrMetaClass: self class).
	model text: text copy.
	model withSaveCapability.
	model withRowNumbers.
	model whenSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: true ].
	model whenCancelRequestedDo: [ :cancelRequested | cancelRequested client text: text copy ].
	
	menu := ToContextMenu new.
	menu addItem: (ToButtonMenuItem new labelText: 'Select all'; whenClickedDo: [:event :client | client widgetDo: [:w | w selecter all; apply ] ]; yourself).
	menu addItem: (ToButtonMenuItem new labelText: 'Copy'; whenClickedDo: [:event :client | client widgetDo: [:w | w editor copySelected ] ]; yourself).
	menu addItem: (ToButtonMenuItem new labelText: 'Paste'; whenClickedDo: [:event :client | client widgetDo: [:w | w editor paste ] ]; yourself).
	menu addSeparator.
	menu addItem: (ToButtonMenuItem new labelText: 'Cancel'; whenClickedDo: [:event :client | client widgetDo: [:w | w requestCancel ] ]; yourself).
	menu withoutLeftColumn.
	menu client: model.
	model widgetDo: [ :widget | widget contextMenuFactory: [ menu ] ].
	model onWidget openInInnerWindow 


]

{ #category : #combobox }
ToSandBox class >> example_ComboBoxWithColors [

	| win combo |
	win := ToInnerWindow new title: 'Combo box Example'.
	combo := ToComboBox new.
	combo nodeFactory: [ :color |
		     ToLabeledNode new
			     labelText: (color asString asRopedText
					      foreground: color contrastingBlackAndWhiteColor;
					      yourself);
			     background: color;
			     hMatchParent].
	combo headContentFactory: [ :color | ToLabel new text: (color asString asRopedText
					      foreground: color contrastingBlackAndWhiteColor;
					      yourself); background: color; yourself ].
	combo data addAll: Color indexedColors.
	combo selectIndex: 1.
	win root addChild: combo.
	win openInWorld
]

{ #category : #combobox }
ToSandBox class >> example_ComboBoxWithHeadPlaceholder [

	| win combo but head |
	win := ToInnerWindow new title: 'Combo box Example'.
	combo := ToComboBox new.
	but := ToButton new labelText: ('<< Fetch data >>' asRopedText foreground: Color gray).
	but whenClickedDo: [ combo data addAll: (Smalltalk globals allClasses collect: [ :cls | cls name ]). combo headPlaceholder: nil ].
	head := ToElement new layout: BlFrameLayout new.
	head vFitContent.
	head addChild: but.
	combo headPlaceholder: head.
	win root addChild: combo.
	win openInWorld
]

{ #category : #combobox }
ToSandBox class >> example_ComboBoxWithListPlaceholder [

	| win combo placeHolder lab but |
	win := ToInnerWindow new title: 'Combo box Example'.
	combo := ToComboBox new.
	placeHolder := ToElement new.
	placeHolder layout: BlLinearLayout vertical.
	placeHolder layout cellSpacing: 10.
	placeHolder margin: (BlInsets all: 10).
	placeHolder fitContent.
	placeHolder addChild: (lab := ToLabel new text: ('No element - click to get data' asRopedText foreground: Color red)).
	placeHolder addChild: (but := ToButton new labelText: 'Fetch data').
	lab constraintsDo: [ :c | c linear horizontal alignCenter ].
	but constraintsDo: [ :c | c linear horizontal alignCenter ].
	but whenClickedDo: [ combo data addAll: (Smalltalk globals allClasses collect: [ :cls | cls name ]) ].
	combo listPlaceholder: placeHolder.
	win root addChild: combo.
	win openInWorld
]

{ #category : #list }
ToSandBox class >> example_EditableListWithAllClassesNames [

	| l |
	l := ToListElement new nodeFactory: [ :assoc :holder |
		     | lab |
		     lab := ToLabel new
			            text: assoc value;
			            beEditable;
			            margin: (BlInsets all: 1);
			            padding: (BlInsets all: 1);
			            yourself.
		     lab whenTextReplacedDo: [
			     holder list
				     at: holder position
				     put: assoc key -> lab text asString ].
		     ToLabeledNode new
			     label: lab;
			     icon: (ToImage inner: assoc key);
			     columnWidth: 20;
			     hMatchParent ].
	l data addAll: (Smalltalk globals allClasses collect: [ :cls |
			 | icon isel |
			 isel := cls hasComment
				         ifTrue: [ #class ]
				         ifFalse: [ #uncommentedClass ].
			 icon := Smalltalk ui icons iconNamed: isel.
			 icon -> cls name ]).
	l withRowNumbers.
	l openInInnerWindow
]

{ #category : #album }
ToSandBox class >> example_EditorWithPrompt [

	| prompt view |
	prompt := ('Here is a prompt' , String cr , 'visible only if the text is empty') asRopedText.
	prompt foreground: Color lightGray.
	prompt fontSize: 24.

	view := (ToAlbumModel new
		 withPrompt: prompt;
		 withRowNumbers;
		 withSaveCapability;
		 whenSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: true ];
		 withEditsFeedbackLayer) onWidget.

	view openInOBlSpace
]

{ #category : #album }
ToSandBox class >> example_EditorWithPromptWithToAlbumModel [

	| prompt view |
	prompt := ('Here is a prompt' , String cr , 'visible only if the text is empty') asRopedText.
	prompt foreground: Color lightGray.
	prompt fontSize: 24.

	view := (ToAlbumModel new
		 withPrompt: prompt;
		 withRowNumbers;
		 withSaveCapability;
		 whenSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: true ];
		 withEditsFeedbackLayer) onWidget.

	view openInOBlSpace
]

{ #category : #album }
ToSandBox class >> example_EditorWithSoftLine [

	| prompt view |
	prompt := ('Here is a prompt' , String cr , 'visible only if the text is empty') asRopedText.
	prompt foreground: Color lightGray.
	prompt fontSize: 24.

	view := (ToAlbumModel new
		 withPrompt: prompt;
		 withRowNumbers;
		 withSaveCapability;
		 whenSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: true ];
		 withEditsFeedbackLayer) onWidget.
	view withSoftLine.
	view text: ((String loremIpsum: 100000) asRopedText fontName: 'Source Code Pro').
	view openInOBlSpace
]

{ #category : #album }
ToSandBox class >> example_EditorWithoutSoftLine [

	| prompt view |
	prompt := ('Here is a prompt' , String cr , 'visible only if the text is empty') asRopedText.
	prompt foreground: Color lightGray.
	prompt fontSize: 24.

	view := (ToAlbumModel new
		 withPrompt: prompt;
		 withRowNumbers;
		 withSaveCapability;
		 whenSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: true ];
		 withEditsFeedbackLayer) onWidget.
	view withoutSoftLine.
	view text: ((String loremIpsum: 100000) asRopedText fontName: 'Source Code Pro').
	view openInOBlSpace
]

{ #category : #combobox }
ToSandBox class >> example_EmptyComboBox [

	| win combo |
	win := ToInnerWindow new title: 'Combo box Example'.
	combo := ToComboBox new.
	win root addChild: combo.
	win openInWorld
]

{ #category : #list }
ToSandBox class >> example_ListOneClass [

	| l |
	l := ToListElement new nodeFactory: [ :cls |
		     ToCheckNode new
			     labelText: cls name;
			     columnWidth: 25;
			     hMatchParent ].
	l data addAll: { Smalltalk globals allClasses first }.
	l openInOBlSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClasses [

	| l |
	l := ToListElement new.
	l data addAll:
		(Smalltalk globals allClasses collect: [ :cls | cls name ]).
	l openInOBlSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClasses3 [

	| l |
	l := ToListElement new 
			nodeFactory: [ :cls :holder |
		     | icn lab |
		     icn := cls hasComment
			            ifTrue: [ #class ]
			            ifFalse: [ #uncommentedClass ].
		     lab := ToLabel new
			            text: cls name;
			            beEditable;
			            yourself.
		     ToLabeledNode new
			     label: lab;
			     icon: (ToImage inner: (Smalltalk ui icons iconNamed: icn));
			     columnWidth: 20;
			     hMatchParent ].
	l data addAll: Smalltalk globals allClasses.
	l withRowNumbers.
	l openInInnerWindow
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClasses4 [

	| l |
	l := ToListElement new 
		withoutSelectionDecoration;
		nodeFactory: [ :cls |
		     ToCheckNode new
			     labelText: cls name;
			     columnWidth: 25;
			     hMatchParent ].
	l data addAll: Smalltalk globals allClasses.
	l openInOBlSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesAndTraitsSorted [

	| l |
	l := ToListElement new nodeFactory: (ToClassToNodeConverterExample new).
	l data addAll: (Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name]).
	l openInOBlSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesAsButton [

	| l |
	l := ToListElement new nodeFactory: [ :cls |
		     ToButton new
			     labelText: cls name;
			     hMatchParent ].
	l data addAll: Smalltalk globals allClasses.
	l openInOBlSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithEditableAndContextMenu [

	| l selectionMenu menuFactory |
	l := ToListElement new.
	l nodeFactory: [ :t :holder |
		| lab |
		lab := ToLabel text: t.
		lab beMultiLine.
		lab beEditable.
		lab whenTextReplacedDo: [
			l data at: holder position put: lab text asString ].
		ToLabeledNode new
			label: lab;
			hMatchParent ].
	l when: ToStrongSelectionEvent do: [ :event |
		| r |
		r := event indexes collect: [ :idx | idx asString , ':XXXXXX' ].
		r do: [ :e | l data addFirst: e ] ].
	menuFactory := [
	               | menu |
	               menu := ToContextMenu new withoutLeftColumn.
	               menu client: l.
	               menu addItem: (ToButtonMenuItem new
			                labelText: 'Add initial Items';
			                whenClickedDo: [ :event :client |
				                40 timesRepeat: [ client data add: 'AAAAAAAAAAA' ] ]).
	               l data ifNotEmpty: [
		               menu addItem: (ToButtonMenuItem new
				                labelText: 'Select all';
				                whenClickedDo: [ :event :client | client selectAll ]).
		               selectionMenu := ToMenu new withoutLeftColumn.
		               selectionMenu label:
			               (ToLabel new text: 'Selection actions') ].
	               l selectedIndexes ifNotEmpty: [
		               l selectedIndexes size = 1 ifTrue: [
			               | holder idx |
			               idx := l selectedIndexes first.
			               holder := l findElementHolderForDataSourcePosition: idx.
			               selectionMenu addItem: (ToButtonMenuItem new
					                labelText: 'Edit Selection';
					                whenClickedDo: [ :event :client |
						                holder itemElement label addEditor ];
					                yourself).
			               selectionMenu addItem: (ToButtonMenuItem new
					                labelText: (holder itemElement label isMonoLine
							                 ifTrue: [ 'Be multiline' ]
							                 ifFalse: [ 'Be monoline' ]);
					                whenClickedDo: [ :event :client |
						                holder itemElement label monoLine:
								                holder itemElement label isMonoLine not ];
					                yourself).
			               selectionMenu addSeparator ].
		               selectionMenu addItem: (ToButtonMenuItem new
				                labelText: 'Insert before';
				                whenClickedDo: [ :event :client |
					                client selectedIndexes do: [ :idx |
							                client data
								                add: idx asString , ':XXXXXX'
								                beforeIndex: idx ] ];
				                yourself).
		               selectionMenu addItem: (ToButtonMenuItem new
				                labelText: 'Insert after';
				                whenClickedDo: [ :event :client |
					                | nb |
					                nb := client selectedIndexes size.
					                client selectedIndexes do: [ :idx |
							                client data
								                add: idx asString , ':XXXXXX'
								                afterIndex: idx + nb - 1 ] ];
				                yourself).
		               selectionMenu addSeparator.
		               selectionMenu addItem: (ToButtonMenuItem new
				                labelText: 'Remove selection';
				                whenClickedDo: [ :event :client |
					                | from to |
					                client selectedIndexes ifNotEmpty: [
							                from := client selectedIndexes first.
							                to := client selectedIndexes last.
							                client data removeFrom: from to: to ] ];
				                yourself).
		               menu addItem: selectionMenu.
		               menu addSeparator ].
	               l data ifNotEmpty: [
		               menu addItem: (ToButtonMenuItem new
				                labelText: 'Remove all';
				                whenClickedDo: [ :event :client |
					                client data removeAll ];
				                yourself) ].
	               menu ].
	l contextMenuFactory: menuFactory.
	l withRowNumbers.
	l inspect.
	l openInInnerWindow
]

{ #category : #list }
ToSandBox class >> example_ListWithIndexedColors [

	| l |
	l := ToListElement new nodeFactory: [ :color |
		     ToLabeledNode new
			     dresser: (ToNodeWithHoverButtonDresserExample new changeBackground: false; yourself);
			     labelText: (color asString asRopedText
					      foreground: color contrastingBlackAndWhiteColor;
					      yourself);
			     background: color ].
	l data addAll: Color indexedColors.
	l openInOBlSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithPanes [

	| list |
	list := ToListElement new 
		withRowNumbers;
		nodeFactory: [ :collectible :holder |
		        | title blContent |
		        title := ToLabel new
			                 id: #title;
			                 text: collectible;
			                 margin: (BlInsets all: 1);
			                 padding: (BlInsets all: 1);
			                 yourself.
		        blContent := ToPaneNodeExample new.
		        blContent addChild: title at: 1.
		        blContent vFitContent.
		        blContent hMatchParent.
		        blContent margin: (BlInsets all: 4).
		        blContent padding: (BlInsets all: 12).
		        blContent geometry: (BlRoundedRectangleGeometry cornerRadius: 6).
		        blContent border: (BlBorder paint: Color lightGray).
		        blContent ].
	list data addAll: (1 to: 1000).
	list openInOBlSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithRowNumbers [

	| l |
	l := ToListElement new nodeFactory: [ :cls |
		     ToCheckNode new
			     labelText: cls name;
			     columnWidth: 25;
			     hMatchParent ].
	l data addAll: Smalltalk globals allClasses.
	l withRowNumbers.
	l openInOBlSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithSingleSelection [

	| l |
	l := ToListElement new
		nodeFactory: [ :cls |
		     ToCheckNode new
			     labelText: cls name;
			     columnWidth: 25;
			     hMatchParent ].
	l data addAll: Smalltalk globals allClasses.
	l selectionStrategy beSingleSelection.
	l openInOBlSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithoutSelection [

	| l |
	l := ToListElement new
		nodeFactory: [ :cls |
		     ToCheckNode new
			     labelText: cls name;
			     columnWidth: 25;
			     hMatchParent ].
	l data addAll: Smalltalk globals allClasses.
	l selectionStrategy beWithoutSelection.
	l openInOBlSpace
]

{ #category : #window }
ToSandBox class >> example_Popup1 [

	| e popup container but |
	container := ToInnerWindow new
		             relocate: 10 @ 10;
		             size: 400 @ 200;
		             yourself.
	e := ToElement new
		     background: Color lightGray;
		     size: 100 @ 40;
		     relocate: 50 @ 50.
	popup := ToPopupWindow new widget: e.
	but := ToWidget new size: 50@90.
	but addDresser: ToGeneralButtonDresser new.
	but whenAnnouncement: ToClickAnnouncement do: [ self inform: 'Click'. popup close ]. 
	popup root addChild: but.
	popup addEventHandler: (BlEventHandler
			 on: BlSpaceMouseDownOutsideEvent
			 do: [ :event | self inform: 'OUTSIDE']).
	e addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :evt | 
				 popup isAttachedToSceneGraph ifFalse: [ popup popupEvent: evt ] ]).
	popup addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :evt | self inform: 'CLICK'. popup close ]).

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

{ #category : #window }
ToSandBox class >> example_anchoredWidow1 [

	| w e |
	w := ToAnchoredWindow new.
	w background: (Color gray alpha: 0.2).
	w border: (BlBorder paint: Color black width: 2).
	w padding: (BlInsets all: 4).
	e := (ToElement new
			 size: 100 @ 100;
			 relocate: 50 @ 50;
			 background: Color yellow;
			 border: (BlBorder paint: Color red)).
	w anchor: e.
	w root addChild: (ToAlbum new dresser: ToLabelEditorDresser new; text: 'bla bla bla').
	w fitContent.
	e openInInnerWindow.
	w popup
]

{ #category : #choicebox }
ToSandBox class >> example_choiceBoxWithPlaceholder [

	| win choicebox |
	win := ToInnerWindow new title: 'Choice box Example'.

	choicebox := ToChoiceBox new.
	choicebox data addAll: { 'OS-X'. 'Windows'. }.
	choicebox placeholder: (ToLabel text: ('Invalid choice' asRopedText foreground: Color red)).

	win root addChild: choicebox.
	win openInWorld
]

{ #category : #choicebox }
ToSandBox class >> example_choiceBoxWithPlaceholderWithUncheckingStrategy [

	| win choicebox t |
	win := ToInnerWindow new title: 'Some host'.
	choicebox := ToChoiceBox new hMatchParent.
	choicebox withUncheckingStrategy.
	t := 'No selection...' asRopedText , String cr asRopedText, ('Please choose an host from the list' asRopedText foreground: Color lightGray; fontSize: 12).
	choicebox placeholder: (ToLabel new beMultiLine; text: t).
	choicebox dataToTextConverter: [ :assoc | assoc key ].
	choicebox whenSelectedDataChangedDo: [ self inform: choicebox selectedData value asString].
	choicebox data addAll: {
			('Morphic SDL' -> BlMorphicWindowHost).
			('Native SDL' -> BlOSWindowSDL2Host) }.
	win root addChild: choicebox.
	win openInWorld
]

{ #category : #choicebox }
ToSandBox class >> example_choiceBoxWithStringData [

	| win choicebox |
	win := ToInnerWindow new title: 'Choice box Example'.

	choicebox := ToChoiceBox new.
	choicebox data addAll: { 'OS-X'. 'Windows'. }.
	choicebox addSeparator.
	choicebox data add: 'Linux'.
	choicebox selectedData: 'Windows'.

	win root addChild: choicebox.
	win openInWorld
]

{ #category : #choicebox }
ToSandBox class >> example_choiceBoxWithStructuredData [

	| win choicebox |
	win := ToInnerWindow new title: 'Alexandrie host'.

	choicebox := ToChoiceBox new
		             hMatchParent;
		             beJustified.
	choicebox dataToTextConverter: [ :assoc | assoc key ].
	choicebox data addAll: {
			('Morphic SDL' -> BlMorphicWindowHost).
			('Native SDL' -> BlOSWindowSDL2Host) }.
	choicebox placeholder: (ToLabel text: 'Place holder').
	choicebox selectedIndex: 2.
	choicebox whenSelectedDataChangedDo: [
		self inform: choicebox selectedData asString ].
	win root addChild: choicebox.
	win openInWorld
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

{ #category : #pane }
ToSandBox class >> example_horizontalPaneWithDivider [

	| pane e1 e2 e3 btn |
	pane := ToPane new.
	pane matchParent.
	e1 := ToElement new
				margin: (BlInsets all: 3);
		      background: (Color random alpha: 0.2);
		      vMatchParent;
		      width: 100.
	e2 := ToElement new
				margin: (BlInsets all: 3);
		      background: (Color random alpha: 0.2);
		      vMatchParent;
		      width: 200.
	e3 := ToElement new
				margin: (BlInsets all: 3);
		      background: (Color random alpha: 0.2);
		      vMatchParent;
		      width: 50.
	pane addChildren: {
			e1.
			e2.
			e3 }.
	btn := ToButton new labelText: 'Change orientation'.
	btn whenClickedDo: [ pane orientation: pane orientation inverted ].
	pane addChild: btn.
	btn := ToButton new labelText: 'Change direction'.
	btn whenClickedDo: [ pane direction: pane direction inverted ].
	pane addChild: btn.

	pane addDividers.
	pane openInWorld
]

{ #category : #menu }
ToSandBox class >> example_menu1 [

	| menu sub subsub |
	menu := ToMenu new.
	menu layout cellSpacing: 5.
	menu globalColumnWidth: 22.
	menu label: (ToLabel new text: 'File').
	menu icon: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #solidMenu)).
	menu addItem: (ToButtonMenuItem new
			 label: (ToLabel new text: 'Open file');
			 icon: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #config))).
	menu addItem: (ToButtonMenuItem new label: (ToLabel new text: 'Export')).
	menu addSeparator.
	
	sub := ToMenu new label: (ToLabel new text: 'Save All').
	sub addItem: (ToButtonMenuItem new label: (ToLabel new text: 'Locally')).
	
	subsub := ToMenu new label: (ToLabel new text: 'Externally'); icon: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #solidMenu)).
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
	menu addItem: (ToCheckMenuItem new label: (ToLabel text:'Other'); beLabelFirst; columnWidth: 200).
	menu relocate: 10@10.
	menu openInNewSpace
]

{ #category : #menu }
ToSandBox class >> example_menu2_2 [

	| menu  sub |
	menu := ToMenu new.
	menu icon: (ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).
	
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
			 icon: (ToImage inner: (Smalltalk ui icons iconNamed: #config))).
	menu addItem: (ToButtonMenuItem new labelText: 'Export').
	menu addItem: (ToCheckMenuItem new labelText: 'Align right').
	menu addSeparator.
	
	sub := ToMenu new labelText: 'Save All'; withoutLeftColumn.
	sub addItem: (ToButtonMenuItem new labelText: 'Locally').
	
	subsub := ToMenu new labelText: 'Externally'; withoutLeftColumn.
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
	menu icon: (ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).
	menu addItem: (ToButtonMenuItem new labelText: 'Open file').
	menu addItem: (ToButtonMenuItem new labelText: 'Export').
	menu addItem: (ToRadioMenuItem new labelText: 'Align right').
	menu addSeparator.
	
	sub := ToMenu new labelText: 'Save All'.
	sub addItem: (ToButtonMenuItem new labelText: 'Locally').
	
	subsub := ToMenu new labelText: 'Externally'; icon: (ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).
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
	grp whenChangedDo: [ :ann | ('checked: ' , ann checkedButtons asString , ' unchecked: ', ann uncheckedButtons asString) traceCr].
	center startChecked.
	
	grp add: right.
	grp add: center.
	grp add: left.


	menu addSeparator.
	menu addAllItems: grp buttons.
	menu addSeparator.

	sub := ToMenu new labelText: 'Save All'.
	sub addItem: (ToButtonMenuItem new labelText: 'Locally').

	subsub := ToMenu new labelText: 'Externally'.
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
			 icon: (ToImage inner: (Smalltalk ui icons iconNamed: #config))).

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
	center startChecked.
	grp addAll: { 
			right.
			center.
			left }.

	grp whenChangedDo: [ :ann | ('checked: ' , ann checkedButtons asString , ' unchecked: ', ann uncheckedButtons asString) traceCr].

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
	center startChecked.
	grp addAll: { 
			right.
			center.
			left }.
	grp whenChangedDo: [ :ann | ('checked: ' , ann checkedButtons asString , ' unchecked: ', ann uncheckedButtons asString) traceCr].

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
	center startChecked.
	grp addAll: { 
			right.
			center.
			left }.

	grp whenChangedDo: [ :ann | ('checked: ' , ann checkedButtons asString , ' unchecked: ', ann uncheckedButtons asString) traceCr].

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
		             withPrompt: 'Your name'.
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
ToSandBox class >> example_overlayWidow1 [

	| w e |
	w := ToOverlayWindow new.
	w background: (Color gray alpha: 0.2).
	w border: (BlBorder paint: Color black width: 2).
	e := (ToElement new
			 size: 100 @ 100;
			 relocate: 50 @ 50;
			 background: Color yellow;
			 border: (BlBorder paint: Color red)).
	w overlayed: e.
	e openInInnerWindow.
	w popup
]

{ #category : #window }
ToSandBox class >> example_rootFrame1 [
	ToInnerWindow new title: 'Internal Frame example' ; openInOBlSpace 
]

{ #category : #'context menu + menubar' }
ToSandBox class >> example_rootFrameWithContextMenu [

	| win menu sub subsub bar textField |
	win := ToInnerWindow new title: 'Context menu Example'.
	menu := ToContextMenu new.
	menu globalColumnWidth: 22.
	menu addItem: (ToButtonMenuItem new
			 labelText: 'Open file';
			 icon: (ToImage inner:  (Smalltalk ui icons iconNamed: #config))).
	menu addItem: (ToButtonMenuItem new labelText: 'Export').
	menu addSeparator.

	sub := ToMenu new labelText: 'Save All'.
	sub addItem: (ToButtonMenuItem new labelText: 'Locally').

	subsub := ToMenu new
		          labelText: 'Externally';
		          icon: (ToImage inner:  (Smalltalk ui icons iconNamed: #solidMenu)).
	subsub addItem: (ToButtonMenuItem new labelText: 'Here').

	sub addItem: subsub.

	menu addItem: sub.

	win contextMenuFactory: [ menu ].

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
		             withPrompt: 'search...'.
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
			 icon: (ToImage inner: (Smalltalk ui icons iconNamed: #config))).
	menu addItem: (ToButtonMenuItem new labelText: 'Export').
	menu addSeparator.

	sub := ToMenu new labelText: 'Save All'.
	sub addItem: (ToButtonMenuItem new labelText: 'Locally').

	subsub := ToMenu new
		          labelText: 'Externally';
		          icon: (ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).
	subsub addItem: (ToButtonMenuItem new labelText: 'Here').

	sub addItem: subsub.

	menu addItem: sub.

	win contextMenuFactory: [ menu ].

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
	t := ToTextField new text: 'AAAA'.
	t openInOBlSpace.
	
]

{ #category : #'text field' }
ToSandBox class >> example_textFieldWithLineWrapping [

	| t |
	t := ToTextField new withLineWrapping; withSaveCapability.
	t openInOBlSpace
]

{ #category : #'text field' }
ToSandBox class >> example_textFieldWithLineWrappingWithSaveCapability [

	| t text |
	t := ToTextField new
		     withLineWrapping;
		     withSaveCapability.
	t whenSaveRequestedDo: [ :saveRequested |
		saveRequested client saveResult: true.
		text := saveRequested client text copy ].
	t whenCancelRequestedDo: [ :cancelRequested |
		cancelRequested client text: text copy ].

	t openInInnerWindow
]

{ #category : #'text field' }
ToSandBox class >> example_textFieldWithPrompt [

	| t text |
	t := ToTextField new withSaveCapability.
	text := ''.
	t withPrompt: 'Enter to accept'.
	t text: text copy.
	t whenSaveRequestedDo: [ :saveRequested | 
		saveRequested client saveResult: true.
		text := saveRequested client text copy].
	t whenCancelRequestedDo: [ :cancelRequested | 
		cancelRequested client text: text copy ].
	t openInOBlSpace.

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

{ #category : #'text field' }
ToSandBox class >> example_textFieldWithoutLineWrapping [

	| t |
	t := ToTextField new withoutLineWrapping; withSaveCapability.
	t openInOBlSpace
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
	but addDresser: ToGeneralButtonDresser new.
	but whenAnnouncement: ToClickAnnouncement do: [ self inform: 'Click' ]. 
	but background: Color blue.
	but size: 300@100.
	but  openInOBlSpace  
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
	but := ToGeneralButton new dresser: ToGeneralButtonDresser new.
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
	but := ToGeneralButton new dresser: ToGeneralButtonDresser new.
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
	but := ToButtonModel new label: (ToLabel text: 'Button').
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
		       beVertical.
	but label: (ToLabel text: 'Button').
	but icon: (BlElement new
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
	but label: (ToLabel text:'Button' asRopedText bold).
	iconImage := BlElement new
		             size: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but icon: iconImage.
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
	but padding: (BlInsets all: 3).
	but border: (BlBorder paint: Color lightGray).
	but label: (ToLabel text:'Button' asRopedText bold).
	iconImage := BlElement new
		             size: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but icon: iconImage.
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
	but icon: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #solidMenu)).
	container addChild: but.
	space := OBlSpace new.
	space addChild: container.
	space show 
]

{ #category : #button }
ToSandBox class >> example_toButtonWithTextAndIconHorizontal [

	| but space |
	but := ToButton new "cellSpacing: 2; padding: (BlInsets all: 4)".
	but label: (ToLabel text: 'Button').
	but icon: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself).
	but beRightToLeft.
	but layout cellSpacing: 10.
	but whenClickedDo: [ :ann | but icon background: Color random ].
	space := OBlSpace new.
	space addChild: but.
	space show 
]

{ #category : #button }
ToSandBox class >> example_toButtonWithTextAndIconVertical [

	| but space |
	but := ToButton new padding: (BlInsets all: 4); beVertical.
	but label: (ToLabel text: 'Button').
	but icon: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself).
	but layout cellSpacing: 10.
	but whenClickedDo: [ :ann | but icon background: Color random ].
	space := OBlSpace new.
	space addChild: but.
	space show 
]

{ #category : #button }
ToSandBox class >> example_toButtonWithTextOnly [

	| but space |
	but := ToButton new.
	but label: (ToLabel text: 'Button').
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
		       label: (ToLabel text: '1');
		       id: 1 asString.
	chb beRightToLeft.
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
	but := ToCheckboxModel new label: (ToLabel text: 'Check me').
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
ToSandBox class >> example_toCheckboxWithToggleGroup2 [

	| group container |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx | 
		| chb |
		chb := ToRadioButton new
			       beVertical;
			       labelText: idx asString;
			       id: idx asString.
		chb beIconFirst.
		group add: chb ].
	group buttons second startChecked.
	container := ToElement new.
	container matchParent.
	container layout: BlLinearLayout horizontal.
	container layout cellSpacing: 2.
	container addChildren: group buttons.
	group whenChangedDo: [ :ann | ('checked: ' , ann checkedButtons asString , ' unchecked: ', ann uncheckedButtons asString) traceCr].
	ToInnerWindow new
		in: [ :f | f addChild: container ];
		openInWorld
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithToggleGroupAndNoneStrategy [

	| group container buttons |
	group := ToCheckableGroup new.
	group withoutCheckingStrategy.
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
	group whenChangedDo: [ :ann | ('checked: ' , ann checkedButtons asString , ' unchecked: ', ann uncheckedButtons asString) traceCr].

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
ToSandBox class >> example_toCheckboxWithToggleGroupAndStrictStrategy [

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
	group whenChangedDo: [ :ann | ('checked: ' , ann checkedButtons asString , ' unchecked: ', ann uncheckedButtons asString) traceCr].

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
ToSandBox class >> example_toCheckboxWithToggleGroupAndUnckekingStrategy [

	| group container buttons |
	group := ToCheckableGroup new.
	group withUncheckingStrategy.
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
	group whenChangedDo: [ :ann | ('checked: ' , ann checkedButtons asString , ' unchecked: ', ann uncheckedButtons asString) traceCr].

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
	group whenChangedDo: [ :ann | ('checked: ' , ann checkedButtons asString , ' unchecked: ', ann uncheckedButtons asString) traceCr].

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
ToSandBox class >> example_toLabel1 [

	| lab |
	lab := ToLabel text: 'Hello world'.
	lab openInNewSpace.

]

{ #category : #label }
ToSandBox class >> example_toLabel2 [

	| lab |
	lab := ToLabel text: 
'Mme XX
28 allée de la mer,
29200 Brest'.
	lab beMultiLine.
	lab openInNewSpace.

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
	root := ToElement new constraintsDo: [ :c | 
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

	root openInInnerWindow 
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
		widget border: (BlBorder paint: Color red width: 1).
		widget innerElement margin: (BlInsets all: 8) ].
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
		icon: (ToImage inner: (BlElement new
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
		       icon: (ToImage inner:  (BlElement new
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
						 icon: (ToImage inner:  (BlElement new
								  size: 400 @ 400;
								  background: Color blue));
						 labelText: 'Big blue' ];
				 yourself).
			(ToWidgetState new name: #green;
				 whenEnterDo: [ :ann | 
					 ann widget
						 icon: (ToImage inner:  (BlElement new
								  size: 20 @ 40;
								  background: Color green));
						 labelText: 'Green' ];
				 yourself).
			(ToWidgetState new
				 whenEnterDo: [ :ann | 
					 ann widget
						 icon: (ToImage inner:  (BlElement new
								  size: 50 @ 50;
								  background: Color black));
						 labelText: 'Black' ];
				 yourself).
			(ToWidgetState new
				 whenEnterDo: [ :ann | 
					 ann widget
						 icon: (ToImage inner:  (BlElement new
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
								 icon: (ToImage inner:  (BlElement new
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
								 icon: (ToImage inner:  (BlElement new
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
								 icon: (ToImage inner:  (BlElement new
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
								 icon: (ToImage inner:  (BlElement new
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
	but := ToPairedElement new.
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
		but direction: but direction inverted.
		but requestLayout ].
	space := OBlSpace new.
	space addChild: but.
	space show
]

{ #category : #pair }
ToSandBox class >> example_toPairJustified1 [

	| but space iconImage |
	but := ToPairedElement new.
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
	but := ToPairedElement new.
	but layout cellSpacing: 4.
	but padding: (BlInsets all: 3).
	but border: (BlBorder paint: Color lightGray).
	but first: (ToLabel text: 'Pair' asRopedText bold).
	iconImage := BlElement new
		             size: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but second: iconImage.
	but when: BlClickEvent do: [ but direction: but direction inverted ].
	but beJustified.
	but hMatchParent.

	space := OBlSpace new.
	space addChild: but.
	space show
]

{ #category : #pair }
ToSandBox class >> example_toPairOrientationChanger [

	| but space iconImage |
	but := ToPairedElement new.
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
	but := ToPairedElement new.
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
	but := ToPairedElement new.
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
	but when: BlClickEvent do: [ but direction: but direction inverted ].
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
	but addDresser: ToGeneralButtonDresser new.
	but whenAnnouncement: ToClickAnnouncement do: [ self inform: 'Click' ]. 
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

{ #category : #pane }
ToSandBox class >> example_verticalPaneWithDivider [

	| pane e1 e2 e3 btn |
	pane := ToPane new beVertical.
	pane matchParent.
	e1 := ToElement new
		      background: (Color random alpha: 0.2);
				id: #e1;
		      hMatchParent;
		      height: 100.
	e2 := ToElement new
		      background: (Color random alpha: 0.2);
				id: #e2;
		      hMatchParent;
		      height: 200.
	e3 := ToElement new
		      background: (Color random alpha: 0.2);
				id: #e3;
		      hMatchParent;
		      height: 50.
	pane addChildren: {
			e1.
			e2.
			e3 }.
	btn := ToButton new labelText: 'Change orientation'.
	btn whenClickedDo: [ pane orientation: pane orientation inverted ].
	pane addChild: btn.
	btn := ToButton new labelText: 'Change direction'.
	btn whenClickedDo: [ pane direction: pane direction inverted ].
	pane addChild: btn.
	pane addDividers.
	pane openInInnerWindow 
]

{ #category : #accessing }
ToSandBox class >> methodText [
	^ self  class sourceCodeAt: #example_CodeEditorWithToAlbumModel
]
