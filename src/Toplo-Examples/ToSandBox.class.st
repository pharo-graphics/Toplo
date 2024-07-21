Class {
	#name : #ToSandBox,
	#superclass : #Object,
	#category : #'Toplo-Examples'
}

{ #category : #bar }
ToSandBox class >> barConfigurationBoardFor: aBar [

	| confPane verticalSwitch wrappingSwitch scrollingSwitch autoDistributionSwitch sameWidthSwitch selectionAnimationSwitch selectOnMouseDownSwitch inspectButton |
	confPane := ToPane vertical.
	confPane padding: (BlInsets all: 5).
	confPane width: 250.
	confPane border: Color lightGray.

	inspectButton := ToButton new labelText: 'Inspect'.
	inspectButton whenClickedDo: [ aBar inspect ].
	confPane addChild: inspectButton.

	verticalSwitch := ToSwitchButton new labelText: 'Vertical'.
	verticalSwitch startFlexible: true.
	verticalSwitch hMatchParent.

	verticalSwitch addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event | aBar vertical: event current ]).

	confPane addChild: verticalSwitch.

	wrappingSwitch := ToSwitchButton new labelText: 'Wrapping'.
	wrappingSwitch startFlexible: true.
	wrappingSwitch hMatchParent.
	confPane addChild: wrappingSwitch.

	sameWidthSwitch := ToSwitchButton new labelText:
		                   'Uniform element width'.
	sameWidthSwitch startFlexible: true.
	sameWidthSwitch hMatchParent.
	sameWidthSwitch checked: false.
	confPane addChild: sameWidthSwitch.

	scrollingSwitch := ToSwitchButton new labelText: 'Scrolling'.
	scrollingSwitch startFlexible: true.
	scrollingSwitch hMatchParent.

	confPane addChild: scrollingSwitch.

	wrappingSwitch addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event |
				 | v |
				 v := event current.
				 aBar nodeWrapping: v.
				 sameWidthSwitch enabled: v.
				 scrollingSwitch disabled: v ]).

	sameWidthSwitch addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event |
				 | v |
				 v := event current.
				 aBar flowLineUniformWidth: v ]).

	scrollingSwitch addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event |
				 | v |
				 v := event current.
				 aBar nodeScrolling: v ]).

	autoDistributionSwitch := ToSwitchButton new labelText:
		                          'Auto-distribution'.
	autoDistributionSwitch startFlexible: true.
	autoDistributionSwitch hMatchParent.

	confPane addChild: autoDistributionSwitch.
	autoDistributionSwitch addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event |
				 | v |
				 v := event current.
				 aBar nodeAutoDistribution: v ]).

	selectionAnimationSwitch := ToSwitchButton new labelText:
		                            'Animate selection transition'.
	selectionAnimationSwitch startFlexible: true.
	selectionAnimationSwitch hMatchParent.

	confPane addChild: selectionAnimationSwitch.
	selectionAnimationSwitch addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event |
				 | v |
				 v := event current.
				 aBar selectionMode option animationDuration: (v
						  ifTrue: [ 200 milliSeconds ]
						  ifFalse: [ 0 milliSeconds ]).
				 aBar secondarySelectionMode option animationDuration: (v
						  ifTrue: [ 150 milliSeconds ]
						  ifFalse: [ 0 milliSeconds ]) ]).

	wrappingSwitch checked: true.

	selectOnMouseDownSwitch := ToSwitchButton new
		                           labelText: 'Select on mouse down';
		                           id: #selectOnMouseDownSwitch.
	selectOnMouseDownSwitch startFlexible: true.
	selectOnMouseDownSwitch hMatchParent.

	confPane addChild: selectOnMouseDownSwitch.
	selectOnMouseDownSwitch addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event |
			 aBar selectionMode selectOnMouseDown: event current ]).

	wrappingSwitch checked: true.

	aBar
		addEventHandlerOn: ToBarNodeVisibilityEvent
		do: [ :event |
		event invisibleNodes ifNotEmpty: [ :in | in traceCr ] ].

	^ confPane
]

{ #category : #bar }
ToSandBox class >> barDashBoardFor: aBar [

	| mainPane barPane confPane |
	mainPane := ToPane horizontal.
	mainPane matchParent.

	confPane := self barConfigurationBoardFor: aBar.
	confPane padding: (BlInsets all: 5).
	confPane width: 250.
	confPane border: Color lightGray.
	barPane := ToPane vertical.
	barPane matchParent.
	mainPane addChildren: {
			confPane.
			barPane }.

	barPane addChild: aBar.
	^ mainPane
]

{ #category : #select }
ToSandBox class >> buildSelectListElementIn: aSelectElement withIconProvider: anIconProviderClass [

	|  phtext icProvider styles iconDescs |
	aSelectElement listElement placeholderMinHeight: 35.
	aSelectElement listElement withRowNumbers.
	phtext := ('No Icon' asRopedText
		           foreground: Color lightGray;
		           yourself)
		          fontSize: 24;
		          yourself.
	aSelectElement listElement placeholderBuilder: [ :placeholder :e |
		| lab |
		placeholder layout alignCenter.
		lab := ToAttributedLabel text: phtext.
		placeholder addChild: lab ].

	icProvider := anIconProviderClass.
	styles := ToIconStyle allSubclasses asArray sort: [ :a :b |
		          a name < b name ].

	iconDescs := Array streamContents: [ :stream |
		             styles do: [ :style |
			             | s |
			             s := ('_' , style prefix , '_loaded') asSymbol.
			             (icProvider respondsTo: s) ifTrue: [
				             | iconNames |
				             iconNames := (icProvider perform: s) sort.
				             iconNames do: [ :n |
					             stream nextPut: (ToIconDescExample new
							              name: n;
							              style: style;
							              provider: icProvider;
							              yourself) ] ] ] ].

	aSelectElement listElement nodeBuilder: [ :node :iconDesc :holder  |
		| styleLab stylePane iclab iclabPane imPane iconStyle iconName icon |
		iconStyle := iconDesc style.
		iconName := iconDesc name.
		icon := iconDesc icon.
		node layout: BlLinearLayout horizontal.
		iclabPane := ToElement new layout: BlFrameLayout new.
		iclabPane vFitContent.
		iclabPane hMatchParent.
		stylePane := ToElement new layout: BlFrameLayout new.
		stylePane vFitContent.
		stylePane width: 60.
		iclab := ToLabel text: iconName.
		iclab constraintsDo: [ :c | c frame vertical alignCenter ].
		iclabPane addChild: iclab.
		styleLab := ToLabel text: iconStyle prefix.
		styleLab constraintsDo: [ :c | c frame vertical alignCenter ].
		stylePane addChild: styleLab.
		imPane := ToElement new layout: BlFrameLayout new.
		imPane fitContent.
		imPane withNullSkin.
		imPane background: Color veryVeryLightGray.
		imPane addChild: (icon
				 size: 24 asPoint;
				 yourself).
		node addChildren: {
				stylePane.
				iclabPane.
				imPane }.
		node childrenDo: [ :child |
			child constraintsDo: [ :c | c linear vertical alignCenter ] ] ].

	aSelectElement sieve dataFilter: [ :iconDesc :pattern |
		(iconDesc style prefix beginsWith: pattern caseSensitive: true) or: [
			iconDesc name beginsWith: pattern caseSensitive: true ] ].

	aSelectElement dataAccessor addAll: iconDescs
]

{ #category : #bar }
ToSandBox class >> checkingStrategyChooserFor: aCheckableBar [

	| buttons checkingStrategyContainer checkingStrategyGroup |
	checkingStrategyGroup := ToCheckableGroup new.
	buttons := OrderedCollection new.
	{ #Strict. #Weak. #None } do: [ :mode |
		| chb |
		chb := ToCheckbox new
			       labelText: mode asString;
			       id: mode.
		buttons add: chb ].

	checkingStrategyGroup registerAll: buttons.
	checkingStrategyGroup addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 | mode |
				 mode := event checkedList first id asSymbol.
				 mode = #Strict
					 ifTrue: [ aCheckableBar withStrictCheckingStrategy ]
					 ifFalse: [
						 mode = #Weak
							 ifTrue: [ aCheckableBar withWeakCheckingStrategy ]
							 ifFalse: [ aCheckableBar withoutCheckingStrategy ] ] ]).
	buttons first checked: true.
	checkingStrategyContainer := ToPane vertical.
	checkingStrategyContainer hMatchParent.
	checkingStrategyContainer addChild:
		(ToLabel text: 'Checking strategy').
	checkingStrategyContainer layout cellSpacing: 0.
	checkingStrategyContainer addChildren:
		checkingStrategyGroup registeredCheckables.
	^ checkingStrategyContainer
]

{ #category : #list }
ToSandBox class >> example_2ListsWithEditableAndContextMenu [

	| win1 win2 l1 l2 space |
	l1 := self listWithEditableAndContextMenu.
	l2 := self listWithEditableAndContextMenu.
	
	win1 := ToInnerWindow new.
	win1 pane addChild: l1.
	win2 := ToInnerWindow new.
	win2 pane addChild: l2.
	
	space := BlSpace new.
	space root addChild: win1.
	space root addChild: win2.
	space show

]

{ #category : #list }
ToSandBox class >> example_BasicListWithAllClasses3 [

	| l |
	l := ToListElement new nodeBuilder: [ :node :dataItem :holder |
		     | icn lab |
		     icn :=  dataItem hasComment
			            ifTrue: [ #class ]
			            ifFalse: [ #uncommentedClass ].
		     lab := ToLabel new
			            text: dataItem name;
			            beEditable;
			            yourself.
		     node addChild: (ToLabeledIcon new
				      label: lab;
				      icon: (ToImage inner: (Smalltalk ui icons iconNamed: icn));
				      startInterspace: 10;
				      hMatchParent) ].
	l inspect.
	l addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :evt | evt traceCr ]).

	l withRowNumbers.
	l dataAccessor addAll: Smalltalk globals allClasses.
	l selecter selectIndexes: #(10 12 3).

	l innerContainer requestFocus.
	l openInInnerWindow
]

{ #category : #transitions }
ToSandBox class >> example_BoundsAndBackgroundTransition [

	| e |
	e := BlElement new.
	e enqueueTask: (BlTaskAction new action: [
			 | anim |
			 anim := BlParallelAnimation withAll: {
					         (ToPointTransition new
						          from: 10 @ 10;
						          to: 300 @ 200;
						          duration: 1 seconds;
						          onStepDo: [ :aSize :target | target size: aSize ]).
					         (ToPointTransition new
						          from: 10 @ 10;
						          to: 100 @ 80;
						          duration: 2 seconds;
						          onStepDo: [ :aPosition :target |
							          target position: aPosition ]).
					         (BlColorTransition new
						          duration: 1 seconds;
						          from: Color veryLightGray;
						          to: Color black;
						          onStepDo: [ :aColor :target |
							          target background: aColor ]) }.
			 anim onFinishedDo: [ e background: Color red ].
			 "anim delay: 1 seconds."
			 e addAnimation: anim ]).
	e openInSpace
]

{ #category : #transitions }
ToSandBox class >> example_BoundsTransition [

	| e anim |
	e := BlElement new.
	e size: 30 @ 30.
	e background: Color blue.
	anim := ToBoundsTransition new
		        from: (10 @ 10 extent: 10 @ 10);
		        to: (300 @ 100 extent: 300 @ 400);
		        duration: 3000 milliSeconds;
		        onStepDo: [ :aRectangle :target |
			        target position: aRectangle origin.
			        target size: aRectangle extent ].
	anim onFinishedDo: [ e background: Color red ].
	e addAnimation: anim.
	anim delay: 100 milliSeconds.

	e openInSpace
]

{ #category : #transitions }
ToSandBox class >> example_BoundsTransitionWithParallelAnimation [

	| e |
	e := BlElement new.
	e size: 30 @ 30.
	e background: Color blue.
	e enqueueTask: (BlTaskAction new action: [
			 | anim |
			 anim := BlParallelAnimation withAll: {
					         (ToPointTransition new
						          from: 10 @ 10;
						          to: 300 @ 100;
						          duration: 6 seconds;
						          onStepDo: [ :aPosition :target |
							          target position: aPosition ]).
					         (ToPointTransition new
						          from: 10 @ 10;
						          to: 300 @ 400;
						          duration: 3 seconds;
						          onStepDo: [ :aSize :target | target size: aSize ]) }.
			 anim onFinishedDo: [ e background: Color red ].
			 e addAnimation: anim ]).
	e openInSpace
]

{ #category : #'toggle button' }
ToSandBox class >> example_ButtonTurnedAsToggleButton [

	| toggle |
	ToTheme cleanUp.
	toggle := ToButton new label: (ToLabel text: 'Regular button turned as Toggle button').
	toggle checkable: true.
	toggle icon: (ToImage new innerImage: (self iconNamed: #solidMenu)).
	toggle checked: false.
	toggle openInInnerWindow.
	toggle inspect
]

{ #category : #'button-dep' }
ToSandBox class >> example_CheckBoxAndButtonWithDefaultStyleSheet [

	| chk btn space |
	ToTheme cleanUp.

	chk := ToCheckbox new.
	chk labelText: 'OK'.
	btn := ToButton new.
	btn labelText: 'Erase all your Pharo images?'.
	btn iconImage: ToThemeIcons searchOutlined16x16.
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
	btn iconImage: ToThemeIcons searchOutlined16x16.
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
			 on: ToSkinEvent
			 do: [ :evt | evt target = chb ifTrue: [ evt traceCr ] ]).
	chb whenClickedDo: [ :event |
		event currentTarget isChecked traceCr.
		event traceCr ].
	chb checked: true.
	chb openInInnerWindow.
	chb inspect
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
			       beEndToStart;
			       labelText: idx asString;
			       id: idx asString.
		buttons add: chb ].
	buttons second checked: true.
	group registerAll: buttons.
	group addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 ('checked: ' , event checkedList asString , ' unchecked: '
				  , event uncheckedList asString) traceCr ]).

	container := ToElement new.
	container constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChildren: group registeredCheckables.
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
			       beEndToStart;
			       labelText: idx asString;
			       id: idx asString.
		buttons add: chb ].
	buttons second checked: true.
	group registerAll: buttons.
	group addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 ('checked: ' , event checkedList asString , ' unchecked: '
				  , event uncheckedList asString) traceCr ]).

	container := ToElement new.
	container constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChildren: group registeredCheckables.
	container openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_CheckboxGroupAndWeakStrategy [

	| group container buttons |
	group := ToCheckableGroup new.
	group withWeakCheckingStrategy.
	buttons := OrderedCollection new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new
			       beEndToStart;
			       labelText: idx asString;
			       id: idx asString.
		buttons add: chb ].
	buttons second checked: true.
	group registerAll: buttons.
	group addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 ('checked: ' , event checkedList asString , ' unchecked: '
				  , event uncheckedList asString) traceCr ]).

	container := ToElement new.
	container constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChildren: group registeredCheckables.
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
ToSandBox class >> example_CheckboxStartFlexible [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new
		       startFlexible: true;
		       hMatchParent;
		       labelText: 'Checkbox' asString.
	"chb inspect."
	chb openInInnerWindow
]

{ #category : #checkbox }
ToSandBox class >> example_CheckboxStartFlexibleWithGroup [

	| group container buttons |
	group := ToCheckableGroup new.
	buttons := OrderedCollection new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new
			       startFlexible: true;
			       hMatchParent;
			       beEndToStart;
			       labelText: idx asString;
			       id: idx asString.
		buttons add: chb ].
	buttons second checked: true.
	group registerAll: buttons.
	group addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 ('checked: ' , event checkedList asString , ' unchecked: '
				  , event uncheckedList asString) traceCr ]).

	container := ToElement new.
	container background: Color veryLightGray.
	container matchParent.

	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChildren: group registeredCheckables.
	container openInSpace
]

{ #category : #checkbox }
ToSandBox class >> example_CheckboxUnchecked [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new
				startInterspace: 10;
		       label: (ToLabel text: 'Checkbox');
		       id: 1 asString.
	chb openInInnerWindow
]

{ #category : #checkbox }
ToSandBox class >> example_CheckboxVertical [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new label: (ToLabel text: 'Checkbox').
	chb beVertical.
	chb addEventHandler: (BlEventHandler
			 on: ToSkinEvent
			 do: [ :evt | evt target = chb ifTrue: [ evt traceCr ] ]).
	chb checked: true.
	chb openInInnerWindow.
	chb inspect
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
		chb beStartToEnd.
		group register: chb ].

	group registeredCheckables second checked: true.
	container := ToElement new.
	container matchParent.
	container layout: BlLinearLayout horizontal.
	container addChildren: group registeredCheckables.
	group addEventHandlerOn: ToCheckableGroupChangedEvent do: [ :event |
		('checked: ' , event checkedList asString , ' unchecked: '
		 , event uncheckedList asString) traceCr ].
	container openInInnerWindow
]

{ #category : #checkbox }
ToSandBox class >> example_CheckboxWithExactWidth [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new
		       startInterspace: 100;
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
	album styler: (BlPharoCodeStyler new
			 classOrMetaClass: self class;
			 yourself).
	album text: text copy.
	album withSaveCapability.
	album withRowNumbers.
	album whenSaveRequestedDo: [ :saveRequested |
		saveRequested accepted: true ].
	album whenCancelRequestedDo: [ :cancelRequested |
		cancelRequested client text: text copy ].

	menuBuilder := [ :menu :request |
	               | element |
	               element := request currentTarget.
	               menu addItem: (ToMenuItem new
			                labelText: 'Select all';
			                whenClickedDo: [ :event |
				                element selecter
					                all;
					                apply ];
			                yourself).
	               menu addItem: (ToMenuItem new
			                labelText: 'Copy';
			                whenClickedDo: [ :event |
				                element editor copySelected ];
			                yourself).
	               menu addItem: (ToMenuItem new
			                labelText: 'Cut';
			                whenClickedDo: [ :event |
				                element editor cutSelected ];
			                yourself).
	               menu addItem: (ToMenuItem new
			                labelText: 'Paste';
			                whenClickedDo: [ :event | element editor paste ];
			                yourself).
	               menu addSeparator.
	               menu addItem: (ToMenuItem new
			                labelText: 'Accept';
			                whenClickedDo: [ :event | element requestSave ];
			                yourself).
	               menu addSeparator.
	               menu addItem: (ToMenuItem new
			                labelText: 'Cancel';
			                whenClickedDo: [ :event | element requestCancel ];
			                yourself) ].
	album contextMenu: menuBuilder.
	album cursorColor: Color black.
	album openInSpace
]

{ #category : #list }
ToSandBox class >> example_EditableList2WithAllClassesNames [

	| l vscrollBar space innerWin |
	l := ToListElement new.
	l beVertical.
	l
		nodeFactory: [ ToListClassNodeExample new ];
		nodeBuilder: [ :node :dataItem :holder |
			node forClassNameAssoc: dataItem ];
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
	vscrollBar attachTo: l innerContainer.
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

{ #category : #list }
ToSandBox class >> example_FilterOnList2WithStatesOfAmerica [

	| listElement pane filterField data selector |
	pane := ToPane new
		        beVertical;
		        matchParent.
	filterField := ToTextField new.
	listElement := ToListElement new.
	data := self statesOfAmerica.

	listElement margin: (BlInsets all: 2).
	filterField margin: (BlInsets all: 2).

	selector := ToObservableCollectionFilter new.
	listElement dataAccessor addAll: data.

	selector onInstalledIn: listElement dataAccessor.

	filterField addEventHandler: (BlEventHandler
			 on: AlbTextEditedEvent
			 do: [
				 | pattern |
				 pattern := filterField text asString.
				 selector pattern: pattern ]).

	listElement dataAccessor addEventHandler: (BlEventHandler
			 on: ToObservableCollectionFilterResultEvent
			 do: [ :event |
				 listElement selecter selectOnlyIndexes:
					 event filter selectedIndexes ]).

	listElement placeholderBuilder: [ :ph :e |
		| lab |
		lab := (ToLabel text: 'No Data') foreground: Color lightGray;
				        fontSize: 24; yourself.
		lab matchParent.
		ph addChild: lab ].

	"handler inspect."
	pane addChild: listElement.
	pane addChild: filterField.
	pane openInSpace
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
	l := ToListElement new nodeBuilder: [ :node :dataItem :holder |
		     node constraintsDo: [ :c |
			     c horizontal fitContent.
			     c vertical fitContent ].
		     node addChild: (ToElement new
				      size: 70 @ 50;
				      background: dataItem) ].
	l background: Color yellow.
	l beHorizontal.
	l dataAccessor addAll: Color indexedColors.
	space := BlSpace new.
	space root addChild: l.
	space show
]

{ #category : #list }
ToSandBox class >> example_HugeIntegerList [

	| l nbItems vscrollBar space |
	nbItems := 50000.
	l := ToListElement new.
	l dataAccessor addAll: (1 to: nbItems).
	l nodeBuilder: [ :node :anInteger |
		node addChild:
			(BlTextElement new text: anInteger asString asRopedText) ].
	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
		c ignoreByLayout.
		c margin: (BlInsets left: 10).
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	vscrollBar attachTo: l innerContainer.

	space := BlSpace new
		         extent: 100 @ 600;
		         title: 'List with ', nbItems asString, ' integers'.

	space root addChild: l.
	space root addChild: vscrollBar.
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
ToSandBox class >> example_LabeledIconlWithIconAndText_interspace [

	| but |
	but := self example_LabeledIconlWithIconAndText.
	but border: Color black.
	but startInterspace: 100.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText_labelFirst [

	| but  |
	but := self example_LabeledIconlWithIconAndText.
	but endToStart: true.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText_labelFirst_startFlexible [

	| but  |
	but := self example_LabeledIconlWithIconAndText_labelFirst.
	but startFlexible: true.
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
ToSandBox class >> example_LabeledIconlWithIconAndText_labelFirst_vertical_startFlexible [

	| but  |
	but := self example_LabeledIconlWithIconAndText_labelFirst_vertical.
	but startFlexible: true.
	but matchParent.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText_startFlexible [

	| but  |
	but := self example_LabeledIconlWithIconAndText.
	but startFlexible: true.
	but border: Color red.
	but vFitContent.
	but hMatchParent.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText_startFlexible_inFitContent [

	| but container |
	container := ToElement new.
	container hMatchParent.
	container vFitContent.
	container layout: BlLinearLayout vertical.
	but := self labeledIconlWithIconAndText.
	but startFlexible: true.
	but border: Color red.
	but vFitContent.
	but hMatchParent.
	container addChild: but.
	container openInInnerWindow.
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
	but startInterspace: 20.
	^ but
]

{ #category : #list }
ToSandBox class >> example_List2WithAllClassesMono [

	| l |
	l := ToListElement new.
	l selectionMode beSingleSelection.
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
	l selectionMode disable.
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
		(ToListSelectionHistoryEventHandlerExample new historyList:
			 historyList).
	statesList addEventHandler: (BlEventHandler
			 on: ToListSelectionCommandAppliedEvent
			 do: [ :event | event traceCr ]).

	pane
		matchParent;
		addDividers.
	pane openInInnerWindow
]

{ #category : #list }
ToSandBox class >> example_ListOneClass [

	| l |
	l := ToListElement new nodeBuilder: [ :node :dataItem  :holder |
		     node addChild: (ToCheckbox new
				      labelText: dataItem name;
				      startInterspace: 10;
				      hMatchParent) ].
	l dataAccessor addAll: { Smalltalk globals allClasses first }.
	l inspect.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWith6Elements [

	| l |
	l := ToListElement new.
	l dataAccessor addAll: ((1 to: 6) collect: [ :i | i asString ]).
	l selecter selectIndex: 4.
	l openInInnerWindow
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClasses [

	| l |
	l := ToListElement new.
	l dataAccessor addAll:
		(Smalltalk globals allClasses collect: [ :cls | cls name ]).
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClasses3 [

	| l |
	l := ToListElement new nodeBuilder: [ :node :dataItem  :holder |
		     | icn lab |
		     icn := dataItem hasComment
			            ifTrue: [ #class ]
			            ifFalse: [ #uncommentedClass ].
		     lab := ToLabel new
			            text: dataItem name;
			            beEditable;
			            yourself.
		     node addChild: (ToLabeledIcon new
				      label: lab;
				      icon: (ToImage inner: (Smalltalk ui icons iconNamed: icn));
				      startInterspace: 10;
				      hMatchParent) ].
	l selectionMode option animationDuration: 200 milliSeconds.
	l secondarySelectionMode option animationDuration: 150 milliSeconds.
	l dataAccessor addAll: Smalltalk globals allClasses.
	l selecter selectIndex: 3.
	l withRowNumbers.
	"l requestFocus."
	l openInInnerWindow
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClasses4 [

	| l |
	l := ToListElement new nodeBuilder: [ :node :dataItem :holder |
		     | cbox |
		node traceCr.
		     cbox := ToCheckbox new.
		     cbox
			     labelText: dataItem name;
			     startInterspace: 10;
			     hMatchParent;
			     startFlexible: true.
		    " node userData at: #handler put: (holder listElement
				      addEventHandlerOn: ToListPrimarySelectionChangedEvent
				      do: [ :event |
					      cbox traceCr.
					      cbox checked:
						      (holder selectionModel containsIndex: holder position) ])."
		     cbox checked: holder isSelected.
		     node addChild: cbox ].
	"l nodeUnbuilder: [ :node :dataItem :holder | node removeEventHandler: (node userData at: #handler) ]."
	l selectionMode selectOnMouseDown: true.
	l
		addEventFilterOn: ToListPrimarySelectionChangedEvent
		do: [ :event | 'list selection changed' traceCr ].
	l selectionMode option masked: true.
	l dataAccessor addAll: Smalltalk globals allClasses.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesAndTraitsSorted [

	| l vscrollBar space |
	l := ToListElement new nodeBuilder: [ :node :dataItem :holder |
			node ensureCanManageSkin.
		     node addChild: (ToClassNameViewExample new
				      class: dataItem position: holder position;
				      yourself) ].
	l withRowNumbers.
	l dataAccessor addAll:
		(Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]).
	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
		c ignoreByLayout.
		c margin: (BlInsets left: 10).
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	vscrollBar attachTo: l innerContainer.

	space := BlSpace new.
	space root addChild: l.
	space root addChild: vscrollBar.
	space show
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesAsButton [

	| l |
	l := ToListElement new nodeBuilder: [ :node :dataItem :holder |
		     node addChild: (ToButton new
				      labelText: dataItem name;
				      hMatchParent) ].
	l dataAccessor addAll: Smalltalk globals allClasses.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllMethods [

	| l nbItems vscrollBar space |
	nbItems := 10000.
	l := ToListElement new.
	l withRowNumbers.
	l dataAccessor addAll: SystemNavigation default allMethods.
	l nodeBuilder: [ :node :aMethod |
		node addChild:
			(BlTextElement new text: aMethod name asString asRopedText) ].
	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
		c ignoreByLayout.
		c margin: (BlInsets left: 10).
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	vscrollBar attachTo: l innerContainer.

	space := BlSpace new.

	space root addChild: l.
	space root addChild: vscrollBar.
	space show
]

{ #category : #list }
ToSandBox class >> example_ListWithEditableAndContextMenu [

	| l |
	l := self listWithEditableAndContextMenu.
	l openInInnerWindow
]

{ #category : #list }
ToSandBox class >> example_ListWithIndexedColors [

	| l vscrollBar space |
	l := ToListElement new nodeBuilder: [ :node :dataItem :holder |
		     node addChild: (ToLabel new
				      text: dataItem asString asRopedText;
				      hMatchParent;
				      background: dataItem) ].
	l dataAccessor addAll: Color indexedColors.

	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
		c ignoreByLayout.
		c margin: (BlInsets right: 2).
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	vscrollBar attachTo: l innerContainer.
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
		        nodeBuilder: [ :node :dataItem :holder |
			        | title blContent |
			        title := ToLabel new
				                 id: #title;
				                 text: dataItem;
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
	list selectionMode option beneath: false.
	list dataAccessor addAll: (1 to: 1000).
	list openInSpace
]

{ #category : #list }
ToSandBox class >> example_NodeContainerWithStatesOfAmerica [

	| l |
	l := ToBarElement new.
	l addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :evt | evt traceCr ]).
	l horizontal: true.
	l dataAccessor addAll: self statesOfAmerica.
	l inspect.
	l openInSpace
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
	list inspect.
	list
		nodeHolderClass: ToPicsumPhotosGalleryImageHolder;
		nodeFactory: [ ToPicsumPhotosGalleryImageNode new ];
		nodeBuilder: [ :node :dataItem :holder |
			node labelString: dataItem id ].
	list selectionMode option
		grouped: false;
		beneath: false;
		triggerSelectionState: true;
		elementBuilder: [ ToPicsumPhotosGallerySelectionElement new ].

	[
	| allImagesData |
	allImagesData := (STONJSON fromString:
		                  'https://picsum.photos/list' asUrl
			                  retrieveContents) collect: [ :aDictionary |
		                 ToPicsumPhotosGalleryImageData fromDictionary:
			                 aDictionary ].
	allImagesData sort: [ :a :b | a id > b id ].
	list dataAccessor addAll: allImagesData ] fork.

	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
		c ignoreByLayout.
		c margin: (BlInsets left: 10).
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	vscrollBar attachTo: list innerContainer.

	space := BlSpace new
		         extent: 200 @ 600;
		         title: 'picsum.photos Gallery'.

	space root addChild: list.
	space root addChild: vscrollBar.
	space show
]

{ #category : #transitions }
ToSandBox class >> example_PointTransition [

	| e |
	e := BlElement new.
	e size: 30 @ 30.
	e background: Color blue.
	e enqueueTask: (BlTaskAction new action: [
			 | anim |
			 anim := ToPointTransition new.
			 anim from: 10 @ 10.
			 anim to: 300 @ 400.
			 anim duration: 2 seconds.
			 anim onStepDo: [ :aPosition :target | target position: aPosition ].
			 anim delay: 200 milliSeconds.
			 e addAnimation: anim ]).
	e openInSpace
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

{ #category : #transitions }
ToSandBox class >> example_RawParallelTransition [

	| e |
	e := BlElement new.
	e background: Color red.
	e enqueueTask: (BlTaskAction new action: [
			 | anim |
			 anim := ToRawParallelTransition new.
			 anim addAll: {
					 (BlNumberTransition new
						  duration: 1 second;
						  from: 10;
						  to: 100).
					 (BlNumberTransition new
						  duration: 800 milliSeconds;
						  from: 10;
						  to: 300).
					 (BlNumberTransition new
						  duration: 500 milliSeconds;
						  from: 20;
						  to: 100).
					 (BlNumberTransition new
						  duration: 2 seconds;
						  from: 20;
						  to: 80) }.
			 "anim duration: 2 second."
			 anim onStepDo: [ :anArray |
				 e position: anArray first @ anArray second.
				 e size: anArray third @ anArray fourth ].
			 anim delay: 200 milliSeconds.
			 e addAnimation: anim ]).

	e openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectAntDesignIconMonoFiltrable [

	| select   |
	select := ToSingleSelectElement new.
	self buildSelectListElementIn: select withIconProvider: ToAntDesignIconProvider.

	select filtrable: true.

	select dataViewBuilder: [ :dataItemView :iconDesc |
		dataItemView selectedDataTextField text: iconDesc style prefix , ' ' , iconDesc name.
		dataItemView addChild: ((iconDesc icon size: 48 asPoint) background: Color veryLightGray) ].
	
	select fakeDataItem: select dataAccessor first.

	select hMatchParent.
	select placeholderText:
		('Select an icon' asRopedText foreground: Color red).

	select inputTextField requestFocus.
	select openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectAntDesignIconMultiFiltrable [

	| select   |
	select := ToMultiSelectElement new.
	self buildSelectListElementIn: select withIconProvider: ToAntDesignIconProvider.

	select filtrable: true.

	select nodeBuilder: [ :node :iconDesc :holder |
		node addChild: ((iconDesc icon size: 48 asPoint) background: Color veryLightGray ) ].
	select fakeDataItem: select dataAccessor first.
	select hMatchParent.
	select placeholderText:
		('Select icons' asRopedText foreground: Color red).

	select inputTextField requestFocus.
	select openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMaterialDesignIconMonoFiltrable [

	| select   |
	select := ToSingleSelectElement new.
	self buildSelectListElementIn: select withIconProvider: ToMaterialDesignIconProvider.

	select filtrable: true.

	select dataViewBuilder: [ :dataItemView :iconDesc |
		dataItemView selectedDataTextField text: iconDesc style prefix , ' ' , iconDesc name.
		dataItemView addChild: ((iconDesc icon size: 48 asPoint) background: Color veryLightGray) ].
	
	select fakeDataItem: select dataAccessor first.

	select hMatchParent.
	select placeholderText:
		('Select an icon' asRopedText foreground: Color red).

	select inputTextField requestFocus.
	select openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMaterialDesignIconMultiFiltrable [

	| select |
	select := ToMultiSelectElement new.
	select nodeWrapping: false.
	select keepPickOrder: true.
	self
		buildSelectListElementIn: select
		withIconProvider: ToMaterialDesignIconProvider.

	select filtrable: true.

	select nodeBuilder: [ :node :iconDesc :holder |
		node addChild:
			((iconDesc icon size: 48 asPoint) background: Color veryLightGray) ].
	select fakeDataItem: select dataAccessor first.
	select hMatchParent.
	select placeholderText:
		('Select icons' asRopedText foreground: Color red).

	select inputTextField requestFocus.
	select openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMonoFiltrable [

	| select innerWindow phtext |
	select := ToSingleSelectElement new.
	select inspect.
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
	"select selecter selectIndex: 2."
	select placeholderText:
		('Select a state' asRopedText foreground: Color red).
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
ToSandBox class >> example_SelectMonoNotFiltrable [

	| select innerWindow |
	select := ToSingleSelectElement new.
	select inspect.
	select filtrable: false.
	select dataAccessor addAll: self statesOfAmerica.
	select placeholderText: ('Select a state' asRopedText foreground: Color red).
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select listElement withRowNumbers.
	select width: 300.
	select position: 50 @ 50.
	innerWindow pane addChild: select.
	innerWindow height: 500.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrable [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select nodeWrapping: true.
	select barElement selectionMode option masked: true.
	select barElement selectionMode option animationDuration:
		200 milliSeconds.
	select listElement withRowNumbers.
	select innerContainer nodeBuilder: [ :node :dataItem :holder |
		node addChild: (ToTagElement new label: (ToAttributedLabel new
					  text: dataItem asString;
					  foreground: Color random;
					  freeze;
					  yourself)) ].
	select hideSelected: false.
	select dataAccessor addAll: self statesOfAmerica.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderText:
		('Select states' asRopedText foreground: Color red).
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select position: 50 @ 10.
	select width: 300.
	select selecter selectIndex: 2.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace.
	^ select
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableAutoDistribution [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select inspect.
	select nodeWrapping: false.
	select dataAccessor addAll: self statesOfAmerica.
	select nodeAutoDistribution: true.

	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderText:
		('Select states' asRopedText foreground: Color red).
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select hMatchParent.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableAutoDistributionWithMax [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select inspect.
	select maxSelectedCount: 4.
	select nodeWrapping: false.
	select nodeAutoDistribution: true.
	select hideSelected: false.
	select dataAccessor addAll: self statesOfAmerica.

	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderText:
		('Select states' asRopedText foreground: Color red).
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select hMatchParent.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableNoWrapping [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select maxSelectedCount: 6.
	select nodeWrapping: false.
	select hideSelected: false.
	select dataAccessor addAll: self statesOfAmerica.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderText:
		('Select states' asRopedText foreground: Color red).
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select hMatchParent.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableNoWrappingKeepPickOrder [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select keepPickOrder: true.
	select nodeWrapping: false.
	select hideSelected: false.
	select dataAccessor addAll: self statesOfAmerica.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderText:
		('Select states' asRopedText foreground: Color red).
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select hMatchParent.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableNotWrappingAutoDistribution [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select inspect.
	select nodeWrapping: false.
	select nodeAutoDistribution: true.
	select hideSelected: false.
	select dataAccessor addAll: self statesOfAmerica.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderText:
		('Select states' asRopedText foreground: Color red).
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select hMatchParent.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableScrolling [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select inspect.
	select nodeScrolling: true.
	select nodeWrapping: false.
	select hideSelected: false.
	select dataAccessor addAll: self statesOfAmerica.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderText:
		('Select states' asRopedText foreground: Color red).
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select hMatchParent.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableWithHideSelected [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select listElement selectionMode option elementBuilder: [
		ToListPrimarySelectionElement new
			withNullSkin;
			yourself ].
	select inspect.
	select hideSelected: true.
	select dataAccessor updateAllWith: self statesOfAmerica.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderText:
		('Selected are removed' asRopedText foreground: Color veryLightGray).
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select hMatchParent.
	select listElement withRowNumbers.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableWithHideSelected2 [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select hideSelected: true.
	select dataAccessor addAll: {'Apples'.'Nails'. 'Bananas'. 'Helicopter'}.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderText:
		('Selected are removed' asRopedText foreground: Color veryLightGray).
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select width: 300.
	select position: 50 @ 10.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableWithMax [

	| select  |
	select := self example_SelectMultiFiltrable.
	select hExact: 200.
	select maxSelectedCount: 4
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableWrappingAutoDistribution [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select inspect.
	"select maxSelectedCount: 6."
	select nodeWrapping: true.
	select nodeAutoDistribution: true.
	select hideSelected: false.
	select dataAccessor addAll: self statesOfAmerica.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderText:
		('Select states' asRopedText foreground: Color red).
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select hMatchParent.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiNotFiltrable [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select inspect.
	select maxSelectedCount: 4.
	select filtrable: false.
	select nodeWrapping: true.
	select dataAccessor addAll: self statesOfAmerica.
	select placeholderText:
		('Select states' asRopedText foreground: Color red).
	select listElement nodeBuilder: [ :node :dataItem :holder |
		node addChild: (ToLabel text: dataItem asString) hMatchParent ].
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select hExact: 300.
	select position: 50 @ 50.

	innerWindow pane addChild: select.
	innerWindow height: 500.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiNotFiltrableWithGroups [

	| select innerWindow phtext |
	select := ToMultiSelectElement new.
	select inspect.
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

	select filtrable: false.
	self statesOfAmericaWithGroups do: [ :assoc |
		select dataAccessor add: assoc key.
		select dataAccessor itemCount.
		select setGroupIndex: select dataAccessor itemCount.
		select dataAccessor addAll: assoc value ].

	select placeholderText:
		('Select a state' asRopedText foreground: Color red).
	innerWindow := ToInnerWindow new.
	select windowManager anchorRoot: innerWindow root.
	select width: 300.
	select position: 50 @ 50.
	select inputTextField requestFocus.
	innerWindow pane addChild: select.
	innerWindow height: 500.
	innerWindow openInSpace
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
	sieve inspect.
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
	listElement dataAccessor addAll: data.

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
	filterField placeholderBuilder: [ :placeholder :e |
		placeholder addChild:
			((ToAttributedLabel text: ' Method name filter')
				 foreground: Color lightGray;
				 yourself) ].

	sieve := ToListElementSieve new.
	sieve onInstalledIn: listElement.
	listElement dataAccessor addAll:
		(Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]).

	sieve dataFilter: [ :aCompiledMethod :aPattern |
		aCompiledMethod selector beginsWith: aPattern caseSensitive: true ].


	listElement nodeBuilder: [ :node :dataItem :holder |
		node addChild: (ToLabel new text: dataItem printString) ].

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
		ph layout alignCenter.
		lab := (ToAttributedLabel text: 'No Data') 
			      
				       foreground: Color lightGray;
				       fontSize: 24;
				       yourself.
		ph addChild: lab ].

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


	listElement nodeBuilder: [ :node :dataItem :holder |
		node addChild: (ToLabel new text: dataItem printString) ].

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
		ph layout alignCenter.
		lab := (ToAttributedLabel text: 'No Data') 
				       foreground: Color lightGray;
				       fontSize: 24;
				       yourself.
		ph addChild: lab ].
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
	listElement selectionMode beSingleSelection
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


	listElement nodeBuilder: [ :node :dataItem :holder |
		node addChild: (ToLabel new text: dataItem printString) ].

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
		ph layout alignCenter.
		lab := (ToAttributedLabel text: 'No Data') 
				       foreground: Color lightGray;
				       fontSize: 24;
				       yourself.
		ph addChild: lab ].
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

{ #category : #'look event' }
ToSandBox class >> example_SkinEventTrace [

	| but |
	but := ToButton new.
	but icon: (ToImage new innerImage: (self iconNamed: #solidMenu)).
	but label: (ToLabel text: 'Button with label').
	but addEventHandler: (BlEventHandler
			 on: ToSkinEvent
			 do: [ :evt | evt target = but ifTrue: [ evt traceCr ] ]).
	but stillPressedStartDelay: 3000 milliSeconds.
	but inspect.
	but openInSpace
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
	b localTheme: ToBeeTheme new.

	"b := ToToggleButton new."
	"b stampWith: #primary. "
	"b stampWith: #'large-sizing'."
	"b stampWith: #'small-sizing'."

	"b stampWith: #vertical."
	b addStamp: #'icon-first'.
	b addStamp: #'label-first'.
	"b withStamp: #'interspace-1' -> 300."
	
	"b stampWith: #circle."
	"b stampWith: #round."
	"b stampWith: #link. "
	"b stampWith: #danger."
	"b stampWith: #dashed."
	b
		iconImage: ToThemeIcons searchOutlined16x16;
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
		iconImage: ToThemeIcons searchOutlined16x16;
		labelText: 'Close'.
	"b labelFirst: true."
	"b checked: nil."
	"b withIndeterminate: true."
	"b innerElement border: (BlBorder paint: Color black)."

	(b openInSpace) localTheme: ToBeeDarkTheme new.
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
	topBar := ToMenuBar new
		          beHorizontal;
		          hMatchParent;
		          vFitContent.
	topBar layout cellSpacing: 10.

	themeSwitcher := ToChoiceMenu new.
	themeSwitcher width: 150.
	themeSwitcher data addAll: {
			ToBeeTheme new.
			ToBeeDarkTheme new }.

	themeSwitcher whenSelectedIndexChangedDo: [
		space toTheme: themeSwitcher selectedData new ].
	themeSwitcher selectData: space toTheme class.
	topBar addChild: themeSwitcher.

	enablementSwitcher := ToSwitchIcon new.
	enablementSwitcher switchBarOnElement: (ToLabel text: 'Enabled').
	enablementSwitcher switchBarOffElement: (ToLabel text: 'Disabled').
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
		choice := event uncheckedList anyOne.
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
	roundShapingRadio userData at: #shaping put: #round.
	defaultShapingRadio checked: true.
	shapingGroup addAll: {
			circleShapingRadio.
			defaultShapingRadio.
			roundShapingRadio }.
	shapingGroup when: ToCheckableGroupChangedEvent do: [ :event |
		| choice shaping |
		choice := event uncheckedList anyOne.
		shaping := choice userData at: #shaping.
		allButtons do: [ :but | but shaping: shaping ] ].

	buttonBar addChildren: {
			circleShapingRadio.
			defaultShapingRadio.
			roundShapingRadio }.

	topBar addChild: buttonBar.

	directionSwitcher := ToSwitchIcon new
		                     labelText: 'Icon first';
		                     beEndToStart;
		                     yourself.
	directionSwitcher check.
	directionSwitcher when: ToCheckableCheckEvent do: [ :event |
		allButtons do: [ :b | b startToEnd: event target isChecked ] ].
	topBar addChild: directionSwitcher.

	orientationSwitcher := ToSwitchIcon new
		                       labelText: 'Horizontal';
		                       beEndToStart;
		                       yourself.
	orientationSwitcher check.
	orientationSwitcher when: ToCheckableCheckEvent do: [ :event |
		allButtons do: [ :b | b horizontal: event target isChecked ] ].
	topBar addChild: orientationSwitcher.

	topBar childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ].

	circleShapingRadio when: ToCheckableCheckEvent do: [ :event |
		event current
			ifTrue: [
				directionSwitcher enabled: false.
				orientationSwitcher enabled: false ]
			ifFalse: [
				directionSwitcher enabled: true.
				orientationSwitcher enabled: true ] ].

	space root addChild: topBar.

	butBuilder := [
	              ToImage new innerImage:
		              ToThemeIcons searchOutlined16x16 ].
	buttonSpecsBuilder := [
	                      {
		                      { 'Primary'. #primary }.
		                      { 'Default'. #default }.
		                      { 'Dashed'. #dashed }.
		                      { 'Text'. #text }.
		                      { 'Link'. #link } } ].

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
	button1 icon: (ToImage new innerImage: (ToThemeIcons searchOutlined16x16)).

	space root addChild: pane.
	space root addChild: button1.

	space show.
]

{ #category : #'toggle button' }
ToSandBox class >> example_ToggleButton [

	| toggle |
	ToTheme cleanUp.
	toggle := ToToggleButton new label: (ToLabel text: 'Toggle button').
	toggle icon: (ToImage new innerImage: (self iconNamed: #solidMenu)).
	toggle checked: false.
	toggle openInInnerWindow.
	toggle inspect
]

{ #category : #'toggle button' }
ToSandBox class >> example_ToggleButtonChecked [

	| toggle |
	ToTheme cleanUp.
	toggle := ToToggleButton new label: (ToLabel text: 'Toggle button').
	toggle icon: (ToImage new innerImage: (self iconNamed: #solidMenu)).
	toggle addEventHandler: (BlEventHandler
			 on: ToSkinEvent
			 do: [ :evt | evt target = toggle ifTrue: [ evt traceCr ] ]).
	toggle whenClickedDo: [ :event |
		event currentTarget isChecked traceCr.
		event traceCr ].
	toggle checked: true.
	toggle openInInnerWindow.
	toggle inspect
]

{ #category : #'toggle button' }
ToSandBox class >> example_ToggleButtonGroupAndWeakStrategy [

	| group groupContainer |
	group := ToCheckableGroup new.
	group withWeakCheckingStrategy.
	{ 'Monday'. 'Tuesday'. 'Wednesday'. 'Thursday'. 'Friday' } do: [ :day |
		group register: (ToToggleButton new
				 labelText: day;
				 hMatchParent;
				 yourself) ].
	group registeredCheckables second checked: true.
	group addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 ('checked: ' , event checkedList asString , ' unchecked: '
				  , event uncheckedList asString) traceCr ]).

	groupContainer := ToPane vertical.
	groupContainer width: 150.
	groupContainer addChildren: group registeredCheckables.
	groupContainer openInSpace
]

{ #category : #'toggle button' }
ToSandBox class >> example_ToggleButtonWithIndeterminate [

	| toggle |
	ToTheme cleanUp.
	toggle := ToToggleButton new label: (ToLabel text: 'Toggle button').
	toggle icon: (ToImage new innerImage: (self iconNamed: #solidMenu)).
	toggle withIndeterminate: true.
	toggle openInInnerWindow.
	toggle inspect
]

{ #category : #triplet }
ToSandBox class >> example_TripletElementWithIconAndText [

	| but  |
	but := self tripletWithText.
	but hMatchParent.
	but inspect.
	but openInSpace.
	^ but
]

{ #category : #triplet }
ToSandBox class >> example_TripletElementWithIconAndText_endAlignment [

	| but  |
	but := self example_TripletElementWithIconAndText.
	but endAlignment: 50.
	but border: Color red.
	but vFitContent.
	but hFitContent.
	^ but
]

{ #category : #triplet }
ToSandBox class >> example_TripletElementWithIconAndText_flexible_Interspace [

	| but  |
	but := self example_TripletElementWithIconAndText.
	but startInterspace: 30.
	but endInterspace: 30.
	but startFlexible: true.
	but endFlexible: true.
	but border: Color red.
	but vFitContent.
	but hMatchParent.
	^ but
]

{ #category : #triplet }
ToSandBox class >> example_TripletElementWithIconAndText_startFlexible [

	| but  |
	but := self example_TripletElementWithIconAndText.
	but startFlexible: true.
	but border: Color red.
	but vFitContent.
	but hMatchParent.
	^ but
]

{ #category : #triplet }
ToSandBox class >> example_TripletElementWithIconAndText_startFlexible_startAlignment [

	| but  |
	but := self example_TripletElementWithIconAndText.
	but startFlexible: true.
	but startAlignment: 60.
	but border: Color red.
	but vFitContent.
	but hMatchParent.
	^ but
]

{ #category : #triplet }
ToSandBox class >> example_TripletElementWithIconAndText_startFlexible_startInterspace [

	| but  |
	but := self example_TripletElementWithIconAndText.
	but startInterspace: 30.
	but startFlexible: true.
	but border: Color red.
	but vFitContent.
	but hMatchParent.
	^ but
]

{ #category : #triplet }
ToSandBox class >> example_TripletElementWithIconAndText_vertical [

	| but  |
	but := self tripletWithText.
	but beVertical.
	but inspect.
	but openInSpace.
	^ but
]

{ #category : #list }
ToSandBox class >> example_TwoCoordinateLists [

	| panel list1 list2 tabSize |
	panel := ToPane new.
	panel matchParent.
	tabSize := 100.
	list1 := ToListElement new.
	list2 := ToListElement new.
	1 to: tabSize do: [ :i |
	list1 dataAccessor add: 'Hello ' , i asString ].
	1 to: tabSize do: [ :i |
	list2 dataAccessor add: 'Goodbye ' , i asString ].
	list1 addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :e |
				 list2 selectionModel deselectAll.
				 e currentTarget selectionModel selectedIndexesDo: [ :idx |
					 list2 selectionModel selectIndex: idx ].
				 list2 notifyPrimarySelectionDirty ]).
	list2 addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :e |
				 list1 selectionModel deselectAll.
				 list1 notifyPrimarySelectionDirty ]).
	panel addChild: list1.
	panel addChild: list2.
	list1 selecter selectIndex: 1.
	list2 selecter selectIndex: 2.
	panel openInSpace
]

{ #category : #bar }
ToSandBox class >> example_bar [

	| bar dashBoard rootPane selectionModeBoard |
	bar := ToBarElement new.
	bar nodeFactory: [ :holder | ToBarNodeExample new ].
	bar nodeBuilder: [ :node :dataItem :holder|
		node label:
			(ToLabel text: holder position asString , ': ' , dataItem asString) ].

	bar contextMenu: [ :menu :request |
		| selectedIndexes target |
		target := request currentTarget.
		selectedIndexes := request selectedIndexes.
		menu addItem: (ToMenuItem new
				 labelText: 'Inspect list';
				 whenClickedDo: [ :event | target inspect ]).
		selectedIndexes ifNotEmpty: [
			menu addItem: (ToMenuItem new
					 labelText: 'Inspect selected nodes';
					 whenClickedDo: [
						 Array withAll:
								 (selectedIndexes collect: [ :idx | target nodeAt: idx ])
									 inspect ]) ] ].

	dashBoard := self barDashBoardFor: bar.
	selectionModeBoard := self selectionModeChooserFor: bar.
	dashBoard constraints linear weight: 0.82.
	selectionModeBoard constraints linear weight: 0.18.
	rootPane := ToPane vertical.
	rootPane padding: (BlInsets all: 5).
	rootPane matchParent.
	rootPane addChild: dashBoard.
	rootPane addChild: selectionModeBoard.
	rootPane addDividers.

	bar dataAccessor addAll: ToSandBox statesOfAmerica. "copyFrom: 1 to: 20"
	"bar dataAccessor addAll:
		(Smalltalk globals allClasses copyFrom: 1 to: 1800)."
	rootPane openInSpace
]

{ #category : #button }
ToSandBox class >> example_buttonWith2Icons [

	| but  |
	but := self example_buttonWithIcon.
	but whenClickedDo: [ :event | event traceCr ].
	but label: (ToLabel text: 'Button with 2 icons').
	but endElement: (ToImage inner: ToThemeIcons searchOutlined16x16).
	^ but
]

{ #category : #button }
ToSandBox class >> example_buttonWith2IconsVertical [

	| but  |
	but := self example_buttonWithIcon.
	but label: (ToLabel text: 'Button with 2 icons').
	but endElement: (ToImage inner: ToThemeIcons searchOutlined16x16).
	but beVertical.
	^ but
]

{ #category : #button }
ToSandBox class >> example_buttonWithActionControl [

	| but count |
	but := ToButton new.
	but label: (ToLabel text: 'Button with label').
	count := 0.
	but whenClickedDo: [ :event | self inform: 'Action runned' ].
	but addEventHandlerOn: ToClickableActionRequestEvent do: [ :event |
		count := count + 1.
		event accept: count odd.
		event denied ifTrue: [ self inform: 'Action denied' ] ].
	but openInSpace.
	^ but
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
	but hMatchParent.
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
	choice withWeakCheckingStrategy.
	choice data addAll: { 'OS-X'. 'Windows'. 'Linux' }.
	choice defaultLabel:
		((ToAttributedLabel text: 'Invalid choice' asRopedText)
			 foreground: Color red;
			 freeze;
			 yourself).
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
			 on: ToChoiceChangedEvent
			 do: [ self inform: choice selectedData asString ]).
	win pane addChild: choice.
	win openInSpace
]

{ #category : #'choice menu' }
ToSandBox class >> example_choiceButtonWithWeakStrategy [

	| win choice t |
	win := ToInnerWindow new title: 'Some host'.
	choice := ToChoiceMenu new hMatchParent.
	choice withWeakCheckingStrategy.
	t := 'No selection...' asRopedText , String cr asRopedText
	     , ('Please choose an host from the list' asRopedText
			      foreground: Color red;
			      fontSize: 12).
	choice defaultLabel: (ToAttributedLabel new
			 beMultiLine;
			 text: t;
			 freeze).
	choice dataToTextConverter: [ :assoc | assoc key ].
	choice addEventHandler: (BlEventHandler
			 on: ToChoiceChangedEvent
			 do: [ self inform: choice selectedData value asString ]).
	choice data addAll: {
			('Morphic SDL' -> BlMorphicWindowHost).
			('Native SDL' -> BlOSWindowSDL2Host) }.
	win pane addChild: choice.
	win openInSpace
]

{ #category : #tabs }
ToSandBox class >> example_closeableTabs [

	| nb but |
	nb := ToTabPane new.
	nb group addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event | event traceCr ]).
	nb preservePaneOnSelect: false.
	(Color wheel: 5) withIndexDo: [ :eachColor :index |
		but := ToTab new.
		but closable: true.
		but addEventHandler: (BlEventHandler
				 on: ToCheckableCheckEvent
				 do: [ :event | event current traceCr ]).

		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: eachColor ].
		nb addTab: but ].
	nb openInSpace
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
	list nodeBuilder: [ :node :dataItem :holder |
		| line remBut |
		node ensureCanManageSkin.
		line := ToElement new
			        layout: BlLinearLayout horizontal;
			        matchParent.
		line addChild: (ToLabel new
				 text: dataItem name;
				 width: 100;
				 margin: (BlInsets right: 10)).
		line addChild: (ToLabel new
				 text: dataItem phoneNumber;
				 width: 100;
				 margin: (BlInsets right: 10)).
		line addChild: (ToLabel new
				 text: dataItem address;
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
					 event consume.
					 holder listElement dataAccessor removeAt: holder position ]).
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

{ #category : #'header positionning' }
ToSandBox class >> example_headerOnBottomCenter [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnBottomCenter.
	nb inspect.
	^ nb
]

{ #category : #'header positionning' }
ToSandBox class >> example_headerOnBottomLeft [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnBottomLeft.
	^ nb
]

{ #category : #tabs }
ToSandBox class >> example_headerOnBottomResizablePanes [

	| nb |
	nb := self example_headerOnBottomLeft.
	nb withoutCheckingStrategy.
	nb withResizablePanes 
]

{ #category : #'header positionning' }
ToSandBox class >> example_headerOnBottomRight [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnBottomRight.
	^ nb
]

{ #category : #'header positionning' }
ToSandBox class >> example_headerOnLeftBottom [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnLeftBottom.
	^ nb
]

{ #category : #'header positionning' }
ToSandBox class >> example_headerOnLeftCenter [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnLeftCenter.
	^ nb
]

{ #category : #tabs }
ToSandBox class >> example_headerOnLeftResizablePanes [

	| nb |
	nb := self example_headerOnLeftTop.
	nb withoutCheckingStrategy.
	nb withResizablePanes 
]

{ #category : #'header positionning' }
ToSandBox class >> example_headerOnLeftTop [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnLeftTop.
	^ nb
]

{ #category : #'vertical labels' }
ToSandBox class >> example_headerOnLeftTopVerticalLabels [

	| nb but |
	nb := ToTabPane new.
	nb constraintsDo: [ :c | c accountTransformation ].
	nb resizablePanes: true.
	1 to: 5 do: [ :index |
		but := ToTab new.
		but labelText: 'Button ' , index asString.
		but firstChild rotateBy: 270.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addTab: but ].
	nb openInSpace.
	nb header constraintsDo: [ :c | c accountTransformation ].
	nb withHeaderOnLeftTop.
	^ nb
]

{ #category : #'header positionning' }
ToSandBox class >> example_headerOnRightBottom [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnRightBottom.
	^ nb
]

{ #category : #'header positionning' }
ToSandBox class >> example_headerOnRightCenter [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnRightCenter.
	^ nb
]

{ #category : #'header positionning' }
ToSandBox class >> example_headerOnRightTop [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnRightTop.
	^ nb
]

{ #category : #'vertical labels' }
ToSandBox class >> example_headerOnRightTopLabelsDiagonally [

	| nb but |
	nb := ToTabPane new.
	nb constraintsDo: [ :c | c accountTransformation ].
	nb resizablePanes: true.
	1 to: 5 do: [ :index |
		but := ToTab new.
		but layout beVertical.
		but layout alignCenter.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but firstChild rotateBy: 50.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addTab: but ].
	nb openInSpace.
	nb header constraintsDo: [ :c | c accountTransformation ].
	nb withHeaderOnRightTop.
	^ nb
]

{ #category : #'header positionning' }
ToSandBox class >> example_headerOnTopCenter [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnTopCenter.
	^ nb
]

{ #category : #'header positionning' }
ToSandBox class >> example_headerOnTopLeft [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnTopLeft.
	^ nb
]

{ #category : #tabs }
ToSandBox class >> example_headerOnTopResizablePanes [

	| nb |
	nb := self example_tabPane.
	nb withoutCheckingStrategy.
	nb withResizablePanes 
]

{ #category : #tabs }
ToSandBox class >> example_headerOnTopResizablePanesHorizontalBody [

	| nb |
	nb := self example_tabPane.
	nb withoutCheckingStrategy.
	nb withResizablePanes.
	nb withHorizontalBody
]

{ #category : #'header positionning' }
ToSandBox class >> example_headerOnTopRight [

	| nb |
	nb := self example_tabPane.
	nb withHeaderOnTopRight.
	^ nb
]

{ #category : #pane }
ToSandBox class >> example_horizontalPaneWithDivider [

	| pane e1 e2 e3 btn |
	pane := ToPane horizontal.
	pane matchParent.
	e1 := ToElement new
		      id: #'1';
		      margin: (BlInsets all: 3);
		      background: (Color random alpha: 0.2);
		      ";
		      width: 100"matchParent.
	e2 := ToElement new
		      id: #'2';
		      margin: (BlInsets all: 3);
		      background: (Color random alpha: 0.2);
				matchParent";
		      width: 200".
	e3 := ToElement new
		      id: #'3';
		      margin: (BlInsets all: 3);
		      background: (Color random alpha: 0.2);
		      ";
		      width: 50"matchParent.
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
	pane dividers first weight: 10.
	pane dividers second weight: 5.
	pane dividers third weight: 0.5.
	pane openInSpace
]

{ #category : #'context menu + menubar' }
ToSandBox class >> example_menuBar1 [

	| win bar fileMenu |
	win := ToInnerWindow new.
	win title: 'Menu bar example'.
	win width: 600.

	bar := ToMenuBar new
		hMatchParent;
		vFitContent;
		yourself.

	bar addMenu: (fileMenu := ToMenu new
			 labelText: 'File').
	fileMenu addItem: (ToMenuItem new labelText: 'Open'; yourself).
	fileMenu padding: (BlInsets all: 10).

	bar addFiller.
	bar addMenu:
		(ToMenu new
			labelText: 'Help';
			tooltipString: 'help stuffs';
			yourself).
	bar
		addEventHandlerOn: BlMouseDownEvent
		do: [ :event | event target traceCr ].
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

{ #category : #tabs }
ToSandBox class >> example_notPreservingPane [

	| nb but |
	nb := ToTabPane new.
	nb withoutCheckingStrategy.
	nb withHorizontalBody.
	nb preservePaneOnSelect: false.
	1 to: 5 do: [ :index |
		but := ToTab new.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addTab: but ].
	nb openInSpace
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

{ #category : #tabs }
ToSandBox class >> example_preservingPane [

	| nb but |
	nb := ToTabPane new.
	nb preservePaneOnSelect: true.
	nb withoutCheckingStrategy.
	nb resizablePanes: true.
	1 to: 5 do: [ :index |
		but := ToTab new.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane withNullSkin; background: Color random ].
		nb addTab: but ].
	nb openInSpace
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

{ #category : #segmented }
ToSandBox class >> example_segmentedWithCheckboxes [

	| checkableBar dashBoard |
	checkableBar := ToSegmentedBarElement new.
	{ 'Daily'. 'Weekly'. 'Monthly'. 'Quaterly'. 'Yearly' } do: [ :l |
		checkableBar checkableElementAccessor add: (ToCheckbox new
				 label: (ToLabel text: l);
				 startFlexible: true;
				 beEndToStart;
				 yourself) ].

	dashBoard := self segmentedDashBoardFor: checkableBar.
	dashBoard openInSpace
]

{ #category : #segmented }
ToSandBox class >> example_segmentedWithToggleButton [

	| seg dashBoard rootPane feedbackPane maj |
	seg := ToSegmentedElement new.
	seg matchParent.
	{ 'Daily'. 'Weekly'. 'Monthly'. 'Quaterly'. 'Yearly' } do: [ :l |
		seg segmentAccessor add:
			((ToToggleButton new label: (ToLabel text: l))
				 defaultRawSkin: ToToggleInSegmentedSkin new;
				 whenClickedDo: [ :event | event currentTarget label text traceCr ];
				" flexible: true;"
				 yourself) ].

	dashBoard := self segmentedDashBoardFor: seg.

	feedbackPane := ToPane horizontal.
	feedbackPane layout alignCenter.
	maj := [
	       | t |
	       feedbackPane removeChildren.
	       t := String streamContents: [ :stream |
		            seg segmentAccessor withIndexDo: [ :e :idx |
			            stream
				            nextPutAll: e label text asString;
				            nextPutAll: ': '.
			            (seg selectionModel containsIndex: idx)
				            ifTrue: [ stream nextPutAll: 'V ' ]
				            ifFalse: [ stream nextPutAll: 'X ' ].
			            stream nextPutAll: e checked asString.
			            stream nextPutAll: ' '.
			            idx < seg segmentAccessor itemCount ifTrue: [
				            stream nextPutAll: '- ' ] ] ].
	       feedbackPane addChild: (ToLabel text: t) ].

	seg addEventHandler: (BlEventHandler
			 on: ToListStrongSelectionEvent
			 do: [ :event |
				 ' double click ' trace.
				 event indexes traceCr ]).

	seg addEventHandlerOn: ToListPrimarySelectionChangedEvent do: maj.
	seg addEventHandlerOn: BlElementAddedToSceneGraphEvent do: maj.
	rootPane := ToPane vertical.
	rootPane matchParent.
	rootPane addChildren: {
			dashBoard.
			feedbackPane }.
	rootPane openInSpace
]

{ #category : #select }
ToSandBox class >> example_selectWith5Nodes [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select listElement nodeBuilder: [ :node :dataItem :holder |
		node addChild: (ToLabel text: dataItem asString) hMatchParent ].
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
			 on: ToStillHoveredSkinEvent
			 do: [ :event |
				 lab text: count asString asRopedText.
				 count := count + 1.
				 count > 50 ifTrue: [
					 event consume.
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
			 on: ToStillPressedSkinEvent
			 do: [ :event |
				 e background: color.
				 lab text: count asString asRopedText.
				 count := count + 1.
				 color := color darker.
				 count > 50 ifTrue: [
					 event consume.
					 count := 0.
					 color := Color white alpha: 0.3 ] ]).
	e openInSpace
]

{ #category : #'switch button' }
ToSandBox class >> example_switchButton [

	| th |
	th := ToSwitchButton new.
	th
		addEventHandlerOn: ToSkinEvent
		do: [ :event | event traceCr ].
	th checked: true.
	th wishedTrackSize: 100 @ 30.
	th inspect.
	th openInSpace
]

{ #category : #'switch button' }
ToSandBox class >> example_switchButton2 [

	| th sp |
	th := ToSwitchButton new.
	th wishedTrackSize: 100@30.
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
	but inspect.
	but wishedTrackSize: 300@50.
	but endToStart: true.
	but startFlexible: true.
	but hMatchParent.
	but labelText: ('Something' asRopedText fontSize: 44).
	handler := BlEventHandler
		           on: ToSkinEvent
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

{ #category : #'switch button' }
ToSandBox class >> example_switchButtonWithSize [

	| th  |
	th := ToSwitchButton new.
	th labelText: 'Wished size is for the button track, it doesn''t include the label size'.
	th startInterspace: 10.
	th wishedTrackSize: 100@30.
	th checked: true.
	th inspect.
	th openInSpace
]

{ #category : #tabs }
ToSandBox class >> example_tabPane [
	| nb but |
	nb := ToTabPane new.
	nb resizablePanes: true.
	1 to: 5 do: [ :index |
		but := ToTab new.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addTab: but ].
	nb openInSpace.
	^ nb
]

{ #category : #tabs }
ToSandBox class >> example_tabPaneInTabPane [

	| tabPane tab |
	tabPane := ToTabPane new.
	tabPane group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | event traceCr ].
	1 to: 3 do: [ :index |
		tab := ToTab new.
		tab labelText: 'Tab ' , index asString.
		tab paneBuilder: [ :pane :theTabPane |
			pane addChild: self subTabPane withHeaderOnLeftTop ].
		tabPane addTab: tab ].
	tabPane openInSpace
]

{ #category : #tabs }
ToSandBox class >> example_tabPaneWithStartContainer [
	| nb but header |
	nb := ToTabPane new.
	header := nb header.
	header startContainer addChild: ((ToElement new size: 150 asPoint) background: Color red; layout: BlFrameLayout new).
	header startContainer fitContent.
	header startContainer constraintsDo: [ :c |
		c linear vertical alignCenter ].

	header endContainer addChild: ((ToElement new size: 50 asPoint) background: Color red; layout: BlFrameLayout new).
	header endContainer fitContent.
	header endContainer constraintsDo: [ :c |
		c linear vertical alignCenter ].

	nb resizablePanes: true.
	1 to: 5 do: [ :index |
		but := ToTab new.
		but closable: true.
		but labelText: 'Button ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addTab: but ].
	nb openInSpace.
	nb withHeaderOnRightCenter.
	^ nb
]

{ #category : #tabs }
ToSandBox class >> example_tabsWith2Pages [

	| aNotebook redPage greenPage redCount greenCount |
	aNotebook := ToTabPane new.
	aNotebook rebuildPaneOnSelect: true.

	redCount := 0.
	redPage := aNotebook
		           addTabWithText: 'RED'
		           builder: [ :pane :theNotebook |
			           redCount := redCount + 1.
			           pane addChild: (ToLabel
					            text:
						            (redCount asRopedText foreground: Color red darker)) ].

	greenCount := 0.
	greenPage := aNotebook
		             addTabWithText: 'GREEN'
		             builder: [ :pane :theNotebook |
			             greenCount := greenCount + 1.
			             pane addChild: (ToLabel
					              text:
						              (greenCount asRopedText foreground:
								               Color green darker) ) ].

	aNotebook openInSpace
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
ToSandBox class >> example_textFieldWithAutocompletePopup [

	| t |
	t := ToAlbum  new.
	t addEventHandler: ToAlbumAutocompletionEventHandler new.
	t openInSpace
]

{ #category : #'text field' }
ToSandBox class >> example_textFieldWithAutocompletePopup_experiment [

	| t queryRunner  |
	t := ToTextField new.
	
	queryRunner := ToItemsQueryRunner new.
	queryRunner onInstalledIn: t.
	queryRunner fetcher: [ :theTextField :thePattern |
		(SystemNavigation default allMethods collect: [ :m | m selector ])
			asSet asArray sort select: [ :m |
			m beginsWith: thePattern caseSensitive: false ] ].
	t addEventHandler: (BlEventHandler
			 on: AlbTextInsertedEvent
			 do: [ :event |
				 | sub selecter wordStart currIdx |
				currIdx := event toIndex.
				 t atTextIndex: event fromIndex do: [ :e :lidx |
					 | origin |
					 origin := e screenCornerAt: lidx.
					 e localPointToGlobal: origin "traceCr" ].
				 selecter := t selecter.
				 wordStart := selecter findWordStartBefore: event toIndex.
				 sub := (t text copyFrom: wordStart to: event toIndex).
				 sub asString ifNotEmpty: [ :pat |
					 queryRunner processPattern: pat for: t ] ]).
	t addEventHandlerOn: ToItemsQueryResultEvent do: [ :event |
		(event items collect: [ :m | m ]) asArray in: [ :result |
			result size trace.
			'->' trace.
			(result first: (5 min: result size)) traceCr ] ].
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
		     withLineWrapping.
	t inspect.
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
	t placeholderBuilder: [ :thePlaceholder :myself |
		thePlaceholder addChild: (ToAttributedLabel text:
				 ('Enter to accept' asRopedText foreground: Color lightGray)) ].
	t whenSaveRequestedDo: [ :saveRequested |
		saveRequested client text ifNotEmpty: [
			saveRequested client saveResult: true.
			text := saveRequested client text copy ] ].
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
				 foreground: Color veryLightGray;
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
			 on: ToChoiceChangedEvent
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
	icon := ToImage new innerImage: ToThemeIcons searchOutlined16x16.
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
	icon := ToImage new innerImage: (ToThemeIcons searchOutlined16x16).
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

{ #category : #image }
ToSandBox class >> example_toImageWithSVG [

	| im |
	im := ToImage inner: (self pathBugSVG).
	im matchParent.
	im withNullSkin.
	im inspect.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImageWithSVG2 [

	| im |
	im := ToImage inner: (self pathCheckSVG).
	im matchParent.
	im withNullSkin.
	im inspect.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImageWithSVG4 [

	| im |
	im := ToImage inner: (self pathCloseSVG).
	im matchParent.
	im withNullSkin.
	im inspect.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImageWithSVG5 [

	| im |
	im := ToImage inner: (self pathAddLinkSVG).
	im matchParent.
	im withNullSkin.
	im inspect.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImageWithSVG6 [

	| im |
	im := ToImage inner: (self path_sharp_electric_bike_SVG
).
	im matchParent.
	im withNullSkin.
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
	self flag: 'Check the elevation of the editor'.
	but := ToButton new.
	but labelText: 'Button with editable tooltip'.
	but closeTooltipWindowOnMouseLeave: false.
	but tooltipBuilder: [ :win :theElement |
		| lab |
		lab := ToLabel text: ' keep mouse over with shift key to edit / Return to accept' asRopedText.
		lab
			beEditable;
			stillHoveredStartDelay: 800 milliSeconds;
			addEventHandler: (BlEventHandler
					 on: ToStillHoveredSkinEvent
					 do: [ :event |
						 event sourceEvent modifiers isShift ifTrue: [
								 event consume.
								 event currentTarget addEditorEvent: event ] ]).
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
	lab1
		hMatchParent;
		vFitContent.
	lab2
		hMatchParent;
		vFitContent.
	lab1 innerElement constraintsDo: [ :c |
		c frame horizontal alignCenter ].
	lab2 innerElement constraintsDo: [ :c |
		c frame horizontal alignCenter ].
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

{ #category : #label }
ToSandBox class >> example_toLabel_editableMultiline [

	| lab |
	lab := ToLabel new text: 'First line' , String cr , 'Second line'.
	lab beMultiLine.
	lab hMatchParent.
	lab isEditable: true.
	lab openInSpace
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

{ #category : #tabs }
ToSandBox class >> example_twoTabsWithLabel [

	| tabsPanel lab1 lab2 tab1 tab2 |
	lab1 := ToLabel text: 'Hello'.
	lab1 text foreground: Color red.
	lab2 := ToLabel text: 'Goodbye'.
	
	tabsPanel := ToTabPane new.
	tab1 := ToTab new.
	tab1 labelText: 'Hello'.
	tab1 paneBuilder: [ :pane :theTabPane | pane addChild: lab1 ].
	tab2 := ToTab new.
	tab2 labelText: 'Goodbye'.
	tab2 paneBuilder: [ :pane :theTabPane | pane addChild: lab2 ].
	tabsPanel addTab: tab1.
	tabsPanel addTab: tab2.
	tabsPanel openInSpace.
	tabsPanel inspect
]

{ #category : #tabs }
ToSandBox class >> example_twoTabsWithListElement [

	| tabsPanel list1 list2 tab1 tab2 |
	list1 := self listWithEditableAndContextMenu.
	list1 constraints vertical matchParent.
	list1 constraints horizontal matchParent.

	list2 := ToListElement new.
	list2 constraints vertical matchParent.
	list2 constraints horizontal matchParent.
	11 to: 20 do: [ :i | list2 dataAccessor add: 'Goodbye ' , i asString ].
	tabsPanel := ToTabPane new.
	tab1 := ToTab new.
	tab1 labelText: 'Lorem'.
	tab1 paneBuilder: [ :pane :theTabPane | pane addChild: list1 ].
	tab2 := ToTab new.
	tab2 labelText: 'Goodbye'.
	tab2 paneBuilder: [ :pane :theTabPane | pane addChild: list2 ].
	tabsPanel addTab: tab1.
	tabsPanel addTab: tab2.
	tabsPanel openInSpace
]

{ #category : #pane }
ToSandBox class >> example_verticalPaneWith1Dividers [

	| rootPane firstPane secondPane |
	rootPane := ToPane horizontal.
	firstPane := ToPane vertical withNullSkin margin: (BlInsets all: 3).
	secondPane := ToPane vertical withNullSkin margin: (BlInsets all: 3).
	firstPane background: Color blue.
	secondPane background: Color red.
	rootPane vMatchParent.
	rootPane width: 400.
	firstPane matchParent.
	secondPane matchParent.
	secondPane width: 100.
	rootPane addChildren: {
			firstPane.
			secondPane }.
	rootPane addDividers.
	"rootPane dividers first weight: 0.3."
	rootPane openInSpace
]

{ #category : #pane }
ToSandBox class >> example_verticalPaneWith2Dividers [

	| rootPane firstPane secondPane thirdPane |
	rootPane := ToPane horizontal.
	firstPane := ToPane vertical withNullSkin margin: (BlInsets all: 3); id: #'1'.
	secondPane := ToPane vertical withNullSkin margin: (BlInsets all: 3); id: #'2'.
	thirdPane := ToPane vertical withNullSkin margin: (BlInsets all: 3); id: #'3'.
	firstPane background: Color blue.
	secondPane background: Color red.
	thirdPane background: Color yellow.
	rootPane vMatchParent.
	rootPane width: 400.
	firstPane matchParent.
	secondPane matchParent.
	secondPane width: 100.
	thirdPane matchParent.
	thirdPane width: 50.

	rootPane addChildren: {
			firstPane.
			secondPane.
			thirdPane }.
	rootPane addDividers.
	"rootPane dividers first weight: 0.3."
	rootPane openInSpace
]

{ #category : #pane }
ToSandBox class >> example_verticalPaneWith3Dividers [

	| rootPane firstPane secondPane thirdPane fourthPane |
	rootPane := ToPane vertical.
	firstPane := ToPane vertical withNullSkin margin: (BlInsets all: 3); id: #'1'.
	secondPane := ToPane vertical withNullSkin margin: (BlInsets all: 3); id: #'2'.
	thirdPane := ToPane vertical withNullSkin margin: (BlInsets all: 3); id: #'3'.
	fourthPane := ToPane vertical withNullSkin margin: (BlInsets all: 3); id: #'3'.
	firstPane background: Color blue.
	secondPane background: Color red.
	thirdPane background: Color yellow.
	fourthPane background: Color gray.
	rootPane matchParent.
	rootPane height: 1000.
	firstPane matchParent.
	firstPane height: 50.
	secondPane matchParent.
	secondPane height: 6.
	thirdPane matchParent.
	thirdPane height: 5.
	fourthPane matchParent.
	fourthPane height: 50.

	rootPane addChildren: {
			firstPane.
			secondPane.
			thirdPane.
			fourthPane }.
	rootPane addDividers.
	rootPane dividers first weight: 0.3.
	rootPane asScrollableElement openInSpace
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

{ #category : #pane }
ToSandBox class >> example_verticalPaneWithDividerAndSubpanesWithWeight [

	| rootPane firstPane secondPane |
	rootPane := ToPane horizontal.
	firstPane := ToPane vertical withNullSkin.
	secondPane := ToPane vertical withNullSkin.
	firstPane background: Color blue.
	secondPane background: Color red.
	rootPane matchParent.
	firstPane matchParent.
	secondPane matchParent.
	rootPane addChildren: {
			firstPane.
			secondPane }.
	rootPane addDividers.
	rootPane dividers first weight: 0.3.
	rootPane openInSpace
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

	grp register: right button.
	grp register: center button.
	grp register: left button.

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
	grp registerAll: {
			right.
			center.
			left }.

	grp addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 ('checked: ' , event checkedList asString , ' unchecked: '
				  , event uncheckedList asString) traceCr ]).

	menu addSeparator.

	lbl := ToAttributedLabel text: 'Radio button icon first'.
	lbl 
			italic;
			fontSize: 12;
			foreground: Color blue.

	menu addItem: (ToCustomMenuItem new
			 innerElement: lbl;
			 margin: (BlInsets
					  top: 2;
					  bottom: 4)).
	menu addAllItems: grp registeredCheckables.

	grp := ToCheckableGroup new.
	right := ToRadioMenuItem new
		         beEndToStart;
		         labelText: 'Right';
		         id: #right.
	center := ToRadioMenuItem new
		          beEndToStart;
		          labelText: 'Center';
		          id: #center.
	left := ToRadioMenuItem new
		        beEndToStart;
		        labelText: 'Left';
		        id: #left.
	center checked: true.
	grp registerAll: {
			right.
			center.
			left }.
	grp addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 ('checked: ' , event checkedList asString , ' unchecked: '
				  , event uncheckedList asString) traceCr ]).

	menu addSeparator.

	lbl := ToAttributedLabel new text:
		       ('Radio button label first' asRopedText
			        italic;
			        fontSize: 12;
			        foreground: (Color blue alpha: 0.7)).
	menu addItem: (ToCustomMenuItem new
			 innerElement: lbl;
			 margin: (BlInsets
					  top: 2;
					  bottom: 4)).
	menu addAllItems: grp registeredCheckables.
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

{ #category : #list }
ToSandBox class >> experiment_intervalCollection [

	<script>
	| t |
	t :=  Time millisecondsToRun: [
		  | s sc r1 r2 |
		  r1 := 30000.
		  r2 := r1 odd
			        ifTrue: [ r1 - 1 ]
			        ifFalse: [ r1 ].
		  s := ToIntervalCollection new.
		  1 to: r1 by: 2 do: [ :idx | s selectIndex: idx ].
		  1 to: r1 by: 2 do: [ :idx |
		  (s containsIndex: idx) ifFalse: [ Error signal ] ].
		  2 to: r2 by: 2 do: [ :idx |
		  (s containsIndex: idx) ifTrue: [ Error signal ] ].
		  sc := s copy.
		  s = sc ifFalse: [ Error signal ].
		  1 to: r2 by: 1 do: [ :idx | s selectIndex: idx ].
		  1 to: r1 do: [ :idx | (s containsIndex: idx) ifFalse: [ Error signal ] ].
		  2 to: r2 by: 2 do: [ :idx | s deselectIndex: idx ].
		  s = sc ifFalse: [ Error signal ] ].
	t traceCr.
	^ t
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
		chb beStartToEnd.
		group add: chb ].
	group buttons second checked: true.
	container := ToElement new.
	container matchParent.
	container layout: BlLinearLayout horizontal.
	container layout cellSpacing: 2.
	container addChildren: group buttons.
	group when: ToCheckableGroupChangedEvent do: [ :event |
		('checked: ' , event uncheckedList asString , ' unchecked: '
		 , event uncheckedList asString) traceCr ].
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

{ #category : #list }
ToSandBox class >> listWithEditableAndContextMenu [

	| l selectionMenu menuFactory phtext disabledMode unselectableMode |
	l := ToListElement new.

	l newHiddenSelectionMode onInstalledIn: l.
	disabledMode := l newDisabledSelectionMode.
	disabledMode onInstalledIn: l.
	disabledMode option elementBuilder: [
		ToListDisabledSelectionElement new ].
	
	unselectableMode := l newUnselectableSelectionMode.
	unselectableMode onInstalledIn: l.

	unselectableMode option elementBuilder: [
		ToListUnselectableSelectionElement new defaultSkin:
			ToListUnselectableSelectionElementExempleSkin new ].

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

	l nodeBuilder: [ :node :dataItem :holder |
		| lab |
		lab := ToLabel text: dataItem.
		lab beMultiLine.
		holder isSelectable ifTrue: [
			lab beEditable.
			lab stillPressedStartDelay: 800 milliSeconds.
			lab addEventHandler: (BlEventHandler
					 on: ToStillPressedSkinEvent
					 do: [ :event |
						 event consume.
						 lab addEditorEvent: event ]).
			lab addEventHandler: (BlEventHandler
					 on: ToLabelEditorOpenedEvent
					 do: [ l disableScrolledEvent ]).
			lab addEventHandler: (BlEventHandler
					 on: ToLabelEditorClosedEvent
					 do: [ l enableScrolledEvent ]).
			lab addEventHandler: (BlEventHandler
					 on: ToLabelTextReplacedEvent
					 do: [ l dataAccessor at: holder position put: lab text asString ]) ].
		node addChild: (ToLabeledIcon new
				 label: lab;
				 hMatchParent) ].

	l addEventHandler: (BlEventHandler
			 on: ToListStrongSelectionEvent
			 do: [ :event |
				 self inform:
					 'Double click on: ' , (event indexes asString contractTo: 150) ]).

	menuFactory := [ :menu :request |
	               | selectionModel indexes target |
	               target := request currentTarget.
	               selectionModel := request selectionModel.
	               indexes := request selectedIndexes.
	               menu addItem: (ToMenuItem new
			                labelText: 'Add initial Items';
			                whenClickedDo: [ :event |
				                target dataAccessor addAll:
						                (String loremIpsum: 20000) substrings ]).
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
				                yourself).
		               menu addItem: (ToMenuItem new
				                labelText: 'Show all';
				                whenClickedDo: [ :event |
					                target hiddenSelecter deselectAll ];
				                yourself).
		               target selectionMode option isAnimated
			               ifTrue: [
				               menu addItem: (ToMenuItem new
						                labelText: 'stop selection transition animation';
						                whenClickedDo: [ :event |
							                target selectionMode option animationDuration:
									                0 milliSeconds ];
						                yourself) ]
			               ifFalse: [
				               menu addItem: (ToMenuItem new
						                labelText:
							                'start selection transition animation';
						                whenClickedDo: [ :event |
							                target selectionMode option animationDuration:
									                200 milliSeconds ];
						                yourself) ] ].
	               indexes ifNotEmpty: [
		               selectionMenu := ToMenu new.
		               selectionMenu label: (ToLabel new text: 'Selection').
		               indexes size = 1 ifTrue: [
			               | node idx label |
			               idx := indexes first.
			               node := l nodeAt: idx.
			               label := node firstChild label.
			               selectionMenu addItem: (ToMenuItem new
					                labelText: 'Inspect node';
					                whenClickedDo: [ :event | node inspect ];
					                yourself).
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
				                labelText: 'Enable/Disable';
				                whenClickedDo: [ :event |
					                indexes do: [ :idx |
							                target disabledSelecter switchIndexSelection:
									                idx ] ];
				                yourself).
		               selectionMenu addItem: (ToMenuItem new
				                labelText: 'Set unselectable';
				                whenClickedDo: [ :event |
					                indexes do: [ :idx |
							                target unselectableSelecter selectIndex: idx ] ];
				                yourself).
		               selectionMenu addItem: (ToMenuItem new
				                labelText: 'Hide';
				                whenClickedDo: [ :event |
					                indexes do: [ :idx |
							                target hiddenSelecter selectIndex: idx ] ];
				                yourself).
		               selectionMenu addItem: (ToMenuItem new
				                labelText: 'Insert before';
				                whenClickedDo: [ :event |
					                | idx |
					                idx := indexes first.
					                target dataAccessor
						                add:
							                String loremIpsum substrings first
							                , ' (inserted before)'
						                beforeIndex: idx ];
				                yourself).
		               selectionMenu addItem: (ToMenuItem new
				                labelText: 'Insert after';
				                whenClickedDo: [ :event |
					                | idx |
					                idx := indexes last.
					                target dataAccessor
						                add:
							                String loremIpsum substrings first
							                , ' (inserted after)'
						                afterIndex: idx ];
				                yourself).
		               selectionMenu addSeparator.
		               selectionMenu addItem: (ToMenuItem new
				                labelText: 'Remove';
				                whenClickedDo: [ :event |
					                indexes reverseDo: [ :idx |
							                target dataAccessor removeAt: idx ] ];
				                yourself).
		               menu addSeparator.
		               menu addItem: selectionMenu ] ].

	l contextMenu: menuFactory.
	l withRowNumbers.
	^ l
]

{ #category : #accessing }
ToSandBox class >> methodText [
	^ self  class sourceCodeAt: #example_CodeEditor
]

{ #category : #accessing }
ToSandBox class >> pathAddLinkSVG [

	<sampleInstance>
	^ '<svg xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" height="24" viewBox="0 0 24 24" width="24"><g><rect fill="none" height="24" width="24"/></g><g><path d="M8,11h8v2H8V11z M20.1,12H22c0-2.76-2.24-5-5-5h-4v1.9h4C18.71,8.9,20.1,10.29,20.1,12z M3.9,12c0-1.71,1.39-3.1,3.1-3.1h4 V7H7c-2.76,0-5,2.24-5,5s2.24,5,5,5h4v-1.9H7C5.29,15.1,3.9,13.71,3.9,12z M19,12h-2v3h-3v2h3v3h2v-3h3v-2h-3V12z"/></g></svg>'
]

{ #category : #accessing }
ToSandBox class >> pathBatmanSVG [

	<sampleInstance>
	^ '	<svg height="200" width="200">
			<g transform="translate(-205,-295)">
				<rect x="205" y="295" width="200" height="200" style="fill: white"/>
				<path d="M305.378,347.01c48.53,0,87.874,22.104,87.874,49.368c0,27.265-39.344,49.367-87.874,49.367
					c-48.531,0-87.874-22.103-87.874-49.367C217.504,369.114,256.847,347.01,305.378,347.01L305.378,347.01z"/>
				<path fill="#FFDD00" d="M335.381,362.068c0,0,8.182,11.324,4.426,17.192c-2.754,4.305-7.377,5.384-11.266,5.384
					c-11.438,0-11.85-6.506-11.85-6.506l-1.571-19.8l-5.343,8.486h-8.8l-5.343-8.486l-1.571,19.8c0,0-0.413,6.506-11.851,6.506
					c-3.888,0-8.51-1.08-11.265-5.384c-3.756-5.869,4.426-17.192,4.426-17.192c-22.527,6.229-38.03,19.251-38.03,34.31
					c0,11.756,9.451,22.27,24.313,29.281c-1.76-2.483-6.095-9.704-1.222-14.834c5.972-6.285,15.4-2.513,19.486,3.772
					c0,0,0.314-7.229,7.543-6.285c7.229,0.941,16.657,9.429,17.914,19.484c1.257-10.056,10.686-18.543,17.914-19.484
					c7.229-0.944,7.543,6.285,7.543,6.285c4.086-6.285,13.515-10.058,19.487-3.772c4.872,5.13,0.537,12.351-1.223,14.834
					c14.862-7.012,24.313-17.525,24.313-29.281C373.411,381.32,357.907,368.298,335.381,362.068L335.381,362.068z M305.378,351.931
					c43.694,0,79.116,19.9,79.116,44.447s-35.422,44.448-79.116,44.448c-43.695,0-79.118-19.901-79.118-44.448
					S261.683,351.931,305.378,351.931L305.378,351.931z"/>
			</g>
		</svg>'
]

{ #category : #accessing }
ToSandBox class >> pathBugSVG [

	<sampleInstance>
	^ '<svg class="icon" viewBox="0 0 1024 1024" 
  xmlns="http://www.w3.org/2000/svg">
  <path d="M304 280h416c4.4 0 8-3.6 8-8 0-40-8.8-76.7-25.9-108.1-17.2-31.5-42.5-56.8-74-74C596.7 72.8 560 64 520 64h-16c-40 0-76.7 8.8-108.1 25.9-31.5 17.2-56.8 42.5-74 74C304.8 195.3 296 232 296 272c0 4.4 3.6 8 8 8z"/>
  <path d="M940 512H792V412c76.8 0 139-62.2 139-139 0-4.4-3.6-8-8-8h-60c-4.4 0-8 3.6-8 8 0 34.8-28.2 63-63 63H232c-34.8 0-63-28.2-63-63 0-4.4-3.6-8-8-8h-60c-4.4 0-8 3.6-8 8 0 76.8 62.2 139 139 139v100H84c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h148v96c0 6.5.2 13 .7 19.3C164.1 728.6 116 796.7 116 876c0 4.4 3.6 8 8 8h56c4.4 0 8-3.6 8-8 0-44.2 23.9-82.9 59.6-103.7 6 17.2 13.6 33.6 22.7 49 24.3 41.5 59 76.2 100.5 100.5 28.9 16.9 61 28.8 95.3 34.5 4.4 0 8-3.6 8-8V484c0-4.4 3.6-8 8-8h60c4.4 0 8 3.6 8 8v464.2c0 4.4 3.6 8 8 8 34.3-5.7 66.4-17.6 95.3-34.5 41.5-24.3 76.2-59 100.5-100.5 9.1-15.5 16.7-31.9 22.7-49C812.1 793.1 836 831.8 836 876c0 4.4 3.6 8 8 8h56c4.4 0 8-3.6 8-8 0-79.3-48.1-147.4-116.7-176.7.4-6.4.7-12.8.7-19.3v-96h148c4.4 0 8-3.6 8-8v-56c0-4.4-3.6-8-8-8z"/>
</svg>'
]

{ #category : #accessing }
ToSandBox class >> pathCheckSVG [

	<sampleInstance>
	^ '<?xml version="1.0" standalone="no"?>
<svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 1024 1024">
  <path d="M912 190h-69.9c-9.8 0-19.1 4.5-25.1 12.2L404.7 724.5 207 474a32 32 0 0 0-25.1-12.2H112c-6.7 0-10.4 7.7-6.3 12.9l273.9 347c12.8 16.2 37.4 16.2 50.3 0l488.4-618.9c4.1-5.1.4-12.8-6.3-12.8z"/>
</svg>
'
]

{ #category : #accessing }
ToSandBox class >> pathCloseSVG [

	<sampleInstance>
	^ '<?xml version="1.0" standalone="no"?>
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024" fill="currentColor" fill-rule="evenodd"><path d="M799.855 166.312c.023.007.043.018.084.059l57.69 57.69c.041.041.052.06.059.084a.118.118 0 0 1 0 .069c-.007.023-.018.042-.059.083L569.926 512l287.703 287.703c.041.04.052.06.059.083a.118.118 0 0 1 0 .07c-.007.022-.018.042-.059.083l-57.69 57.69c-.041.041-.06.052-.084.059a.118.118 0 0 1-.069 0c-.023-.007-.042-.018-.083-.059L512 569.926 224.297 857.629c-.04.041-.06.052-.083.059a.118.118 0 0 1-.07 0c-.022-.007-.042-.018-.083-.059l-57.69-57.69c-.041-.041-.052-.06-.059-.084a.118.118 0 0 1 0-.069c.007-.023.018-.042.059-.083L454.073 512 166.371 224.297c-.041-.04-.052-.06-.059-.083a.118.118 0 0 1 0-.07c.007-.022.018-.042.059-.083l57.69-57.69c.041-.041.06-.052.084-.059a.118.118 0 0 1 .069 0c.023.007.042.018.083.059L512 454.073l287.703-287.702c.04-.041.06-.052.083-.059a.118.118 0 0 1 .07 0Z"/></svg>
'
]

{ #category : #accessing }
ToSandBox class >> pathConsoleSQLSVG [

	<sampleInstance>
	^ '<?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"><svg t="1569683650778" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="13065" xmlns:xlink="http://www.w3.org/1999/xlink" width="200" height="200"><defs><style type="text/css"></style></defs><path d="M301.3 496.7c-23.8 0-40.2-10.5-41.6-26.9H205c0.9 43.4 36.9 70.3 93.9 70.3 59.1 0 95-28.4 95-75.5 0-35.8-20-55.9-64.5-64.5l-29.1-5.6c-23.8-4.7-33.8-11.9-33.8-24.2 0-15 13.3-24.5 33.4-24.5 20.1 0 35.3 11.1 36.6 27h53c-0.9-41.7-37.5-70.3-90.3-70.3-54.4 0-89.7 28.9-89.7 73 0 35.5 21.2 58 62.5 65.8l29.7 5.9c25.8 5.2 35.6 11.9 35.6 24.4 0.1 14.7-14.5 25.1-36 25.1z" p-id="13066"></path><path d="M928 140H96c-17.7 0-32 14.3-32 32v496c0 17.7 14.3 32 32 32h380v112H304c-8.8 0-16 7.2-16 16v48c0 4.4 3.6 8 8 8h432c4.4 0 8-3.6 8-8v-48c0-8.8-7.2-16-16-16H548V700h380c17.7 0 32-14.3 32-32V172c0-17.7-14.3-32-32-32z m-40 488H136V212h752v416z" p-id="13067"></path><path d="M828.5 486.7h-95.8V308.5h-57.4V534h153.2zM529.9 540.1c14.1 0 27.2-2 39.1-5.8l13.3 20.3h53.3L607.9 511c21.1-20 33-51.1 33-89.8 0-73.3-43.3-118.8-110.9-118.8s-111.2 45.3-111.2 118.8c-0.1 73.7 43 118.9 111.1 118.9z m0-190c31.6 0 52.7 27.7 52.7 71.1 0 16.7-3.6 30.6-10 40.5l-5.2-6.9h-48.8L542 491c-3.9 0.9-8 1.4-12.2 1.4-31.7 0-52.8-27.5-52.8-71.2 0.1-43.6 21.2-71.1 52.9-71.1z" p-id="13068"></path></svg>'
]

{ #category : #accessing }
ToSandBox class >> pathFlagSVG [

	<sampleInstance>
	^ '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1000" height="700"><path d="M0 0h1000v700H0V0z" fill="#d50032"/><path d="M0 0h680v700H0V0z" class="F"/><path d="M0 0h320v700H0V0z" fill="#10069f"/><path d="M469.37 188.48c12.051 0 16.979 10.338 29.029 10.338 7.44 0 11.777-2.43 18.261-6.087 4.524-2.562 7.41-3.927 12.605-3.927 5.319 0 8.58 1.608 11.301 6.167 1.537 2.58 2.814 7.628 2.138 10.525a62.488 62.488 0 0 1-4.262 12.953c-1.043 2.438-2.028 3.898-2.028 6.566 0 6.396 8.704 8.594 14.622 8.685 1.29.02 12.139.198 18.815-6.56-3.622-.16-7.675-2.965-7.675-6.588 0-4.099 2.88-6.873 6.785-8.057.742-.212 2.006.443 2.677.09.954-.495.508-1.568 1.356-2.24 1.944-1.555 3.207-2.525 5.699-2.525a5.732 5.732 0 0 1 3.885 1.165c.69.495.943 1.107 1.79 1.107 1.786 0 2.67-1.13 4.454-1.13a6.876 6.876 0 0 1 3.604.848c1.06.548 1.037 2.349 2.238 2.349.601 0 3.779-1.296 5.44-1.296 3.446 0 5.285 1.248 7.512 3.863.6.707.985 2.137 1.596 2.137a9.72 9.72 0 0 1 5.832 2.559 9.871 9.871 0 0 1 1.68 2.038c.406.654 1.03 2.25 1.748 2.526.927.193 1.822.52 2.655.971a9.315 9.315 0 0 1 4.377 7.611 15.88 15.88 0 0 1-.75 3.31c-2.942 10.284-9.94 13.548-17.009 22.382-3.004 3.763-5.375 6.767-5.375 11.59 0 1.167 1.436 3.303 2.073 4.275-.389-2.267.647-5.051 3.043-5.18a6.09 6.09 0 0 1 6.259 5.568 7.025 7.025 0 0 1-.519 2.85 14.911 14.911 0 0 1 6.217-2.202 19.38 19.38 0 0 1 2.979-.13c5.245.13 11.034 3.08 14.547 6.064 10.749 9.13 12.049 22.492 11.462 26.203-1.305 8.246-.484 23.168-21.56 29.117 3.897 1.641 6.55 4.573 6.55 8.178a7.11 7.11 0 0 1-6.927 7.28 6.825 6.825 0 0 1-5.372-2.12c-4.382 4.381-5.23 8.852-5.23 15.054a19.283 19.283 0 0 0 2.261 9.258c1.644 3.552 2.827 5.637 5.796 8.2 1.573-2.369 3.234-4.1 6.078-4.1 2.757 0 5.09.883 6.22 3.392.336.76.035 1.379.424 2.12.495.955 1.326 1.167 1.838 2.121.795 1.467.018 2.721.707 4.24.441.99 1.413 1.132 1.837 2.121a9.168 9.168 0 0 1 .849 4.24c0 4.701-4.277 8.058-8.977 8.058-1.413 0-2.19-.565-3.604-.424 2.686 2.686 4.735 3.852 6.785 7.068 2.968 4.647 3.71 7.951 4.382 13.429.11.891.157 1.788.142 2.686 0 7.032-1.096 11.238-4.241 17.528-3.004 6.025-5.566 9.365-11.026 13.287-8.517 6.131-14.72 7.899-25.02 9.895a116.172 116.172 0 0 1-17.105 2.262l-22.052 1.13c-11.238.76-19.03 2.35-27 10.32 3.765 2.756 6.362 5.46 6.362 10.107 0 4.77-2.951 8.18-7.492 9.683-1.06.353-1.838.035-2.827.565-1.184.618-1.131 1.979-2.262 2.686a9.7 9.7 0 0 1-5.937 1.555c-4.205 0-7.068-.99-10.037-3.959-3.445 2.863-4.612 5.443-8.481 7.634-1.273.707-1.927 1.696-3.393 1.696-2.315 0-3.375-1.466-5.23-2.827a35.88 35.88 0 0 1-6.927-6.36c-3.516 2.102-5.672 3.816-9.754 3.816a10.173 10.173 0 0 1-6.22-1.697c-1.113-.689-1.29-1.714-2.403-2.403-1.166-.724-2.138-.459-3.392-.99-4.718-2.031-7.775-5.53-7.775-10.671 0-4.506 2.845-7.369 6.927-9.26-7.828-7.827-15.532-9.187-26.576-9.894l-21.911-1.131a154.24 154.24 0 0 1-17.246-2.262c-5.072-.83-8.075-1.095-12.722-3.251-15.991-7.457-26.187-17.687-28.272-35.198a28.508 28.508 0 0 1-.142-3.887c0-9.118 3.587-14.683 10.036-21.133-1.66-.39-2.774.159-4.382-.424-4.029-1.467-6.926-4.259-6.926-8.553a7.173 7.173 0 0 1 .848-4.028c.548-.972 1.59-1.167 1.837-2.262.318-1.449-.106-2.474.566-3.817.442-.9 1.272-1.078 1.696-1.979 1.396-2.897 3.146-5.23 6.361-5.23 2.757 0 4.524 1.449 5.937 3.817 2.686-1.237 3.428-3.252 4.948-5.796 2.527-4.223 3.675-7.174 3.675-12.086a23.87 23.87 0 0 0-1.413-8.693c-.778-2.333-1.096-3.923-2.827-5.654a6.825 6.825 0 0 1-5.372 2.12 8.135 8.135 0 0 1-7.916-8.34 7.516 7.516 0 0 1 4.665-7.21c-2.421-2.084-4.524-2.261-7.21-3.957-4.081-2.58-5.512-5.301-8.198-9.33-1.75-2.633-2.21-4.47-3.11-7.492a29.36 29.36 0 0 1-1.697-9.612 17.52 17.52 0 0 1 .141-2.545c1.008-7.668 2.386-12.475 7.21-18.518 2.862-3.587 4.806-5.795 9.047-7.633 3.604-1.555 5.76-2.686 9.683-2.686a21.67 21.67 0 0 1 3.04.142c1.583.086 3.127.52 4.523 1.272.6.336 1.696 1.343 1.696.636 0-.813-.424-1.237-.424-2.05 0-3.25 2.332-6.22 5.584-6.22 2.35 0 3.304 2.068 4.453 4.1a6.091 6.091 0 0 0 1.13-3.534c0-5.372-2.88-8.11-6.22-12.298-7.28-9.1-16.397-13.358-16.397-25.02 0-3.48 1.678-5.849 4.665-7.633.865-.513 2.03 0 2.877-.543.725-.46.642-1.395 1.101-2.137a10.415 10.415 0 0 1 2.373-2.525c1.661-1.449 3.12-1.015 4.957-2.287.919-.636 1.136-1.463 1.843-2.31 2.05-2.474 3.89-3.669 7.123-3.669a9.254 9.254 0 0 1 4.04.607c.512.195 1.47.967 1.594.818a7.35 7.35 0 0 1 2.243-1.813 6.37 6.37 0 0 1 3.432-.907c1.732 0 2.866.971 4.598.971.636 0 .783-.635 1.295-.971 1.537-1.042 2.422-1.632 4.295-1.632a7.157 7.157 0 0 1 4.318 1.567c1.43.902 1.637 2.108 3.103 2.957.813.477 1.502.265 2.404.565 4.028 1.343 7.068 4.029 7.068 8.27a6.487 6.487 0 0 1-2.262 5.442c-1.361 1.201-2.65.99-4.382 1.555 5.619 4.488 10.508 5.601 17.682 5.601 6.573 0 14.612-2.687 14.612-9.26 0-3.057-1.69-4.7-2.892-7.509-2.156-5-3.325-7.942-3.325-13.384 0-4.311.47-6.927 2.979-10.426 2.58-3.604 5.731-4.445 10.167-4.445l.002.001z" class="J"/><g class="C H"><path d="M425.59 223.46a5.564 5.564 0 0 0 3.82 3.807 5.894 5.894 0 0 0 5.986-2.177 6.92 6.92 0 0 0 .833-6.297 7.32 7.32 0 0 0-2.698-3.468l-7.938 8.057-.002.079-.001-.001z" stroke-linejoin="round" class="K"/><path d="M626.61 343.94c-1.866-4.51-6.686-2.488-6.983 0-.683 5.732 4.34 7.464 7.916 6.53a6.22 6.22 0 0 0 3.896-3.03 7.55 7.55 0 0 0 .61-5.824 8.38 8.38 0 0 0-3.325-4.471c-1.375-.878-2.874-.965-5.224-.965-8.708 0-16.327 10.289-18.886 20.977a46.074 46.074 0 0 0-.396 18.815 35.044 35.044 0 0 0 9.16 17.585 39.21 39.21 0 0 0 8.99 6.435 38.76 38.76 0 0 0 6.496 2.683 12.41 12.41 0 0 0 6.159.142c5.16-1.12 7.559-5.92 4.96-10.83-2.129-4.02-8.397-6.219-11.352-1.088a5.1 5.1 0 0 0-.628 2.411 4.65 4.65 0 0 0 1.561 3.64c2.246 1.428 5.838 1.024 5.672-2.941" class="B L"/><path d="M599.69 403.07a17.66 17.66 0 0 1 10.343-5.703c4.654-.572 8.699.783 12.828 3.004 8.06 4.335 12.554 8.995 15.549 17.641a26.91 26.91 0 0 1 1.304 9.022c-.14 5.604-1.563 11.73-3.092 14.692-1.334 2.583-4.82 13.994-23.946 21.868-11.161 4.594-28.3 5.653-40.118 6.12-16.256.642-31.254 1.244-39.962 11.973" stroke-width="1.276"/><g stroke-width="1.121"><path d="M603.75 421.45c-.466-1.71-.035-3.35 1.322-5.209 1.814-2.486 5.675-3.343 9.174-1.4a11.61 11.61 0 0 1 3.965 3.266l1.788 2.488a19.33 19.33 0 0 1 1.703 3.887c3.846 10.928-2.265 22.771-10.255 27.522-6.206 3.69-13.608 5.336-22.469 6.375-3.982.468-6.256.437-10.263.623-3.223.149-6.008.096-8.63.064l-6.297-.064a110.46 110.46 0 0 0-11.274.155c-4.55.331-7.972.448-11.818 1.089-2.511.418-5.455.822-8.542 1.515-.926.207-1.865.377-2.809.661l-1.881.575a62.311 62.311 0 0 0-15.257 6.521 27.29 27.29 0 0 0-3.877 2.708c-.665.627-1.472 1.256-2.124 1.898-2.99 2.941-6.047 6.126-6.762 10.438a15.452 15.452 0 0 0-.132 2.507c0 2.798 2.278 6.608 8.42 7.852m8.638-265.811c1.285 2.324 1.992 3.738 1.244 6.142-.847 2.723-2.778 4.354-5.52 4.354-6.22 0-9.878-7.364-7.075-12.051 4.976-8.319 14.539-3.647 23.402.474-.428-2.134-1.174-2.828-1.096-5.471.193-6.565 5.061-9.542 7.005-15.605 1.157-3.613 1.618-6.75-1.025-9.316-2.308-2.24-4.982-2.205-7.994-1.025-6.018 2.359-13.246 9.138-25.97 9.326-12.724-.188-20.012-6.967-26.03-9.326-3.012-1.18-5.686-1.214-7.994 1.025-2.643 2.566-2.183 5.703-1.025 9.316 1.944 6.064 6.812 9.04 7.005 15.605.077 2.643-.669 3.337-1.096 5.47 8.863-4.12 18.798-9.211 23.402-.473 2.565 4.869-.855 12.05-7.075 12.05-2.742 0-4.667-1.747-5.52-4.353a6.71 6.71 0 0 1 1.244-6.142"/><path d="M491.5 224.79c2.403 1.838 4.1 4.1 3.817 7.775-.307 3.986-1.273 4.947-4.382 7.068m3.745-5.933a5.124 5.124 0 0 1-3.534 4.947" class="B"/></g></g><path d="m432.4 214.49 1.088.777 1.166 1.245.778 1.555.389 1.321.078 1.71-.078 1.167-.389 1.322-.778.932-.933 1.011-1.321.7-1.71.389-1.478.233-1.555-.7-1.399-1.01-.855-1.245-.622-1.555v-.621l7.62-7.231h-.001z" class="J"/><g class="C H"><path d="M430.01 220.57c-.478-2.581-3.496-3.11-4.665-1.586-1.8 2.348-.485 6.257 3.176 7.401a5.89 5.89 0 0 0 5.987-2.177 6.78 6.78 0 0 0-1.587-9.451l-.279-.189c-4.252-3.233-11.118-2.488-13.373 2.954-2.909 7.02 3.42 12.284 9.252 16.25 7.34 4.991 15.705 5.899 22.003 5.83 14.306-.155 25.19-6.997 32.265-10.884 1.648-.905 3.345-.72 4.198.311a3.115 3.115 0 0 1-.389 4.276" class="B K"/><path d="m387.6 414.35-3.188 1.166-3.265 2.488-1.4 1.944-1.788 3.11-.777 2.332-.622 2.877-.311 2.177m29.701-15.784-.233 2.8-.467 1.943-1.4 3.343-2.176 2.877-2.333 1.865-1.71.856-2.41.544" stroke-width="1.057"/><path d="M499.6 489.23c-.58 2.588-3.004 5.548-8.279 6.617l-1.025.212" stroke-width="1.197"/><path d="M631.59 406.57a28.457 28.457 0 0 1 7.488 12.109 26.88 26.88 0 0 1 1.303 9.021c-.14 5.604-1.562 11.73-3.091 14.692-1.334 2.584-4.82 13.994-23.946 21.868-11.161 4.595-28.3 5.654-40.118 6.12-16.022.633-30.822 1.227-39.582 11.517" class="M"/><path d="M605.45 416.95c1.188-1.621 5.517-3.673 9.016-1.73a9.68 9.68 0 0 1 3.714 3.243" stroke-width=".929"/><path d="m627.51 402.79 2.244.767c1.997.635 4.134.685 6.158.142 4.423-1.327 7.261-5.459 4.96-10.83a8.856 8.856 0 0 0-2.717-3.333" class="M"/><path d="M375.44 287.13c-2.969 1.838-5.182 2.273-7.492 4.947a43.944 43.944 0 0 0-4.1 10.65m72.032-80.767c0 2.686-1.98 4.382-4.665 4.947" class="B K"/><path d="M620.49 275.03c7.39-.15 28.859 5.64 29.012 30.876.15 24.925-15.383 28.997-21.607 30.656" stroke-width=".997"/><path d="M622.43 275.03c12.743-.554 25.892 8.826 26.472 32.236.452 18.289-12.517 26.584-18.742 28.243" class="L"/><path d="m615.33 363.16.196-2.502.834-3.974 1.178-3.091 1.324-2.551 1.717-2.06m12.161-5.312-.195 2.449-.7 1.672-1.088 1.594-1.244.933-1.904.7-1.672.116-1.244-.195M602.33 268.42l.544-2.643 1.166-2.45 1.517-2.449 2.604-3.343 2.06-2.293 3.343-3.382 2.877-2.916 1.827-2.099 2.41-2.915 2.138-3.227 1.283-2.643.7-3.421.212-4.242-.388-1.23M605.44 429.44l2.527-.505 1.905-1.011 1.05-1.05.738-1.205.505-1.943.04-1.361M364.94 403.38l1.866.155 2.41-.194 2.41-.855m7.814-57.106-.31 2.177-.506.972-.739.933-1.01.777-1.128.505-1.477.234-1.011.078m15.471-24.406-.544 3.382-.661 1.477-1.36 1.866-1.828 1.4-1.866.932-3.615.894m23.904-62.121-.7 2.021-.855 1.478-1.166 1.632-1.633 1.477-1.943.934-1.633.388-1.01-.078m.59-9.682.04 1.555" stroke-width=".881"/><g class="D"><path d="M397.32 325.09a10.71 10.71 0 0 1-3.265 2.029M629.24 397.16c.134.145.581.217.739.31 2.215 1.323 6.577-.325 5.294-3.746" class="B"/><path d="M621.54 349.38c1.573 2.055 4.538 2.588 6.883 1.976a6.22 6.22 0 0 0 3.895-3.03 7.54 7.54 0 0 0 .61-5.825 7.65 7.65 0 0 0-1.325-2.58 10.59 10.59 0 0 0-2.132-2.23c-.17-.111-.339-.262-.518-.383m10.037 53.152a6.23 6.23 0 0 0-1.906-5.711 7.44 7.44 0 0 0-1.36-1.233m.746.734c-.073-2.912-2.456-4.995-5.41-5.513m-6.52 4.433a20.74 20.74 0 0 1-2.042-1.69 24.55 24.55 0 0 1-6.742-16.677c-.037-6.473 2.566-13.062 5.598-15.627M533.07 481.44l2.799-2.566 1.944-1.477 3.654-2.255 3.42-1.632 2.41-.622 4.821-1.089 5.598-.855M511.61 501.2c-2.022 3.11-6.842 7.775-11.896 9.64-5.054-1.865-9.874-6.53-11.895-9.64"/><path d="M491.28 494.73a15.468 15.468 0 0 1-3.468 6.451" class="B"/><path d="m491.78 491.47-.7 3.42m-3.65 6.53-1.477 1.477-2.644 1.477-3.032.934M471.46 227.45a9.8 9.8 0 0 0 .71-4.014c-.193-6.565-5.06-9.542-7.005-15.606-1.157-3.612-1.618-6.75 1.026-9.316 2.307-2.24 4.981-2.205 7.993-1.025 6.018 2.36 13.308 9.138 26.032 9.326-12.724-.188-20.015-6.967-26.032-9.326-3.012-1.18-5.935-1.525-8.242.714-2.644 2.566-1.934 6.015-.777 9.627 1.944 6.064 6.563 9.041 6.756 15.606a9.61 9.61 0 0 1-.834 4.014m29.093-21.08c12.517-.661 23.245-9.071 26.706-9.757 3.086-.612 4.809-.336 7.072 1.721-2.264-2.057-4.842-1.993-7.77-.845-6.018 2.359-13.246 9.138-25.97 9.326M624.59 383.2a24.286 24.286 0 0 1-9.718-19.274c-.036-6.474 2.565-13.061 5.597-15.627M511.17 500.76c-2.021 3.11-6.842 7.775-11.895 9.64-5.054-1.865-9.874-6.53-11.895-9.64"/><path d="m479.17 230.74 3.624-2.018c1.649-.906 3.63-.716 4.483.316a3.27 3.27 0 0 1-.226 4.416" class="B"/><path d="M460.48 239.49c8.588-1.792 15.585-5.638 20.875-8.597M531.78 487.43a4.15 4.15 0 0 1 1.166 1.493 6.91 6.91 0 0 1 .521 1.326 3.353 3.353 0 0 1-2.533 4.008 3.35 3.35 0 0 1-.55.077 5.26 5.26 0 0 1-5.482-3.17M460.04 239.05c8.588-1.792 15.585-5.638 20.875-8.597M633.38 397.49c-1.633.63-2.526.544-4.557-.358-.834-.37-1.788-.943-2.907-1.578-3.98-2.261-8.708-5.824-13.139-14.143a29.387 29.387 0 0 1-2.672-6.992 25.88 25.88 0 0 1-.78-5.212 40.11 40.11 0 0 1 .964-9.72 31.62 31.62 0 0 1 6.376-14.15c1.795-2.463 3.343-3.966 6.686-4.043M398.83 279.88a11.11 11.11 0 0 1 4.12 8.94c0 4.842-4.05 12.75-14.001 15.55a12.945 12.945 0 0 1-9.87-1.18m21.381-6.91a5.39 5.39 0 0 1 2.488 5.07c0 1.664-1.076 3.822-2.907 5.866a19.31 19.31 0 0 1-13.716 6.26 15.986 15.986 0 0 1-9.422-2.735 14.16 14.16 0 0 1-5.987-8.397"/><path d="M400.3 306.71c2.026 1.862 2.648 4.193 2.648 7.129 0 4.29-1.742 7.6-5.75 11.107a19.69 19.69 0 0 1-3.032 2.178M596.4 292.63v5.519m-.44-6.879v7.774m.44-24.604v10.185m-.44-12.435v13.918m-2.97 128.062a29.244 29.244 0 0 1-6.53 8.863 30.66 30.66 0 0 1-9.097 6.375 38.43 38.43 0 0 1-10.263 3.421 52.465 52.465 0 0 1-10.73 1.322 73.824 73.824 0 0 1-9.909-.255c-4.127-.285-6.417-.86-10.538-1.222a83.08 83.08 0 0 0-8.743-.566 44.835 44.835 0 0 0-8.983.643 34.411 34.411 0 0 0-8.086 2.255c-4.198 1.7-8.941 4.665-9.952 5.987-1.01-1.322-5.754-4.286-9.952-5.987a34.42 34.42 0 0 0-8.085-2.255 44.79 44.79 0 0 0-8.984-.643 82.8 82.8 0 0 0-8.743.566c-4.121.362-6.41.937-10.538 1.222a74.2 74.2 0 0 1-9.91.255 52.169 52.169 0 0 1-10.728-1.322 38.667 38.667 0 0 1-10.263-3.42 30.57 30.57 0 0 1-9.097-6.376l-.948-.953m65.889 83.39 2.799-.35m47.301-3.68 2.825-.269 2.69-1.076 1.884-1.144 2.556-3.027.538-1.144.404-2.623.134-1.21M613.23 277.36c1.213-4.128-.268-8.483-4.266-8.366M402.79 341.75a12.78 12.78 0 0 1-5.62 7.293m5.69-72.993a10.186 10.186 0 0 1-5.724 6.26c-2.886 1.304-6.227.086-8.014-1.292"/><path d="M380.95 291.2c2.392 1.253 4.82-.584 4.322-3.696a4.45 4.45 0 0 0-3.933-3.433" class="B"/><path d="M390.87 422.86c.516.485.626 1.115 1.322 1.244 1.05.194 1.866.583 2.915-.816 1.294-1.725.599-4.409-.747-6.098a7.72 7.72 0 0 0-9.112-1.461 11.606 11.606 0 0 0-3.965 3.265l-1.788 2.488a19.351 19.351 0 0 0-1.704 3.887c-3.2 9.098.6 18.664 6.489 24.493"/><path d="M531.59 487.23a9.19 9.19 0 0 1 1.01 1.244 6.18 6.18 0 0 1 .428 1.327 3.353 3.353 0 0 1-3.083 4.084 4.97 4.97 0 0 1-5.267-3.156" class="B"/><path d="M608.5 216.81a11.565 11.565 0 0 1 9.784 10.992c0 6.92-2.331 9.496-5.974 14.446-3.899 5.297-16.638 15.005-16.638 26.045 0 6.686 1.866 10.962 6.686 13.139 3.108 1.404 6.742-.116 8.397-1.61 4.042-3.655 2.426-10.063-1.788-10.829-5.132-.933-6.096 7.145-1.089 6.609M635.73 383.51a5.72 5.72 0 0 0-11.377.99 5.924 5.924 0 0 0 1.615 4.085M599.79 279.88a11.11 11.11 0 0 0-4.12 8.94c0 4.842 4.05 12.75 14.001 15.55 3.814 1.072 7.458.971 9.74-.417M375.61 287.8a14.64 14.64 0 0 0-7.55 5.395c-1.856 2.63-2.938 6.286-3.608 9.485a31.01 31.01 0 0 0 .252 10.41 24.6 24.6 0 0 0 3.602 8.806 12.38 12.38 0 0 0 1.62 1.932 17.35 17.35 0 0 0 1.774 1.373M471.72 469.02c7.576 3.359 13.13 5.875 17.839 13.31a15.464 15.464 0 0 1 1.866 7.62 15.864 15.864 0 0 1-5.21 11.894 12.946 12.946 0 0 1-10.417 3.188c-3.007-.295-5.831-2.488-6.298-4.043M396.88 325.2c4.276 3.343 6.064 6.586 6.064 11.74a13.056 13.056 0 0 1-6.22 11.662"/><path d="M392.99 344.41c6.375 7.93 9.758 12.637 9.952 22.08.181 8.863-2.644 14.927-7.93 21.303" class="B"/><path d="M515.23 239.57a6.42 6.42 0 0 0 2.497-3.485c.753-2.325.77-4.308-.474-6.096 1.534 2.009 1.675 3.705 1.243 6.142-.274 1.552-1.264 2.369-2.497 3.485M596.4 374.24v25.241h.067a38.529 38.529 0 0 1-.212 3.887l-.429 2.703"/><path d="M595.96 371.81v27.223h.067a38 38 0 0 1-.212 3.887l-.729 4.125m.874-67.105v22.702m.44-20.912v18.463m0-41.943v13.841m-.44-15.471v17.064m.44-29.584v5.37m-.44-6.46v7.776m-2.88 101.864-.53 1.084a29.244 29.244 0 0 1-6.53 8.863 30.67 30.67 0 0 1-9.097 6.376 38.43 38.43 0 0 1-10.263 3.42 52.32 52.32 0 0 1-10.73 1.322c-3.305.135-6.615.05-9.908-.255-4.128-.285-6.417-.86-10.538-1.222a83.226 83.226 0 0 0-8.743-.566 44.767 44.767 0 0 0-8.984.644 34.39 34.39 0 0 0-8.086 2.254c-4.197 1.7-8.94 4.665-9.951 5.987-1.011-1.322-5.754-4.286-9.952-5.987a34.36 34.36 0 0 0-8.086-2.254 44.7 44.7 0 0 0-8.983-.644 82.69 82.69 0 0 0-8.743.566c-4.122.362-6.41.937-10.538 1.222a74.2 74.2 0 0 1-9.91.255 52.24 52.24 0 0 1-10.729-1.321 38.705 38.705 0 0 1-10.263-3.421 30.566 30.566 0 0 1-9.096-6.376 34.17 34.17 0 0 1-3.858-4.355m-3.142-4.982a15.78 15.78 0 0 1-3.523 12.034c-1.321 1.4-4.2 4.074-7.775 4.12-5.908.078-7.672-3.986-8.03-4.975M399.4 410.7a16.05 16.05 0 0 1 2.893 3.965c1.477 2.799 1.022 7.48-.148 9.64a6.86 6.86 0 0 1-.475.749M370.04 453.2c3.514 3.687 8.828 7.692 16.99 11.052 11.161 4.595 28.3 5.654 40.118 6.12 15.715.62 30.193 1.266 39.01 10.998m27.132-6.36c2.598 2.556 5.247 5.295 6.366 8.798M488.18 501.7a13.7 13.7 0 0 1-11.501 4.217 9.657 9.657 0 0 1-6.685-4.025m-8.364-4.542a9.78 9.78 0 0 0 .457.577 11.88 11.88 0 0 0 7.978 3.833m41.985-.12c-2.022 3.11-6.842 7.774-11.895 9.64-5.054-1.866-9.874-6.53-11.896-9.64l-.472-.727m24.343.707a12.76 12.76 0 0 0 1.156 1.109 12.95 12.95 0 0 0 10.418 3.187 8.544 8.544 0 0 0 6.36-4.043c.303-.329.539-.715.692-1.136"/><path d="m529.75 500.99-1.16 1.867-1.766 1.463-2.674 1.11-2.421.1"/><path d="M536.03 483.22a12.03 12.03 0 0 1 3.599 4.534 10.78 10.78 0 0 1 .787 3.698 9.15 9.15 0 0 1-2.222 6.474 11.745 11.745 0 0 1-8.43 3.866h-.734m.29-.442a10.67 10.67 0 0 1-8.092-3.375M620.72 391.93a37.11 37.11 0 0 1-7.507-10.077 29.38 29.38 0 0 1-2.672-6.992 25.85 25.85 0 0 1-.78-5.211 40.13 40.13 0 0 1 .964-9.722 32.63 32.63 0 0 1 6.376-14.15 17.19 17.19 0 0 1 3.25-3.488M618.2 223.83c3.965.31 7.639 4.58 7.59 8.764-.07 6.078-2.108 8.59-6.89 14.545-4.12 5.131-16.482 14.15-16.171 22.78a8.51 8.51 0 0 0 1.802 4.39m-4.941 5.411a10.847 10.847 0 0 0 3.207 2.156 7.846 7.846 0 0 0 6.654-.443M576.37 213.9a9.443 9.443 0 0 1 3.415 4.061c2.908 7.02-3.42 12.284-9.252 16.25a33.35 33.35 0 0 1-12.968 5.128m12.125-11.909a6.53 6.53 0 0 1-4.92-2.34 5.225 5.225 0 0 1-1.106-1.552M540.45 231.2a7.23 7.23 0 0 1-2.063-1.504 6.393 6.393 0 0 1-1.242-6.853c.987-2.963 5.746-11.274 5.98-17.027.356-8.79-3.025-13.977-8.313-16"/><path d="m542.68 203.85-.206 3.305-.895 3.374-1.722 4.613-1.308 2.96-1.377 2.961-.688 2.066-.276 1.515.207 1.446M595.81 423.4a4.77 4.77 0 0 0 .933 1.306c1.01 1.687 4.94 4.655 8.514 4.701 5.91.078 7.312-4.057 7.464-4.975.746-4.509-.796-5.743-3.11-7.013a5.263 5.263 0 0 0-2.994-.433" class="B"/><path d="M370.23 403.67c-1.88.535-3.871.546-5.757.033-4.423-1.326-8.007-5.564-6.18-10.829m20.917-49.724a2.8 2.8 0 0 1 .653 1.67c.683 5.732-4.34 7.402-7.916 6.469a8.8 8.8 0 0 1-4.71-3.56 7.354 7.354 0 0 1-.963-3.6m34.466-36.979a7.546 7.546 0 0 1 1.931 2.757M400.9 296.6a5.98 5.98 0 0 1 1.825 2.042"/><path d="M402.91 303.94a13.23 13.23 0 0 1-2.43 3.718 19.312 19.312 0 0 1-13.716 6.26 15.99 15.99 0 0 1-9.422-2.736 14.897 14.897 0 0 1-6.377-8.715" class="B"/><path d="M399.11 280.13a12.11 12.11 0 0 1 3.698 5.295"/><path d="M402.86 292.56a18.42 18.42 0 0 1-13.473 12.248c-3.804.964-8.702-.241-10.374-1.664" class="B"/><path d="M375.06 291.49c.417 4.12 3.174 7.209 8.401 7.308 7.35.138 11.818-10.574 5.287-18.094"/><path d="M358.52 327.39a25.41 25.41 0 0 0 3.63 3.636 26.228 26.228 0 0 0 9.272 5.153m8.248.771c6.569-.789 10.272-5.684 9.538-11.41-.56-4.363-4.563-7.718-7.285-7.912" class="B"/><path d="M390.39 268.92a4.464 4.464 0 0 1 4.449 4.478l-.005.187"/><path d="M389.72 229.81a17.95 17.95 0 0 0 7.86 9.099m225.28 48.381c2.686 3.679.927 10.932-6.379 11.07a8.102 8.102 0 0 1-6.939-3.924" class="B"/><path d="M596.4 239.25v24.686"/><path d="M380.87 291.14c2.255 1.632 5.15-1.124 4.03-4.05-.757-1.975-3.563-4.106-7.45-1.463-4.294 2.92-3.11 12.13 5.13 12.284 7.35.139 11.819-10.574 5.287-18.093-6.282-7.234-17.727-5.542-25.19.396a33.43 33.43 0 0 0-11.04 18.164 34.314 34.314 0 0 0-.912 7.93 35.44 35.44 0 0 0 5.562 18.276 18.21 18.21 0 0 0 2.037 2.56 39.13 39.13 0 0 0 2.954 3.032c4.223 3.515 9.665 6.27 16.327 5.987 7.308-.311 11.507-5.442 10.729-11.507-.754-5.88-6.69-8.805-10.574-6.064-2.644 1.866-3.584 7.644 1.088 9.018 2.644.778 4.976-2.565 3.11-4.509M584.4 210.68c4.218-2.29 7.47-1.867 9.874 1.47a15.457 15.457 0 0 1 2.41 11.28c-.855 4.199-2.068 5.942-5.407 8.988m3.303-19.868c4.82-3.187 10.041-1.834 12.906 2.41 2.1 3.11 2.636 5.712 2.488 9.563a17.555 17.555 0 0 1-8.941 14.383" class="B"/><path d="M617.28 223.67a8.052 8.052 0 0 1 7.153 8.086c0 5.986-1.671 8.583-6.454 14.539-4.12 5.131-16.482 14.15-16.17 22.78.117 3.263 2.868 6.338 5.241 6.51"/><path d="M617.75 291.14c-2.255 1.632-5.131-1.004-3.887-3.803.859-1.932 3.42-4.353 7.308-1.71 4.293 2.92 3.11 12.13-5.131 12.284-7.35.139-12.317-10.297-5.287-18.093 6.416-7.116 18.315-5.723 25.778.214 3.176 2.527 9.566 9.466 10.936 18.573 1.658 11.02 1.445 24.575-9.937 32.922a26.91 26.91 0 0 1-16.516 4.637c-7.308-.32-11.506-5.443-10.729-11.507.754-5.88 6.416-8.368 10.574-6.065 4.32 2.393 3.565 8.466-1.088 9.019-2.736.325-4.976-2.566-3.11-4.51" class="B"/><path d="M613.86 287.34c1.212-5.454 5.885-5.962 9.658-5.907 10.296.151 17.416 12.364 17.535 24.178.15 14.923-6.334 23.711-17.241 24.178-2.823.121-7.684-1.221-7.768-4.665"/><path d="M620.2 284.9c10.858 2.413 14.67 12.196 14.67 21.532 0 7.616-.754 18.022-15.575 21.682" stroke-linecap="square"/><path d="M638.11 389.58a6.104 6.104 0 1 0-9.789 3.66"/><g class="B"><path d="M616.33 380.33a25.82 25.82 0 0 0 9.74 9.238m-1.96 16.482c-5.12-3.359-14.838-7.761-23.624-3.428-3.259 1.608-5.442 3.597-6.675 6.84a15.52 15.52 0 0 0 2.788 14.949c1.321 1.4 4.2 4.074 7.774 4.12 5.91.079 7.314-4.056 7.464-4.975.7-4.276-1.788-5.987-3.11-6.453-1.014-.358-4.312-.266-5.012 2.065a4.174 4.174 0 0 0 .348 3.144"/><path d="M531.99 488.16c1.633 3.343-.224 5.024-2.488 5.287-3.343.388-5.131-2.255-5.364-4.665a6.87 6.87 0 0 1 6.327-7.366l.515-.02a8.674 8.674 0 0 1 7.764 5.477 10.79 10.79 0 0 1 .788 3.697 9.147 9.147 0 0 1-2.223 6.474 11.745 11.745 0 0 1-8.429 3.866c-6.6.265-11.74-5.908-11.74-12.206 0-12.05 17.872-18.623 24.957-20.314 8.708-2.077 14.006-2.855 27.99-3.632 5.597-.311 9.697-.153 15.86-.792a94.33 94.33 0 0 0 14.072-2.162 42.58 42.58 0 0 0 19.592-9.952c4.55-4.131 7.153-7.075 9.26-12.75 1.817-4.898 2.653-14.596-1.951-21.77a22.4 22.4 0 0 0-16.171-10.565c-5.83-.843-10.942 1.672-13.995 7.456-1.477 2.8-1.022 7.48.148 9.64a9.37 9.37 0 0 0 7.471 4.666c5.909.078 7.313-4.057 7.464-4.976.7-4.276-1.788-5.987-3.11-6.453-1.014-.358-4.312-.266-5.012 2.065a4.18 4.18 0 0 0 .347 3.144M526.9 469.02c-7.576 3.359-13.13 5.875-17.839 13.31a15.464 15.464 0 0 0-1.866 7.62 15.864 15.864 0 0 0 5.21 11.894 12.947 12.947 0 0 0 10.417 3.188c3.007-.295 5.832-2.488 6.298-4.043"/></g><path d="M601.73 325.2c-3.545 1.183-6.064 6.586-6.064 11.74a13.056 13.056 0 0 0 6.22 11.662"/><path d="M605.62 344.41c-6.375 7.93-9.758 12.637-9.952 22.08-.182 8.863 2.644 14.927 7.93 21.303" class="B"/><path d="m571.64 212.58.547-.81c2.644-3.887 7.312-4.911 10.73-2.332 4.12 3.11 5.16 8.402 4.042 13.994a13.57 13.57 0 0 1-6.325 8.521"/><path d="M414.22 210.68c-4.043-1.866-7.371-1.507-9.874 1.47-2.877 3.421-2.986 8.453-2.41 11.28.855 4.199 2.068 5.942 5.407 8.988" class="B"/><path d="M404.03 212.55c-4.82-3.187-10.041-1.834-12.906 2.41-2.1 3.11-2.636 5.712-2.488 9.563a17.555 17.555 0 0 0 8.941 14.383"/><path d="M390.12 216.81a10.65 10.65 0 0 0-9.4 10.433c0 6.92 1.703 9.718 5.59 15.005 3.897 5.299 16.638 15.005 16.638 26.045 0 6.686-1.866 10.962-6.686 13.139-3.108 1.404-6.742-.116-8.397-1.61-4.043-3.655-2.426-10.063 1.788-10.829 5.131-.933 6.096 7.145 1.089 6.609m-9.412-51.932c-3.965.31-7.867 3.723-7.867 7.908 0 5.986 2.385 8.761 7.167 14.716 4.121 5.131 15.762 13.972 15.451 22.602-.117 3.263-2.31 7.253-4.488 6.786"/><path d="M372 343.94c1.866-4.51 6.686-2.488 6.983 0 .683 5.732-4.34 7.464-7.916 6.53a6.218 6.218 0 0 1-3.896-3.03 7.55 7.55 0 0 1-.61-5.824 7.66 7.66 0 0 1 1.326-2.581 7.748 7.748 0 0 1 1.999-1.89c1.375-.878 2.874-.965 5.224-.965 8.708 0 16.327 10.289 18.886 20.977a46.039 46.039 0 0 1 .396 18.815 35.051 35.051 0 0 1-9.16 17.585 39.21 39.21 0 0 1-8.99 6.435 38.76 38.76 0 0 1-6.496 2.683 10.954 10.954 0 0 1-6.158.142c-4.423-1.327-7.262-5.46-4.96-10.83 1.792-4.18 8.397-6.219 11.351-1.088a5.1 5.1 0 0 1 .628 2.411 4.648 4.648 0 0 1-1.561 3.64c-2.246 1.428-5.838 1.024-5.671-2.941" class="B"/><path d="M365.24 397.49c1.633.63 2.526.544 4.557-.358.834-.37 1.789-.943 2.907-1.578 3.98-2.261 8.708-5.824 13.139-14.143a29.38 29.38 0 0 0 2.672-6.992 25.87 25.87 0 0 0 .78-5.212 40.06 40.06 0 0 0-.964-9.72 31.607 31.607 0 0 0-6.376-14.15c-1.795-2.463-3.343-3.966-6.686-4.043M360.51 389.58a6.104 6.104 0 1 1 9.789 3.66m-7.419-9.73a5.72 5.72 0 0 1 11.377.99 5.926 5.926 0 0 1-1.615 4.085"/><path d="M374.02 383.2a24.286 24.286 0 0 0 9.718-19.274c.036-6.474-2.565-13.061-5.597-15.627"/><path d="M382.29 380.33a25.82 25.82 0 0 1-9.74 9.238" class="B"/><path d="M397.81 402.63c-1.449-3.409-4.329-4.985-9.019-5.486-4.662-.497-8.698.784-12.828 3.005-8.06 4.335-12.554 8.995-15.55 17.641a26.88 26.88 0 0 0-1.303 9.021c.14 5.604 1.563 11.73 3.091 14.692 1.334 2.584 4.82 13.994 23.946 21.868 11.161 4.595 28.3 5.654 40.118 6.12 16.256.642 31.255 1.245 39.962 11.973"/><path d="M374.5 406.05c5.12-3.359 14.838-7.761 23.624-3.428 3.259 1.608 5.442 3.597 6.675 6.84a15.52 15.52 0 0 1-2.788 14.949c-1.321 1.4-4.2 4.074-7.775 4.12-5.908.079-7.313-4.056-7.463-4.975-.7-4.276 1.788-5.987 3.11-6.453 1.014-.358 4.312-.266 5.011 2.065a4.174 4.174 0 0 1-.347 3.144" class="B"/><path d="M394.86 421.45a5.27 5.27 0 0 0-1.321-5.209 8.013 8.013 0 0 0-9.175-1.4 11.61 11.61 0 0 0-3.965 3.266l-1.788 2.488a19.351 19.351 0 0 0-1.704 3.887c-3.845 10.928 2.413 22.532 10.256 27.522 6.842 4.354 13.84 5.598 22.47 6.375 3.993.36 6.256.437 10.263.623 3.223.149 6.008.096 8.63.064l6.296-.064a110.46 110.46 0 0 1 11.274.155c4.55.331 7.973.448 11.818 1.089 2.512.418 5.456.822 8.543 1.515.926.207 1.865.377 2.808.661l1.882.575a62.33 62.33 0 0 1 15.257 6.521 23.63 23.63 0 0 1 3.877 2.708c.796.795 1.472 1.256 2.123 1.898 2.99 2.941 6.048 6.126 6.763 10.438.112.831.156 1.669.132 2.507 0 2.798-2.278 6.608-8.42 7.852"/><path d="M466.62 488.16c-1.633 3.343.224 5.024 2.488 5.287 3.343.388 5.131-2.255 5.364-4.665a6.87 6.87 0 0 0-6.327-7.366l-.515-.02a8.674 8.674 0 0 0-7.764 5.477 10.79 10.79 0 0 0-.788 3.697 9.147 9.147 0 0 0 2.223 6.474 11.74 11.74 0 0 0 8.429 3.866c6.6.265 11.74-5.908 11.74-12.206 0-12.05-17.873-18.623-24.957-20.314-8.708-2.077-14.006-2.855-27.99-3.632-5.597-.311-9.697-.153-15.86-.792a94.337 94.337 0 0 1-14.073-2.162 42.58 42.58 0 0 1-19.592-9.952c-4.55-4.131-7.153-7.075-9.26-12.75-1.817-4.898-2.652-14.596 1.951-21.77a22.4 22.4 0 0 1 16.172-10.565c5.83-.843 10.942 1.672 13.995 7.456 1.478 2.8 1.022 7.48-.148 9.64a9.37 9.37 0 0 1-7.471 4.666c-5.909.078-7.313-4.057-7.464-4.976-.7-4.276 1.788-5.987 3.11-6.453 1.014-.358 4.312-.266 5.012 2.065a4.18 4.18 0 0 1-.347 3.144"/><path d="m426.97 212.58-.547-.81c-2.644-3.887-7.312-4.911-10.73-2.332-4.12 3.11-5.16 8.402-4.042 13.994a13.572 13.572 0 0 0 6.324 8.521" class="B"/><path d="M573.04 224.37c-6.298 6.842-12.595 9.026-22.003 9.33-2.938.095-8.552-.933-11.818-3.258-2.098-1.494-4.432-4.05-2.954-8.482.987-2.962 5.746-11.273 5.98-17.027.355-8.79-3.026-13.606-8.313-15.472-9.774-3.45-20.267 6.211-26.589 8.319a21.34 21.34 0 0 1-8.008 1.243 21.63 21.63 0 0 1-8.068-1.243c-6.323-2.108-16.816-11.77-26.59-8.32-5.287 1.867-8.668 6.683-8.312 15.473.234 5.753 4.992 14.064 5.98 17.027 1.477 4.431-.857 6.988-2.955 8.481-3.265 2.326-8.88 3.353-11.818 3.259-9.407-.304-15.705-2.488-22.003-9.33"/><path d="M464.58 466.27c1.246.487.303-.295 8.195 3.203 7.576 3.359 12.954 6.3 17.663 13.736a15.464 15.464 0 0 1 1.866 7.62 16.65 16.65 0 0 1-.459 3.841" class="B"/><path d="M465.09 500.06a12.52 12.52 0 0 0 5.081 1.29c6.6.264 11.74-5.91 11.74-12.207 0-4.366-2.377-8.044-5.706-11"/><path d="M466.52 488.15c-1.594 3.553.677 5.475 2.94 5.738a4.91 4.91 0 0 0 5.432-4.328l.026-.337a6.98 6.98 0 0 0-3.278-6.485" class="B"/><path d="M609.53 216.87c5.018 0 9.394 5.585 9.394 11.317 0 6.605-3.513 10.648-6.087 13.705-2.072 2.46-4.316 4.663-6.982 7.348"/><path d="M603.58 211.58a10.822 10.822 0 0 1 4.346 3.819c2.099 3.11 2.633 5.712 2.487 9.563-.249 6.6-4.998 11.17-9.246 13.959m-7.457-27.341a8.66 8.66 0 0 1 1 1.014c2.877 3.421 3.1 8.478 2.41 11.281-1.035 4.213-2.427 6.029-5.846 8.549m-7.914-22.574c4.12 3.11 5.346 8.489 3.98 14.026-.975 3.957-3.463 6.328-6.565 8.217m17.385 64.187c.493 1.447 1.306 1.949 2.332 3.022a21.14 21.14 0 0 0 9.623 5.504c3.334.979 6.928.482 9.87-1.367M365.29 387.87c1.937-.035 3.869 1.273 5.133 3.468a5.09 5.09 0 0 1 .628 2.41 4.276 4.276 0 0 1-1.593 3.453c-2.245 1.43-6.232.815-6.065-3.15" class="B"/><path d="M377.33 336.4c7.703 1.438 15.119 10.729 17.546 20.865a46.03 46.03 0 0 1 .396 18.815 35.05 35.05 0 0 1-9.16 17.585 25.826 25.826 0 0 1-3.323 2.855l-1.643 1.113M368.76 378.67c3.164 0 5.934 3.032 5.934 6.273a5.926 5.926 0 0 1-1.615 4.085m-6.459-6.678a6.84 6.84 0 0 1 6.433 6.546 6.09 6.09 0 0 1-2.316 4.786"/><path d="M396.84 349.2c3.027 4.063 5.025 7.561 5.954 12.07m-.104 13.26a26.98 26.98 0 0 1-2.264 6.322 27.859 27.859 0 0 1-5.552 7.253" class="B"/><path d="M397.32 325.52a14.58 14.58 0 0 1 5.501 7.469"/><path d="M402.9 317.92c-.767 2.66-2.506 4.674-5.266 7.193M383.33 298.27l3.369-.886 1.994-1.508 1.285-1.817 1.108-2.837.444-2.305" class="B"/><path d="M376.51 286.41a20.24 20.24 0 0 0-3.824 1.333 13.97 13.97 0 0 0-5.506 4.576c-1.856 2.63-2.938 6.286-3.608 9.484a30.98 30.98 0 0 0 .252 10.41 24.628 24.628 0 0 0 3.601 8.807 14.292 14.292 0 0 0 1.621 2.087c2.022 2.021 3.888 3.265 6.997 2.643"/><path d="M395.38 271.58c-.546 2.007-1.625 4.493-4.774 4.221" class="B"/><path d="M383.87 285.2c-3.024-2.956-9.43-3.726-15.798.302a24.12 24.12 0 0 0-2.448 1.859 13.847 13.847 0 0 0-2.25 2.482 28.057 28.057 0 0 0-2.182 3.8 19.629 19.629 0 0 0-1.474 4.142 31.717 31.717 0 0 0-1.02 9.776c.176 1.513.32 2.903.567 4.182a29.13 29.13 0 0 0 3.475 9.656c1.407 2.333 4.906 7.69 12.058 8.397 2.811.278 7.612-1.01 7.768-4.665"/><path d="M568.38 220.42c.478-2.581 3.59-3.08 4.758-1.555 1.8 2.348.61 6.382-3.051 7.526a5.89 5.89 0 0 1-5.987-2.177 6.78 6.78 0 0 1 1.585-9.45l.281-.19c4.251-3.234 11.118-2.488 13.372 2.954 2.909 7.02-3.42 12.284-9.252 16.249-7.34 4.992-15.705 5.9-22.003 5.831-14.306-.156-25.19-6.997-32.265-10.884-1.648-.906-3.345-.72-4.198.31a3.117 3.117 0 0 0 .389 4.277M571.26 218a2.625 2.625 0 0 1 2.387 1.267c1.8 2.348.485 6.383-3.176 7.526m27.869 80.537c-5.45 5.933-.437 16.116 3.636 18.418 1.41 1.097 2.013.515 3.14 1.175" class="B"/><path d="M598.63 295.99c-1.788 1.244-2.418 2.642-2.488 5.07a8.196 8.196 0 0 0 2.203 6.272c2.972 3.092 8.786 5.784 14.42 5.855 3.35.097 6.645-.86 9.422-2.736a14.156 14.156 0 0 0 5.987-8.397M595.58 398.6a38 38 0 0 1-.212 3.887 32.805 32.805 0 0 1-9.795 19.671 30.679 30.679 0 0 1-9.097 6.375 38.43 38.43 0 0 1-10.263 3.42 52.317 52.317 0 0 1-10.73 1.322 74.53 74.53 0 0 1-9.909-.254c-4.127-.286-6.417-.86-10.538-1.223a83.34 83.34 0 0 0-8.743-.566 44.763 44.763 0 0 0-8.983.644 34.33 34.33 0 0 0-8.086 2.255c-4.198 1.7-8.941 4.664-9.952 5.986-1.01-1.322-5.754-4.286-9.952-5.986a34.403 34.403 0 0 0-8.085-2.255 44.767 44.767 0 0 0-8.984-.644 82.69 82.69 0 0 0-8.743.566c-4.121.362-6.41.937-10.538 1.223-3.294.306-6.605.39-9.91.254a52.444 52.444 0 0 1-10.728-1.321 38.43 38.43 0 0 1-10.263-3.421 30.66 30.66 0 0 1-9.097-6.375 32.812 32.812 0 0 1-9.796-19.671 37.952 37.952 0 0 1-.212-3.887V239.58h192.55V398.6h.066z"/></g></g><g class="J"><path d="M387.41 421.32a3.91 3.91 0 0 1 3.903-3.911 3.91 3.91 0 0 1 3.911 3.903v.009a3.91 3.91 0 0 1-3.911 3.903 3.91 3.91 0 0 1-3.903-3.903zm-23.99-27.61c0-1.932 1.236-3.499 2.76-3.499s2.76 1.567 2.76 3.499-1.236 3.499-2.76 3.499-2.76-1.567-2.76-3.499z" stroke="#c7b37f" class="E"/><path d="M377.05 324.36a2.674 2.674 0 0 1 5.33.4 2.673 2.673 0 0 1-2.665 2.472 2.775 2.775 0 0 1-2.665-2.873zm47.86-102.55a2.49 2.49 0 0 1 2.636-2.329 2.49 2.49 0 0 1 2.329 2.636 2.488 2.488 0 0 1-2.221 2.32 2.7 2.7 0 0 1-2.744-2.627z"/></g><g stroke="#c7b37f" class="C D"><path d="M373.92 340.54a3.884 3.884 0 0 0-2.138 2.208 6.36 6.36 0 0 0-.381 1.858m7.369 41.794 1.391-1.687a16.95 16.95 0 0 0 1.073-1.47c.344-.539.498-.867.801-1.43l1.05-2.06m-1.975 21.777-2.371 1.088-1.71 1.003-1.945 1.307-1.904 1.523m23.38-59.201-1.283-1.321-1.4-1.322c-.556-.469-.91-.683-1.492-1.12" class="B"/><path d="M397.17 326.47c-.618.319-1.254.602-1.905.848-.751.278-1.54.44-2.34.482"/><path d="M371 300.68c.173.787.391 1.563.653 2.325a12.18 12.18 0 0 0 1.446 2.666 13.05 13.05 0 0 0 1.99 2.457c.655.658 1.383 1.24 2.17 1.734.753.455 1.529.87 2.325 1.244m-1.544-9.156a19.32 19.32 0 0 0 1.944 1.042c.614.261 1.251.461 1.904.598a11.49 11.49 0 0 0 2.683.32 12.09 12.09 0 0 0 2.916-.234m11.203-63.526-3.196-1.866a19.074 19.074 0 0 1-2.923-2.371 14.607 14.607 0 0 1-1.811-2.022c-.563-.76-.778-1.257-1.275-2.06m11.715-7.111c.278.914.613 1.81 1.003 2.682a12.19 12.19 0 0 0 2.224 3.188c1.414 1.552 2.613 1.992 4.283 3.265m2.27-9.245c.28.824.612 1.629.995 2.41.364.68.799 1.318 1.299 1.905a11.468 11.468 0 0 0 2.099 2.06 22.796 22.796 0 0 0 2.939 1.75" class="B"/></g><g fill="#713f2a"><path d="M520.78 211.91c-.08-2.649-2.69-2.924-3.69-2.924-2.885 0-3.666 1.8-7.265 3.732-4.512 2.424-6.455 2.962-10.466 2.998-4.01-.036-6.005-.575-10.517-2.998-3.6-1.932-4.205-3.674-7.091-3.674a3.64 3.64 0 0 0-3.516 3.757l.003.075a6.48 6.48 0 0 0 .093 1.347c.047.204.296.14.374.32a3.64 3.64 0 0 1 .8-2.633 3.415 3.415 0 0 1 2.54-1.313c2.885 0 3.953 1.851 7.553 3.784 4.512 2.423 6.453 2.962 10.464 2.998 4.01-.036 6.007-.575 10.519-2.998 3.6-1.933 4.634-3.938 7.52-3.938a2.12 2.12 0 0 1 2.032 1.667 4.96 4.96 0 0 1 .14 1.293c.026.121.174.109.207.24a4.08 4.08 0 0 0 .3-1.733z" stroke-width=".277" class="H"/><path d="M413.12 434.42c.81-.872 1.423-.544 1.573-.946.11-.297-.13-.327-.46-.45-.44-.165-.906-.26-1.346-.424-.457-.17-.87-.405-1.327-.576-.189-.07-.625-.293-.75.04-.228.61 1.602.558.988 2.2a5.79 5.79 0 0 1-1.274 1.875l-4.141 4.507c-.093.104-.248.326-.342.29s-.082-.309-.083-.45l.06-6.39a8.468 8.468 0 0 1 .303-2.636c.275-.734 1.12-.119 1.297-.59.111-.298.026-.31-.477-.498-.252-.094-.734-.195-1.74-.571l-1.563-.664c-.236-.088-.672-.41-.828.01-.046.123.119.304.16.339.524.294.816.876.74 1.472l.114 11.635c.009.84.1 1.073.258 1.132.173.065.29-.011.633-.4l8.205-8.904v-.001z"/><path d="M417.95 436.22c.533-1.69 1.532-.671 1.723-1.276.067-.214-.001-.275-.482-.426l-2.088-.58-1.788-.642c-.144-.046-.527-.225-.623.077-.196.623 1.77.695 1.26 2.314l-2.693 8.542c-.533 1.69-1.54.864-1.736 1.486-.028.09-.036.224.109.27l1.816.494 2.412.839c.368.116.534.09.596-.106.18-.57-1.872-.316-1.182-2.505l2.676-8.487zm5.78 1.71c.318-1.073.817-.926 1.413-.75 1.626.483 2.135 2.073 1.616 3.827-.313 1.055-.706 2.028-3.153 1.303-.483-.143-1.079-.32-.946-.766l1.07-3.614zm-4.434 7.696c-.667 2.254-1.797 1.278-1.966 1.85-.106.358.248.404.425.457l2.5.663c.677.2 1.09.4 1.364.481.37.11.53.04.579-.12.19-.644-1.621-.383-1.054-2.297l.917-3.095c.185-.626.126-.78.979-.527.805.238 1.047.485 1.184 1.382l.515 3.227c.192 1.186.374 2.465 1.645 2.842.644.19 1.824.112 1.988-.443a.248.248 0 0 0-.149-.316c-.179-.054-.372.005-.533-.042a.617.617 0 0 1-.495-.458l-1.06-5.704c.053-.179.568-.201 1.156-.475a2.963 2.963 0 0 0 1.596-1.959c.244-.823.67-3.44-2.856-4.485l-3.274-.892-1.862-.63c-.193-.056-.381-.015-.434.164-.19.644 1.76.502 1.167 2.505l-2.332 7.872zm13.164 3.854c-.518 2.159-2.154.845-2.324 1.552-.096.4.186.448.48.519l2.303.476 2.269.622c.473.113.787.246.891-.19.122-.507-2.094-.483-1.558-2.715l1.968-8.2c.21-.87.395-.922 1.064-.761l1.388.333c1.895.378.889 2.267 1.542 2.423.425.102.415-.648.435-.874l.22-1.712c.028-.185.089-.44-.156-.498l-5.014-1.127-4.978-1.272c-.245-.06-.306.195-.366.372l-.836 2.332c-.09.228-.283.604.06.686.734.176.815-2.318 2.66-1.875l1.372.33c.669.16.81.29.601 1.161l-2.02 8.418h-.001zm19.84-5.06c.646-1 1.306-.782 1.385-1.204.057-.312-.184-.3-.53-.364-.463-.086-.939-.098-1.401-.184-.479-.089-.928-.248-1.406-.337-.198-.037-.667-.18-.732.168-.119.643 1.675.273 1.355 1.997a5.75 5.75 0 0 1-.93 2.067l-3.295 5.158c-.073.119-.187.364-.286.345s-.134-.29-.16-.428l-1.052-6.305a8.5 8.5 0 0 1-.158-2.648c.143-.77 1.083-.311 1.175-.807.057-.312-.029-.309-.557-.407-.264-.049-.756-.064-1.813-.26l-1.654-.382c-.248-.046-.732-.288-.814.152-.024.129.17.279.217.306.566.199.955.722.984 1.321l2.132 11.44c.155.825.286 1.039.451 1.07.182.034.285-.061.555-.505l6.534-10.193zm.93 10.51c.009.456-.032.6.363.78.848.496 1.756.884 2.702 1.152 2.169.362 3.967-1.02 4.37-3.43.391-2.338-.57-3.312-2.197-4.473-2.037-1.457-2.908-1.85-2.702-3.082a1.774 1.774 0 0 1 2.162-1.624c2.849.476 2.524 3.94 2.905 4.004.364.061.45-.151.486-.562l.23-2.496c.038-.429.134-.697-.115-.738-.215-.036-.679.19-.894.153-.496-.083-1.072-.917-2.43-1.144-1.938-.325-3.521 1-3.875 3.116-.324 1.932.533 2.813 1.84 3.75 2.448 1.753 3.452 2.167 3.19 3.731a2.235 2.235 0 0 1-2.68 1.973c-1.838-.308-2.585-2.154-2.82-4.01-.025-.25-.03-.42-.296-.465-.414-.069-.337.492-.33.758l.091 2.607zm24.72-6.97c.538-1.062 1.217-.915 1.251-1.343.025-.316-.214-.279-.566-.306-.468-.037-.943 0-1.412-.036-.485-.038-.948-.15-1.433-.188-.201-.016-.682-.11-.71.243-.051.651 1.694.096 1.556 1.845a5.77 5.77 0 0 1-.708 2.152l-2.739 5.474c-.06.126-.148.381-.248.374s-.164-.275-.204-.41l-1.704-6.16a8.466 8.466 0 0 1-.435-2.617c.062-.78 1.044-.423 1.084-.925.024-.316-.06-.304-.596-.346-.268-.02-.76.016-1.83-.07l-1.685-.207c-.251-.02-.759-.21-.794.237-.011.13.199.26.247.282a1.476 1.476 0 0 1 1.118 1.21l3.316 11.154c.24.805.393 1.004.56 1.017.184.014.277-.091.499-.56l5.433-10.82z"/><path d="M480.6 457c-.016 1.903-1.626 1.553-1.632 2.3-.002.317.334.226.519.228l1.444-.062 1.98.092c.22 0 .639.024.64-.237.008-.877-2.152.373-2.12-3.21l.055-6.342c0-.168.036-.299.137-.298.084 0 .183.095.3.245l7.992 9.772a.493.493 0 0 0 .434.265c.202 0 .203-.147.206-.558l.092-10.466c.015-1.958 1.44-1.498 1.445-2.058 0-.056.002-.243-.317-.245-.15 0-.74.068-1.797.059l-1.914-.091c-.218 0-.27.184-.271.314-.005.616 2.046.298 2.03 1.996l-.053 6.213c-.005.466-.04.69-.14.689s-.3-.227-.517-.49l-6.678-8.286c-.3-.358-.097-.486-.634-.491-.89-.01-1.327.063-1.764.059-.319 0-.62-.08-.94-.083a.282.282 0 0 0-.29.274c0 .014 0 .027.002.041-.009.895 1.884-.301 1.852 3.281l-.061 7.09V457zm16.26-8.4c.016-1.772 1.27-1.09 1.274-1.724.002-.224-.08-.262-.585-.267-.957-.01-1.562.061-2.166.056-.588 0-1.242-.086-1.897-.09-.151-.002-.57-.062-.573.256-.005.653 1.802.147 1.788 1.845l.015 8.955c-.015 1.772-1.22 1.277-1.225 1.93-.001.093.031.224.182.225.437.01 1.16-.064 1.882-.058l2.55.097c.387 0 .539-.07.54-.275.006-.597-1.882.245-1.862-2.05l.077-8.9zm7.04 8.67c.02 2.22-1.886 1.341-1.88 2.069.006.41.29.39.592.386l2.35-.095 2.351.054c.487 0 .824.05.82-.399-.005-.522-2.15.037-2.17-2.257l-.073-8.433c-.007-.895.16-.99.848-.996l1.427-.011c1.93-.091 1.411 1.984 2.083 1.978.436 0 .245-.73.21-.953l-.2-1.715c-.018-.187-.02-.448-.273-.446l-5.137.12c-2.452.02-3.577-.044-5.139-.03-.252 0-.25.263-.265.45l-.247 2.465c-.031.243-.128.654.224.651.756-.01.231-2.446 2.128-2.462l1.41-.014c.69-.01.858.086.866.98l.075 8.658zm9.78-3.53c-.301.024-.534.061-.549-.125a1.91 1.91 0 0 1 .13-.703l1.03-3.393c.067-.212.133-.236.166-.238.084-.01.034 0 .146.138l1.638 3.259a1.92 1.92 0 0 1 .238.673c.013.186-.221.186-.523.21l-2.276.179zm2.874.784c.436-.034.534.146 1.2 1.553a3.5 3.5 0 0 1 .4 1.222c.09 1.135-1.115 1.024-1.073 1.563.02.26.236.206.537.183l1.835-.22 2.166-.096c.452-.035.605-.01.58-.326-.048-.614-.895.183-1.535-1.096l-5.415-11.028c-.262-.54-.298-.575-.449-.563-.217.018-.273.377-.367.684l-3.651 11.61c-.336 1.074-1.199 1.03-1.165 1.458.02.242.284.183.518.165.485-.038.965-.151 1.467-.19l1.58-.05c.351-.028.88.062.85-.329-.04-.502-1.824-.062-1.93-1.401.013-.507.093-1.01.236-1.497.288-1.258.634-1.36.919-1.382l3.298-.26h-.001zm12.976-7.734c-.168-1.276-.104-1.304 1.91-1.569 3.213-.423 2.2 1.912 2.982 1.81.383-.05.22-.65.171-.889l-.307-1.822a.343.343 0 0 0-.373-.309l-3.793.575-4.438.509a.332.332 0 0 0-.326.337l.001.026c.098.74 1.901-.1 2.12 1.564l1.14 8.658c.297 2.256-1.1 1.424-.988 2.275.016.111.127.19.343.162l2.122-.355 1.99-.186c.417-.055.776-.027.727-.397-.065-.5-1.885.21-2.156-1.843l-.36-2.738c-.142-1.073-.237-1.286.528-1.387l1.232-.162c1.732-.228 1.524 1.795 2.056 1.724.4-.053.212-.705.164-.943l-.55-3.277c-.082-.498-.26-.437-.377-.421-.333.044-.159 1.752-1.59 1.94l-1.05.139c-.715.094-.732-.035-.837-.831l-.34-2.59h-.001zm6.14 4.24c.69 3.724 3.378 5.787 6.697 5.172 5.267-.976 5.44-5.657 4.965-8.225-.721-3.89-3.62-5.8-6.833-5.166-3.939.767-5.574 4.201-4.829 8.219zm1.837-1.422c-.493-2.66-.137-5.345 2.643-5.917 2.123-.431 4.532 1.323 5.283 5.378.565 3.045.096 5.675-2.734 6.256-2.945.603-4.696-3.039-5.192-5.717zm13.023-6.498c-.261-1.089.245-1.21.849-1.355 1.65-.396 2.886.727 3.313 2.505.257 1.07.403 2.11-2.08 2.705-.49.118-1.093.263-1.202-.19l-.88-3.665zm.009 8.882c.549 2.286-.917 2.004-.778 2.585.087.363.417.226.596.183l2.498-.676c.685-.165 1.143-.198 1.421-.265.376-.09.48-.23.44-.393-.156-.654-1.594.478-2.06-1.463l-.753-3.138c-.153-.635-.281-.739.584-.947a1.356 1.356 0 0 1 1.717.605l2.06 2.537c.758.931 1.555 1.949 2.845 1.64.653-.158 1.635-.816 1.5-1.378a.246.246 0 0 0-.286-.199l-.02.004c-.163.039-.3.187-.464.226a.62.62 0 0 1-.657-.149l-3.77-4.41c-.044-.181.39-.458.764-.99a2.96 2.96 0 0 0 .403-2.494c-.2-.835-1.141-3.314-4.717-2.456l-3.281.864-1.928.386c-.196.047-.337.177-.294.359.157.653 1.776-.446 2.264 1.586l1.916 7.983zm13.471-3.012c.556 2.15-1.505 1.758-1.323 2.462.102.398.374.308.667.232l2.257-.66 2.295-.517c.471-.122.81-.152.698-.585-.13-.506-2.076.556-2.65-1.666l-2.112-8.164c-.224-.867-.085-1 .581-1.172l1.382-.358c1.851-.555 1.85 1.584 2.5 1.416.422-.11.061-.767-.027-.976l-.609-1.615c-.063-.177-.128-.43-.372-.367l-4.956 1.36-4.993 1.214c-.244.063-.179.316-.148.5l.356 2.452c.029.243.034.666.375.577.732-.189-.368-2.429 1.469-2.904l1.365-.353c.667-.172.853-.124 1.077.743l2.168 8.381zm8.59-11.46c-.474-1.708.92-1.397.75-2.009-.06-.215-.15-.229-.636-.095l-2.068.651-1.848.435c-.146.04-.565.098-.48.405.174.629 1.863-.382 2.316 1.254l2.394 8.63c.474 1.708-.821 1.564-.647 2.193.025.09.093.207.238.167l1.793-.575 2.48-.61c.371-.103.497-.215.442-.413-.16-.576-1.742.754-2.356-1.458l-2.378-8.575zm3.58 4.17c1.202 3.592 4.15 5.261 7.352 4.19 5.08-1.7 4.6-6.36 3.771-8.836-1.255-3.751-4.391-5.24-7.485-4.166-3.793 1.31-4.934 4.937-3.638 8.812zm1.621-1.664c-.858-2.565-.879-5.273 1.794-6.227 2.043-.723 4.672.68 5.98 4.59.983 2.937.885 5.606-1.836 6.576-2.833 1.006-5.074-2.356-5.938-4.939zm11.919-8.466c-.41-1.041.074-1.232.652-1.46 1.578-.622 2.96.318 3.63 2.02.403 1.024.692 2.033-1.683 2.968-.469.185-1.047.412-1.218-.023l-1.381-3.506v.001zm1.245 8.794c.861 2.187-.63 2.113-.411 2.669.136.347.444.166.616.098l2.378-1.017c.657-.259 1.106-.355 1.371-.46.36-.142.444-.295.382-.452-.246-.625-1.512.697-2.244-1.16l-1.183-3.004c-.24-.608-.38-.692.447-1.018a1.354 1.354 0 0 1 1.784.36l2.393 2.225c.881.816 1.812 1.713 3.046 1.227.625-.246 1.506-1.034 1.294-1.572a.246.246 0 0 0-.31-.158l-.02.007c-.157.062-.272.227-.428.289a.62.62 0 0 1-.672-.056l-4.347-3.843c-.068-.173.323-.508.62-1.085.392-.793.41-1.719.05-2.527-.314-.8-1.59-3.123-5.012-1.776l-3.129 1.313-1.855.65c-.188.075-.31.222-.241.396.246.625 1.696-.688 2.462 1.256l3.009 7.638z"/></g><path d="M412.66 249.25h82.179v82.023H412.66V249.25z" class="G"/><path d="M451.2 313.83a20.15 20.15 0 0 1-.855 5.287c-.933 2.721-.94 2.721-1.796 4.043a13.133 13.133 0 0 1-3.81 3.887 9.42 9.42 0 0 1-5.948 1.71c-5.49-.486-8.038-6.44-9.283-11.273-1.321-5.13-5.073-7.923-7.463-6.064-1.4 1.089-1.479 2.914-.311 4.665a9.01 9.01 0 0 0 4.099 2.8l-2.933 3.731a9.18 9.18 0 0 1-7.535-7.393c-.466-2.488.742-7.134 4.891-8.522 5.297-1.774 8.686 2.004 10.318 5.191 2.246 4.384 3.21 12.434 9.43 11.19 3.384-.677 4.976-5.598 4.976-7.852l2.467-2.644 3.654 1.167.099.078v-.001zm5.12 0a20.15 20.15 0 0 0 .855 5.287c.933 2.721.94 2.721 1.796 4.043a13.133 13.133 0 0 0 3.81 3.887 9.42 9.42 0 0 0 5.948 1.71c5.49-.486 8.038-6.44 9.283-11.273 1.321-5.13 5.073-7.923 7.463-6.064 1.4 1.089 1.479 2.914.311 4.665a9.01 9.01 0 0 1-4.099 2.8l2.933 3.731a9.18 9.18 0 0 0 7.535-7.393c.466-2.488-.742-7.134-4.891-8.522-5.297-1.774-8.686 2.004-10.318 5.191-2.246 4.384-3.21 12.434-9.43 11.19-3.384-.677-4.976-5.598-4.976-7.852l-2.467-2.644-3.654 1.167-.099.078v-.001z" fill="#fff"/><path d="m461.12 278.95 10.76-11.643a4.69 4.69 0 0 0 1.61-3.401l-2.219.345-.497-1.142-.11-1.147 2.981-.63c.048-.484.007-.85.092-1.384.08-.494.19-.76.311-1.244l-3.265.218c.166-.571.128-.875.31-1.406a4.04 4.04 0 0 1 .504-1.103l1.907-.304c.728-.073 1.143-.04 1.873-.085 1.781-3.321 9.19-6.373 14.454-.904 3.81 3.958 2.988 11.219-1.95 13.139a6.32 6.32 0 0 1-6.862-1.11l1.97-3.866c2.722 1.625 4.976-.396 4.821-2.495a4.58 4.58 0 0 0-4.354-4.51c-2.254-.197-3.872 1.093-4.898 3.11-.626 1.231-.336 2.134-.544 3.5a23.92 23.92 0 0 1-.537 3.809 8.76 8.76 0 0 1-2.37 3.592l-11.03 11.935-42.941 46.445-3.227-2.983 43.211-46.737v.001z" class="F"/><path d="M429.51 283.04s2.7 13.372 11.874 33.431c4.665-1.71 7.42-2.8 12.362-2.8s7.697.934 12.362 2.8c9.174-20.059 11.874-33.431 11.874-33.431l-24.236-31.177-24.236 31.177z" fill="#fff"/><path d="m456.12 262.41 16.82 21.637s-2.243 10.52-9.078 26.354a47.33 47.33 0 0 0-7.733-1.32l-.009-46.67v-.001zm-4.74 0-16.82 21.637s2.243 10.52 9.078 26.354a47.33 47.33 0 0 1 7.733-1.32l.009-46.67v-.001zm52.22-13.16h82.179v82.023H503.6V249.25z" class="F"/><path d="M515.11 249.25h12.253v82.023H515.11V249.25zm23.48 0h12.253v82.023H538.59V249.25zm23.48 0h12.253v82.023H562.07V249.25z" class="G"/><path d="M412.97 402.41a20.76 20.76 0 0 0 2.163 6.609c1.477 2.332.932 2.269 4.276 6a23.918 23.918 0 0 0 6.227 4.495 26.955 26.955 0 0 0 6.842 2.496 50.943 50.943 0 0 0 16.574 1.598 98.46 98.46 0 0 0 10.249-1.062 108.8 108.8 0 0 1 11.118-1.01c2.133-.09 4.149-.11 6.142 0 2.457.162 4.899.499 7.308 1.01a79.67 79.67 0 0 1 10.962 3.188l.014-85.655-82.193-.023V398.6s.168 2.86.318 3.81z" class="F"/><path d="m422.51 417.43 3.852 2.241 5.278 1.9-.005-81.528h-9.126l.001 77.387zm45.66 3.71.011-81.099h-9.143v82.396l9.131-.988.001-.309zm18.24-81.09h-9.113v81.381a60.43 60.43 0 0 1 9.13 1.683l-.017-83.064zm-36.49 0v83.331a80.663 80.663 0 0 1-9.173-.003l.002-83.314 9.171-.014z" stroke="#d52b1e" class="E G"/><path d="M585.48 402.39a20.728 20.728 0 0 1-2.163 6.608c-1.477 2.333-.932 2.27-4.275 6.001a23.963 23.963 0 0 1-6.228 4.495 26.91 26.91 0 0 1-6.841 2.495 50.95 50.95 0 0 1-16.574 1.599 98.69 98.69 0 0 1-10.25-1.062 108.633 108.633 0 0 0-11.117-1.01c-2.133-.09-4.15-.11-6.142 0a51.47 51.47 0 0 0-7.309 1.01 82.42 82.42 0 0 0-11.033 3.188l.057-85.655 82.193-.023v58.543s-.168 2.86-.318 3.81v.001z" class="F"/><use xlink:href="#B" class="G"/><g stroke="#fedf00"><use xlink:href="#C" class="B C D"/><use xlink:href="#D" class="E I"/><g class="C D"><use xlink:href="#E" class="B"/><path d="m560.12 369.78.384-.249a8.149 8.149 0 0 0 2.686-1.79"/><g class="B"><path d="M552.38 368.02h.007c3.533-.883 5.885-2.648 7.579-2.869"/><use xlink:href="#F"/></g></g><use xlink:href="#G" class="E I"/></g><path d="M525.13 364.17a15.473 15.473 0 0 1-1.966-.826c.323-.25.587-.265.863-.555.39-.408.373-.788.593-1.319.215-.52.184-.954.671-1.343.329-.22.74-.281 1.118-.165.389.106.703.39.848.766.137.561-.16.886-.246 1.454-.155.47-.221.965-.195 1.46a6.07 6.07 0 0 0 .354.907 15.3 15.3 0 0 1-2.04-.38v.001zm-.99.95a.625.625 0 1 1 1.252-.014.626.626 0 0 1-1.252.018v-.004zm-1.76-16.51-.144-.104c-.383-.31-.42-.653-.601-1.11a4.093 4.093 0 0 1-.315-1.154 7.331 7.331 0 0 1 0-1.048c.02-.314.02-.63 0-.944a2.172 2.172 0 0 0-.21-.944c-.097-.18-.394-.337-.314-.42.094-.096.257-.02.42 0a1.64 1.64 0 0 1 .943.42c.338.262.576.632.672 1.049l.407 1.468c.058.257.154.505.284.734a4.27 4.27 0 0 0 .524.629l-.011.023a9.012 9.012 0 0 1-.777.834c-.261.22-.544.412-.846.573l-.033-.01.001.004zm3.6 10.64 2.23 1.031a9.23 9.23 0 0 0 3.497-3.919 13.839 13.839 0 0 0 1.364-4.313l-1.789-.581-.357.073a15.655 15.655 0 0 1-1.618 4.192 11.63 11.63 0 0 1-2.649 3.034l-.678.483zm4.94 18.12c.282-.439.59-.861.922-1.264a12.73 12.73 0 0 1 1.312-1.15c.163-.011.327.014.48.071a8.677 8.677 0 0 1-.526 2.751 3.48 3.48 0 0 1-.39.979 4.15 4.15 0 0 1-.476.518c-.51-.742-1.33-1.297-1.322-1.906v.001zm33.01 1.85a7.51 7.51 0 0 1 2.936 1.482c.055.155.076.319.063.483a9.05 9.05 0 0 1-1.53.251 8.39 8.39 0 0 1-1.259 0 3.46 3.46 0 0 1-1.048-.105 4.3 4.3 0 0 1-.63-.314c.573-.696.88-1.637 1.468-1.797zm-9.76-2.04a7.53 7.53 0 0 1 2.936 1.482 1.16 1.16 0 0 1 .063.482 8.95 8.95 0 0 1-1.53.252 8.4 8.4 0 0 1-1.259 0 3.46 3.46 0 0 1-1.048-.105 4.3 4.3 0 0 1-.63-.314c.573-.696.88-1.637 1.468-1.797zm-17.34 2.13a13.02 13.02 0 0 1 1.469.538 13.16 13.16 0 0 1 1.468.944 1.2 1.2 0 0 1 .063.483 9.08 9.08 0 0 1-1.531.251 8.38 8.38 0 0 1-1.258 0 3.433 3.433 0 0 1-1.049-.105 4.252 4.252 0 0 1-.63-.314c.573-.696.88-1.637 1.468-1.797zm-8.98-29.8c-.613-.278-1.05-1.045-.66-1.594.155-.22.412-.174.565-.395.144-.254.192-.552.136-.839a5.22 5.22 0 0 0-.21-.944 5.007 5.007 0 0 1-.135-1.048 2.25 2.25 0 0 1 .345-1.573c.211-.279.497-.491.825-.612.147.136-.057.502-.033.822a3.83 3.83 0 0 0 .288 1.153c.202.563.479.809.703 1.363a3.58 3.58 0 0 1 .42 1.363 2.29 2.29 0 0 1-.21 1.154 2.007 2.007 0 0 1-.61.839 1.85 1.85 0 0 1-.796.419 1.15 1.15 0 0 1-.628-.108z" fill="#005eb8"/><use xlink:href="#B" y="36.591" class="G"/><g stroke="#fedf00"><use xlink:href="#C" y="36.591" class="B C D"/><use xlink:href="#D" y="36.591" class="E I"/><g class="C D"><use xlink:href="#E" y="36.591" class="B"/><path d="m560.12 406.371.384-.249a8.149 8.149 0 0 0 2.686-1.79"/><g class="B"><path d="M552.38 404.611h.007c3.533-.883 5.885-2.648 7.579-2.869"/><use xlink:href="#F" y="36.591"/></g></g><use xlink:href="#G" y="36.591" class="E I"/></g><path d="M525.13 400.761a15.473 15.473 0 0 1-1.966-.826c.323-.25.587-.265.863-.555.39-.408.373-.788.593-1.319.215-.52.184-.954.671-1.343.329-.22.74-.281 1.118-.165.389.106.703.39.848.766.137.561-.16.886-.246 1.454-.155.47-.221.965-.195 1.46a6.07 6.07 0 0 0 .354.907 15.3 15.3 0 0 1-2.04-.38v.001zm-.99.95a.625.625 0 1 1 1.252-.014.626.626 0 0 1-1.252.018v-.004zm-1.76-16.51-.144-.104c-.383-.31-.42-.653-.601-1.11a4.093 4.093 0 0 1-.315-1.154 7.331 7.331 0 0 1 0-1.048c.02-.314.02-.63 0-.944a2.172 2.172 0 0 0-.21-.944c-.097-.18-.394-.337-.314-.42.094-.096.257-.02.42 0a1.64 1.64 0 0 1 .943.42c.338.262.576.632.672 1.049l.407 1.468c.058.257.154.505.284.734a4.27 4.27 0 0 0 .524.629l-.011.023a9.012 9.012 0 0 1-.777.834c-.261.22-.544.412-.846.573l-.033-.01.001.004zm3.6 10.64 2.23 1.031a9.23 9.23 0 0 0 3.497-3.919 13.839 13.839 0 0 0 1.364-4.313l-1.789-.581-.357.073a15.655 15.655 0 0 1-1.618 4.192 11.63 11.63 0 0 1-2.649 3.034l-.678.483zm4.94 18.12c.282-.439.59-.861.922-1.264a12.73 12.73 0 0 1 1.312-1.15c.163-.011.327.014.48.071a8.677 8.677 0 0 1-.526 2.751 3.48 3.48 0 0 1-.39.979 4.15 4.15 0 0 1-.476.518c-.51-.742-1.33-1.297-1.322-1.906v.001zm33.01 1.85a7.51 7.51 0 0 1 2.936 1.482c.055.155.076.319.063.483a9.05 9.05 0 0 1-1.53.251 8.39 8.39 0 0 1-1.259 0 3.46 3.46 0 0 1-1.048-.105 4.3 4.3 0 0 1-.63-.314c.573-.696.88-1.637 1.468-1.797zm-9.76-2.04a7.53 7.53 0 0 1 2.936 1.482 1.16 1.16 0 0 1 .063.482 8.95 8.95 0 0 1-1.53.252 8.4 8.4 0 0 1-1.259 0 3.46 3.46 0 0 1-1.048-.105 4.3 4.3 0 0 1-.63-.314c.573-.696.88-1.637 1.468-1.797zm-17.34 2.13a13.02 13.02 0 0 1 1.469.538 13.16 13.16 0 0 1 1.468.944 1.2 1.2 0 0 1 .063.483 9.08 9.08 0 0 1-1.531.251 8.38 8.38 0 0 1-1.258 0 3.433 3.433 0 0 1-1.049-.105 4.252 4.252 0 0 1-.63-.314c.573-.696.88-1.637 1.468-1.797zm-8.98-29.8c-.613-.278-1.05-1.045-.66-1.594.155-.22.412-.174.565-.395.144-.254.192-.552.136-.839a5.22 5.22 0 0 0-.21-.944 5.007 5.007 0 0 1-.135-1.048 2.25 2.25 0 0 1 .345-1.573c.211-.279.497-.491.825-.612.147.136-.057.502-.033.822a3.83 3.83 0 0 0 .288 1.153c.202.563.479.809.703 1.363a3.58 3.58 0 0 1 .42 1.363 2.29 2.29 0 0 1-.21 1.154 2.007 2.007 0 0 1-.61.839 1.85 1.85 0 0 1-.796.419 1.15 1.15 0 0 1-.628-.108z" fill="#005eb8"/><path d="M412.66 249.25h82.179v82.023H412.66V249.25zm90.94 0h82.179v82.023H503.6V249.25zm-90.63 153.16a20.76 20.76 0 0 0 2.163 6.609c1.477 2.332.932 2.269 4.276 6a23.918 23.918 0 0 0 6.227 4.495 26.955 26.955 0 0 0 6.842 2.496 50.943 50.943 0 0 0 16.574 1.598 98.46 98.46 0 0 0 10.249-1.062 108.8 108.8 0 0 1 11.118-1.01c2.133-.09 4.149-.11 6.142 0 2.457.162 4.899.499 7.308 1.01a79.67 79.67 0 0 1 10.962 3.188l.014-85.655-82.193-.023V398.6s.168 2.86.318 3.81zm172.51-.02a20.728 20.728 0 0 1-2.163 6.608c-1.477 2.333-.932 2.27-4.275 6.001a23.963 23.963 0 0 1-6.228 4.495 26.91 26.91 0 0 1-6.841 2.495 50.95 50.95 0 0 1-16.574 1.599 98.69 98.69 0 0 1-10.25-1.062 108.633 108.633 0 0 0-11.117-1.01c-2.133-.09-4.15-.11-6.142 0a51.47 51.47 0 0 0-7.309 1.01 82.42 82.42 0 0 0-11.033 3.188l.057-85.655 82.193-.023v58.543s-.168 2.86-.318 3.81v.001z" stroke-width=".797" class="C H"/><defs><path id="B" d="m524.62 346.91-.594.281a8.45 8.45 0 0 1-.781.813 12.25 12.25 0 0 1-1.25.843c-.22.113-.421.261-.594.438-.252.32-.079.63-.25 1a3.68 3.68 0 0 1-.656.938c-.332.356-.687.69-1.063 1a4.973 4.973 0 0 1-1.093 1 1.77 1.77 0 0 1-.344.187c-.216.067-.35-.011-.563.062-.388.134-.51.563-.78.719.111.218.106.372.218.594.158.323.705 1.215.812 1.437.21.305.27.7.532.781a3.1 3.1 0 0 0 1.312.125 10.76 10.76 0 0 1 2.031.469c.613.254.863.575 1.47.844.406.201.836.348 1.28.437.326.087.664.119 1 .094.25-.024.377-.12.625-.156a.52.52 0 0 1 .125 0l-.03.375c-.006 0 .004.028 0 .031v.062h.062l2.062.906c-.24.358-.33.796-.25 1.219.63 1.888 1.16 3.069 1.469 3.188.615.236.806.865 1.156 1.5-.123.132-.227.2-.344.312a8.998 8.998 0 0 0-1.656 1.813c-.745 1.188-1.248 1.203-.312 2.78.549.926.814 1.1 1.53 2.407a8.16 8.16 0 0 1 .782 1.969 7.64 7.64 0 0 1 .313 1.969l.968.375.657-.657.625-1.187.03-.906a.775.775 0 0 1-.25-.782c.07-.368.515-.29.72-.625.283-.461-.332-.734-.657-1.093-.605-.67-1.43-.833-1.625-1.844-.052-.273.078-.427.375-.719l1.97-1.812a1.46 1.46 0 0 0 .968.125c.28-.053.53.125 1.406.375a2.21 2.21 0 0 0 1.219.03l.375-.093a3.5 3.5 0 0 1 .125.687c.053 1.06-.155 2.995.156 3.5a3.29 3.29 0 0 1 .281.563 1.69 1.69 0 0 1 .22.656v1.875a15.2 15.2 0 0 1-.22 1.75 2.02 2.02 0 0 1-.437 1.062c-.283.364-.595.418-.969.688l-.093 1 1.125.469 1.28.312.688-.281a1.18 1.18 0 0 1 .156-.625c.128-.247.232-.439.47-.531.362-.143.759.129.905-.094.16-.242.06-.338.032-.75-.046-.662-.184-.99-.282-1.657a11.8 11.8 0 0 1-.156-2.75 9.4 9.4 0 0 1 .156-1.562c.172-.883.486-1.311.688-2.188a21.53 21.53 0 0 0 .375-2.468c3.11.48 6.283.353 9.344-.375.169-.037.75-.25.75-.25a8.64 8.64 0 0 0 2.718 1.625c-.006.101-.015.845 0 .968.037.288-.04.482.125.72a.583.583 0 0 0 .375.28.66.66 0 0 0 .657-.156c.226-.201.184-.454.25-.75a3.94 3.94 0 0 0 0-.687c.289.049.582.069.875.062.292.012.585.002.875-.031l.03.468c.028.245-.075.435.032.657.082.215.273.37.5.406a.66.66 0 0 0 .531-.094c.296-.185.264-.498.313-.844.015-.11.011-.692 0-.781l1.031-.375a5.12 5.12 0 0 1-.094.812 5.01 5.01 0 0 1-.25.938 7.2 7.2 0 0 1-.75 1.375c-.301.547-.646 1.07-1.03 1.562l-.563.657c-.256.337-.342.566-.594.906a4.67 4.67 0 0 1-.938 1.062c-.693.55-1.15.11-2.093.844l-.22 1.031 1.438.532 1.282.25.437-.25a1.01 1.01 0 0 1 .219-.75c.191-.24.475-.388.781-.407.361-.059.747.034 1.031-.218.35-.311.349-.914.625-1.47a12.671 12.671 0 0 1 3-3.905c.613-.597 1.138-.758 1.657-1.438.246-.322.52-.469.53-.875.009-.283-.143-.415-.218-.687a9.62 9.62 0 0 1-.187-1c1.521.744.97.646 1.25 1.406.225.615-.033 1.04.062 1.687.111.756.466 1.114.531 1.875a7.42 7.42 0 0 1-.312 2.313 7.14 7.14 0 0 1-.469 2 3.84 3.84 0 0 1-1.156 1.562c-.211.175-.369.25-.594.407l-.125 1.03 1.125.376 1.625.437.375-.343c.164-.655-.055-1.617.406-1.688.406-.062.693 0 .782-.312a5.01 5.01 0 0 0 .093-.625l.625-4.5.407-1.907c.06-.578.197-1.145.406-1.687.734-2.097-.208-2.375-1.063-3.656a2.992 2.992 0 0 1-.687-1.5c-.097-.817.164-1.495.125-2.75v-2.875c.115-.053.222-.121.344-.188a4.08 4.08 0 0 0 2.375-2.469 3.43 3.43 0 0 0 .312-1.468c-.005-.332-.065-.652-.094-1.032a2.76 2.76 0 0 0-.312-.937 3.192 3.192 0 0 0-.563-.844 5.443 5.443 0 0 0-2.718-1.469 13.91 13.91 0 0 0-4.125-.562 26.85 26.85 0 0 0-4.282-.062c-2.006.114-3.128.519-5.125.75a43.35 43.35 0 0 1-4.906.406c-2.26.042-4.42-.46-5.781-.344-2.451.21-2.493.762-6.188 1.063l-3.843.187-2.157-.687a2.425 2.425 0 0 0 1.47-1.031c.271-.366.232-.679.562-1.063.266-.312.443-.622.78-.969a2.2 2.2 0 0 0-.937-.437 2.502 2.502 0 0 0-.937 0c-.425.031-.84.148-1.219.344a2.77 2.77 0 0 0-.844.593 19.624 19.624 0 0 0-2.187-1.218 9.178 9.178 0 0 0-3-.907v.002zm1.969 11.906h.062c-.012.01-.019.022-.03.031l-.032-.031z"/><path id="C" d="m568.77 359.52-.763.244a6.792 6.792 0 0 1-2.6.496c-2.644.202-4.272-1.057-6.998-.847-1.404.108-2.025 1.19-3.46 1.548a9.237 9.237 0 0 1-1.701.282l.512-1.034c-.697.143-1.404.231-2.115.264a7.55 7.55 0 0 1-1.523-.13l1.018-.95a7.219 7.219 0 0 1-1.294-.336 3.923 3.923 0 0 1-1.06-.63l1.69-.353c1.556-.385 2.04-1.147 3.89-1.325 1.15-.111 3.032-.046 7.643.717 3.036.502 4.382.267 5.536-.258a2 2 0 0 0 1.103-1.788 2.14 2.14 0 0 0-.874-1.81 1.74 1.74 0 0 0-1.113-.363"/><path id="D" d="M524.8 350.61a1.84 1.84 0 0 0-1.34.291c-.48.296-.541.697-.888 1.142.445.1.699.361 1.142.254.306-.074.575-.253.761-.507a1.55 1.55 0 0 0 .428-1.156l-.103-.024z"/><path id="E" d="m536.04 363.79.407.8c.224.47.4.961.524 1.467.117.695.197 1.395.24 2.098l.077.376-.05 1.129m6.802-6.95-.354 1.333-.944 3.46-.103.644m-10.859-3.977c.79.176.544 3.36 1.789 4.09"/><path id="F" d="M555.97 363.61a8.14 8.14 0 0 0 .83-.068c1.467-.21 1.703.687 2.725 1.258 1.857 1.039 2.098 2.307 4.3 3.356l.32.155.848.429"/><path id="G" d="M517.7 354.53c.23.064.47.083.707.054.332-.031.484-.238.817-.249a.965.965 0 0 1 .684.125.83.83 0 0 1 .28.342c.101.133.145.3.124.466a.576.576 0 0 1-.614.42.55.55 0 0 1-.544-.272.47.47 0 0 1-.039-.389 1.167 1.167 0 0 1-1.415-.497z"/></defs></svg>'
]

{ #category : #accessing }
ToSandBox class >> path_sharp_electric_bike_SVG [

	<sampleInstance>
	^ '<svg xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" height="24" viewBox="0 0 24 24" width="24"><g><rect fill="none" height="24" width="24"/></g><g><g><path d="M19,7h-0.82L16,1h-4v2h2.6l1.46,4h-4.81l-0.36-1H12V4H7v2h1.75l1.82,5H9.9C9.46,8.77,7.59,7.12,5.25,7.01 C2.45,6.87,0,9.2,0,12c0,2.8,2.2,5,5,5c2.46,0,4.45-1.69,4.9-4h4.2c0.44,2.23,2.31,3.88,4.65,3.99c2.8,0.13,5.25-2.19,5.25-5 C24,9.2,21.8,7,19,7z M7.82,13c-0.4,1.17-1.49,2-2.82,2c-1.68,0-3-1.32-3-3s1.32-3,3-3c1.33,0,2.42,0.83,2.82,2H5v2H7.82z M14.1,11h-1.4l-0.73-2H15C14.56,9.58,14.24,10.25,14.1,11z M19,15c-1.68,0-3-1.32-3-3c0-0.93,0.41-1.73,1.05-2.28l0.96,2.64 l1.88-0.68l-0.97-2.67C18.94,9.01,18.97,9,19,9c1.68,0,3,1.32,3,3S20.68,15,19,15z"/><polygon points="11,20 7,20 13,23 13,21 17,21 11,18"/></g></g></svg>'
]

{ #category : #segmented }
ToSandBox class >> segmentedConfigurationBoardFor: aBar [

	| confPane verticalSwitch wrappingSwitch scrollingSwitch autoDistributionSwitch sameWidthSwitch selectionAnimationSwitch selectOnMouseDownSwitch inspectButton |
	confPane := ToPane vertical.
	confPane padding: (BlInsets all: 5).
	confPane width: 250.
	confPane border: Color lightGray.

	inspectButton := ToButton new labelText: 'Inspect'.
	inspectButton whenClickedDo: [ aBar inspect ].
	confPane addChild: inspectButton.

	verticalSwitch := ToSwitchButton new labelText: 'Vertical'.
	verticalSwitch startFlexible: true.
	verticalSwitch hMatchParent.

	verticalSwitch addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event | aBar vertical: event current ]).
	confPane addChild: verticalSwitch.

	wrappingSwitch := ToSwitchButton new labelText: 'Wrapping'.
	wrappingSwitch startFlexible: true.
	wrappingSwitch hMatchParent.
	confPane addChild: wrappingSwitch.

	sameWidthSwitch := ToSwitchButton new labelText:
		                   'Uniform element width'.
	sameWidthSwitch startFlexible: true.
	sameWidthSwitch hMatchParent.
	sameWidthSwitch checked: false.
	confPane addChild: sameWidthSwitch.

	scrollingSwitch := ToSwitchButton new labelText: 'Scrolling'.
	scrollingSwitch startFlexible: true.
	scrollingSwitch hMatchParent.

	confPane addChild: scrollingSwitch.

	wrappingSwitch addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event |
				 | v |
				 v := event current.
				 aBar nodeWrapping: v.
				 sameWidthSwitch enabled: v.
				 scrollingSwitch disabled: v ]).

	sameWidthSwitch addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event |
				 | v |
				 v := event current.
				 aBar flowLineUniformWidth: v ]).

	scrollingSwitch addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event |
				 | v |
				 v := event current.
				 aBar nodeScrolling: v ]).

	autoDistributionSwitch := ToSwitchButton new labelText:
		                          'Auto-distribution'.
	autoDistributionSwitch startFlexible: true.
	autoDistributionSwitch hMatchParent.

	confPane addChild: autoDistributionSwitch.
	autoDistributionSwitch addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event |
				 | v |
				 v := event current.
				 aBar nodeAutoDistribution: v ]).

	selectionAnimationSwitch := ToSwitchButton new labelText:
		                            'Animate selection transition'.
	selectionAnimationSwitch startFlexible: true.
	selectionAnimationSwitch hMatchParent.

	confPane addChild: selectionAnimationSwitch.
	selectionAnimationSwitch addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event |
				 | v |
				 v := event current.
				 aBar selectionMode option animationDuration: (v
						  ifTrue: [ 200 milliSeconds ]
						  ifFalse: [ 0 milliSeconds ]).
				 aBar secondarySelectionMode option animationDuration: (v
						  ifTrue: [ 150 milliSeconds ]
						  ifFalse: [ 0 milliSeconds ]) ]).

	wrappingSwitch checked: true.

	selectOnMouseDownSwitch := ToSwitchButton new
		                           labelText: 'Select on mouse down';
		                           id: #selectOnMouseDownSwitch.
	selectOnMouseDownSwitch startFlexible: true.
	selectOnMouseDownSwitch hMatchParent.

	confPane addChild: selectOnMouseDownSwitch.
	selectOnMouseDownSwitch addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event |
			 aBar selectionMode selectOnMouseDown: event current ]).

	wrappingSwitch checked: true.

	aBar
		addEventHandlerOn: ToBarNodeVisibilityEvent
		do: [ :event |
		event invisibleNodes ifNotEmpty: [ :in | in traceCr ] ].

	^ confPane
]

{ #category : #segmented }
ToSandBox class >> segmentedDashBoardFor: aSegmentedElement [

	| mainPane barPane confPane checkingStrategyPane |
	mainPane := ToPane horizontal.
	mainPane matchParent.

	confPane := self segmentedConfigurationBoardFor: aSegmentedElement.
	(confPane childWithId: #selectOnMouseDownSwitch) disable.
	confPane padding: (BlInsets all: 5).
	confPane width: 250.
	confPane border: Color lightGray.
	barPane := ToPane vertical.
	barPane matchParent.
	
	checkingStrategyPane := self checkingStrategyChooserFor: aSegmentedElement.
	confPane addChild: checkingStrategyPane.
	
	mainPane addChildren: {
			confPane.
			barPane }.
	barPane addChild: aSegmentedElement.

	^ mainPane
]

{ #category : #select }
ToSandBox class >> selectWithEditingMultiSelection [

	| select phtext |
	select := ToMultiSelectElement new.
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

{ #category : #bar }
ToSandBox class >> selectionModeChooserFor: aBar [

	| selectionModeGroup buttons selectionModeContainer |
	selectionModeGroup := ToCheckableGroup new.
	buttons := OrderedCollection new.
	{ #Multiple. #Single. #Disabled } do: [ :mode |
		| chb |
		chb := ToCheckbox new
			       labelText: mode asString;
			       id: mode.
		buttons add: chb ].

	selectionModeGroup registerAll: buttons.
	selectionModeGroup addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 | mode |
				 mode := event checkedList first id asSymbol.
				 aBar selectionMode enabled: mode ~= #Disabled.
				 mode = #Multiple
					 ifTrue: [ aBar selectionMode multiple: true ]
					 ifFalse: [
					 mode = #Single ifTrue: [ aBar selectionMode multiple: false ] ] ]).
	buttons first checked: true.
	selectionModeContainer := ToPane vertical.
	selectionModeContainer border: Color lightGray.
	selectionModeContainer padding: (BlInsets all: 2).
	selectionModeContainer hMatchParent.
	selectionModeContainer addChild: (ToLabel text: 'Selection mode').
	selectionModeContainer addChildren:
		selectionModeGroup registeredCheckables.
	^ selectionModeContainer
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

{ #category : #accessing }
ToSandBox class >> statesOfAmericaWithGroups [

	^ {
		  (#West
		   ->
			   { #Hawaii. #Alaska. #Washington. "#Oregon. #California.
			   #Nevada. #Idaho. #Utah. #Arizona" }).
		  (#'Middle-west'
		   -> { #Montana. #Wyoming. "#Colorado. #'New Mexico'" }).
		  (#Middle
		   ->
			   { #'North Dakota'. #'South Dakota'. #Nebraska. "#Kansas. #Oklahoma.
			   #Texas "}).
		  (#'Middle-east'
		   ->
			   { #Minnesota. #Iowa. #Missouri. "#Arkansas. #Louisiana. #Wisconsin.
			   #Michigan. #Illinois. #Indiana. #Kentucky. #Tennessee. #Mississippi.
			   #Alabama" }).
		  (#East
		   -> { #Ohio. #'West Virginia'. #Virginia. #'North Carolina'.
			   #'South Carolina'. "#Georgia. #Florida. #Pennsylvania.
			   #'New York'. #Maryland. #Delaware. #'New Jersey'. #Connecticut.
			   #'Rhode Island'. #Massachusetts. #'New Hampshire'.
			   #Maine. #Vermont" }) }
]

{ #category : #tabs }
ToSandBox class >> subTabPane [

	| nb but |
	nb := ToTabPane new.
	nb resizablePanes: true.
	1 to: 3 do: [ :index |
		but := ToTab new.
		but labelText: 'sub tab ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane addChild: self subsubTabPane withHeaderOnRightBottom ].
		nb addTab: but ].
	^ nb
]

{ #category : #tabs }
ToSandBox class >> subsubTabPane [

	| nb but |
	nb := ToTabPane new.
	nb resizablePanes: true.
	1 to: 4 do: [ :index |
		but := ToTab new.
		but labelText: 'sub sub tab ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane addChild: self subsubsubTabPane withHeaderOnBottomLeft ].
		nb addTab: but ].
	^ nb
]

{ #category : #tabs }
ToSandBox class >> subsubsubTabPane [

	| nb but |
	nb := ToTabPane new.
	nb resizablePanes: true.
	1 to: 2 do: [ :index |
		but := ToTab new.
		but labelText: 'sub sub sub tab ' , index asString.
		but paneBuilder: [ :pane :theNoteBook | pane background: Color random ].
		nb addTab: but ].
	^ nb
]

{ #category : #triplet }
ToSandBox class >> tripletWithText [

	| but |
	but := ToTripletElement new.
	but middleElement: (ToLabel text: 'Middle').
	but startElement: (ToLabel text: 'Start').
	but endElement: (ToLabel text: 'End').
	^ but
]

{ #category : #'see class side' }
ToSandBox >> seeClassSide [ 
]
