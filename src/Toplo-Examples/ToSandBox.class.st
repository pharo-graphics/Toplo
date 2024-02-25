Class {
	#name : #ToSandBox,
	#superclass : #Object,
	#category : #'Toplo-Examples'
}

{ #category : #'button-dep' }
ToSandBox class >> example_CheckBoxAndButtonWithDefaultStyleSheet [

	| chk btn space |
	ToTheme cleanUp.

	chk := ToCheckbox new.
	chk labelText: 'OK'.
	btn := ToButton new.
	btn labelText: 'Erase all your Pharo images?'.
	btn iconImage: ToThemeIcons iconSearchOutlined16x16.
	btn label addStamp: #H3.
	btn addStamp: #primary.
	btn addStamp: #danger.
	btn size: 500 @ 100.
	space := BlSpace new.
	space toTheme: ToBeeTheme new.
	space root layout: BlLinearLayout vertical.
	space root addChildren: {
			chk.
			btn }.
	space show
]

{ #category : #'button-dep' }
ToSandBox class >> example_CheckBoxAndButtonWithDefaultStyleSheetDarkTheme [

	| chk btn space |
	ToTheme cleanUp.
	chk := ToCheckbox new.
	chk labelText: 'OK'.
	btn := ToButton new.
	btn labelText: 'Erase all your Pharo images?'.
	btn iconImage: ToThemeIcons iconSearchOutlined16x16.
	btn label addStamp: #H3.
	btn addStamp: #primary.
	btn addStamp: #danger.
	btn size: 500 @ 100.
	space := BlSpace new toTheme: ToBeeDarkTheme new.
	space root layout: BlLinearLayout vertical.
	space root addChildren: {
			chk.
			btn }.
	space show
]

{ #category : #'button-dep' }
ToSandBox class >> example_CheckBoxWithDefaultStyleSheetDarkTheme [

	| chk  space |
	ToTheme cleanUp.
	chk := ToCheckbox new.
	chk labelText: 'OK'.
	space := BlSpace new toTheme: ToBeeDarkTheme new.
	space root layout: BlLinearLayout vertical.
	space root addChildren: {
			chk }.
	chk disabled: false.
	space show
]

{ #category : #checkbox }
ToSandBox class >> example_CheckboxChecked [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new label: (ToLabel text: 'Checkbox').
	chb addEventHandler: (BlEventHandler
			 on: ToElementLookEvent
			 do: [ :evt | evt target = chb ifTrue: [ evt traceCr ] ]).
	chb checked: true.
	chb openInInnerWindow.
	chb inspect
]

{ #category : #checkbox }
ToSandBox class >> example_CheckboxFlexible [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new
		       flexible: true;
		       hMatchParent;
		       labelText: 'Checkbox' asString.
	"chb inspect."
	chb openInInnerWindow
]

{ #category : #checkbox }
ToSandBox class >> example_CheckboxFlexibleWithGroup [

	| group container buttons |
	group := ToCheckableGroup new.
	buttons := OrderedCollection new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new
			       flexible: true;
			       hMatchParent;
			       beLabelFirst;
			       labelText: idx asString;
			       id: idx asString.
		buttons add: chb ].
	buttons second checked: true.
	group addAll: buttons.
	group addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 ('checked: ' , event checkedButtons asString , ' unchecked: '
				  , event uncheckedButtons asString) traceCr ]).

	container := ToElement new.
	container background: Color veryLightGray.
	container matchParent.

	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChildren: group buttons.
	container openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_CheckboxGroupAndNoneStrategy [

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
	group addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 ('checked: ' , event checkedButtons asString , ' unchecked: '
				  , event uncheckedButtons asString) traceCr ]).

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
ToSandBox class >> example_CheckboxGroupAndStrictStrategy [

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
	group addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 ('checked: ' , event checkedButtons asString , ' unchecked: '
				  , event uncheckedButtons asString) traceCr ]).

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
ToSandBox class >> example_CheckboxGroupAndUnckekingStrategy [

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
	group addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 ('checked: ' , event checkedButtons asString , ' unchecked: '
				  , event uncheckedButtons asString) traceCr ]).

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
ToSandBox class >> example_CheckboxNoLabel [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new .
	chb checked: true.
	chb inspect.
	chb openInInnerWindow
]

{ #category : #checkbox }
ToSandBox class >> example_CheckboxUnchecked [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new
				interspace: 10;
		       label: (ToLabel text: 'Checkbox');
		       id: 1 asString.
	chb openInInnerWindow
]

{ #category : #checkbox }
ToSandBox class >> example_CheckboxVerticalGroupHorizontal [

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
ToSandBox class >> example_CheckboxWithExactWidth [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new
		       interspace: 100 @ 0;
		       labelText: 'Checkbox' asString.
	chb openInInnerWindow
]

{ #category : #checkbox }
ToSandBox class >> example_CheckboxWithIndeterminate [

	| but |
	but := ToCheckbox new labelText: 'Checkbox'.
	but withIndeterminate: true.
	but inspect.
	but openInSpace
]

{ #category : #album }
ToSandBox class >> example_CodeEditor [

	| text album menuBuilder |
	text := self methodText asRopedText fontName: 'Source Code Pro'.
	album := ToAlbum new.
	album inspect.
	album styler: (BlRBTextStyler new classOrMetaClass: self class).
	album text: text copy.
	album withSaveCapability.
	album withRowNumbers.
	album whenSaveRequestedDo: [ :saveRequested | saveRequested accepted: true ].
	album whenCancelRequestedDo: [ :cancelRequested | cancelRequested client text: text copy ].
	
	menuBuilder := [ :menu :request | | element |
		element := request currentTarget.
		menu addItem: (ToMenuItem new labelText: 'Select all'; whenClickedDo: [:event  | element selecter all; apply ]; yourself).
		menu addItem: (ToMenuItem new labelText: 'Copy'; whenClickedDo: [:event  | element editor copySelected ]; yourself).
		menu addItem: (ToMenuItem new labelText: 'Cut'; whenClickedDo: [:event  | element editor cutSelected ]; yourself).
		menu addItem: (ToMenuItem new labelText: 'Paste'; whenClickedDo: [:event  | element editor paste ]; yourself).
		menu addSeparator.
		menu addItem: (ToMenuItem new labelText: 'Accept'; whenClickedDo: [:event  | element requestSave ]; yourself).
		menu addSeparator.
		menu addItem: (ToMenuItem new labelText: 'Cancel'; whenClickedDo: [:event  | element requestCancel ]; yourself) ].
	album contextMenu: menuBuilder. 
	album cursorColor: Color black.
	album openInSpace


]

{ #category : #list }
ToSandBox class >> example_EditableList2WithAllClassesNames [

	| l vscrollBar space innerWin |
	l := ToListElement new.
	l beVertical.
	l inspect.
	l
		nodeClass: ToListClassNodeExample;
		nodeBuilder: [ :node :holder |
			node forClassNameAssoc: holder dataItem ];
		addEventHandler: (BlEventHandler
				 on: ToListStrongSelectionEvent
				 do: [ :event |
					 event indexes size == 1 ifTrue: [
							 (l nodeAt: event indexes first) label addEditorEvent: event ] ]);
		withRowNumbers.

	l dataAccessor addAll:
		(Smalltalk globals allClasses collect: [ :cls | cls -> cls name ]).

	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
		c ignoreByLayout.
		c margin: (BlInsets right: 2).
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	vscrollBar attachTo: l infinite.
	innerWin := ToInnerWindow new.
	innerWin pane addChild: l.
	innerWin pane addChild: vscrollBar.
	space := BlSpace new.
	space root addChild: innerWin.
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
				placeholderBuilder: [:placeholder :e | 		
					| lab |
					placeholder preventMeAndChildrenMouseEvents.
					lab := ToAttributedLabel new text: placeholderText.
					lab beMultiLine.
					placeholder addChild: lab ];
		        withRowNumbers;
		        withSaveCapability;
		        whenSaveRequestedDo: [ :saveRequested |
			        saveRequested client saveResult: true ];
		        withEditsFeedback.
	view openInInnerWindow 
]

{ #category : #album }
ToSandBox class >> example_EditorWithPlaceholderWithAlbum [

	| placeholderText view |
	placeholderText := 'Here is a placeholder text visible only if the editor is empty' asRopedText.
	placeholderText foreground: Color veryLightGray.
	placeholderText fontSize: 30.

	view := ToAlbum new
				placeholderBuilder: [:placeholder :e | 		
					| lab |
					placeholder layout: BlLinearLayout new.
					placeholder padding: (BlInsets all: 40).
					lab := ToAlbum new text: placeholderText.
					lab background: Color transparent.
					lab next background: Color transparent.
					lab border: BlBorder empty.
					lab beReadonlyWithSelection.
					placeholder addChild: lab ];
		        withRowNumbers;
		        withSaveCapability;
		        whenSaveRequestedDo: [ :saveRequested |
			        saveRequested client saveResult: true ];
		        withEditsFeedback.
	view openInInnerWindow 
]

{ #category : #album }
ToSandBox class >> example_EditorWithoutSoftLine [

	| view |

	view := ToAlbum new
		        withRowNumbers;
		        withSaveCapability;
		        whenSaveRequestedDo: [ :saveRequested |
			        saveRequested client saveResult: true ];
		        withEditsFeedback.
	view withoutSoftLine.
	view text: ((String loremIpsum: 100000) asRopedText fontName: 'Source Code Pro').
	view openInSpace
]

{ #category : #'general button' }
ToSandBox class >> example_GeneralButtonWithIconAndLabel [

	| but lab ico pane |
	pane := ToPane new.
	pane fitContent.
	lab := ToLabel new text: 'General button'.
	ico := ToImage inner: (self iconNamed: #remove).
	pane addChildren: {
			ico.
			lab }.
	pane childrenDo: [ :child |
		child constraintsDo: [ :c |
			c linear horizontal alignCenter.
			c linear vertical alignCenter ] ].

	but := ToGeneralButton new.
	but fitContent.
	but padding: (BlInsets all: 4).
	but geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	but border: Color black.
	but addChild: pane.
	but whenClickedDo: [ self inform: 'clicked' ].
	but openInSpace.
	^ but
]

{ #category : #'general button' }
ToSandBox class >> example_GeneralButtonWithIconAndLabel_matchParent [

	| but |
	but := self example_GeneralButtonWithIconAndLabel.
	but layout alignCenter.
	but childrenDo: [ :child |
		child constraintsDo: [ :c |
			c linear horizontal alignCenter.
			c linear vertical alignCenter ] ].
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

{ #category : #list }
ToSandBox class >> example_HorizontalListWithIndexedColors [

	| l space |
	l := ToListElement new nodeBuilder: [ :node :holder |
		     node constraintsDo: [ :c |
			     c horizontal fitContent.
			     c vertical fitContent ].
		     node addChild: (ToElement new
				      size: 70 @ 50;
				      background: holder dataItem) ].
	l background: Color yellow.
	l beHorizontal.
	l data addAll: Color indexedColors.
	space := BlSpace new.
	space root addChild: l.
	space show
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText [

	| but  |
	but := self labeledIconlWithIconAndText.
	but hMatchParent.
	but inspect.
	but openInSpace.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText_flexible [

	| but  |
	but := self example_LabeledIconlWithIconAndText.
	but flexible: true.
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
	but flexible: true.
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
	but flexible: true.
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
	but flexible: true.
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

{ #category : #list }
ToSandBox class >> example_List2WithAllClassesMono [

	| l |
	l := ToListElement new.
	l selectionMode: ToListSingleSelectionMode new.
	l dataAccessor addAll:
		(Smalltalk globals allClasses collect: [ :cls | cls name ]).
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_List2WithAllClassesMulti [

	| l |
	l := ToListElement new.
	l withRowNumbers.
	"l selectionModel inspect."
	l dataAccessor addAll:
		(Smalltalk globals allClasses collect: [ :cls | cls name ]).
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_List2WithAllClassesNone [

	| l |
	l := ToListElement new.
	l selectionMode: ToListNoneSelectionMode new.
	l dataAccessor addAll:
		(Smalltalk globals allClasses collect: [ :cls | cls name ]).
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_List2WithSelectionHistory [

	| statesList historyList pane |
	pane := ToPane horizontal.
	statesList := ToListElement new matchParent.
	historyList := ToListElement new matchParent.
	statesList dataAccessor addAll: self statesOfAmerica.
	pane addChildren: {
			statesList.
			historyList }.

	statesList addEventHandler:
		(ToListSelectionHistoryEventHandlerExample2 new historyList:
			 historyList).
	statesList addEventHandler: (BlEventHandler
			 on: ToCommandAppliedEvent
			 do: [ :event | event traceCr ]).

	pane
		matchParent;
		addDividers.
	pane openInInnerWindow
]

{ #category : #list }
ToSandBox class >> example_ListOneClass [

	| l |
	l := ToListElement new nodeBuilder: [ :node :holder |
		     node addChild: (ToCheckbox new
				      labelText: holder data name;
				      interspace: 10;
				      hMatchParent) ].
	l data addAll: { Smalltalk globals allClasses first }.
	l inspect.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWith6Elements [

	| l |
	l := ToListElement new.
	l data addAll: ((1 to: 6) collect: [ :i | i asString ]).
	l selecter selectIndex: 4.
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
	l := ToListElement new nodeBuilder: [ :node :holder |
		     | icn lab |
		     icn := holder dataItem hasComment
			            ifTrue: [ #class ]
			            ifFalse: [ #uncommentedClass ].
		     lab := ToLabel new
			            text: holder dataItem name;
			            beEditable;
			            yourself.
		     node addChild: (ToLabeledIcon new
				      label: lab;
				      icon: (ToImage inner: (Smalltalk ui icons iconNamed: icn));
				      interspace: 10;
				      hMatchParent) ].
	l addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :evt | evt traceCr ]).

	l dataAccessor addAll: Smalltalk globals allClasses.
	l withRowNumbers.
	l inspect.
	l infinite requestFocus.
	l openInInnerWindow
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClasses4 [

	| l |
	l := ToListElement new nodeBuilder: [ :node :holder |
		     node addChild: (ToCheckbox new
				      labelText: holder dataItem name;
				      interspace: 10) ].
	l dataAccessor addAll: Smalltalk globals allClasses.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesAndTraitsSorted [

	| l |
	l := ToListElement new nodeBuilder: [ :node :holder |
		     node addChild: (ToClassNameViewExample new
				      class: holder dataItem position: holder position;
				      yourself) ].
	l dataAccessor addAll:
		(Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]).
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesAsButton [

	| l |
	l := ToListElement new nodeBuilder: [ :node :holder |
		     node addChild: (ToButton new
				      labelText: holder data name;
				      hMatchParent) ].
	l data addAll: Smalltalk globals allClasses.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithEditableAndContextMenu [

	| l selectionMenu menuFactory phtext |
	l := ToListElement new.
	phtext := (('Invoke the context menu ' , String cr
	            , 'with a right-click' , String cr
	            , 'to initialize the list') asRopedText
		           foreground: Color lightGray;
		           yourself)
		          fontSize: 24;
		          yourself.

	l placeholderBuilder: [ :placeholder :e |
		| lab |
		placeholder layout alignCenter.
		placeholder preventMeAndChildrenMouseEvents.
		lab := ToAttributedLabel new
			       beMultiLine;
			       text: phtext;
			       yourself.
		placeholder addChild: lab ].
	l nodeBuilder: [ :node :holder |
		| lab t |
		t := holder dataItem.
		lab := ToLabel text: t.
		lab defaultRawSkin: ToLabelInListSkin new.
		lab beMultiLine.
		lab beEditable.
		lab stillPressedStartDelay: 800 milliSeconds.
		lab addEventHandler: (BlEventHandler
				 on: ToStillPressedLookEvent
				 do: [ :event |
					 event consumed: true.
					 lab addEditorEvent: event ]).
		lab addEventHandler: (BlEventHandler
				 on: ToLabelEditorOpenedEvent
				 do: [ l disableScrolledEvent ]).
		lab addEventHandler: (BlEventHandler
				 on: ToLabelEditorClosedEvent
				 do: [ l enableScrolledEvent ]).
		lab addEventHandler: (BlEventHandler
				 on: ToLabelTextReplacedEvent
				 do: [ l dataAccessor at: holder position put: lab text asString ]).
		node addChild: (ToLabeledIcon new
				 label: lab;
				 hMatchParent) ].
	l addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event |
				 self class name trace.
				 ' list selection changed' traceCr ]).
	l addEventHandler: (BlEventHandler
			 on: ToListStrongSelectionEvent
			 do: [ :event |
				 | r |
				 self class name trace.
				 ' double click' traceCr.
				 r := event indexes collect: [ :idx | idx asString , ':XXXXXX' ].
				 r do: [ :e | l dataAccessor addFirst: e ] ]).
	menuFactory := [ :menu :request |
	               | selectedIndexes target |
	               target := request currentTarget.
	               selectedIndexes := request selectedIndexes.
	               menu addItem: (ToMenuItem new
			                labelText: 'Add initial Items';
			                whenClickedDo: [ :event |
				                target dataAccessor addAll:
						                ((1 to: 2000) collect: [ :p |
								                 p asString , ' AAAAAAAAAAA' ]) ]).
	               menu addItem: (ToMenuItem new
			                labelText: 'Inspect list';
			                whenClickedDo: [ :event | target inspect ]).
	               target dataAccessor ifNotEmpty: [
		               menu addItem: (ToMenuItem new
				                labelText: 'Select all';
				                whenClickedDo: [ :event |
					                target selecter selectAll ]).
		               menu addItem: (ToMenuItem new
				                labelText: 'Remove all';
				                whenClickedDo: [ :event |
					                target dataAccessor removeAll ];
				                yourself) ].
	               selectedIndexes ifNotEmpty: [
		               selectionMenu := ToMenu new.
		               selectionMenu label: (ToLabel new text: 'Selection').
		               selectedIndexes size = 1 ifTrue: [
			               | node idx label |
			               idx := selectedIndexes first.
			               node := l nodeAt: idx.
			               label := node firstChild label.
			               selectionMenu addItem: (ToMenuItem new
					                labelText: 'Edit';
					                whenClickedDo: [ :event |
						                label addEditorEvent: nil ];
					                yourself).
			               selectionMenu addItem: (ToMenuItem new
					                labelText: (label isMonoLine
							                 ifTrue: [ 'Be multiline' ]
							                 ifFalse: [ 'Be monoline' ]);
					                whenClickedDo: [ :event |
						                node firstChild label monoLine:
								                label isMonoLine not ];
					                yourself).
			               selectionMenu addItem: (ToMenuItem new
					                labelText: 'Inspect';
					                whenClickedDo: [ :event | node inspect ];
					                yourself).
			               selectionMenu addSeparator ].
		               selectionMenu addItem: (ToMenuItem new
				                labelText: 'Insert before';
				                whenClickedDo: [ :event |
					                | idx |
					                idx := selectedIndexes first.
					                target dataAccessor
						                add: idx asString , ':XXXXXX'
						                beforeIndex: idx ];
				                yourself).
		               selectionMenu addItem: (ToMenuItem new
				                labelText: 'Insert after';
				                whenClickedDo: [ :event |
					                | idx |
					                idx := selectedIndexes last.
					                target dataAccessor
						                add: idx asString , ':XXXXXX'
						                afterIndex: idx ];
				                yourself).
		               selectionMenu addSeparator.
		               selectionMenu addItem: (ToMenuItem new
				                labelText: 'Remove';
				                whenClickedDo: [ :event |
					                selectedIndexes reverseDo: [ :idx |
							                target dataAccessor removeAt: idx ] ];
				                yourself).
		               menu addSeparator.
		               menu addItem: selectionMenu ] ].

	l contextMenu: menuFactory.
	l withRowNumbers.
	l openInInnerWindow
]

{ #category : #list }
ToSandBox class >> example_ListWithIndexedColors [

	| l vscrollBar space |
	l := ToListElement new nodeBuilder: [ :node :holder |
		     node addChild: (ToLabel new
				      text: holder dataItem asString asRopedText;
				      hMatchParent;
				      background: holder dataItem) ].
	l dataAccessor addAll: Color indexedColors.

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
		        nodeBuilder: [ :node :holder |
			        | title blContent |
			        title := ToLabel new
				                 id: #title;
				                 text: holder data;
				                 margin: (BlInsets all: 1);
				                 padding: (BlInsets all: 1);
				                 yourself.
			        blContent := ToPaneNodeExample new.
			        blContent addChild: title at: 1.
			        blContent margin: (BlInsets all: 4).
			        blContent padding: (BlInsets all: 12).
			        blContent geometry:
				        (BlRoundedRectangleGeometry cornerRadius: 6).
			        blContent border: (BlBorder paint: Color lightGray).
			        node addChild: blContent ].
	list data addAll: (1 to: 1000).
	list openInSpace
]

{ #category : #select }
ToSandBox class >> example_MonoFiltrable [

	| select innerWindow phtext |
	select := ToSelect new.

	select listElement placeholderMinHeight: 35.
	phtext := ('No Data' asRopedText
		           foreground: Color lightGray;
		           yourself)
		          fontSize: 24;
		          yourself.

	select listElement placeholderBuilder: [ :placeholder :e |
		| lab |
		placeholder layout alignCenter.
		lab := ToAttributedLabel text: phtext.
		placeholder addChild: lab ].

	select filtrable: true.
	select dataAccessor addAll: self statesOfAmerica.
	select placeholderText: ('Select a state' asRopedText foreground: Color red).
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select width: 300.
	select position: 50 @ 50.
	select inputTextField requestFocus.
	innerWindow pane addChild: select.
	innerWindow height: 500.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_MonoNotFiltrable [

	| select innerWindow |
	select := ToSelect new.
	select filtrable: false.
	select dataAccessor addAll: self statesOfAmerica.
	select placeholderText: ('Select a state' asRopedText foreground: Color red).
	select listElement nodeBuilder: [ :node :holder |
		node addChild: (ToLabel text: holder dataItem asString) hMatchParent ].
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select width: 300.
	select position: 50 @ 50.
	innerWindow pane addChild: select.
	innerWindow height: 500.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_MultiFiltrable [

	| select innerWindow |
	select := ToSelect new.
	select dataAccessor addAll: self statesOfAmerica.
	select strategy: ToMultipleSelectStrategy new.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderText:
		('Select states' asRopedText foreground: Color red).
	select listElement nodeBuilder: [ :node :holder |
		node addChild: (ToLabel text: holder dataItem asString) hMatchParent ].
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select width: 300.
	select position: 50 @ 10.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_MultiNotFiltrable [

	| select innerWindow |
	select := ToSelect new.
	select filtrable: false.
	select dataAccessor addAll: self statesOfAmerica.
	select strategy: ToMultipleSelectStrategy new.
	select placeholderText:
		('Select states' asRopedText foreground: Color red).
	select listElement nodeBuilder: [ :node :holder |
		node addChild: (ToLabel text: holder dataItem asString) hMatchParent ].
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select width: 300.
	select position: 50 @ 50.

	innerWindow pane addChild: select.
	innerWindow height: 500.
	innerWindow openInSpace
]

{ #category : #menu }
ToSandBox class >> example_OpenSaveSaveAsCloseWithSubmenu [

	| menu container saveAs lbl |
	container := ToInnerWindow new
		             position: 10 @ 10;
		             size: 400 @ 200;
		             yourself.
	menu := ToMenu new.
	"menu label: (ToLabel text: 'Menu')."
	menu icon: (ToImage inner: (self iconNamed: #solidMenu)).
	menu addItem: (ToMenuItem new
			 icon: (ToImage inner: (self iconNamed: #solidMenu));
			 label: (ToLabel text: 'Open')).
	lbl := ToAttributedLabel new text: ('Save stuffs' asRopedText
			        fontSize: 12;
			        italic;
			        foreground: (Color blue alpha: 0.7)).
	menu addSeparator.
	menu addItem: (ToCustomMenuItem new innerElement: lbl).

	menu addItem: (ToMenuItem new
			 icon: (ToImage inner: (self iconNamed: #solidMenu));
			 label: (ToLabel text: 'Save')).
	saveAs := ToMenu new label: (ToLabel text: 'Save as').
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.pdf')).
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.doc')).
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.xml')).
	menu addItem: saveAs.
	"menu items last when: BlMouseDownEvent do: [ :event | event currentTarget inspect ]."

	saveAs := ToMenu new label: (ToLabel text: 'Save as').
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.pdf')).
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.doc')).
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.xml')).
	menu addItem: saveAs.
	saveAs := ToMenu new label: (ToLabel text: 'Save as').
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.pdf')).
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.doc')).
	saveAs addItem: (ToMenuItem new label: (ToLabel text: '.xml')).
	menu addItem: (ToMenu new label: (ToLabel text: 'Save as again')).
	menu items last addItem: saveAs.
	menu addSeparator.
	menu addItem: (ToMenuItem new label: (ToLabel text: 'Close')).
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
	list nodeBuilder: [ :node :holder |
		| imageData photoElement |
		imageData := holder dataItem.
		photoElement := ToPicsumPhotosGalleryImageElement new
			                hMatchParent;
			                vFitContent;
			                margin: (BlInsets all: 5);
			                imageData: imageData;
			                yourself.
		node addChild: photoElement ].

	list addEventHandler: (BlEventHandler
			 on: BlInfiniteElementAttachedEvent
			 do: [ :event | event element firstChild attached ]).
	list addEventHandler: (BlEventHandler
			 on: BlInfiniteElementDetachedEvent
			 do: [ :event | event element firstChild detached ]).

	[
	| images |
	images := (STONJSON fromString:
		           'https://picsum.photos/list' asUrl retrieveContents)
		          collect: [ :aDictionary |
			          ToPicsumPhotosGalleryImageData fromDictionary:
				          aDictionary ].
	images sort: [ :a :b | a id > b id ].
	list dataAccessor addAll: images ] fork.

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
		        layout: BlBasicLayout new;
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
	popupWindowHandler := ToPopupWindowManager new.
	popupWindowHandler builder: [ :popup :element |
		popup border: Color black.
		item := ToElement new size: 50 @ 90.
		item background: Color yellow.
		item addEventHandler: (BlEventHandler
				 on: BlPrimaryClickEvent
				 do: [ self inform: 'Click' ]).
		popup root addChild: item ].
	popupWindowHandler onInstalledIn: menu.
	container pane addChild: menu.
	container openInSpace
]

{ #category : #list }
ToSandBox class >> example_QueryOnList2WithStatesOfAmerica [

	| listElement pane filterField data selector |
	pane := ToPane new
		        beVertical;
		        matchParent.
	filterField := ToTextField new.
	listElement := ToListElement new.
	data := self statesOfAmerica.

	listElement margin: (BlInsets all: 2).
	filterField margin: (BlInsets all: 2).

	selector := ToObservableCollectionQueryRunner new.
	listElement dataAccessor addAll: data.

	selector onInstalledIn: listElement dataAccessor.

	filterField addEventHandler: (BlEventHandler
			 on: AlbTextEditedEvent
			 do: [
				 | pattern |
				 pattern := filterField text asString.
				 selector pattern: pattern ]).

	listElement dataAccessor addEventHandler: (BlEventHandler
			 on: ToObservableCollectionQueryResultEvent
			 do: [ :event |
				 listElement selecter selectOnlyIndexes:
					 event queryRunner selectedIndexes ]).

	listElement placeholderBuilder: [ :ph :e |
		| lab |
		lab := ToAttributedLabel new text: ('No Data' asRopedText
				        foreground: Color lightGray;
				        fontSize: 24;
				        yourself).
		lab matchParent.
		ph addChild: lab ].

	"handler inspect."
	pane addChild: listElement.
	pane addChild: filterField.
	pane openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_RadioButtonChecked [

	| but |
	ToTheme cleanUp.
	but := ToRadioButton new.
	but checked: true.
	but labelText: 'Radio'.
	but openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_RadioButtonUnchecked [

	| but |
	ToTheme cleanUp.
	but := ToRadioButton new.
	but labelText: 'Radio'.
	but openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_RadioButtonWithIndeterminate [

	| but |
	ToTheme cleanUp.
	but := ToRadioButton new.
	but withIndeterminate: true.
	but checked: #something. " any value except a boolean (and except nil) for indeterminate state "
	but labelText: 'Radio'.
	but inspect.
	but openInSpace
]

{ #category : #list }
ToSandBox class >> example_SieveOnList2WithStatesOfAmerica [

	| listElement pane filterField data sieve |
	pane := ToPane new
		        beVertical;
		        matchParent.
	filterField := ToTextField new.
	listElement := ToListElement new.
	data := self statesOfAmerica. "copyFrom: 1 to: 8"

	listElement margin: (BlInsets all: 2).
	listElement withRowNumbers.
	filterField margin: (BlInsets all: 2).

	sieve := ToListElementSieve new.
	sieve onInstalledIn: listElement.
	listElement dataAccessor addAll: data.

	filterField addEventHandler: (BlEventHandler
			 on: AlbTextEditedEvent
			 do: [
				 | pattern |
				 pattern := filterField text asString.
				 sieve pattern: pattern ]).

	listElement placeholderBuilder: [ :ph :e |
		| lab |
		lab := ToAttributedLabel new text: ('No Data' asRopedText
				        foreground: Color lightGray;
				        fontSize: 24;
				        yourself).
		lab matchParent.
		ph addChild: lab ].

	"handler inspect."
	pane addChild: listElement.
	pane addChild: filterField.
	pane openInSpace.
	^ listElement->sieve
]

{ #category : #list }
ToSandBox class >> example_SieveOnList2With_350000_Items [

	| listElement pane filterField data sieve |
	pane := ToPane new
		        beVertical;
		        matchParent.
	filterField := ToTextField new.
	listElement := ToListElement new.
	data := OrderedCollection new.
	Character alphabet do: [ :c1 |
		Character alphabet do: [ :c2 |
			Character alphabet do: [ :c3 |
				((48 to: 57) collect: [ :n | n asCharacter ]) do: [ :c4 |
					data add: (String streamContents: [ :str |
							 str nextPutAll: {
									 c1.
									 c2.
									 c3.
									 c4 } ]) ] ] ] ].

	listElement margin: (BlInsets all: 2).
	listElement withRowNumbers.
	filterField margin: (BlInsets all: 2).
	listElement dataAccessor addAll: (data collect: [:d | d copy]).

	sieve := ToListElementSieve new.
	sieve onInstalledIn: listElement.
	listElement dataAccessor addAll: data.
	listElement dataAccessor size traceCr.
	filterField addEventHandler: (BlEventHandler
			 on: AlbTextEditedEvent
			 do: [
				 | pattern |
				 pattern := filterField text asString.
				 sieve pattern: pattern ]).

	listElement placeholderBuilder: [ :ph :e |
		| lab |
		lab := ToAttributedLabel new text: ('No Data' asRopedText
				        foreground: Color lightGray;
				        fontSize: 24;
				        yourself).
		lab matchParent.
		ph addChild: lab ].

	"handler inspect."
	pane addChild: listElement.
	pane addChild: filterField.
	pane openInSpace
]

{ #category : #list }
ToSandBox class >> example_SieveOnList2With_AllClassNames [

	| listElement pane filterField data sieve |
	pane := ToPane new
		        beVertical;
		        matchParent.

	filterField := ToTextField new.
	listElement := ToListElement new.
	data := SystemNavigation default allMethods.
	listElement withRowNumbers.
	filterField margin: (BlInsets all: 2).
	filterField placeholderText:
		(' Method name filter' asRopedText foreground: Color lightGray).

	sieve := ToListElementSieve new.
	sieve onInstalledIn: listElement.
	listElement dataAccessor addAll:
		(Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]).

	sieve dataFilter: [ :aCompiledMethod :aPattern |
		aCompiledMethod selector beginsWith: aPattern caseSensitive: true ].


	listElement nodeBuilder: [ :node :holder |
		node addChild: (ToLabel new text: holder dataItem printString) ].

	sieve dataFilter: [ :aClass :aPattern |
		aClass name beginsWith: aPattern caseSensitive: true ].
	filterField addEventHandler: (BlEventHandler
			 on: AlbTextEditedEvent
			 do: [
				 | pattern |
				 pattern := filterField text asString.
				 sieve pattern: pattern ]).

	listElement placeholderBuilder: [ :ph :e |
		| lab |
		lab := ToAttributedLabel new text: ('No Data' asRopedText
				        foreground: Color lightGray;
				        fontSize: 24;
				        yourself).
		lab matchParent.
		ph addChild: lab ].
	"handler inspect."
	"listElement inspect."
	pane addChild: listElement.
	pane addChild: filterField.
	pane openInSpace
]

{ #category : #list }
ToSandBox class >> example_SieveOnList2With_AllMethods [

	| listElement pane filterField data sieve |
	pane := ToPane new
		        beVertical;
		        matchParent.

	filterField := ToTextField new.
	listElement := ToListElement new.
	data := SystemNavigation default allMethods.
	listElement withRowNumbers.
	filterField margin: (BlInsets all: 2).
	filterField placeholderText:
		(' Method name filter' asRopedText foreground: Color lightGray).

	sieve := ToListElementSieve new.
	sieve onInstalledIn: listElement.
	listElement dataAccessor addAll: data.
	listElement
		addEventHandlerOn: ToSieveSelectionChangedEvent
		do: [ :event |
			'selected: ' trace.
			event selectionModel selectedIndexes traceCr ].

	sieve dataFilter: [ :aCompiledMethod :aPattern |
		aCompiledMethod selector beginsWith: aPattern caseSensitive: true ].


	listElement nodeBuilder: [ :node :holder |
		node addChild: (ToLabel new text: holder dataItem printString) ].

	sieve dataFilter: [ :aCompiledMethod :aPattern |
		aCompiledMethod selector beginsWith: aPattern caseSensitive: true ].
	filterField addEventHandler: (BlEventHandler
			 on: AlbTextEditedEvent
			 do: [
				 | pattern |
				 pattern := filterField text asString.
				 sieve pattern: pattern ]).

	listElement placeholderBuilder: [ :ph :e |
		| lab |
		lab := ToAttributedLabel new text: ('No Data' asRopedText
				        foreground: Color lightGray;
				        fontSize: 24;
				        yourself).
		lab matchParent.
		ph addChild: lab ].
	"handler inspect."
	"listElement inspect."
	pane addChild: listElement.
	pane addChild: filterField.
	pane openInSpace.
	^ listElement -> sieve
]

{ #category : #list }
ToSandBox class >> example_SieveOnList2With_AllMethods_MonoSelection [

	| listElement assoc |
	assoc := self example_SieveOnList2With_AllMethods.
	listElement := assoc key.
	listElement selectionMode: ToListSingleSelectionMode new
]

{ #category : #list }
ToSandBox class >> example_SieveOnList2With_AllMethods_OnCR [

	| listElement pane filterField data sieve |
	pane := ToPane new
		        beVertical;
		        matchParent.

	filterField := ToTextField new.
	listElement := ToListElement new.
	data := SystemNavigation default allMethods.
	listElement withRowNumbers.
	filterField margin: (BlInsets all: 2).

	sieve := ToListElementSieve new.
	sieve onInstalledIn: listElement.
	listElement dataAccessor addAll: data.

	sieve dataFilter: [ :aCompiledMethod :aPattern |
		aCompiledMethod selector beginsWith: aPattern caseSensitive: true ].


	listElement nodeBuilder: [ :node :holder |
		node addChild: (ToLabel new text: holder dataItem printString) ].

	sieve dataFilter: [ :aCompiledMethod :aPattern |
		aCompiledMethod selector beginsWith: aPattern caseSensitive: true ].
	filterField addEditorShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination return;
			 action: [ :event |
				 | pattern |
				 pattern := event currentTarget text asString.
				 self inform: pattern.
				 sieve pattern: pattern ] yourself).

	listElement placeholderBuilder: [ :ph :e |
		| lab |
		lab := ToAttributedLabel new text: ('No Data' asRopedText
				        foreground: Color lightGray;
				        fontSize: 24;
				        yourself).
		lab matchParent.
		ph addChild: lab ].
	"handler inspect."
	pane addChild: listElement.
	pane addChild: filterField.
	pane openInSpace
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
	menu addItem: (ToMenuItem new
			 icon: ((ToImage inner: (self iconNamed: #solidMenu)));
			 label: (ToLabel text: 'Save');
			 background: Color random).
	menu addItem: (ToMenuItem new
			 icon: ((ToImage inner: (self iconNamed: #solidMenu)));
			 label: (ToLabel text: 'Save as');
			 background: Color random).
	menu items last whenClickedDo: [ :event | event currentTarget inspect ].
	menu addSeparator.
	menu addItem: (ToMenuItem new
			 label: (ToLabel text: 'Close');
			 background: Color random).
	menu items last whenClickedDo: [ :event | event currentTarget inspect ].
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
	"b := ToCheckbox new."
	"b := ToRadioButton new."
	b := ToButton new.
	b toTheme: ToBeeTheme new.

	"b := ToToggleButton new."
	"b stampWith: #primary. "
	"b stampWith: #'large-sizing'."
	"b stampWith: #'small-sizing'."

	"b stampWith: #vertical."
	b addStamp: #'icon-first'.
	b addStamp: #'label-first'.
	"b withStamp: #'interspace-1' -> 300."
	b interspace: #flexible.
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
	"b := ToCheckbox new."
	"b := ToRadioButton new."
	b := ToButton new.
	"b := ToToggleButton new."
	"b stampWith: #primary. "
	"b stampWith: #'large-sizing'."
	"b stampWith: #'small-sizing'."

	"b stampWith: #vertical."
	b addStamp: #'icon-first'.
	b addStamp: #'label-first'.
	b addStamp: #'interspace-1' -> 300.
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

	themeSwitcher := ToChoiceMenu new.
	themeSwitcher width: 150.
	themeSwitcher data addAll: {
			ToBeeTheme new.
			ToBeeDarkTheme new. }.

	themeSwitcher whenSelectedIndexChangedDo: [
		space toTheme: themeSwitcher selectedData new ].
	themeSwitcher selectData: space toTheme class.
	topBar addChild: themeSwitcher.

	enablementSwitcher := ToSwitchIcon new.
	enablementSwitcher switchBarOnElement:
		((ToLabel text: 'Enabled')).
	enablementSwitcher switchBarOffElement:
		((ToLabel text: 'Disabled')).
	enablementSwitcher check.
	enablementSwitcher
		when: ToCheckableCheckEvent
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
	
	directionSwitcher := ToSwitchIcon new labelText: 'Icon first'; beLabelFirst; yourself.
	directionSwitcher check.
	directionSwitcher
		when: ToCheckableCheckEvent
		do: [ :event | allButtons do: [ :b | b iconFirst: event target isChecked ] ].
	topBar addChild: directionSwitcher.
	
	orientationSwitcher := ToSwitchIcon new labelText: 'Horizontal'; beLabelFirst; yourself.
	orientationSwitcher check.
	orientationSwitcher
		when: ToCheckableCheckEvent
		do: [ :event | allButtons do: [ :b | b horizontal: event target isChecked ] ].
	topBar addChild: orientationSwitcher.
	
	topBar childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ].

	circleShapingRadio 
		when: ToCheckableCheckEvent 
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
		arr second ifNotNil: [ :s | but addStamp: s ].
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
		arr second ifNotNil: [ :s | but addStamp: s ].
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
		arr second ifNotNil: [ :s | but addStamp: s ].
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
		arr second ifNotNil: [ :s | but addStamp: s ].
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
		arr second ifNotNil: [ :s | but addStamp: s ].
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
		arr second ifNotNil: [ :s | but addStamp: s ].
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
	button1 label: (ToLabel text: 'Default raw button').
	button1 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).

	space root addChild: pane.
	space root addChild: button1.

	space show.
]

{ #category : #button }
ToSandBox class >> example_buttonWithIcon [

	| but space |
	ToTheme cleanUp.
	space := BlSpace new.
	but := ToButton new.
	space root addChild: but.
	space show.
	but icon: (ToImage new innerImage: (self iconNamed: #solidMenu)).
	^ but
]

{ #category : #button }
ToSandBox class >> example_buttonWithIconAndLabel [

	| but  |
	but := self example_buttonWithIcon.
	but label: (ToLabel text: 'Button with label').
	but inspect.
	^ but
]

{ #category : #button }
ToSandBox class >> example_buttonWithIconAndLabelDisabled [

	| but  |
	but := self example_buttonWithIconDisabled.
	but label: (ToLabel text: 'Button with label').
	but inspect.
	^ but
]

{ #category : #button }
ToSandBox class >> example_buttonWithIconDisabled [

	| but  |
	but := ToButton new.
	but icon: (ToImage new innerImage: (self iconNamed: #solidMenu)).
	but disable.
	but openInSpace.
	^ but
]

{ #category : #button }
ToSandBox class >> example_buttonWithLabel [

	| but  |
	but := ToButton new.
	but label: (ToLabel text: 'Button with label').
	but openInSpace.
	^ but
]

{ #category : #'choice menu' }
ToSandBox class >> example_choiceButtonWithPlaceholder [

	| win choice |
	win := ToInnerWindow new title: 'Operating system'.

	choice := ToChoiceMenu new.
	"choice width: 250."
	choice withUncheckingStrategy.
	choice data addAll: { 'OS-X'. 'Windows'. 'Linux' }.
	choice defaultLabel:
		(ToAttributedLabel text: ('Invalid choice' asRopedText
				  foreground: Color red;
				  yourself)) withNullSkin.
	win pane addChild: choice.
	win openInSpace
]

{ #category : #'choice menu' }
ToSandBox class >> example_choiceButtonWithStructuredData [

	| win choice |
	win := ToInnerWindow new title: 'Alexandrie host'.

	choice := ToChoiceMenu new
		          hMatchParent;
		          addStamp: #justified.
	choice dataToTextConverter: [ :assoc | assoc key ].
	choice	
		defaultSelectedIndex: 2;
		withStrictCheckingStrategy.

	choice data addAll: {
			('Morphic SDL' -> BlMorphicWindowHost).
			('Native SDL' -> BlOSWindowSDL2Host) }.

	choice addEventHandler: (BlEventHandler
			 on: ToChoiceSelectedIndexChangeEvent
			 do: [ self inform: choice selectedData asString ]).
	win pane addChild: choice.
	win openInSpace
]

{ #category : #'choice menu' }
ToSandBox class >> example_choiceButtonWithUncheckingStrategy [

	| win choice t |
	win := ToInnerWindow new title: 'Some host'.
	choice := ToChoiceMenu new hMatchParent.
	choice withUncheckingStrategy.
	t := 'No selection...' asRopedText , String cr asRopedText
	     , ('Please choose an host from the list' asRopedText
			      foreground: Color lightGray;
			      fontSize: 12).
	choice defaultLabel: (ToAttributedLabel new
			 beMultiLine;
			 text: t).
	choice dataToTextConverter: [ :assoc | assoc key ].
	choice addEventHandler: (BlEventHandler
			 on: ToChoiceSelectedIndexChangeEvent
			 do: [ self inform: choice selectedData value asString ]).
	choice data addAll: {
			('Morphic SDL' -> BlMorphicWindowHost).
			('Native SDL' -> BlOSWindowSDL2Host) }.
	win pane addChild: choice.
	win openInSpace
]

{ #category : #list }
ToSandBox class >> example_contactList [

	| panel button list contacts contact nameTxtF phoneTxtF addressTxtF inputPane |
	self flag:
		'issue when clicking on the row remove button in case the row is selected: the selection element is not correctly removed '.

	panel := ToPane vertical.
	panel constraints horizontal matchParent.
	panel layout cellSpacing: 10.

	list := ToListElement new.
	list inspect.
	list addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :evt | evt traceCr ]).

	nameTxtF := ToTextField new
		            width: 100;
		            placeholderBuilder: [ :placeholder :e |
			            placeholder addChild: (ToAttributedLabel new
						             text: ('Name' asRopedText
								              foreground: Color lightGray;
								              italic);
						             yourself) ].
	phoneTxtF := ToTextField new
		             width: 100;
		             placeholderBuilder: [ :placeholder :e |
			             placeholder addChild: (ToAttributedLabel new
						              text: ('Phone' asRopedText
								               foreground: Color lightGray;
								               italic);
						              yourself) ].
	addressTxtF := ToTextField new
		               width: 200;
		               placeholderBuilder: [ :placeholder :e |
			               placeholder addChild: (ToAttributedLabel new
						                text: ('Adress' asRopedText
								                 foreground: Color lightGray;
								                 italic);
						                yourself) ].

	list addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :evt |
				 evt selectedIndexes size = 1 ifTrue: [
					 contact := list dataAccessor at: evt selectedIndexes anyOne.
					 nameTxtF text: contact name.
					 phoneTxtF text: contact phoneNumber.
					 addressTxtF text: contact address ] ]).

	button := ToButton new label: (ToLabel text: 'Update table').
	button whenClickedDo: [
		| n p a c idx |
		n := nameTxtF text asString.
		p := phoneTxtF text asString.
		a := addressTxtF text asString.
		idx := list dataAccessor
			       detectIndex: [ :e | e name = n ]
			       ifNone: [  ].
		c := ToContactExample new
			     name: n;
			     phoneNumber: p;
			     address: a;
			     yourself.
		idx
			ifNotNil: [ list dataAccessor at: idx put: c ]
			ifNil: [ list dataAccessor add: c ] ].
	inputPane := ToPane horizontal.
	inputPane layout cellSpacing: 10.
	inputPane addChildren: {
			nameTxtF.
			phoneTxtF.
			addressTxtF.
			button }.
	contacts := OrderedCollection new.
	contact := ToContactExample new.
	contact name: 'Patty'.
	contact phoneNumber: '0299041101'.
	contact address: 'Brest'.
	contacts add: contact.
	contact := ToContactExample new.
	contact name: 'Paulie'.
	contact phoneNumber: '0298010101'.
	contact address: 'Brest'.
	contacts add: contact.
	list nodeBuilder: [ :node :holder |
		| line remBut |
		line := ToElement new
			        layout: BlLinearLayout horizontal;
			        matchParent.
		line addChild: (ToLabel new
				 text: holder dataItem name;
				 defaultRawSkin: ToLabelInListSkin new;
				 width: 100;
				 margin: (BlInsets right: 10)).
		line addChild: (ToLabel new
				 text: holder dataItem phoneNumber;
				 defaultRawSkin: ToLabelInListSkin new;
				 width: 100;
				 margin: (BlInsets right: 10)).
		line addChild: (ToLabel new
				 text: holder dataItem address;
				 defaultRawSkin: ToLabelInListSkin new;
				 width: 200;
				 margin: (BlInsets right: 10)).
		line addChild: ToElement new matchParent.
		remBut := ToButton new.
		remBut withNullSkin.
		remBut icon: (ToImage inner: (self iconNamed: #windowClose)).
		remBut constraintsDo: [ :c | c linear vertical alignCenter ].
		remBut addEventHandler: (BlEventHandler
				 on: BlClickEvent
				 do: [ :event |
					 event consumed: true.
					 holder infiniteElement dataAccessor removeAt: holder position ]).
		line addChild: remBut.
		node addChild: line ].
	list dataAccessor addAll: contacts.
	panel addChild: inputPane.
	panel addChild: list.
	panel openInSpace
]

{ #category : #'context menu + menubar' }
ToSandBox class >> example_contextMenu [

	| container |
	container := ToElement new matchParent.
	container contextMenu: [ :win :request |
		win addItem: (ToMenuItem new
				 labelText: 'Open';
				 whenClickedDo: [ self inform: 'Open' ];
				 yourself) ].

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

{ #category : #list }
ToSandBox class >> example_listStress [

	| tabsPanel list1 tab1 tabSize |
	tabSize := 1.
	list1 := ToListElement new.
	list1 constraints vertical matchParent.
	list1 constraints horizontal matchParent.
	1 to: tabSize do: [ :i |
	list1 dataAccessor add: 'Hello ' , i asString ].
	tabsPanel := ToTabPane new.
	tab1 := ToTab new.
	tab1 labelText: 'Hello'.
	tab1 paneBuilder: [ :pane :theTabPane | pane addChild: list1 ].
	tabsPanel addTab: tab1.
	list1 selecter selectAll.
	list1 withRowNumbers.
	tabsPanel openInSpace.

	tabsPanel enqueueTask: (BlTaskAction new action: [
			 [
			 1 to: 10000 do: [ :e |
				 tabsPanel enqueueTask: (BlTaskAction new action: [
						  | r |
						  1 to: tabSize do: [ :i |
						  list1 dataAccessor at: i put: 'Hello ' , e asString ].
						  list1 dataAccessor addFirst:
							  'Hello ' , (list1 dataAccessor size + 1) asString.
						  list1 dataAccessor add:
							  'Hello ' , (list1 dataAccessor size + 1) asString.
						  r := (Random new next * 1000) asInteger
						       \\ (list1 dataAccessor size - 1) + 1.
						  list1 selecter selectIndex: r.
						  list1 dataAccessor removeAt: (r + 1 min: list1 dataAccessor size).
						  list1 scrollToIndex: list1 dataAccessor size ]).
				 50 milliSeconds wait ] ] fork ])
]

{ #category : #'look event' }
ToSandBox class >> example_lookEventTrace [

	| but |
	but := ToButton new.
	but icon: (ToImage new innerImage: (self iconNamed: #solidMenu)).
	but label: (ToLabel text: 'Button with label').
	but addEventHandler: (BlEventHandler
			 on: ToElementLookEvent
			 do: [ :evt | evt target = but ifTrue: [ evt traceCr ] ]).
	but stillPressedStartDelay: 3000 milliSeconds.
	but inspect.
	but openInSpace
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
		menu label: (ToLabel text: 'Levels').
		menu icon:
			(ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).

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
						          nextPutAll: 'Level ';
						          space;
						          print: i ].
				selector := String streamContents: [ :out |
					            out
						            nextPutAll: 'level ';
						            print: index;
						            nextPutAll: ' Grid ';
						            print: i ].
				subMenu addItem:
					((ToMenuItem new labelText: stream) addEventHandler:
						 (BlEventHandler
							  on: BlPrimaryMouseUpEvent
							  do: [ :event | self inform: selector asSymbol ])) ].
			menu addItem: subMenu ].

		bar addMenu: menu ].

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
	windowHandler := ToOverlayWindowManager new.
	windowHandler onInstalledIn: e.
	windowHandler builder: [ :anchWin :element |
		anchWin background: (Color gray alpha: 0.2).
		anchWin border: (BlBorder paint: Color black width: 2) ].
	e openInInnerWindow.
	(windowHandler newWindowEvent: nil) popup
]

{ #category : #window }
ToSandBox class >> example_overlayWindow2 [

	| e windowHandler |
	e := ToInnerWindow new
		     size: 100 @ 100;
		     position: 50 @ 50.
	windowHandler := ToOverlayWindowManager new.
	windowHandler positionHook: [ :theWindow :theElement :event |
		theWindow position:
			theElement bounds inSpace bounds topLeft + (20 @ 40) ].
	windowHandler sizeHook: [ :theWindow :theElement :event |
		theWindow size:
			theElement measuredWidth - 40 @ (theElement measuredHeight - 60) ].
	windowHandler onInstalledIn: e.
	windowHandler builder: [ :anchWin :element |
		anchWin background: (Color gray alpha: 0.2).
		anchWin border: (BlBorder paint: Color black width: 2) ].
	e openInInnerWindow.
	(windowHandler newWindowEvent: nil) popup
]

{ #category : #window }
ToSandBox class >> example_rootFrame1 [

	| e |
	(e := ToInnerWindow new)
		title: 'Internal Frame example';
		openInSpace
]

{ #category : #'context menu + menubar' }
ToSandBox class >> example_rootFrameWithContextMenu [

	| win sub subsub bar textField |
	win := ToInnerWindow new title: 'Context menu Example'.
	win width: 600.

	win pane contextMenu: [ :menu :request |
		menu addItem: (ToMenuItem new
				 id: #openFile;
				 labelText: 'Open file';
				 icon: (ToImage inner: (Smalltalk ui icons iconNamed: #config))).
		menu addItem: (ToMenuItem new labelText: 'Export').
		menu addSeparator.

		1 timesRepeat: [
			sub := ToMenu new labelText: 'Save All'.
			sub addItem: (ToMenuItem new labelText: 'Locally').

			subsub := ToMenu new
				          labelText: 'Externally';
				          icon:
					          (ToImage inner:
							           (Smalltalk ui icons iconNamed: #solidMenu)).

			subsub addItem: (ToMenuItem new
					 id: #here;
					 labelText: 'Here').

			sub addItem: subsub.

			menu addItem: sub ] ].

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
		             width: 200.
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

	win pane contextMenu: [ :contextMenu :request | ].

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
ToSandBox class >> example_rotateImage [

	| im  |
	im := ToImage new innerImage: (Smalltalk ui icons iconNamed: #pharoBig).
	im rotateBy: 270.
	im border: (BlBorder paint: Color black width: 2).
	im openInSpace
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

{ #category : #select }
ToSandBox class >> example_selectWith5Nodes [

	| select innerWindow |
	select := ToSelect new.
	select listElement nodeBuilder: [ :node :holder |
		node addChild: (ToLabel text: holder dataItem asString) hMatchParent ].
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select width: 300.
	select position: 50 @ 50.
	select dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	innerWindow pane addChild: select.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_selectWithEditingMultiSelectionWithAllClassNames [

	| select innerWindow space |
	select := self selectWithEditingMultiSelection.
	select filtrable: true.
	select strategy: ToMultipleSelectStrategy new.
	
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select hMatchParent.
	select dataAccessor updateAllWith: (Smalltalk globals allClasses collect: [ :cls | cls name ]).

	innerWindow pane addChild: select.
	innerWindow height: 800.
	space := BlSpace new.
	space extent: 800@900.
	space root addChild: innerWindow.
	space show
]

{ #category : #space }
ToSandBox class >> example_spaceRootSkin [

	| space  |
	space := BlSpace new.
	space inspect.
	space toTheme: ToBeeDarkTheme new.
"	themeSwitcher := ToToggleButton new
		      labelText: 'Theme';
		      beLabelFirst.
	themeSwitcher switchBarOnElement: ((ToLabel text: ('Dark' asRopedText foreground: Color white)) ).
	themeSwitcher switchBarOffElement: ((ToLabel text: ('Light' asRopedText foreground: Color black)) ).
	themeSwitcher when: ToCheckableCheckedEvent do: [ :event | space toTheme: ( event current ifTrue: [ToBeeDarkTheme new] ifFalse: [ ToBeeLightTheme new]) ].
	space root addChild: themeSwitcher."
	space show
]

{ #category : #'still pressed hovered event' }
ToSandBox class >> example_stillHoveredEvent [

	| e count lab |
	e := ToElement new.
	e stillHoveredStartDelay: 200 milliSeconds.
	e layout: BlFrameLayout new.
	lab := ToLabel new text: 'Keep mouse inside'.
	lab constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter ].
	e addChild: lab.
	e size: 200 asPoint.
	e border: Color black.
	count := 0.
	e addEventHandler: (BlEventHandler
			 on: ToStillHoveredLookEvent
			 do: [ :event |
				 lab text: count asString asRopedText.
				 count := count + 1.
				 count > 50 ifTrue: [
					 event consumed: true.
					 count := 0 ] ]).
	e openInSpace
]

{ #category : #'still pressed hovered event' }
ToSandBox class >> example_stillPressedEvent [

	| e count lab color |
	e := ToElement new.
	e stillPressedStartDelay: 200 milliSeconds.
	e layout: BlFrameLayout new.
	lab := ToLabel new text: 'Keep mouse pressed here'.
	lab constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter ].
	e addChild: lab.
	e size: 200 asPoint.
	e border: Color black.
	count := 0.
	color := Color white alpha: 0.3.
	e addEventHandler: (BlEventHandler
			 on: ToStillPressedLookEvent
			 do: [ :event |
				 e background: color.
				 lab text: count asString asRopedText.
				 count := count + 1.
				 color := color darker.
				 count > 50 ifTrue: [
					 event consumed: true.
					 count := 0.
					 color := Color white alpha: 0.3 ] ]).
	e openInSpace
]

{ #category : #'switch button' }
ToSandBox class >> example_switchButton [

	| th  |
	th := ToSwitchButton new.
	th checked: true.
	th openInSpace
]

{ #category : #'switch button' }
ToSandBox class >> example_switchButton2 [

	| th sp |
	th := ToSwitchButton new.
	th checkedContainer addChild:
		((ToImage inner: (self iconNamed: #glamorousAccept)) formColor:
			 Color white).
	th uncheckedContainer addChild:
		((ToImage inner: (self iconNamed: #glamorousClose)) formColor:
			 Color white).

	th addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event | event current traceCr ]).
	sp := th openInSpace
]

{ #category : #'switch button' }
ToSandBox class >> example_switchButton3 [

	| but onLab offLab onHandleIm handler |
	but := ToSwitchButton new.
	but labelFirst: true.
	but flexible: true.
	but hMatchParent.
	but labelText: ('Something' asRopedText fontSize: 44).
	handler := BlEventHandler
		           on: ToElementLookEvent
		           do: [ :event | event traceCr ].
	but addEventHandler: handler.
	onLab := ToLabel text: ('In' asRopedText foreground: Color white; fontSize: 44).
	offLab := ToLabel text: ('Out' asRopedText foreground: Color white; fontSize: 44).
	onHandleIm := ToImage inner: (but iconNamed: #glamorousAccept).
	{
		onLab.
		offLab.
		onHandleIm } do: [ :e |
		e constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ] ].
	but checkedContainer addChild: onLab.
	but uncheckedContainer addChild: offLab.
	but handleCheckedBuilder: [ :handle :switch |
		handle addChild: onHandleIm ].
	but checked: true.
	"but disable."
	"but inspect."
	but openInSpace
]

{ #category : #'text field' }
ToSandBox class >> example_textField0 [

	| t |
	t := ToTextField new text: 'AAAA'.
	t inspect.
	t background: Color yellow.
	t openInSpace
]

{ #category : #'text field' }
ToSandBox class >> example_textFieldOnlyDigits [

	| t |
	t := ToTextField new inputFilter: AlbTextEditorDigitInputFilter new.
	t requestFocus.
	t openInSpace
]

{ #category : #'text field' }
ToSandBox class >> example_textFieldWithCRAction [

	| t  |
	t := ToTextField new tooltipString: 'Return to do the action'; withoutLineBreak.
	t addEditorShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination return;
			 action: [ :event | self inform: event currentTarget text asString ]
			 yourself).
	t openInInnerWindow 
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
		saveRequested accepted: true.
		text := saveRequested client text copy ].
	t whenCancelRequestedDo: [ :cancelRequested |
		cancelRequested client text: text copy ].

	t openInInnerWindow
]

{ #category : #'text field' }
ToSandBox class >> example_textFieldWithPlaceholder [

	| t text |
	t := ToTextField new withSaveCapability.
	t inspect.
	text := ''.
	t placeholderBuilder: [:thePlaceholder :myself | thePlaceholder addChild: (ToAttributedLabel text: (('Enter to accept' asRopedText) foreground: Color lightGray)) ].
	t whenSaveRequestedDo: [ :saveRequested |
		saveRequested client text ifNotEmpty: [ 
		saveRequested client saveResult: true.
		text := saveRequested client text copy ]].
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
	t placeholderBuilder: [ :placeholder :e |
		placeholder addChild: (ToAttributedLabel new
				 text: 'Enter text';
				 yourself) ].
	t whenSaveRequestedDo: [ :saveRequested |
		saveRequested accepted: true.
		text := saveRequested client text copy ].
	t whenSaveAcceptedDo: [ :saveAccepted |
		text := saveAccepted client text copy ].
	t whenCancelRequestedDo: [ :cancelRequested |
		cancelRequested client text: text copy ].
	t showPlaceholder.
	t openInSpace.
	t inspect
]

{ #category : #'text field' }
ToSandBox class >> example_textFieldWithSaveCapability [

	| t text |
	t := ToTextField new withSaveCapability; tooltipString: 'Return to accept'.
	text := ''.
	t text: text copy.
	t whenSaveRequestedDo: [ :saveRequested | 
		saveRequested accepted: true.
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

{ #category : #'text field' }
ToSandBox class >> example_textFields [

	| pane |
	pane := ToPane vertical.
	pane matchParent.
	10 timesRepeat: [ pane addChild: (ToTextField new text: (String loremIpsum: 50) ) ].
	10 timesRepeat: [ pane addChild: (ToTextField new) ].
	pane openInSpace
]

{ #category : #'choice menu' }
ToSandBox class >> example_themeChoiceButton [

	| win themeSelect space |
	space := BlSpace new.
	win := ToInnerWindow new title: 'Some host'.
	themeSelect := ToChoiceMenu new.
	themeSelect withStrictCheckingStrategy.
	themeSelect defaultSelectedIndex: 4.
	themeSelect dataToTextConverter: [ :assoc | assoc key ].
	themeSelect data addAll: {
			('Bee Light' -> ToBeeTheme new).
			('Bee Dark' -> ToBeeDarkTheme new).
			('Raw Light' -> ToRawTheme new).
			('Raw Dark' -> ToRawDarkTheme new) }.

	themeSelect addEventHandler: (BlEventHandler
			 on: ToChoiceChangedEvent
			 do: [ space toTheme: themeSelect selectedData value ]).

	space root addChild: themeSelect.
	space show
]

{ #category : #'choice menu' }
ToSandBox class >> example_themeChoiceButton2 [

	| win themeSelect space |
	space := BlSpace new.
	win := ToInnerWindow new title: 'Some host'.
	themeSelect := ToChoiceMenu new.
	themeSelect withStrictCheckingStrategy.
	themeSelect defaultSelectedIndex: 1.
	themeSelect dataToTextConverter: [ :assoc | assoc key ].
	themeSelect data addAll: {
			"('Bee Light' -> ToBeeTheme new).
			('Bee Dark' -> ToBeeDarkTheme new)."
			('Raw Light' -> ToRawTheme new).
			"('Raw Dark' -> ToRawDarkTheme new)" }.
themeSelect inspect.
	themeSelect addEventHandler: (BlEventHandler
			 on: ToChoiceChangedEvent
			 do: [ space toTheme: themeSelect selectedData value ]).

	space root addChild: themeSelect.
	space show
]

{ #category : #checkbox }
ToSandBox class >> example_themeSelectPlusCheckbox [

	| space themePane themeSelect chb |
	space := BlSpace new.
	space root layout: BlLinearLayout vertical.

	themePane := ToPane horizontal.

	themeSelect := ToChoiceMenu new.
	themeSelect width: 100.
	themeSelect dataToTextConverter: [ :assoc | assoc key ].
	themeSelect data addAll: {
			('Bee' -> ToBeeTheme).
			('Raw' -> ToRawTheme) }.
	themeSelect selectIndex: 2.

	themeSelect addEventHandler: (BlEventHandler
			 on: ToChoiceSelectedIndexChangeEvent
			 do: [ space toTheme: themeSelect selectedData value new ]).

	themePane addChild: themeSelect.
	space root addChild: themePane.

	chb := ToCheckbox new label: (ToLabel text: 'Swith primary').
	chb defaultSkin: ToCheckboxSkin new.
	chb inspect.

	space root addChild: chb.
	space show
]

{ #category : #'button-dep' }
ToSandBox class >> example_toAlbumAsButton [

	| but |
	but := ToAlbum new
		       text: 'Hello world'";
		       preventChildrenMouseEvents".
	but
		when: BlPrimaryClickEvent
		do: [ self inform: 'Click' ].
"	but background: Color blue."
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
	but addChild: (BlElement new
			 size: 30 @ 30;
			 yourself).
	but whenClickedDo: [ self inform: 'clicked' ].
	but background: (Color blue alpha: 0.3).
	but openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_toBasicButton2 [

	| but lab |
	lab := ToLabel new text: ('Button' asRopedText
			        fontSize: 40;
			        yourself).
	but := ToGeneralButton new.
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
	but addEventHandler: (ToSkinStateGenerator new target: but).
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

{ #category : #tooltip }
ToSandBox class >> example_toButtonWithElementTooltip [

	| but |
	but := ToButton new.
	but labelText: 'Button with tooltip'.
	but tooltipBuilder: [ :win :theElement |
		win root addChild: (BlElement new
				 background: Color random;
				 size: 70 @ 100;
				 yourself) ].
	but whenClickedDo: [ :ann | self inform: 'Button clicked' ].
	but openInInnerWindow
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButtonWithIconAndText [

	| but space icon |
	but := ToButton new.

	but label: (ToLabel text: 'Button').
	icon := ToImage new innerImage: ToThemeIcons iconSearchOutlined16x16.
	but icon: icon.
	"but effect: (BlGaussianShadowEffect
					color: Color green
					width: 4.5
					offset: 0 @ 0)."
	but effect: (BlBlurAboveEffect new radius: 20).
	but addEventHandler: (BlEventHandler
			 on: BlPrimaryClickEvent
			 do: [ :event | event currentTarget traceCr ]).

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

{ #category : #tooltip }
ToSandBox class >> example_toKeepTooltipWindowOnMouseLeave [

	| but  |
	self flag: 'not working as expected'.
	but := ToButton new.
	but closeTooltipWindowOnMouseLeave: false.
	but labelText: 'Button with tooltip text'.
	but tooltipText: ('This is a button', String cr, 'so, click on me...') asRopedText. 
	but whenClickedDo: [ :ann | self inform: 'Button clicked' ].
	but openInSpace
 
]

{ #category : #tooltip }
ToSandBox class >> example_toKeepTooltipWindowOnMouseLeaveWithEditableLabel [

	| but |
	self flag: 'not working as expected'.
	but := ToButton new.
	but labelText: 'Button with editable tooltip'.
	but closeTooltipWindowOnMouseLeave: false.
	but tooltipBuilder: [ :win :theElement |
		| lab |
		lab := ToLabel text: ' keep mouse pressed to edit ' asRopedText.
		lab
			beEditable;
			stillHoveredStartDelay: 800 milliSeconds;
			addEventHandler: (BlEventHandler
					 on: ToStillHoveredLookEvent
					 do: [ :event |
						 event consumed: true.
						 event currentTarget addEditorEvent: event ]).
		win root addChild: lab ].
	but whenClickedDo: [ :ann | self inform: 'Button clicked' ].
	but openInSpace
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
	lab withNullSkin.
	lab background: Color lightBlue.
	lab hMatchParent.
	lab isEditable: true.
	lab innerElement constraintsDo: [:c | c frame horizontal alignCenter].
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
	lab1 innerElement constraintsDo: [:c | c frame horizontal alignCenter].
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
	lab2 := ToAttributedLabel new
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
	lab1 innerElement constraintsDo: [:c | c frame horizontal alignCenter].

	lab2 innerElement constraintsDo: [:c | c frame horizontal alignCenter].
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

{ #category : #'button-dep' }
ToSandBox class >> example_toWidgetAsButton0 [

	| but |
	but := ToElement new.
	but
		when: BlPrimaryClickEvent
		do: [ self inform: 'Click' ].
	but background: Color blue.
	but size: 50 @ 50.
	but openInSpace
]

{ #category : #pane }
ToSandBox class >> example_twoSubPanesWithDivider [

	| pane e1 e2 |
	pane := ToPane horizontal.
	pane matchParent.
	e1 := ToElement new
		      margin: (BlInsets all: 0);
		      background: (Color random alpha: 0.2);
		      vMatchParent;
		      width: 100.
	e2 := ToElement new
		      margin: (BlInsets all: 0);
		      background: (Color random alpha: 0.2);
		      vMatchParent;
		      width: 200.
	pane addChildren: {
			e1.
			e2}.

	pane addDividers.
	pane openInSpace
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
	menu items last icon: (ToImage inner: (self iconNamed: #solidMenu)).
	menu addItem: (ToMenuItem new labelText: 'Export').
	grp := ToCheckableGroup new.
	right := ToCheckMenuItem new
		         labelText: 'Right';
		         id: #right.
	center := ToCheckMenuItem new
		          labelText: 'Center';
		          id: #center.
	left := ToCheckMenuItem new
		        labelText: 'Left';
		        id: #left.
	center checked: true.

	grp add: right button.
	grp add: center button.
	grp add: left button.

	menu addSeparator.
	menu addAllItems: {
			right.
			center.
			left }.
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

{ #category : #menu }
ToSandBox class >> example_withCustomMenuItems [

	| menu grp right center left textField sub lbl |
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

	grp addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 ('checked: ' , event checkedButtons asString , ' unchecked: '
				  , event uncheckedButtons asString) traceCr ]).

	menu addSeparator.

	lbl := ToAttributedLabel new text:
		       ('Radio button icon first' asRopedText
			        italic;
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
	grp addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 ('checked: ' , event checkedButtons asString , ' unchecked: '
				  , event uncheckedButtons asString) traceCr ]).

	menu addSeparator.

	lbl := ToAttributedLabel new text:
		       ('Radio button label first' asRopedText
			        italic;
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
		         flexible: true;
		         labelText: 'Right';
		         id: #right.
	center := ToRadioMenuItem new
		          beLabelFirst;
		          flexible: true;
		          labelText: 'Center';
		          id: #center.
	left := ToRadioMenuItem new
		        beLabelFirst;
		        flexible: true;
		        labelText: 'Left';
		        id: #left.
	center checked: true.
	grp addAll: {
			right.
			center.
			left }.

	grp addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 ('checked: ' , event checkedButtons asString , ' unchecked: '
				  , event uncheckedButtons asString) traceCr ]).

	center checked: true.

	menu addSeparator.
	lbl := ToAttributedLabel new text:
		       ('Radio buttons label first and justified' asRopedText
			        fontSize: 12;
			        italic;
			        foreground: (Color black alpha: 0.7)).
	menu addItem: (ToCustomMenuItem new
			 innerElement: lbl;
			 margin: (BlInsets
					  top: 2;
					  bottom: 4)).
	menu addAllItems: grp buttons.
	menu addSeparator.
	textField := ToTextField new
		             placeholderBuilder: [ :thePlaceholder :theElement |
			             thePlaceholder addChild:
					             (ToAttributedLabel new text:
							              ('Your name' asRopedText
								               foreground: Color lightGray;
								               yourself)) ];
		             withLineWrapping;
		             width: 200.
	menu addItem: (ToCustomMenuItem new innerElement: textField).
	menu addSeparator.
	sub := ToMenu new labelText: 'Save All'.
	sub addItem: (ToMenuItem new labelText: 'Locally').
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

{ #category : #select }
ToSandBox class >> selectWithEditingMultiSelection [

	| select phtext |
	select := ToSelect new.
	phtext := ('No Data' asRopedText
		           foreground: Color lightGray;
		           yourself)
		          fontSize: 24;
		          yourself.
	select popupMaxHeight: 600.
	select listElement placeholderMinHeight: 35.

	select listElement placeholderBuilder: [ :placeholder :e |
		| lab |
		placeholder layout alignCenter.
		lab := ToAttributedLabel text: phtext.
		placeholder addChild: lab ].
	
	select addEventHandler: (BlEventHandler
			 on: ToAlbumSaveAcceptedEvent
			 do: [ :event |
				 | d |
				 d := event client text asString asSymbol.
				 event client text: ''.
				event currentTarget data add: d.
				event currentTarget mode selectIndex: event currentTarget data size ]).

	select addEventHandler: (BlEventHandler
			 on: ToAlbumSaveRequestedEvent
			 do: [ :event |
				 | target idx |
				 target := event currentTarget.
				 idx := target data indexOf: event client text asString asSymbol.
				 event accepted: idx isZero.
				 idx > 0 ifTrue: [
					 event client text: ''.
					 target listElement selection selectIndex: idx ] ]).
	^ select
]

{ #category : #accessing }
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
