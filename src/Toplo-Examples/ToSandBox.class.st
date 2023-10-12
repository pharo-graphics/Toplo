Class {
	#name : #ToSandBox,
	#superclass : #Object,
	#category : #'Toplo-Examples'
}

{ #category : #combobox }
ToSandBox class >> example_BasicComboBox [

	| win combo |
	win := ToInnerWindow new title: 'Combo box Example'.
	combo := ToComboBox new.
	combo data addAll:
		(Smalltalk globals allClasses collect: [ :cls | cls name ]).
	"combo inspect."
	win root addChild: combo.
	win openInSpace
]

{ #category : #combobox }
ToSandBox class >> example_BasicComboBoxWith5Elements [

	| win combo |
	win := ToInnerWindow new title: 'Combo box Example'.
	combo := ToComboBox new.
	combo data addAll: ((1 to: 5) collect: [ :i | '#' , i asString ]).
	combo selectIndex: 3.
	win root addChild: combo.
	"combo inspect."
	win openInSpace
]

{ #category : #combobox }
ToSandBox class >> example_BasicComboBoxWithStatesOfAmerica [

	| win combo placeholder |
	win := ToInnerWindow new title: 'Combo box Example'.
	combo := ToComboBox new.
	placeholder := ToLabel new
		               text:
			               ('Choose a state' asRopedText foreground:
					                Color lightGray);
		               hMatchParent.
	combo headPlaceholder: placeholder.
	combo data addAll: self statesOfAmerica.
	win root addChild: combo.

	"combo inspect."
	win openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_CheckBoxAndButtonWithDefaultStyleSheet [

	| chk btn space |
	ToStyleSheetTheme cleanUp.
	chk := ToCheckbox new.
	chk labelText: 'OK'.
	btn := ToButton new.
	btn labelText: 'Erase all your Pharo images?'.
	btn iconImage: ToThemeIcons iconSearchOutlined16x16.
	btn label withStamp: #H3.
	btn withStamp: #primary.
	btn withStamp: #danger.
	btn size: 500 @ 100.
	space := BlSpace new.
	space root layout: BlLinearLayout vertical.
	space root addChildren: {
			chk.
			btn }.
	space show
]

{ #category : #'button-dep' }
ToSandBox class >> example_CheckBoxAndButtonWithDefaultStyleSheetDarkTheme [

	| chk btn space |
	ToStyleSheetTheme cleanUp.
	chk := ToCheckbox new.
	chk labelText: 'OK'.
	btn := ToButton new.
	btn labelText: 'Erase all your Pharo images?'.
	btn iconImage: ToThemeIcons iconSearchOutlined16x16.
	btn label withStamp: #H3.
	btn withStamp: #primary.
	btn withStamp: #danger.
	btn size: 500 @ 100.
	space := BlSpace new toTheme: ToBeeDarkTheme new; yourself.
	space root layout: BlLinearLayout vertical.
	space root addChildren: {
			chk.
			btn }.
	space show
]

{ #category : #'button-dep' }
ToSandBox class >> example_CheckBoxWithDefaultStyleSheetDarkTheme [

	| chk  space |
	ToStyleSheetTheme cleanUp.
	chk := ToCheckbox new.
	chk labelText: 'OK'.
	space := BlSpace new toTheme: ToBeeDarkTheme new; yourself.
	space root layout: BlLinearLayout vertical.
	space root addChildren: {
			chk }.
	chk disabled: false.
	space show
]

{ #category : #album }
ToSandBox class >> example_CodeEditor [

"
The Client is a defined by user class. 
ToAlbumBasicClient implement typical Album user with a styler.
It is a kind of model but without any association from the widget to the client (no reference to the client is stored in widget).
It can be used and subclassed to support comment and code editing, workspace implementation...
All the different kind of Album using should use the available basic client class or subclass it for specific purpose.
Here an example of a client for a method.
"

	| text album menuBuilder |
	text := self methodText asRopedText.
	album := ToAlbum new.
	album styler: (BlRBTextStyler new classOrMetaClass: self class).
	album text: text copy.
	album withSaveCapability.
	album withRowNumbers.
	album whenSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: true ].
	album whenCancelRequestedDo: [ :cancelRequested | cancelRequested client text: text copy ].
	
	menuBuilder := [ :alb | | menu |
		menu := ToContextMenu new.
		menu addItem: (ToMenuItem new labelText: 'Select all'; whenClickedDo: [:event  | alb selecter all; apply ]; yourself).
		menu addItem: (ToMenuItem new labelText: 'Copy'; whenClickedDo: [:event  | alb editor copySelected ]; yourself).
		menu addItem: (ToMenuItem new labelText: 'Cut'; whenClickedDo: [:event  | alb editor cutSelected ]; yourself).
		menu addItem: (ToMenuItem new labelText: 'Paste'; whenClickedDo: [:event  | alb editor paste ]; yourself).
		menu addSeparator.
		menu addItem: (ToMenuItem new labelText: 'Accept'; whenClickedDo: [:event  | alb requestSave ]; yourself).
		menu addSeparator.
		menu addItem: (ToMenuItem new labelText: 'Cancel'; whenClickedDo: [:event  | alb requestCancel ]; yourself).
		menu ].
	album contextMenuBuilder: menuBuilder. 
	album cursorColor: Color black.
	album openInInnerWindow 


]

{ #category : #combobox }
ToSandBox class >> example_ComboBoxEmpty [

	| win combo |
	win := ToInnerWindow new title: 'Combo box Example'.
	combo := ToComboBox new.
	win root addChild: combo.
	win openInSpace
]

{ #category : #combobox }
ToSandBox class >> example_ComboBoxWithAllClasses [

	| win combo |
	win := ToInnerWindow new title: 'Pharo classes'.
	combo := ToComboBox new.
	combo nodeFactory: [ :cls |
		ToLabeledNode new
			label: (ToLabel new text: cls name; yourself);
			hMatchParent ].
	combo data addAll: Smalltalk globals allClasses.
	combo listElementSize: 200 @ 500.
	win root addChild: combo.
	win openInSpace
]

{ #category : #combobox }
ToSandBox class >> example_ComboBoxWithColors [

	| win combo |
	win := ToInnerWindow new title: 'Combo box Example'.
	combo := ToComboBox new.
	combo nodeFactory: [ :color |
				(ToElement new
					 height: 30;
					 hMatchParent;
					 background: color;
					 yourself;
			hMatchParent) ].
	combo headElementFactory: [ :color |
		ToElement new
			margin: (BlInsets all: 4);
			height: 25;
			hMatchParent;
			background: color;
			yourself ].
	combo data addAll: Color indexedColors.
	combo selectIndex: (combo data size / 2) asInteger.
	win root addChild: combo.
	win openInSpace
]

{ #category : #combobox }
ToSandBox class >> example_ComboBoxWithHeadPlaceholder [

	| win combo but t |
	win := ToInnerWindow new title: 'Combo box Example'.
	combo := ToComboBox new.
	t := '<Click to fetch data>' asRopedText foreground: Color red.
	but := ToLabel new
		       text: t;
		       hMatchParent.
	but when: BlClickEvent do: [
		combo data addAll:
			(Smalltalk globals allClasses collect: [ :cls | cls name ]).
		combo headPlaceholder: (ToLabel new text: '<No selection>'; hMatchParent; yourself)].
	combo headPlaceholder: but.
	win root addChild: combo.
	win openInSpace
]

{ #category : #combobox }
ToSandBox class >> example_ComboBoxWithListPlaceholder [

	| win combo placeholder lab but |
	win := ToInnerWindow new title: 'Combo box Example'.
	combo := ToComboBox new.
	placeholder := ToElement new.
	placeholder layout: BlLinearLayout vertical.
	placeholder layout cellSpacing: 10.
	placeholder margin: (BlInsets all: 20).
	placeholder fitContent.
	placeholder addChild: (lab := ToLabel new text:
			        ('No element - click to get data' asRopedText foreground:
				         Color red)).
	placeholder addChild: (but := ToButton new labelText: 'Fetch data').
	lab constraintsDo: [ :c | c linear horizontal alignCenter ].
	but constraintsDo: [ :c | c linear horizontal alignCenter ].
	but whenClickedDo: [
		combo data addAll:
			(Smalltalk globals allClasses collect: [ :cls | cls name ]) ].
	combo listPlaceholder: placeholder.
	combo inspect.
	win root addChild: combo.
	win openInSpace
]

{ #category : #combobox }
ToSandBox class >> example_EditableComboBoxEmpty [

	| win combo res |
	res := true.
	win := ToInnerWindow new title: 'Editable Combo box Example'.
	combo := ToComboBox new.
	combo beEditable; withSaveCapability.
 	combo whenSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: res. res := res not ].
	combo whenSaveAcceptedDo: [ :saveAccepted | saveAccepted traceCr ].
	combo whenSaveDeniedDo: [ :saveDenied | saveDenied traceCr ].
	combo whenCancelRequestedDo: [ :cancelRequested | cancelRequested client text: '' ].

	win root addChild: combo.
	win openInSpace
]

{ #category : #combobox }
ToSandBox class >> example_EditableComboBoxWithStatesOfAmerica [

	| win combo |
	win := ToInnerWindow new title: 'Editable Combo box Example'.
	combo := ToComboBox new.
	combo data addAll: self statesOfAmerica.
	combo beEditable; withSaveCapability.
 	combo whenSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: true ].
	combo whenSaveAcceptedDo: [ :saveAccepted |'saved' traceCr ].
	combo whenCancelRequestedDo: [ :cancelRequested | cancelRequested client text: '' ].

	win root addChild: combo.
	win openInSpace
]

{ #category : #list }
ToSandBox class >> example_EditableListWithAllClassesNames [

	| l vscrollBar space |
	l := ToListElement new nodeFactory: [ :assoc :holder |
		     | lab |
		     lab := ToLabel new
			            text: assoc value;
			            beEditable;
			            margin: (BlInsets all: 1);
			            padding: (BlInsets all: 1);
			            yourself.
		     lab whenTextReplacedDo: [
			     holder infiniteElement data
				     at: holder position
				     put: assoc key -> lab text asString ].
		     ToLabeledNode new
			     label: lab;
			     icon: (ToImage inner: assoc key);
			     interspace: 20;
			     hMatchParent ].
	l data addAll: (Smalltalk globals allClasses collect: [ :cls |
			 | icon isel |
			 isel := cls hasComment
				         ifTrue: [ #class ]
				         ifFalse: [ #uncommentedClass ].
			 icon := Smalltalk ui icons iconNamed: isel.
			 icon -> cls name ]).
	l withRowNumbers.
	
	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets right: 2).
			c ignored horizontal alignRight.
			c ignored vertical alignBottom]. 
	vscrollBar attachTo: l infinite.
	space := BlSpace new.
	space root addChild: l.
	space root addChild: vscrollBar.
	space show
]

{ #category : #album }
ToSandBox class >> example_EditorWithPlaceholder [

	| placeholderText view |
	placeholderText := ('Here is a placeholder text' , String cr
	                    , 'visible only if the text is empty')
		                   asRopedText.
	placeholderText foreground: Color lightGray.
	placeholderText fontSize: 24.

	view := ToAlbum new
		        placeholderText: placeholderText;
		        withRowNumbers;
		        withSaveCapability;
		        whenSaveRequestedDo: [ :saveRequested |
			        saveRequested client saveResult: true ];
		        withEditsFeedback.
	view showPlaceholder.
	view openInSpace
]

{ #category : #album }
ToSandBox class >> example_EditorWithoutSoftLine [

	| placeholderText view |
	placeholderText := ('Here is a placeholder text' , String cr
	                    , 'visible only if the text is empty')
		                   asRopedText.
	placeholderText foreground: Color lightGray.
	placeholderText fontSize: 24.

	view := ToAlbum new
		        placeholderText: placeholderText;
		        withRowNumbers;
		        withSaveCapability;
		        whenSaveRequestedDo: [ :saveRequested |
			        saveRequested client saveResult: true ];
		        withEditsFeedback.
	view withoutSoftLine.
	view text:
		((String loremIpsum: 100000) asRopedText fontName: 'Source Code Pro').
	view openInSpace
]

{ #category : #list }
ToSandBox class >> example_FilterOnListWithAllClassesAndTraitsSorted [

	| l pane filter |
	pane := ToPane new
		        beVertical;
		        matchParent.
	filter := ToTextField new.
	l := ToListElement new nodeFactory: ToClassToNodeConverterExample new.
	l data addAll:
		(Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]).
	l margin: (BlInsets all: 2).
	filter margin: (BlInsets all: 2).
	pane addChild: l.
	pane addChild: filter.
	pane openInSpace
]

{ #category : #'general button' }
ToSandBox class >> example_GeneralButtonWithIconAndLabel [

	| but lab ico pane |
	pane := ToPane new.
	pane fitContent.
	pane layout alignCenter.
	lab := ToLabel new text: 'General button'.
	ico := ToImage inner: (self iconNamed: #remove).
	pane addChildren: {
			ico.
			lab }.
	but := ToGeneralButton new.
	but fitContent.
	but padding: (BlInsets all: 4).
	but geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	but border: Color black.
	but addChild: pane.
	but layout alignCenter.
	but whenClickedDo: [ self inform: 'clicked' ].
	but openInSpace.
	^ but
]

{ #category : #'general button' }
ToSandBox class >> example_GeneralButtonWithIconAndLabel_matchParent [

	| but |
	but := self example_GeneralButtonWithIconAndLabel.
	but matchParent
]

{ #category : #'general button' }
ToSandBox class >> example_GeneralButtonWithLabel [

	| but |
	but := ToGeneralButton new.
	but addChild: (ToLabel text: 'General button').
	but border: Color black.
	but fitContent.
	but whenClickedDo: [ self inform: 'clicked' ].
	but openInSpace.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText [

	| but  |
	but := self labeledIconlWithIconAndText.
	but matchParent.
	but openInSpace.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText_flexible [

	| but  |
	but := self example_LabeledIconlWithIconAndText.
	but interspace: #flexible.
	but border: Color red.
	but vFitContent.
	but hMatchParent.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText_flexible_inFitContent [

	| but container |
	container := ToElement new.
	container hMatchParent.
	container vFitContent.
	container layout: BlLinearLayout vertical.
	but := self labeledIconlWithIconAndText.
	but interspace: #flexible.
	but border: Color red.
	but vFitContent.
	but hMatchParent.
	container addChild: but.
	container openInInnerWindow.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText_interspace [

	| but  |
	but := self example_LabeledIconlWithIconAndText.
	but border: Color black.
	but layout cellSpacing: 20.
	but interspace: 100 asPoint.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText_labelFirst [

	| but  |
	but := self example_LabeledIconlWithIconAndText.
	but labelFirst: true.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText_labelFirst_flexible [

	| but  |
	but := self example_LabeledIconlWithIconAndText_labelFirst.
	but interspace: #'flexible'.
	but matchParent.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText_labelFirst_vertical [

	| but  |
	but := self example_LabeledIconlWithIconAndText_labelFirst.
	but vertical: true.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText_labelFirst_vertical_flexible [

	| but  |
	but := self example_LabeledIconlWithIconAndText_labelFirst_vertical.
	but interspace: #flexible.
	but matchParent.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText_vertical [

	| but  |
	but := self example_LabeledIconlWithIconAndText.
	but vertical: true.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText_vertical_interspace [

	| but  |
	but := self example_LabeledIconlWithIconAndText_vertical.
	but interspace: 20.
	^ but
]

{ #category : #combobox }
ToSandBox class >> example_ListAutocompleteComboBoxEmpty [

	| win combo  |
	win := ToInnerWindow new title: 'Inline autocomplete Combo box Example'.
	combo := ToComboBox new beEditable; beListAutocomplete; yourself.
	combo whenTextEditedDo: [ :textEditedEvent | textEditedEvent text traceCr ].
	win root addChild: combo.
	win openInSpace
]

{ #category : #combobox }
ToSandBox class >> example_ListAutocompleteComboBoxWithAllClasses [

	| win combo placeholder |
	win := ToInnerWindow new title: 'Inline autocomplete Combo box Example'.
	combo := ToComboBox new beEditable; beListAutocomplete.
	placeholder := ToLabel new
		               text: ('Choose a class' asRopedText foreground: Color lightGray);
		               hMatchParent.
	combo headPlaceholder: placeholder.
	combo data addAll: (Smalltalk globals allClasses collect: [ :cls | cls name ]).
	combo selectIndex: 10.
	win root addChild: combo.
	win openInSpace
]

{ #category : #combobox }
ToSandBox class >> example_ListAutocompleteComboBoxWithStatesOfAmerica [

	| win combo placeholder |
	win := ToInnerWindow new title:
		       'Inline autocomplete Combo box Example'.
	combo := ToComboBox new beEditable; beListAutocomplete; withSaveCapability.
	placeholder := ToLabel new
		               text:
			               ('Choose a state' asRopedText foreground:
					                Color lightGray);
		               hMatchParent.
	combo headPlaceholder: placeholder.
	combo data addAll: self statesOfAmerica.
	combo selectIndex: 10.
	win root addChild: combo.
	win openInSpace
]

{ #category : #combobox }
ToSandBox class >> example_ListAutocompleteWithSaveInListComboBoxEmpty [

	| win combo  |
	win := ToInnerWindow new title: 'Inline autocomplete Combo box Example'.
	combo := ToComboBox new beEditable; beListAutocomplete; yourself.
	win root addChild: combo.
	win openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListOneClass [

	| l |
	l := ToListElement new nodeFactory: [ :cls |
		     ToCheckNode new
			     labelText: cls name;
			     interspace: 10;
			     hMatchParent ].
	l data addAll: { Smalltalk globals allClasses first }.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWith6Elements [

	| l |
	l := ToListElement new.
	l data addAll: ((1 to: 6) collect: [:i | i asString]).
	l selectIndex: 4.
	l openInInnerWindow
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClasses [

	| l |
	l := ToListElement new.
	l data addAll: (Smalltalk globals allClasses collect: [ :cls | cls name ]).
	l openInSpace
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
			     interspace: 10;
			     hMatchParent ].
	l when: ToInfiniteSelectionChangedEvent do: [ :evt | evt traceCr ].
	l data addAll: Smalltalk globals allClasses.
	l withRowNumbers.
	l infinite requestFocus.
	l openInInnerWindow
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClasses4 [

	| l |
	l := ToListElement new
		     beWithoutSelection;
		     nodeFactory: [ :cls |
			     ToCheckNode new
				     labelText: cls name;
				     interspace: 10;
				     hMatchParent ].
	l data addAll: Smalltalk globals allClasses.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesAndTraitsSorted [

	| l |
	l := ToListElement new nodeFactory: ToClassToNodeConverterExample new.
	l data addAll:
		(Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]).
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesAsButton [

	| l |
	l := ToListElement new nodeFactory: [ :cls |
		     ToButton new
			     labelText: cls name;
			     hMatchParent ].
	l data addAll: Smalltalk globals allClasses.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithEditableAndContextMenu [

	| l selectionMenu menuFactory phlab |
	l := ToListElement new.
	phlab :=ToLabel new
		  beMultiLine;
		  text: ((('Invoke the context menu ', String cr, 
					'with a right-click', String cr, 
					'to initialize the list') asRopedText 
						foreground: Color lightGray; 
						yourself) 
			fontSize: 24; yourself);
		  foreground: Color lightGray;
		  margin: (BlInsets all: 5);
		  constraintsDo: [ :c |
			  c frame vertical alignCenter.
			  c frame horizontal alignCenter ];
		  yourself.
	phlab layout alignCenter.
	phlab innerElement layout alignCenter.
	l placeholder: phlab.
	l showPlaceholder.
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
	l when: ToListStrongSelectionEvent do: [ :event |
		| r |
		r := event indexes collect: [ :idx | idx asString , ':XXXXXX' ].
		r do: [ :e | l data addFirst: e ] ].
	menuFactory := [ :widget |
	               | menu selectedIndexes |
						selectedIndexes := widget secondarySelectionIndexes.
	               menu := ToContextMenu new.
	               menu addItem: (ToMenuItem new
			                labelText: 'Add initial Items';
			                whenClickedDo: [ :event  |
				                widget data addAll: ((1 to: 2000) collect: [:p | 'AAAAAAAAAAA'] ) ]).
	               widget data ifNotEmpty: [
		               menu addItem: (ToMenuItem new
				                labelText: 'Select all';
				                whenClickedDo: [ :event  | widget  selectAll ]).
			            menu addItem: (ToMenuItem new
				                labelText: 'Remove all';
				                whenClickedDo: [ :event  |
					                widget  data removeAll ];
				                yourself) ].
	               selectedIndexes ifNotEmpty: [ 
				         selectionMenu := ToMenu new .
		               selectionMenu label: (ToLabel new text: 'Selection').
		               selectedIndexes size = 1 ifTrue: [
			               | node idx |
			               idx := selectedIndexes first.
			               node := l nodeAt: idx.
			               selectionMenu addItem: (ToMenuItem new
					                labelText: 'Edit';
					                whenClickedDo: [ :event  | 
						                node label addEditorEvent: nil ];
					                yourself).
			               selectionMenu addItem: (ToMenuItem new
					                labelText: (node label isMonoLine
							                 ifTrue: [ 'Be multiline' ]
							                 ifFalse: [ 'Be monoline' ]);
					                whenClickedDo: [ :event  |
						                node label monoLine: node label isMonoLine not ];
					                yourself).			               
								selectionMenu addItem: (ToMenuItem new
					                labelText: 'Inspect';
					                whenClickedDo: [ :event  |
						                node inspect ];
					                yourself).
			               selectionMenu addSeparator ].
		               selectionMenu addItem: (ToMenuItem new
				                labelText: 'Insert before';
				                whenClickedDo: [ :event  | 
					                selectedIndexes do: [ :idx |
							                widget  data
								                add: idx asString , ':XXXXXX'
								                beforeIndex: idx ] ];
				                yourself).
		               selectionMenu addItem: (ToMenuItem new
				                labelText: 'Insert after';
				                whenClickedDo: [ :event |
					                | nb |
					                nb := selectedIndexes size.
					                selectedIndexes do: [ :idx |
							                widget  data
								                add: idx asString , ':XXXXXX'
								                afterIndex: idx + nb - 1 ] ];
				                yourself).
		               selectionMenu addSeparator.
		               selectionMenu addItem: (ToMenuItem new
				                labelText: 'Remove';
				                whenClickedDo: [ :event  | 
					                selectedIndexes ifNotEmpty: [widget data removeFrom: selectedIndexes first to: selectedIndexes last ] ];
				                yourself).
  							menu addSeparator.
		               menu addItem: selectionMenu].
	               menu ].

	l contextMenuBuilder: menuFactory.
	l withRowNumbers.
	l openInInnerWindow
]

{ #category : #list }
ToSandBox class >> example_ListWithIndexedColors [

	| l vscrollBar space |
	l := ToListElement new nodeFactory: [ :color |
		     ToLabeledNode new
			     labelText: (color asString asRopedText);
			     hMatchParent;
			     background: color ].
	l data addAll: Color indexedColors.

	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
		c ignoreByLayout.
		c margin: (BlInsets right: 2).
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	vscrollBar attachTo: l infinite.
	space := BlSpace new.
	space root addChild: l.
	space root addChild: vscrollBar.
	space show
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
			        blContent
				        when: ToNodeHolderSelectedEvent
				        do: [ 'S' traceCr ].
			        blContent
				        when: ToNodeHolderDeselectedEvent
				        do: [ 'D' traceCr ].
			        blContent addChild: title at: 1.
			        blContent margin: (BlInsets all: 4).
			        blContent padding: (BlInsets all: 12).
			        blContent geometry: (BlRoundedRectangleGeometry cornerRadius: 6).
			        blContent border: (BlBorder paint: Color lightGray).
			        blContent ].
	list data addAll: (1 to: 1000).
	list openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithRowNumbers [

	| l |
	l := ToListElement new nodeFactory: [ :cls |
		     ToCheckNode new
			     labelText: cls name;
			     interspace: 25;
			     hMatchParent ].
	l data addAll: Smalltalk globals allClasses.
	l withRowNumbers.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithSingleSelection [

	| l |
	l := ToListElement new nodeFactory: [ :cls |
		     ToCheckNode new
			     labelText: cls name;
			     interspace: 25;
			     hMatchParent ].
	l data addAll: Smalltalk globals allClasses.
	l beSingleSelection.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithoutSelection [

	| l |
	l := ToListElement new nodeFactory: [ :cls |
		     ToCheckNode new
			     labelText: cls name;
			     interspace: 25;
			     hMatchParent ].
	l data addAll: Smalltalk globals allClasses.
	l beWithoutSelection.
	l openInSpace
]

{ #category : #menu }
ToSandBox class >> example_OpenSaveSaveAsCloseWithSubmenu [

	| menu container saveAs |
	container := ToInnerWindow new
		             position: 10 @ 10;
		             size: 400 @ 200;
		             yourself.
	menu := ToMenu new.
	menu label: (ToLabel text: 'Menu').
	menu addItem: (ToMenuItem new
			 icon: (ToImage inner: (self iconNamed: #solidMenu));
			 label: (ToLabel text: 'Open')).
	menu items last labelOffset: 25.
	menu addItem: (ToMenuItem new
			 icon: (ToImage inner: (self iconNamed: #solidMenu));
			 label: (ToLabel text: 'Save')).
	menu items last labelOffset: 25.
	saveAs := ToMenu new label: (ToLabel text: 'Save as ...').
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.pdf')).
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.doc')).
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.xml')).
	menu addItem: saveAs.
	menu items last labelOffset: 25.
	saveAs := ToMenu new label: (ToLabel text: 'Save as ...').
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.pdf')).
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.doc')).
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.xml')).
	menu addItem: saveAs.
	menu items last labelOffset: 25.
	saveAs := ToMenu new label: (ToLabel text: 'Save as ...').
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.pdf')).
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.doc')).
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.xml')).
	menu addItem: (ToMenu new label: (ToLabel  text: 'Save as again...')).
	menu items last addItem: saveAs.
	menu items last labelOffset: 25.
	menu addSeparator.
	menu addItem: (ToMenuItem new
			 label: (ToLabel text: 'Close')).
	menu items last labelOffset: 25.
	container pane addChild: menu.
	"menu window inspect."
	container openInSpace
]

{ #category : #list }
ToSandBox class >> example_PicsumPhotosGallery [
	" cool example adapted from the feenk Glamorous Toolkit version BlInfiniteExample>>exampleGallery"
	" Images loaded from https://picsum.photos "
	| space list vscrollBar |
	list := ToListElement new
		        matchParent;
		        yourself.
	list padding: (BlInsets all: 1).
	list nodeFactory: [ :anImageData |
		ToPicsumPhotosGalleryImageElement new
			hMatchParent;
			vFitContent;
			margin: (BlInsets all: 5);
			imageData: anImageData;
			yourself ].

	[
	| images |
	images := (STONJSON fromString:
		           'https://picsum.photos/list' asUrl retrieveContents)
		          collect: [ :aDictionary |
			          ToPicsumPhotosGalleryImageData fromDictionary:
				          aDictionary ].
	images sort: [ :a :b | a id > b id ].
	list data addAll: images ] fork.

	list whenChildAttachedDo: [ :event | event element attached ].
	list whenChildDetachedDo: [ :event | event element detached ].

	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
		c ignoreByLayout.
		c margin: (BlInsets right: 0).
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	vscrollBar attachTo: list infinite.

	space := BlSpace new
		         extent: 200 @ 600;
		         title: 'picsum.photos Gallery'.

	space root addChild: list.
	space root addChild: vscrollBar.
	space show
]

{ #category : #window }
ToSandBox class >> example_Popup1 [

	| container menu item sub popupWindowHandler |
	container := ToInnerWindow new
		             position: 10 @ 10;
		             size: 400 @ 200;
		             yourself.

	menu := ToElement new
		        id: #'red-button';
		        background: Color red;
		        size: 100 @ 40;
		        position: 50 @ 50.
	sub := ToElement new
		       background: Color white;
		       border: Color black;
		       size: 20 @ 20;
		       position: 10 @ 10.
	menu addChild: sub.
	popupWindowHandler := ToPopupWindowHandler new.
	popupWindowHandler builder: [
		| popup |
		popup := ToAnchoredWindow new border: Color black.
		item := ToElement new size: 50 @ 90.
		item background: Color yellow.
		item addEventHandler: ToSkinnableEventHandler new.
		item when: BlPrimaryClickEvent do: [ self inform: 'Click' ].
		popup root addChild: item.
		popup ].
	popupWindowHandler element: menu.
	container pane addChild: menu.
	container openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectWithPlaceholder [

	| win select |
	win := ToInnerWindow new title: 'Choice box Example'.

	select := ToSelect new.
	select width: 250.
	select withUncheckingStrategy.
	select data addAll: { 'OS-X'. 'Windows' }.
	select placeholder: (ToLabel text: ('Invalid choice' asRopedText foreground: Color red)).

	win root addChild: select.
	win openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectWithPlaceholderWithUncheckingStrategy [

	| win select t |
	win := ToInnerWindow new title: 'Some host'.
	select := ToSelect new hMatchParent.
	select beVertical.
	select withUncheckingStrategy.
	t := 'No selection...' asRopedText , String cr asRopedText
	     , ('Please choose an host from the list' asRopedText
			      foreground: Color lightGray;
			      fontSize: 12).
	select placeholder: (ToLabel new
			 beMultiLine;
			 text: t).
	select dataToTextConverter: [ :assoc | assoc key ].
	select whenSelectedIndexChangedDo: [
		self inform: select selectedData value asString ].
	select data addAll: {
			('Morphic SDL' -> BlMorphicWindowHost).
			('Native SDL' -> BlOSWindowSDL2Host) }.
	win root addChild: select.
	win openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectWithStringData [

	| win select |
	win := ToInnerWindow new title: 'Choice box Example'.

	select := ToSelect new.
	select hMatchParent.

	"select withUncheckingStrategy."
	select data addAll: { 'OS-X'. 'Windows' }.
	select addSeparator.
	select data add: 'Linux'.
	select selectData: 'Windows'.

	win root addChild: select.
	win openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectWithStructuredData [

	| win select |
	win := ToInnerWindow new title: 'Alexandrie host'.

	select := ToSelect new
		             hMatchParent;
		             withStamp: #justified.
	select dataToTextConverter: [ :assoc | assoc key ].
	select data addAll: {
			('Morphic SDL' -> BlMorphicWindowHost).
			('Native SDL' -> BlOSWindowSDL2Host) }.
	select placeholder: (ToLabel text: 'Place holder').
	select selectIndex: 2.
	select whenSelectedIndexChangedDo: [
		self inform: select selectedData asString ].
	win root addChild: select.
	win openInSpace
]

{ #category : #menu }
ToSandBox class >> example_SimpleOpenSaveSaveAsClose [

	| menu container |
	container := ToInnerWindow new
		             position: 10 @ 10;
		             size: 400 @ 200;
		             yourself.
	menu := ToMenu new background: Color random.
	menu label: (ToLabel text: 'Menu').
	menu addItem: (ToMenuItem new
			 icon: ((ToImage inner: (self iconNamed: #solidMenu)));
			 label: (ToLabel text: 'Open')).
	menu items last labelOffset: 25.
	menu addItem: (ToMenuItem new
			 icon: ((ToImage inner: (self iconNamed: #solidMenu)));
			 label: (ToLabel text: 'Save');
			 background: Color random).
	menu items last labelOffset: 25.
	menu addItem: (ToMenuItem new
			 icon: ((ToImage inner: (self iconNamed: #solidMenu)));
			 label: (ToLabel text: 'Save as ...');
			 background: Color random).
	menu items last labelOffset: 25.
	menu addSeparator.
	menu addItem: (ToMenuItem new
			 label: (ToLabel text: 'Close');
			 background: Color random).
	menu items last labelOffset: 25.
	container pane addChild: menu.
	
	container openInSpace
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
		| lab im node |
		im := ToImage new innerImage: (Smalltalk ui icons iconNamed: k).
		lab := ToLabel new text: k asString.
		node := ToButton new icon: im; label: lab; yourself.
		node width: 600.
		node justified: true.
		column addChild: node ].

	root := column asScrollableElement.
	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
		c ignoreByLayout.
		c margin: (BlInsets right: 2).
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	vscrollBar attachTo: root.
	container := BlElement new
		             constraintsDo: [ :c |
			             c horizontal matchParent.
			             c vertical matchParent ];
		             yourself.
	container
		addChild: root;
		addChild: vscrollBar.
	container openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_StyleSheetSandbox [

	| b |
	ToStyleSheetTheme cleanUp.
	"b := ToCheckbox new."
	"b := ToRadioButton new."
	b := ToButton new.
	"b := ToToggleButton new."
	"b stampWith: #primary. "
	"b stampWith: #'large-sizing'."
	"b stampWith: #'small-sizing'."

	"b stampWith: #vertical."
	b withStamp: #'icon-first'.
	b withStamp: #'label-first'.
	"b withStamp: #'interspace-1' -> 300."
	b justified: true.
	"b stampWith: #circle."
	"b stampWith: #round."
	"b stampWith: #link. "
	"b stampWith: #danger."
	"b stampWith: #dashed."
	b
		iconImage: ToThemeIcons iconSearchOutlined16x16;
		labelText: 'Close'.
	"b labelFirst: true."
	"b checked: nil."
	"b withIndeterminate: true."
	"b innerElement border: (BlBorder paint: Color black)."

	b openInSpace.
	b width: 200.
	"b size: 100 @ 100."

	b inspect.
	"b matchParent"
]

{ #category : #'button-dep' }
ToSandBox class >> example_StyleSheetSandboxDarkTheme [

	| b |
	ToStyleSheetTheme cleanUp.
	"b := ToCheckbox new."
	"b := ToRadioButton new."
	b := ToButton new.
	"b := ToToggleButton new."
	"b stampWith: #primary. "
	"b stampWith: #'large-sizing'."
	"b stampWith: #'small-sizing'."

	"b stampWith: #vertical."
	b withStamp: #'icon-first'.
	b withStamp: #'label-first'.
	b withStamp: #'interspace-1' -> 300.
	"b justified: true."
	"b stampWith: #circle."
	"b stampWith: #round."
	"b stampWith: #link. "
	"b stampWith: #danger."
	"b stampWith: #dashed."
	b
		iconImage: ToThemeIcons iconSearchOutlined16x16;
		labelText: 'Close'.
	"b labelFirst: true."
	"b checked: nil."
	"b withIndeterminate: true."
	"b innerElement border: (BlBorder paint: Color black)."

	(b openInSpace) toTheme: ToBeeDarkTheme new.
	"b width: 200."
	"b size: 100 @ 100."

	"b inspect.
	b matchParent"
]

{ #category : #'button-dep' }
ToSandBox class >> example_ToButtonSkins [

	| space pane themeSwitcher butBuilder buttonSpecsBuilder enablementSwitcher allButtons sizingGroup smallSizingRadio middleSizingRadio largeSizingRadio shapingGroup circleShapingRadio defaultShapingRadio roundShapingRadio topBar buttonBar directionSwitcher orientationSwitcher |
	space := BlSpace new.
	allButtons := OrderedCollection new.

	space root layout: (BlLinearLayout vertical cellSpacing: 10).
	topBar := ToMenuBar new beHorizontal; hMatchParent; vFitContent.
	topBar layout cellSpacing: 10.

	themeSwitcher := ToSelect new.
	themeSwitcher width: 150.
	themeSwitcher data addAll: {
			ToBeeLightTheme.
			ToBeeDarkTheme }.

	themeSwitcher whenSelectedIndexChangedDo: [
		space toTheme: themeSwitcher selectedData new ].
	themeSwitcher selectData: space toTheme class.
	topBar addChild: themeSwitcher.

	enablementSwitcher := ToToggleButton new.
	enablementSwitcher switchBarOnElement:
		((ToLabel text: 'Enabled')).
	enablementSwitcher switchBarOffElement:
		((ToLabel text: 'Disabled')).
	enablementSwitcher check.
	enablementSwitcher
		when: ToCheckableCheckedEvent
		do: [ :event |
		allButtons do: [ :b | b enabled: event target isChecked ] ].

	topBar addChild: enablementSwitcher.

	buttonBar := ToPane vertical vFitContent.
	 
	sizingGroup := ToCheckableGroup new.
	smallSizingRadio := ToRadioButton new labelText: 'Small'.
	smallSizingRadio userData at: #sizing put: #'small-sizing'.
	middleSizingRadio := ToRadioButton new labelText: 'Middle'.
	middleSizingRadio userData at: #sizing put: #'middle-sizing'.
	largeSizingRadio := ToRadioButton new labelText: 'Large'.
	largeSizingRadio userData at: #sizing put: #'large-sizing'.
	middleSizingRadio checked: true.
	sizingGroup addAll: {
			smallSizingRadio.
			middleSizingRadio.
			largeSizingRadio }.
	sizingGroup when: ToCheckableGroupChangedEvent do: [ :event |
		| choice sizing |
		choice := event checkedButtons anyOne.
		sizing := choice userData at: #sizing.
		allButtons do: [ :but | but sizing: sizing ] ].

	buttonBar addChildren: {
			smallSizingRadio.
			middleSizingRadio.
			largeSizingRadio }.
	topBar addChild: buttonBar.
	
	buttonBar := ToPane vertical vFitContent.

	shapingGroup := ToCheckableGroup new.
	circleShapingRadio := ToRadioButton new labelText: 'Circle'.
	circleShapingRadio userData at: #shaping put: #circle.
	defaultShapingRadio := ToRadioButton new labelText: 'Default shape'.
	defaultShapingRadio userData at: #shaping put: #'default-shaping'.
	roundShapingRadio := ToRadioButton new labelText: 'Round'.
	roundShapingRadio userData at: #shaping put: #'round'.
	defaultShapingRadio checked: true.
	shapingGroup addAll: {
			circleShapingRadio.
			defaultShapingRadio.
			roundShapingRadio }.
	shapingGroup when: ToCheckableGroupChangedEvent do: [ :event |
		| choice shaping |
		choice := event checkedButtons anyOne.
		shaping := choice userData at: #shaping.
		allButtons do: [ :but | but shaping: shaping ] ].

	buttonBar addChildren: {
			circleShapingRadio.
			defaultShapingRadio.
			roundShapingRadio }.
	
	topBar addChild: buttonBar.
	
	directionSwitcher := ToToggleButton new labelText: 'Icon first'; beLabelFirst; yourself.
	directionSwitcher check.
	directionSwitcher
		when: ToCheckableCheckedEvent
		do: [ :event | allButtons do: [ :b | b iconFirst: event target isChecked ] ].
	topBar addChild: directionSwitcher.
	
	orientationSwitcher := ToToggleButton new labelText: 'Horizontal'; beLabelFirst; yourself.
	orientationSwitcher check.
	orientationSwitcher
		when: ToCheckableCheckedEvent
		do: [ :event | allButtons do: [ :b | b horizontal: event target isChecked ] ].
	topBar addChild: orientationSwitcher.
	
	topBar childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ].

	circleShapingRadio 
		when: ToCheckableCheckedEvent 
		do: [ :event | 
			event current 
				ifTrue: [ directionSwitcher enabled: false. orientationSwitcher  enabled: false] 
				ifFalse: [ directionSwitcher enabled: true. orientationSwitcher  enabled: true ] ].	

	space root addChild: topBar.

	butBuilder := [
	              ToImage new innerImage:
		              ToThemeIcons iconSearchOutlined16x16 ].
	buttonSpecsBuilder := [
	                      {
		                      {
			                      'Primary'.
			                      #primary }.
		                      {
			                      'Default'.
			                      #default }.
		                      {
			                      'Dashed'.
			                      #dashed }.
		                      {
			                      'Text'.
			                      #text }.
		                      {
			                      'Link'.
			                      #link } } ].

	" Line 1 "
	pane := ToPane horizontal.
	pane layout: (BlLinearLayout horizontal cellSpacing: 10).

	buttonSpecsBuilder value do: [ :arr |
		| but |
		but := ToButton new.
		allButtons add: but.
		arr second ifNotNil: [ :s | but withStamp: s ].
		but labelText: arr first.
		pane addChild: but ].

	space root addChild: pane.

	" line 2 "
	pane := ToPane horizontal.
	pane layout: (BlLinearLayout horizontal cellSpacing: 10).

	buttonSpecsBuilder value do: [ :arr |
		| but |
		but := ToButton new.
		allButtons add: but.
		arr second ifNotNil: [ :s | but withStamp: s ].
		but labelText: arr first.
		but icon: butBuilder value.
		pane addChild: but ].

	space root addChild: pane.

	" line 3 "
	pane := ToPane horizontal.
	pane layout: (BlLinearLayout horizontal cellSpacing: 10).

	buttonSpecsBuilder value do: [ :arr |
		| but |
		but := ToButton new.
		allButtons add: but.
		arr second ifNotNil: [ :s | but withStamp: s ].
		but icon: butBuilder value.
		pane addChild: but ].

	space root addChild: pane.

	" line 4 "
	pane := ToPane horizontal.
	pane layout: (BlLinearLayout horizontal cellSpacing: 10).

	buttonSpecsBuilder value do: [ :arr |
		| but |
		but := ToButton new.
		allButtons add: but.
		arr second ifNotNil: [ :s | but withStamp: s ].
		but labelText: arr first.
		pane addChild: but ].

	space root addChild: pane.

	" line 5 "
	pane := ToPane horizontal.
	pane layout: (BlLinearLayout horizontal cellSpacing: 10).

	buttonSpecsBuilder value do: [ :arr |
		| but |
		but := ToButton new.
		allButtons add: but.
		arr second ifNotNil: [ :s | but withStamp: s ].
		but labelText: arr first.
		but icon: butBuilder value.
		pane addChild: but ].

	space root addChild: pane.

	" line 6 "
	pane := ToPane horizontal.
	pane layout: (BlLinearLayout horizontal cellSpacing: 10).

	buttonSpecsBuilder value do: [ :arr |
		| but |
		but := ToButton new.
		allButtons add: but.
		arr second ifNotNil: [ :s | but withStamp: s ].
		but icon: butBuilder value.
		pane addChild: but ].

	space root addChild: pane.

	space show.

	^ space
]

{ #category : #'button-dep' }
ToSandBox class >> example_ToButtonWithDefaultSkin0 [


	| space button1 pane |
	
	space := BlSpace new.
	pane := ToPane horizontal.
	pane layout cellSpacing: 10.
	space root layout: (BlLinearLayout vertical cellSpacing: 10).

	button1 := ToButton new.
	"button1 addStyleClass: #primary."
	"button1 addStyleClass: #danger."
	button1 label: (ToLabel text: 'Primary button').
	button1 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).

	space root addChild: pane.
	space root addChild: button1.

	space show.
]

{ #category : #label }
ToSandBox class >> example_ToLabelWithHeadingSkin [

	|  typeArr headingArr listElement themeSwitcher space |

	space := BlSpace new.
	space root layout: (BlLinearLayout vertical cellSpacing: 10).
	themeSwitcher := ToToggleButton new
		      labelText: 'Theme';
		      beLabelFirst.
	themeSwitcher switchBarOnElement: ((ToLabel text: ('Dark' asRopedText foreground: Color white)) ).
	themeSwitcher switchBarOffElement: ((ToLabel text: ('Light' asRopedText foreground: Color black)) ).
	themeSwitcher 
		when: ToCheckableCheckedEvent 
		do: [ :event | space toTheme: ( event current ifTrue: [ToBeeDarkTheme new] ifFalse: [ ToBeeLightTheme new]) ].
	
	space root addChild: themeSwitcher.

	listElement := ToListElement new nodeFactory: [ :lab |
		     lab hMatchParent; yourself].
	listElement background: Color transparent.
	typeArr := {
		           ('Default' -> ToLabelDefaultType).
		           ('Danger' -> ToLabelDangerType).
		           ('Disabled' -> ToLabelDisabledType).
		           ('Secondary' -> ToLabelSecondaryType).
		           ('Success' -> ToLabelSuccessType).
		           ('Warning' -> ToLabelWarningType) }.
	headingArr := {
		              ('H0' -> ToTextH0).
		              ('H1' -> ToTextH1).
		              ('H2' -> ToTextH2).
		              ('H3' -> ToTextH3).
		              ('H4' -> ToTextH4).
		              ('H5' -> ToTextH5) }.

	typeArr do: [ :typeAssoc |
		headingArr do: [ :headingAssoc |
			| lab skin |
			skin := ToLabelSkin new
				        type: typeAssoc value new;
				        heading: headingAssoc value new;
				        yourself.
			lab := ToLabel new withSkin: skin.
			lab text: typeAssoc key , ' ' , headingAssoc key.
			listElement data add: lab ] ].
	space root addChild: listElement.
	space show
]

{ #category : #button }
ToSandBox class >> example_buttonWithIcon [

	| but  |
	but := ToButton new.
	but icon: (ToImage new innerImage: (self iconNamed: #solidMenu)).
	but openInSpace.
	^ but
]

{ #category : #button }
ToSandBox class >> example_buttonWithIconAndLabel [

	| but  |
	but := self example_buttonWithIcon.
	but label: (ToLabel text: 'Button with label').
	^ but
]

{ #category : #'context menu + menubar' }
ToSandBox class >> example_contextMenu [

	| container win |
	container := ToElement new matchParent.
	container contextMenuBuilder: [ :e |
		win := ToContextMenu new.
		win addItem: (ToMenuItem new
				 labelText: 'Open';
				 whenClickedDo: [ self inform: 'Open' ];
				 yourself).
		win ].

	container openInSpace
]

{ #category : #pane }
ToSandBox class >> example_horizontalPaneWithDivider [

	| pane e1 e2 e3 btn |
	pane := ToPane horizontal.
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
	pane openInSpace
]

{ #category : #'menu dep' }
ToSandBox class >> example_menu0 [

	| menu sub subsub space themeSwitcher |
	
	space := BlSpace new.
	space root layout: (BlLinearLayout vertical cellSpacing: 10).
	themeSwitcher := ToToggleButton new
		      labelText: 'Theme';
		      beLabelFirst.
	themeSwitcher switchBarOnElement: ((ToLabel text: ('Dark' asRopedText foreground: Color white)) ).
	themeSwitcher switchBarOffElement: ((ToLabel text: ('Light' asRopedText foreground: Color black)) ).
	themeSwitcher 
		when: ToCheckableCheckedEvent 
		do: [ :event | space toTheme: ( event current ifTrue: [ToBeeDarkTheme new] ifFalse: [ ToBeeLightTheme new]) ].
	
	themeSwitcher checked: true.
	space root addChild: themeSwitcher.
	
	menu := ToMenu new.
	menu label: (ToLabel new text: 'File').
	menu icon: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #solidMenu)).
	menu addItem: (ToMenuItem new 
		label: (ToLabel new text: 'Openfile'; id: #open; yourself); 
		icon: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #config))).
	menu addItem: (ToMenuItem new 
		label: (ToLabel new text: 'Openfile'; id: #open2; yourself)"; 
		icon: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #config))").
	"menu inspect."
	space root addChild: menu.
	space show
]

{ #category : #'menu dep' }
ToSandBox class >> example_menu6 [

	| menu grp right center left textField sub th lbl |
	menu := ToMenu new.

	menu labelText: 'File'.
	menu addItem: (ToMenuItem new
			 labelText: 'Open file';
			 whenClickedDo: [ self inform: 'Open file' ];
			 icon: (ToImage inner: (Smalltalk ui icons iconNamed: #config))).

	menu addItem: (ToMenuItem new
			 labelText: 'Export';
			 whenClickedDo: [ self inform: 'Export' ]).
	menu addItem: (ToMenuItem new
			 labelText: 'Export';
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
	center checked: true.
	grp addAll: {
			right.
			center.
			left }.

	grp when: ToCheckableGroupChangedEvent do: [ :event |
		('checked: ' , event checkedButtons asString , ' unchecked: '
		 , event uncheckedButtons asString) traceCr ].

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
		         labelText: 'Right';
		         id: #right.
	center := ToRadioMenuItem new
		          beLabelFirst;
		          labelText: 'Center';
		          id: #center.
	left := ToRadioMenuItem new
		        beLabelFirst;
		        labelText: 'Left';
		        id: #left.
	center checked: true.
	grp addAll: {
			right.
			center.
			left }.
	grp when: ToCheckableGroupChangedEvent do: [ :event |
		('checked: ' , event checkedButtons asString , ' unchecked: '
		 , event uncheckedButtons asString) traceCr ].

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
		         justified: true;
		         labelText: 'Right';
		         id: #right.
	center := ToRadioMenuItem new
		          beLabelFirst;
		          justified: true;
		          labelText: 'Center';
		          id: #center.
	left := ToRadioMenuItem new
		        beLabelFirst;
		        justified: true;
		        labelText: 'Left';
		        id: #left.
	center checked: true.
	grp addAll: {
			right.
			center.
			left }.

	grp when: ToCheckableGroupChangedEvent do: [ :event |
		('checked: ' , event checkedButtons asString , ' unchecked: '
		 , event uncheckedButtons asString) traceCr ].

	center checked: true.

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
		             placeholderText: 'Your name'.
	menu addItem: (ToCustomMenuItem new innerElement: textField).

	menu addSeparator.
	th := ToToggleButton new
		      labelText: 'Cheesecake';
		      beLabelFirst;
		      hMatchParent.
	
	menu addItem: (ToCustomMenuItem new innerElement: th).
	th := ToToggleButton new
		      labelText: 'Column';
		      beLabelFirst.
	
	menu addItem: (ToCustomMenuItem new innerElement: th).
	th := ToToggleButton new
		      labelText: 'Cheesecake justified';
		      beLabelFirst;
				justified: true;
		      hMatchParent.
	
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
	sub addItem: (ToMenuItem new labelText: 'Locally').
	menu addItem: sub.

	menu position: 10 @ 10.
	menu openInInnerWindow
]

{ #category : #'context menu + menubar' }
ToSandBox class >> example_menuBar1 [

	| win bar fileMenu |
	win := ToInnerWindow new title: 'Menu bar example'.
	win width: 600.

	bar := ToMenuBar new
		       hMatchParent;
		       vFitContent.
	bar addMenu: (fileMenu := ToMenu new
			 labelText: 'File').
	fileMenu addItem: (ToMenuItem new label: (ToLabel new text: 'Open')).
	fileMenu padding: (BlInsets all: 10).
	bar addFiller.
	bar addMenu: (ToMenu new
			 labelText: 'Help';
			 tooltipString: 'help stuffs').
	bar when: BlMouseDownEvent do: [ :event | event target traceCr ].
	bar border: (BlBorder paint: Color red).
	win pane addChild: bar.
	win openInSpace
]

{ #category : #'context menu + menubar' }
ToSandBox class >> example_menuBar2 [

	| menu frame bar |

	bar := ToMenuBar new
		       hMatchParent;
		       vFitContent.
	frame := ToInnerWindow new.
	
	3 timesRepeat: [ 
		menu := ToMenu new.
		menu layout cellSpacing: 5.
		menu label: (ToLabel text: 'Levels').
		menu icon: (ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).

		4 to: 12 by: 2 do: [ :index |
			| subMenu |
			subMenu := ToMenu new label:
			           (ToLabel new text: (String streamContents: [ :out |
					             out
						             print: index;
						             nextPut: $x;
						             print: index ])).
			1 to: 5 do: [ :i |
				| stream selector |
				stream := String streamContents: [ :out |
				          out
					          nextPutAll: 'Level';
					          space;
					          print: i ].
				selector := String streamContents: [ :out |
				            out
					            nextPutAll: 'level';
					            print: index;
					            nextPutAll: 'Grid';
					            print: i ].
				subMenu addItem: ((ToMenuItem new labelText: stream) 
					when: BlPrimaryMouseUpEvent do: [ :event | self inform: selector asSymbol ]) ].
			"subMenu defaultColumnWidth: 0."
			menu addItem: subMenu ].

		bar addMenu: menu	].
	
	frame pane addChild: bar. 
	frame openInSpace
]

{ #category : #window }
ToSandBox class >> example_overlayWindow1 [

	| e windowHandler |
	e := ToElement new
		     size: 100 @ 100;
		     position: 50 @ 50;
		     background: Color yellow;
		     border: (BlBorder paint: Color red).
	windowHandler := ToOverlayWindowHandler new.
	windowHandler element: e.
	windowHandler builder: [
		| w |
		w := ToAnchoredWindow new.
		w background: (Color gray alpha: 0.2).
		w border: (BlBorder paint: Color black width: 2).
		w ].
	e openInInnerWindow.
	(windowHandler newWindowEvent: nil) popup
]

{ #category : #window }
ToSandBox class >> example_rootFrame1 [

	ToInnerWindow new
		title: 'Internal Frame example';
		openInSpace
]

{ #category : #'context menu + menubar' }
ToSandBox class >> example_rootFrameWithContextMenu [

	| win menu sub subsub bar textField |
	win := ToInnerWindow new title: 'Context menu Example'.
	win width: 600.
	menu := ToContextMenu new.
	menu addItem: (ToMenuItem new
			 labelText: 'Open file';
			 icon: (ToImage inner: (Smalltalk ui icons iconNamed: #config))).
	menu addItem: (ToMenuItem new labelText: 'Export').
	menu addSeparator.

	3 timesRepeat: [ 
		sub := ToMenu new labelText: 'Save All'.
		sub addItem: (ToMenuItem new labelText: 'Locally').

		subsub := ToMenu new
		          	labelText: 'Externally';
		          	icon: (ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).
		subsub addItem: (ToMenuItem new labelText: 'Here').

		sub addItem: subsub.

		menu addItem: sub ].

	win pane contextMenuBuilder: [ :e | menu ].
	
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
		             placeholderText: 'search...'.
	bar addChild: (ToLabel new text: 'Token :').
	bar addChild: textField.
	bar addMenu: (ToMenu new
			 labelText: 'Help';
			 tooltipString: 'help stuffs').

	bar position: 0 @ 0.
	bar border: (BlBorder paint: Color black).
	win pane addChild: bar.
	win openInSpace
]

{ #category : #'context menu + menubar' }
ToSandBox class >> example_rootFrameWithContextMenu_menubarVertical [

	| win menu sub subsub bar |
	win := ToInnerWindow new title: 'Context menu Example'.
	menu := ToContextMenu new.
	menu addItem: (ToMenuItem new
			 labelText: 'Open file';
			 icon: (ToImage inner: (Smalltalk ui icons iconNamed: #config))).
	menu addItem: (ToMenuItem new labelText: 'Export').
	menu addSeparator.

	sub := ToMenu new labelText: 'Save All'.
	sub addItem: (ToMenuItem new labelText: 'Locally').

	subsub := ToMenu new
		          labelText: 'Externally';
		          icon:
			          (ToImage inner:
					           (Smalltalk ui icons iconNamed: #solidMenu)).
	subsub addItem: (ToMenuItem new labelText: 'Here').

	sub addItem: subsub.

	menu addItem: sub.

	win pane contextMenuBuilder: [ menu ].

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

	bar position: 0 @ 0.
	bar beVertical.
	bar hFitContent.
	bar border: (BlBorder paint: Color black).
	win pane addChild: bar.
	win openInSpace
]

{ #category : #image }
ToSandBox class >> example_scaledImage [

	| im scale |
	scale := 0.5.
	im := ToImage new innerImage: (Smalltalk ui icons iconNamed: #pharoBig).
	im when: BlClickEvent do: [ :event |
		im transformDo: [ :t |
			t topLeftOrigin scaleBy: scale.
			scale := scale < 1.0
				         ifTrue: [ 1.0 ]
				         ifFalse: [ 0.5 ] ] ].
	im border: (BlBorder paint: Color black width: 2).
	im openInSpace
]

{ #category : #space }
ToSandBox class >> example_spaceRootSkin [

	| space themeSwitcher |
	space := BlSpace new.
	space inspect.
	themeSwitcher := ToToggleButton new
		      labelText: 'Theme';
		      beLabelFirst.
	themeSwitcher switchBarOnElement: ((ToLabel text: ('Dark' asRopedText foreground: Color white)) ).
	themeSwitcher switchBarOffElement: ((ToLabel text: ('Light' asRopedText foreground: Color black)) ).
	themeSwitcher when: ToCheckableCheckedEvent do: [ :event | space toTheme: ( event current ifTrue: [ToBeeDarkTheme new] ifFalse: [ ToBeeLightTheme new]) ].
	space root addChild: themeSwitcher.
	space show
]

{ #category : #'text field' }
ToSandBox class >> example_textField0 [

	| t |
	t := ToTextField new text: 'AAAA'.
	t openInSpace
]

{ #category : #'text field' }
ToSandBox class >> example_textFieldOnlyDigits [

	| t |
	t := ToTextField new inputFilter: AlbTextEditorDigitInputFilter new.
	t openInSpace
]

{ #category : #'text field' }
ToSandBox class >> example_textFieldWithLineWrapping [

	| t |
	t := ToTextField new
		     withLineWrapping;
		     withSaveCapability.
	t openInSpace
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
ToSandBox class >> example_textFieldWithPlaceholder [

	| t text |
	t := ToTextField new withSaveCapability.
	text := ''.
	t placeholderText: 'Enter to accept'.
	t whenSaveRequestedDo: [ :saveRequested |
		saveRequested client saveResult: true.
		text := saveRequested client text copy ].
	t whenCancelRequestedDo: [ :cancelRequested |
		cancelRequested client text: text copy ].
	t showPlaceholder.
	t openInSpace
]

{ #category : #'text field' }
ToSandBox class >> example_textFieldWithPlaceholder2 [

	| t text |
	t := ToTextField new withSaveCapability.
	text := ''.
	t placeholder: (ToLabel new
			 text: 'Enter text';
			 yourself).
	t whenSaveRequestedDo: [ :saveRequested |
		saveRequested client saveResult: true.
		text := saveRequested client text copy ].
	t whenCancelRequestedDo: [ :cancelRequested |
		cancelRequested client text: text copy ].
	t showPlaceholder.
	t openInSpace
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
	t := ToTextField new
		     withoutLineWrapping;
		     withSaveCapability.
	t openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_toAlbumAsButton [

	| but |
	but := ToAlbum new
		       text: 'Hello world';
		       preventChildrenMouseEvents.
	but addEventHandler: (ToSkinnableEventHandler new target: but).
	but
		when: BlPrimaryClickEvent
		do: [ self inform: 'Click' ].
	but background: Color blue.
	but size: 300 @ 100.
	but openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_toBasicButton0 [

	| but |
	but := ToGeneralButton new.
	but whenClickedDo: [ self inform: 'clicked' ].
	but openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_toBasicButton1 [

	| but |
	but := ToGeneralButton new.
	but addEventHandler: (ToSkinnableEventHandler new target: but).
	but addChild: (BlElement new
			 size: 30 @ 30;
			 yourself).
	but fitContent.
	but whenClickedDo: [ self inform: 'clicked' ].
	but openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_toBasicButton2 [

	| but lab |
	lab := ToLabel new text: ('Button' asRopedText
			        fontSize: 40;
			        yourself).
	but := ToGeneralButton new.
	but addEventHandler: (ToSkinnableEventHandler new target: but).
	but matchParent.
	but addChild: lab.
	but layout alignCenter.
	but whenClickedDo: [ self inform: 'clicked' ].
	but openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_toBasicButton3 [

	| but |
	but := ToButton new label: (ToLabel new text: ('Button' asRopedText
				         fontSize: 40;
				         yourself)).
	but matchParent.
	but layout alignCenter.
	but whenClickedDo: [ self inform: 'clicked' ].
	but openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_toBasicButton4 [

	| but lab ico pane |
	pane := ToPane new.
	pane fitContent.
	pane layout alignCenter.
	lab := ToLabel new text: 'Make something cool happen'.
	ico := ToImage inner: (self iconNamed: #remove).
	pane addChildren: {
			ico.
			lab }.
	but := ToGeneralButton new.
	but addEventHandler: (ToSkinnableEventHandler new target: but).
	but matchParent.
	but addChild: pane.
	but layout alignCenter.
	but whenClickedDo: [ self inform: 'clicked' ].
	but openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButton0 [

	| but |
	but := ToButton new.
	but openInSpace.
	but inspect.
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButtonOrientationChanger [

	| but space iconImage count |
	but := ToButton new.
	but label: (ToLabel text:'Button' asRopedText bold).
	iconImage := BlElement new
		             size: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but iconImage: iconImage.
	count := 0.
	but whenClickedDo: [ :ann | count := count + 1. count traceCr. ann currentTarget orientation: but orientation inverted ].
	space := BlSpace new.
	space root addChild: but.
	space show 
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButtonOrientationChanger3 [

	| but space iconImage count |
	but := ToButton new.
	but label: (ToLabel text:'Button' asRopedText bold).
	iconImage := BlElement new
		             size: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but iconImage: iconImage.
	count := 0.
	but whenClickedDo: [ :ann | count := count + 1. count traceCr. ann currentTarget orientation: but orientation inverted ].
	space := BlSpace new.
	space root addChild: but.
	space show 
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButtonWithIconAndText [

	| but space  icon |
	but := ToButton new.

	but label: (ToLabel text: 'Button').
	icon := ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16).
	but icon: icon.
	"but effect: (BlGaussianShadowEffect
					color: Color green
					width: 4.5
					offset: 0 @ 0)."
	but effect: (BlBlurAboveEffect new radius: 20).
	but when: BlPrimaryClickEvent do: [ :event | event currentTarget traceCr ].

	space := BlSpace new.
	space root addChild: but.
	space show 
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButtonWithIconAndTextAndExtra [

	| but space  icon |
	but := ToButton new.

	but label: (ToLabel text: 'Button').
	icon := ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16).
	but icon: icon.
	but effect: (BlBlurAboveEffect new radius: 20).
	but when: BlPrimaryClickEvent do: [ :event | event currentTarget traceCr ].
	but third: ((ToLabel text: 'extra') margin: (BlInsets left: 5)).

	space := BlSpace new.
	space root addChild: but.
	space show 
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButtonWithIconOnly [

	| but space container |
	container := BlElement new size: 200@200; border: (BlBorder paint: Color gray); background: (Color gray alpha: 0.1).
	but := ToButton new.
	"but addLook: ToButtonLinkLook new."
	"but addLook: ToButtonDashedLook new."
	"but addLook: ToButtonFixedSizeLook new."
	"but addLook: ToButtonPrimaryLook new."
	"but addLook: ToButtonDangerLook new."
	"but addLook: ToButtonLinkLook new."

	but icon: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #solidMenu)).
	"but icon addLook: ToImagePrimaryLook new."
	"but icon addLook: ToImageDangerLook new."
	container addChild: but.
	space := BlSpace new.
	space root addChild: container.
	space show 
]

{ #category : #tooltip }
ToSandBox class >> example_toButtonWithRedElementTooltip [

	| but  |
	but := ToButton new.
	but labelText: 'Button with tooltip'.
	but tooltipContent: (BlElement new background: Color red; size: 70@100; yourself). 
	but whenClickedDo: [ :ann | self inform: 'Button clicked' ].
	but openInInnerWindow 
 
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButtonWithTextAndIconHorizontal [

	| but space count |
	but := ToButton new.
	but label: (ToLabel text: 'Button').
	but iconImage: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself).
	but beRightToLeft.
	but layout cellSpacing: 10.
	count := 0.
	but when: BlClickEvent do: [ :event | count := count + 1. count traceCr ].
	but whenClickedDo: [ :ann | but icon background: Color random ].
	space := BlSpace new.
	space root addChild: but.
	but inspect.
	space show 
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButtonWithTextAndIconHorizontal2 [

	| but count |
	but := ToButton new.
	but label: (ToLabel text: 'Button').
	but iconImage: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself).
	but beRightToLeft.
	but layout cellSpacing: 10.
	count := 0.
	but when: BlClickEvent do: [ :event | count := count + 1. count traceCr ].
	but openInInnerWindow 
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButtonWithTextAndIconHorizontal3 [

	| but count pane |
	but := ToButton new "cellSpacing: 2; padding: (BlInsets all: 4)".
	but label: (ToLabel text: 'Button').
	but iconImage: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself).
	but beRightToLeft.
	but layout cellSpacing: 10.
	count := 0.
	but when: BlClickEvent do: [ :event | count := count + 1. count traceCr ].
	"but whenClickedDo: [ :ann | but icon background: Color random ]."
	pane := ToPane new size: 400@400.
	pane border: (BlBorder paint: Color red).
	pane addChild: but.
	pane openInSpace.
	but id: 'BUT'
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButtonWithTextAndIconVertical [

	| but space |
	but := ToButton new padding: (BlInsets all: 4); beVertical.
	but label: (ToLabel text: 'Button').
	but iconImage: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself).
	but layout cellSpacing: 10.
	but whenClickedDo: [ :ann | but icon background: Color random ].
	space := BlSpace new.
	space root addChild: but.
	space show 
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButtonWithTextOnly [

	| but space |
	but := ToButton new.
	but label: (ToLabel text: 'Button').
	but padding: (BlInsets all: 4).
	but whenClickedDo: [ self inform: 'clicked' ].

	space := BlSpace new.
	space root addChild: but.
	space show 
]

{ #category : #tooltip }
ToSandBox class >> example_toButtonWithTooltipString [

	| but  |
	but := ToButton new.
	but labelText: 'Button with tooltip string'.
	but tooltipString: ('This is a button', String cr, 'so, click on me...'). 
	but whenClickedDo: [ :ann | self inform: 'Button clicked' ].
	but openInInnerWindow 
 
]

{ #category : #tooltip }
ToSandBox class >> example_toButtonWithTooltipText [

	| but  |
	but := ToButton new.
	but labelText: 'Button with tooltip text'.
	but tooltipText: ('This is a button', String cr, 'so, click on me...') asRopedText. 
	but whenClickedDo: [ :ann | self inform: 'Button clicked' ].
	but openInInnerWindow 
 
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckbox1 [

	| chb |
	ToStyleSheetTheme cleanUp.
	chb := ToCheckbox new
				interspace: 10;
		       label: (ToLabel text: '1');
		       id: 1 asString.
	"chb beRightToLeft."
	chb updateSkin.
	chb checked: true.
	chb inspect.
	chb openInInnerWindow
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckbox2 [

	| chb container |
	chb := ToCheckbox new
		       labelText: '1';
		       id: 1 asString;
				 beLabelFirst.
	chb withStamp: #button.
	chb withStamp: #danger.
	""
	container := BlElement new.
	container constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChild: chb.
	container openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxModelWithLabel3 [

	| but |
	ToStyleSheetTheme cleanUp.
	but := ToCheckbox new labelText: 'Check me'.
	but checked: true.
	but openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxModelWithLabel3_bis [

	| but |
	ToStyleSheetTheme cleanUp.
	but := ToCheckbox new labelText: 'Check me'.
	but withIndeterminate: true.
	but checked: nil.
	but openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithGroup2 [

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

	group buttons second checked: true.
	container := ToElement new.
	container matchParent.
	container layout: BlLinearLayout horizontal.
	container addChildren: group buttons.
	group when: ToCheckableGroupChangedEvent do: [ :event |
		('checked: ' , event checkedButtons asString , ' unchecked: '
		 , event uncheckedButtons asString) traceCr ].
	container openInInnerWindow 
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithGroupAndNoneStrategy [

	| group container buttons |
	group := ToCheckableGroup new.
	group withoutCheckingStrategy.
	buttons := OrderedCollection new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new
			       beLabelFirst;
			       labelText: idx asString;
			       id: idx asString.
		buttons add: chb ].
	buttons second checked: true.
	group addAll: buttons.
	group when: ToCheckableGroupChangedEvent do: [ :event |
		('checked: ' , event checkedButtons asString , ' unchecked: '
		 , event uncheckedButtons asString) traceCr ].

	container := BlElement new.
	container constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChildren: group buttons.
	container openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithGroupAndStrictStrategy [

	| group container buttons |
	group := ToCheckableGroup new.
	buttons := OrderedCollection new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new
			       beLabelFirst;
			       labelText: idx asString;
			       id: idx asString.
		buttons add: chb ].
	buttons second checked: true.
	group addAll: buttons.
	group when: ToCheckableGroupChangedEvent do: [ :event |
		('checked: ' , event checkedButtons asString , ' unchecked: '
		 , event uncheckedButtons asString) traceCr ].

	container := ToElement new.
	container constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChildren: group buttons.
	container openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithGroupAndUnckekingStrategy [

	| group container buttons |
	group := ToCheckableGroup new.
	group withUncheckingStrategy.
	buttons := OrderedCollection new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new
			       beLabelFirst;
			       labelText: idx asString;
			       id: idx asString.
		buttons add: chb ].
	buttons second checked: true.
	group addAll: buttons.
	group when: ToCheckableGroupChangedEvent do: [ :event |
		('checked: ' , event checkedButtons asString , ' unchecked: '
		 , event uncheckedButtons asString) traceCr ].

	container := BlElement new.
	container constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChildren: group buttons.
	container openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithGroupJustified [

	| group container buttons |
	group := ToCheckableGroup new.
	buttons := OrderedCollection new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new
			       justified: true;
			       hMatchParent;
			       beLabelFirst;
			       labelText: idx asString;
			       id: idx asString.
		buttons add: chb ].
	buttons second checked: true.
	group addAll: buttons.
	group when: ToCheckableGroupChangedEvent do: [ :event |
		('checked: ' , event checkedButtons asString , ' unchecked: '
		 , event uncheckedButtons asString) traceCr ].

	container := ToElement new.
	container background: Color veryLightGray.
	container matchParent.

	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChildren: group buttons.
	container openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithIndeterminate1 [

	| chb |
	chb := ToCheckbox new
		       interspace: 50;
		       label: (ToLabel text: '1');
		       id: 1 asString.
	chb withIndeterminate: true.	
	chb openInInnerWindow
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithLabel [

	| but |
	but := ToCheckbox new labelText: 'Check me'.
	but when: ToCheckableCheckedEvent do: [ :event | self inform: 'checked ', event current asString ].
	but openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toCheckboxWithLabel2 [

	| but |
	but := ToCheckbox new
		       labelText: 'Check me';
		       beLabelFirst;
		       checked: true.
	but when: ToCheckableCheckedEvent do: [ :event | self inform: 'checked ', event current asString ].

	but openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImage0 [

	| im |
	im := ToImage new.
	im inspect.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImage1 [

	| im |
	im := ToImage new innerImage: (BlElement new
			       size: 16 @ 16;
			       background: (Color green alpha: 0.5);
			       geometry: BlCircleGeometry new).
	im inspect.
	im openInSpace
]

{ #category : #label }
ToSandBox class >> example_toLabel0 [

	| lab |
	lab := ToLabel new.
	lab inspect.
	lab border: (BlBorder paint: Color black).
	lab openInSpace
]

{ #category : #label }
ToSandBox class >> example_toLabel1 [

	| lab |
	lab := ToLabel text: 'Hello world'.
	lab openInSpace
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
	lab := ToLabel new text: ('This is a bold label' asRopedText
			        fontSize: 20;
			        bold;
			        foreground: Color gray;
			        yourself).
	lab background: Color lightBlue.
	lab hMatchParent.
	lab isEditable: true.
	lab layout alignCenter.
	lab border: (BlBorder paint: Color yellow width: 1).
	lab openInSpace
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
	container openInSpace
]

{ #category : #label }
ToSandBox class >> example_toLabel_Multiline1 [

	| lab |
	lab := ToLabel new text: 'This is a Text' , String cr , 'secondLine'.
	lab beMultiLine.
	lab openInSpace
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
	space := container openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toRadioButton0 [

	| but |
	ToStyleSheetTheme cleanUp.
	but := ToRadioButton new.
	but checked: true.
	but labelText: 'Radio'.
	but inspect.
	but openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_toRadioButtonWithIndeterminate [

	| but |
	but := ToRadioButton new withIndeterminate: true.
	but openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_toWidgetAsButton0 [

	| but |
	but := ToElement new.
	but addEventHandler: (ToSkinnableEventHandler new target: but)..
	but
		when: BlPrimaryClickEvent
		do: [ self inform: 'Click' ].
	but background: Color blue.
	but size: 50 @ 50.
	but openInSpace
]

{ #category : #'toggle button' }
ToSandBox class >> example_toggle [

	| th tv win |
	th := ToToggleButton new
		      labelText: 'Cheesecake';
		      beLabelFirst;
				justified: true;
		      hMatchParent.
	th innerElement hMatchParent.
	th checked: true.

	tv := ToToggleButton new
		      beVertical;
		      labelText: 'Cheesecake';
		      beLabelFirst;
				justified: true;
		      hMatchParent.
	tv innerElement hMatchParent.
	
	win := ToInnerWindow new
		       position: 10 @ 10;
		       size: 400 @ 200;
		       yourself.
	win root layout: BlLinearLayout vertical.
	win root addChildren: {
			th.
			tv }.

	win openInSpace
]

{ #category : #'toggle button' }
ToSandBox class >> example_toggle3 [

	| th sp |
	th := ToToggleButton new
		      labelText: 'Cheesecake';
		      beLabelFirst;
				justified: true;
				hMatchParent.
	th switchButtonOnElement: (ToImage inner: (Smalltalk ui icons iconNamed: #glamorousAccept)).
	th switchButtonOffElement: (ToImage inner: (Smalltalk ui icons iconNamed: #glamorousClose)).

	th when: ToCheckableCheckedEvent do: [ :event | event current traceCr ].
	th checked: true.
	sp := th openInSpace.
	sp root background: Color veryLightGray
]

{ #category : #pane }
ToSandBox class >> example_verticalPaneWithDivider [

	| pane e1 e2 e3 btn |
	pane := ToPane vertical.
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

{ #category : #menu }
ToSandBox class >> example_withCheckBox [

	| menu sub subsub grp right center left |
	menu := ToMenu new.
	menu labelText: 'File'.
	menu addItem: (ToMenuItem new labelText: 'Open file').

	menu addItem: (ToMenuItem new labelText: 'Export').
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
	grp when: ToCheckableGroupChangedEvent do: [ :event |
		('checked: ' , event checkedButtons asString , ' unchecked: '
		 , event uncheckedButtons asString) traceCr ].
	center checked: true.

	grp add: right.
	grp add: center.
	grp add: left.

	menu addSeparator.
	menu addAllItems: grp buttons.
	menu addSeparator.

	sub := ToMenu new labelText: 'Save All'.
	sub addItem: (ToMenuItem new labelText: 'Locally').

	subsub := ToMenu new labelText: 'Externally'.
	subsub addItem: (ToMenuItem new labelText: 'Here').

	sub addItem: subsub.

	menu addItem: sub.
	menu position: 10 @ 10.
	menu openInInnerWindow
]

{ #category : #checkbox }
ToSandBox class >> group [ 

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
	group buttons second checked: true.
	container := ToElement new.
	container matchParent.
	container layout: BlLinearLayout horizontal.
	container layout cellSpacing: 2.
	container addChildren: group buttons.
	group when: ToCheckableGroupChangedEvent do: [ :event |
		('checked: ' , event checkedButtons asString , ' unchecked: '
		 , event uncheckedButtons asString) traceCr ].
	ToInnerWindow new
		in: [ :f | f root addChild: container ];
		openInSpace
]

{ #category : #'labeled icon' }
ToSandBox class >> labeledIconlWithIconAndText [

	| but  |
	ToStyleSheetTheme cleanUp.
	but := ToLabeledIcon new.
	but label: (ToLabel text: 'Labeled icon').
	but icon: (ToImage inner: (BlElement new
			 size: 60 @ 60;
			 background: (Color blue alpha: 0.2);
			 yourself)).
	^ but
]

{ #category : #accessing }
ToSandBox class >> methodText [
	^ self  class sourceCodeAt: #example_CodeEditor
]

{ #category : #combobox }
ToSandBox class >> statesOfAmerica [

	^ { #Alabama. #Alaska. #Arizona. #Arkansas. #California. #Colorado.
		#Connecticut. #Delaware. #Florida. #Georgia. #Hawaii. #Idaho. #'Illinois Indiana'.
		#Iowa. #Kansas. #Kentucky. #Louisiana. #Maine. #Maryland. #Massachusetts.
		#Michigan. #Minnesota. #Mississippi. #Missouri. #Montana. #Nebraska.
		#Nevada. #'New Hampshire'. #'New Jersey'. #'New Mexico'.
		#'New York'. #'North Carolina'. #'North Dakota'. #Ohio. #Oklahoma.
		#Oregon. #'Pennsylvania Rhode Island'. #'South Carolina'.
		#'South Dakota'. #Tennessee. #Texas. #Utah. #Vermont. #Virginia.
		#Washington. #'West Virginia'. #Wisconsin. #Wyoming }.
]

{ #category : #'see class side' }
ToSandBox >> seeClassSide [ 
]
