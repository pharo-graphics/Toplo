Class {
	#name : #ToSandBox,
	#superclass : #Object,
	#category : #'Toplo-Examples-SandBox'
}

{ #category : #accordion }
ToSandBox class >> accordionWithLabel [

	^ self accordionWithLabelText: 'Header'
]

{ #category : #accordion }
ToSandBox class >> accordionWithLabelAndAlbumInBody [

	| inst |
	inst := ToAccordionElement new.
	inst headerBuilder: [ :header |
		header addChild: (ToLabel text: 'Header') ].
	inst bodyBuilder: [ :body |
		| album |
		album := ToAlbum new
			         withSaveCapability;
			         whenSaveRequestedDo: [ :saveRequested |
				         saveRequested accepted: true ];
			         whenCancelRequestedDo: [ :cancelRequested |
				         cancelRequested editorElement text: '' ];
			         yourself.
		album hMatchParent.
		album vFitContent.
		album next constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal matchParent ].
		album infinite constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal matchParent ].
		album minHeight: 50.
		album text: 'AAAAAAAA'.
		body addChild: album ].
	^ inst
]

{ #category : #accordion }
ToSandBox class >> accordionWithLabelText: aString [

	| inst |
	inst := ToAccordionElement new.
	inst headerBuilder: [ :header |
		header addChild: (ToLabel text: aString) ].
	inst bodyBuilder: [ :body |
		body addChild: (ToLabel text: 'Body with random color');
			hMatchParent;
			height: 100;
			background: Color random ].
	inst
		vFitContent;
		hMatchParent.
	^ inst
]

{ #category : #'finite list' }
ToSandBox class >> alignmentChooserFor: aCheckableBar [

	| buttons alignContainer alignGroup |
	alignGroup := ToCheckableGroup new.
	buttons := OrderedCollection new.
	{ #None. #Start. #Center. #End } do: [ :mode |
		| chb |
		chb := ToCheckbox new
			       labelText: mode asString;
			       id: mode.
		buttons add: chb ].

	alignGroup registerAll: buttons.
	
	alignGroup addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |
				 | mode |
				 mode := event checkedList first id asSymbol.
				 mode = #None
					 ifTrue: [ aCheckableBar alignNone ]
					 ifFalse: [
						 mode = #Start
							 ifTrue: [ aCheckableBar alignStart ]
							 ifFalse: [
								 mode = #Center
									 ifTrue: [ aCheckableBar alignCenter ]
									 ifFalse: [ aCheckableBar alignEnd ] ] ] ]).
	buttons first checked: true.
	aCheckableBar isAlignStart ifTrue: [ buttons second checked: true ].
	aCheckableBar isAlignCenter ifTrue: [ buttons third checked: true ].
	aCheckableBar isAlignEnd ifTrue: [ buttons fourth checked: true ].
	alignContainer := ToPane vertical.
	alignContainer hMatchParent.
	alignContainer addChild: (ToLabel text: 'Alignment').
	alignContainer layout cellSpacing: 0.
	alignContainer addChildren: alignGroup registeredCheckables.
	^ alignContainer
]

{ #category : #select }
ToSandBox class >> buildSelectListElementIn: aSelectElement withIconProvider: anIconProviderClass [

	| icProvider styles iconDescs |
	aSelectElement manager minHeight: 85.
	aSelectElement popupListElement withRowNumbers.
	aSelectElement popupListElement placeholderBuilder: [ :placeholder :e |
		placeholder empty labelText: 'No Icon' ].

	icProvider := anIconProviderClass.
	styles := ToIconStyle allSubclasses asArray sort: [ :a :b |
		          a name < b name ].

	iconDescs := Array streamContents: [ :stream |
			             styles do: [ :style |
					             | s |
					             s := ('_' , style prefix , '_loaded') asSymbol.
					             (icProvider respondsTo: s) ifTrue: [
							             | iconNames |
							             iconNames := (icProvider perform: s) sorted.
							             iconNames do: [ :n |
									             stream nextPut: (ToIconDescExampleObject new
											              name: n;
											              style: style;
											              provider: icProvider;
											              yourself) ] ] ] ].

	aSelectElement popupListElement nodeBuilder: [ :node :iconDesc :holder |
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
					 extent: 24 asPoint;
					 yourself).
			node addChildren: {
					stylePane.
					iclabPane.
					imPane }.
			node childrenDo: [ :child |
				child constraintsDo: [ :c | c linear vertical alignCenter ] ] ].

	aSelectElement sieve filter: [ :iconDesc :pattern |
			(iconDesc style prefix
				 includesSubstring: pattern
				 caseSensitive: true) or: [
				iconDesc name beginsWith: pattern caseSensitive: true ] ].

	aSelectElement popupListElement dataAccessor addAll: iconDescs
]

{ #category : #'finite list' }
ToSandBox class >> checkingStrategyChooserFor: aCheckableBar [

	| checkingStrategyContainer checkingStrategyGroupPane |
	checkingStrategyGroupPane := ToCheckableGroupPane vertical.
	{
		(#Strict -> #withStrictCheckingStrategy).
		(#Weak -> #withWeakCheckingStrategy).
		(#None -> #withNoneCheckingStrategy) } do: [ :modeAssoc |
		| chb |
		chb := ToRadioButton new
			       labelText: modeAssoc key asString;
			       yourself.
		checkingStrategyGroupPane addChild: chb.
		chb
			checkAction: [ :evt  |
				chb isChecked ifTrue: [
					| message |
					message := modeAssoc value.
					aCheckableBar perform: message ] ] ].

	checkingStrategyGroupPane registeredCheckables first checked: true.
	checkingStrategyContainer := ToPane vertical.
	checkingStrategyContainer vFitContent.
	checkingStrategyContainer hMatchParent.
	checkingStrategyContainer addChild:
		(ToLabel text: 'Checking strategy').
	checkingStrategyContainer addChild:
		checkingStrategyGroupPane.
	^ checkingStrategyContainer
]

{ #category : #accordion }
ToSandBox class >> exampleAccordionWithLabel [

	<script>
	| inst |
	inst := self accordionWithLabel.
	inst openInSpace.

	^ inst
]

{ #category : #accordion }
ToSandBox class >> exampleAccordionWithLabelAndAlbumInBody [

	<script>
	| inst |
	inst := self accordionWithLabelAndAlbumInBody.
	inst openInSpace.
	^ inst
]

{ #category : #accordion }
ToSandBox class >> exampleAccordionWithLabelChecked [

	<script>
	| inst |
	inst := self accordionWithLabel.
	inst checked: true.
	inst openInSpace.
	^ inst
]

{ #category : #accordion }
ToSandBox class >> exampleAccordionWithLabelExpanded [

	<script>
	| inst |
	inst := self accordionWithLabel.
	inst isExpanded: true.
	inst openInSpace.
	^ inst
]

{ #category : #accordion }
ToSandBox class >> exampleAccordionWithLabelNotPreservingBody [

	<script>
	| inst |
	inst := self accordionWithLabel.
	inst preserveBody: false.
	inst openInSpace.
	^ inst
]

{ #category : #accordion }
ToSandBox class >> exampleAccordionWithLabelNotPreservingBodyAndExpanded [

	<script>
	| inst |
	inst := self accordionWithLabel.
	inst preserveBody: false.
	inst isExpanded: true.
	inst openInSpace.
	^ inst
]

{ #category : #accordion }
ToSandBox class >> exampleBorderlessAccordionWithLabel [

	<script>
	| inst |
	inst := self accordionWithLabel.
	inst addStamp: #borderless.
	inst openInSpace.

	^ inst
]

{ #category : #accordion }
ToSandBox class >> exampleCheckableListWithAccordions [

	<script>
	| list |
	list := ToCheckableListElement infinite.
	list group withNoneCheckingStrategy.
	(1 to: 500) do: [ :i |
		list addItem: (self accordionWithLabelText: 'Header ' , i asString) ].
	list openInSpace.
	^ list
]

{ #category : #accordion }
ToSandBox class >> exampleGhostAccordionWithLabel [

	<script>
	| inst |
	inst := self accordionWithLabel.
	inst addStamp: #ghost.
	inst openInSpace.

	^ inst
]

{ #category : #theme }
ToSandBox class >> exampleLocalThemeChangesChildrenLookup [

	| space parent child changeButton |
	space := BlSpace new.

	parent := ToButton new
		          extent: 200 asPoint;
		          position: 50 asPoint;
		          border: (BlBorder paint: Color red width: 4).

	child := ToButton new
		         extent: 100 @ 50;
		         constraintsDo: [ :c | c ignoreByLayout ];
		         position: 30 asPoint.

	space root addChild: parent.
	parent addChild: child.

	changeButton := ToButton new
		                extent: 200 @ 50;
		                position: 300 @ 50;
		                clickAction: [
				                (parent localTheme isNil or: parent localTheme class = ToRawTheme)
					                ifTrue: [ parent localTheme: ToRawDarkTheme new ]
					                ifFalse: [ parent localTheme: ToRawTheme new ] ];
		                label: (ToLabel text: 'Change parent local theme');
		                yourself.

	space root addChild: changeButton.

	space show
]

{ #category : #accordion }
ToSandBox class >> examplePaneWithAccordionsWithCheckableGroup [

	<script>
	| pane |
	pane := ToCheckableGroupPane vertical.
	pane hMatchParent.
	pane group withWeakCheckingStrategy.
	pane vFitContent.
	(1 to: 5) do: [ :i |
		pane addChild:
			((self accordionWithLabelText: 'Header ' , i asString)
				 isExpanded: false;
				 expandIconAtStart: false;
				 yourself) ].
	pane openInSpace.
	^ pane
]

{ #category : #accordion }
ToSandBox class >> examplePaneWithAccordionsWithLabel [

	<script>
	| pane |
	pane := self paneWithAccordionsWithLabel.
	pane openInSpace.
	^ pane
]

{ #category : #accordion }
ToSandBox class >> examplePaneWithAccordionsWithLabelWithExtra [

	<script>
	| pane |
	pane := self paneWithAccordionsWithLabel.
	pane childrenDo: [ :acc |
			| im btn |
			im := ToImage inner:
				      (ToAntDesignIconProvider innerImageNamed: 'outlined_search').
			im extent: 18 asPoint.
			btn := ToButton new icon: im.
			btn clickAction: [ ].
			btn addStamp: #iconic.
			btn addStamp: #borderless.
			acc headerExtraBuilder: [ :extra | extra addChild: btn ] ].
	pane openInSpace.
	^ pane
]

{ #category : #accordion }
ToSandBox class >> examplePaneWithAccordionsWithLabelWithExtra2 [

	<script>
	| pane |
	pane := self examplePaneWithAccordionsWithLabelWithExtra.
	pane childrenDo: [ :acc |
		acc expandIconAtStart: false ].
	^ pane
]

{ #category : #accordion }
ToSandBox class >> examplePaneWithNestedAccordions [

	<script>
	| pane |
	pane := ToPane new.
	pane layout: BlLinearLayout vertical.
	pane hMatchParent.
	pane vFitContent.
	(1 to: 5) collect: [ :i |
		| accordion |
		accordion := ToAccordionElement new.
		accordion headerBuilder: [ :header |
			header addChild: (ToLabel text: 'This is panel header 1') ].
		accordion bodyBuilder: [ :body |
			body addChild:
				(self accordionWithLabelText: 'This is panel nest panel') ].
		pane addChild: accordion ].
	pane openInSpace.
	^ pane
]

{ #category : #list }
ToSandBox class >> example_2ListsWithEditableAndContextMenu [

	| win1 win2 l1 l2 space |
	l1 := self listWithEditableAndContextMenu.
	l2 := self listWithEditableAndContextMenu.
	l2 toConfiguration useCheckbox: true.
	
	win1 := ToInnerWindow new.
	win1 pane addChild: l1.
	win2 := ToInnerWindow new.
	win2 pane addChild: l2.
	
	space := BlSpace new.
	space root addChild: win1.
	space root addChild: win2.
	space show

]

{ #category : #tree }
ToSandBox class >> example_AllClasses [
	"For this example we created a new wrapper dealing with classes and methods at the same time, a new Node was also created (ToTreeSubAndMethNode) to apply a new skin (ToTreeNodeSubAndMethSkin) with new icons and a different background color for methods "

	| l |
	l := ToTreeElement new.
	l nodeManager childrenGetter: [ :dataItem |
			dataItem isClass
				ifTrue: [
						Array streamContents: [ :stream |
								stream nextPutAll: dataItem subclasses.
								stream nextPutAll:
									(dataItem methods collect: [ :each | each selector ]) sorted ] ]
				ifFalse: [ #(  ) ] ].
	l nodeManager nodeFactory: [ :holder | ToExTreeSubAndMethNode new ].
	l withRowNumbers.
	l contextMenuBuilder: [ :menu :request |
			| selectionModel indexes target |
			target := request currentTarget.
			selectionModel := request selectionModel.
			indexes := request selectedIndexes.
			indexes traceCr.
			menu addItem: (ToMenuItem new
					 labelText: 'Expand all';
					 clickAction: [
							 indexes
								 ifEmpty: [ target expandAll ]
								 ifNotEmpty: [
									 indexes reverseDo: [ :idx |
											 (target dataSource at: idx) expandAll ] ] ];
					 yourself).
			menu addItem: (ToMenuItem new
					 labelText: 'Collapse all';
					 clickAction: [
							 indexes
								 ifEmpty: [ target collapseAll ]
								 ifNotEmpty: [
									 indexes reverseDo: [ :idx |
											 (target dataSource at: idx) collapse ] ] ];
					 yourself) ].

	l dataAccessor addAll:
		((Smalltalk globals allClasses select: [ :cls |
			  cls subclasses notEmpty ]) sorted: [ :a :b | a name < b name ]).

	l openInSpace.
	^ l
]

{ #category : #tree }
ToSandBox class >> example_AllClassesWithCheckbox [
	"For this example we created a new wrapper dealing with classes and methods at the same time, a new Node was also created (ToTreeSubAndMethNode) to apply a new skin (ToTreeNodeSubAndMethSkin) with new icons and a different background color for methods "

	| l |
	l := self example_AllClasses.
	l toConfiguration useCheckbox: true
]

{ #category : #window }
ToSandBox class >> example_AllSimplePopups [

	| p pane |
	pane := ToPane new.
	pane vertical: true.
	pane layout cellSpacing: 20.
	{
		ToAnchoredBottomCenterPlacement new.
		ToAnchoredBottomLeftPlacement new.
		ToAnchoredBottomRightPlacement new.
		ToAnchoredTopCenterPlacement new.
		ToAnchoredTopLeftPlacement new.
		(ToActionPlacement new action: [ :theWin :evt :aBoundsUpdater |
				 | theElem theRoot |
				 theElem := theWin anchorElement.
				 theRoot := theWin anchorRoot.
				 theWin position:
					 theElem bounds inSpace bounds topLeft - (0 @ theWin height) ]).
		ToAnchoredTopRightPlacement new } do: [ :placement |
			p := self newPopup.
			p placement: placement.
			p measurement: (ToActionMeasurement new action: [ :spec :w :e |
					 spec widthSpec beExact: 130 ]).
			pane addChild: p anchorElement ].
	pane addChild: self themeSelectNoDeselectionPopupOnTop.
	pane position: 150 @30.
	pane openInSpace
]

{ #category : #anchors }
ToSandBox class >> example_AnchorLayout [

	| pane pink blue red green |
	pane := ToElement new id: #pane.
	pane matchParent.
	pane layout: BlAnchorLayout new.
	pane border: Color red.
	pane padding: (BlInsets horizontal: 5 vertical: 12).

	blue := ToElement new
		        id: #blue;
		        yourself.
	blue background: Color blue.
	blue extent: 30 asPoint.
	blue constraintsDo: [ :c |
			c anchors add: (blue rightAnchor on: pane rightAnchor).
			c anchors add: (blue bottomAnchor on: pane bottomAnchor) ].
	pane addChild: blue.

	pink := ToElement new
		        id: #pink;
		        yourself.
	pink background: Color pink.
	pink extent: 10 asPoint.
	pink constraintsDo: [ :c |
			c anchors add: (pink rightAnchor on: pane rightAnchor).
			c anchors add: (pink bottomAnchor on: pane bottomAnchor) ].
	pane addChild: pink.

	red := ToElement new
		       id: #red;
		       yourself.
	red background: Color red.
	red extent: 20 asPoint.
	red margin: (BlInsets all: 10).
	red constraintsDo: [ :c |
			c anchors add: (red rightAnchor on: blue leftAnchor).
			c anchors add: (red bottomAnchor on: blue bottomAnchor) ].
	pane addChild: red.

	green := ToElement new
		         id: #green;
		         yourself.
	green background: Color green.
	green extent: 10 @ 60.
	"green margin: (BlInsets all: 10)."
	green constraintsDo: [ :c |
			c anchors add: (green bottomAnchor on: red topAnchor).
			c anchors add: (green rightAnchor on: blue leftAnchor) ].
	pane addChild: green.

	pane openInInnerWindow
]

{ #category : #anchors }
ToSandBox class >> example_AnchorLayout1v2 [

	| pane blue |
	pane := ToElement new
		        id: #pane;
		        yourself.
	pane matchParent.
	pane layout: BlAnchorLayout new.
	pane border: Color red.
	pane padding: (BlInsets all: 2).

	blue := ToElement new
		        id: #blue;
		        yourself.
	blue background: Color blue.
	blue margin: (BlInsets all: 10).
	blue constraintsDo: [ :c |
			c anchors add: (blue rightAnchor on: pane rightAnchor).
			c anchors add: (blue bottomAnchor on: pane bottomAnchor).
			c anchors add: (blue extentAnchor on: pane extentAnchor) ].
	pane addChild: blue.

	pane openInInnerWindow
]

{ #category : #anchors }
ToSandBox class >> example_AnchorLayout1v3 [

	| pane blue |
	pane := ToElement new
		        id: #pane;
		        yourself.
	pane matchParent.
	pane layout: BlAnchorLayout new.
	pane border: Color red.
	pane padding: (BlInsets all: 2).

	blue := ToElement new
		        id: #blue;
		        yourself.
	blue background: Color blue.
	blue margin: (BlInsets all: 10).
	blue constraintsDo: [ :c |
			c anchors add: (blue topLeftAnchor on: pane topLeftAnchor).
			c anchors add: (blue extentAnchor on: pane extentAnchor) ].
	pane addChild: blue.

	pane openInInnerWindow
]

{ #category : #anchors }
ToSandBox class >> example_AnchorLayout1v4 [

	| pane blue |
	pane := ToElement new
		        id: #pane;
		        yourself.
	pane matchParent.
	pane layout: BlAnchorLayout new.
	pane border: Color red.
	pane padding: (BlInsets all: 2).

	blue := ToElement new
		        id: #blue;
		        yourself.
	blue background: Color blue.
	blue constraintsDo: [ :c |
			c anchors add: (blue leftAnchor on: pane leftAnchor).
			c anchors add: (blue topAnchor on: pane topAnchor).
			c anchors add: (blue extentAnchor on: pane extentAnchor) ].
	pane addChild: blue.

	pane openInInnerWindow
]

{ #category : #anchors }
ToSandBox class >> example_AnchorLayout2 [

	| pane blue topLeft topRight bottomLeft bottomRight topCenter rightCenter bottomCenter leftCenter center |
	pane := ToElement new.
	pane matchParent.
	pane layout: BlAnchorLayout new.
	pane border: Color red.
	"pane padding: (BlInsets all: 10)."

	blue := ToElement new
		        id: #blue;
		        yourself.
	blue background: Color blue muchDarker darker.
	blue extent: 100 asPoint.
	blue margin: (BlInsets all: 10).
	blue constraintsDo: [ :c |
			c anchors add:
				(blue verticalCenterAnchor on: pane verticalCenterAnchor).
			c anchors add:
				(blue horizontalCenterAnchor on: pane horizontalCenterAnchor) ].

	pane addChild: blue.

	topLeft := ToElement new
		           id: #topLeft;
		           yourself.
	topLeft background: Color blue.
	topLeft extent: 20 asPoint.
	"topLeft margin: (BlInsets all: 10)."
	topLeft constraintsDo: [ :c |
			c anchors add: (topLeft rightAnchor on: blue leftAnchor).
			c anchors add: (topLeft bottomAnchor on: blue topAnchor) ].
	pane addChild: topLeft.

	topCenter := ToElement new
		             id: #topCenter;
		             yourself.
	topCenter background: Color blue.
	topCenter extent: 20 asPoint.
	"topLeft margin: (BlInsets all: 10)."
	topCenter constraintsDo: [ :c |
			c anchors add:
				(topCenter horizontalCenterAnchor on: blue horizontalCenterAnchor).
			c anchors add: (topCenter bottomAnchor on: blue topAnchor) ].
	pane addChild: topCenter.

	topRight := ToElement new
		            id: #topRight;
		            yourself.
	topRight background: Color blue.
	topRight extent: 20 asPoint.
	"topLeft margin: (BlInsets all: 10)."
	topRight constraintsDo: [ :c |
			c anchors add: (topRight leftAnchor on: blue rightAnchor).
			c anchors add: (topRight bottomAnchor on: blue topAnchor) ].
	pane addChild: topRight.

	rightCenter := ToElement new
		               id: #rightCenter;
		               yourself.
	rightCenter background: Color blue.
	rightCenter extent: 20 asPoint.
	"topLeft margin: (BlInsets all: 10)."
	rightCenter constraintsDo: [ :c |
			c anchors add:
				(rightCenter verticalCenterAnchor on: blue verticalCenterAnchor).
			c anchors add: (rightCenter leftAnchor on: blue rightAnchor) ].
	pane addChild: rightCenter.

	bottomLeft := ToElement new
		              id: #bottomLeft;
		              yourself.
	bottomLeft background: Color blue.
	bottomLeft extent: 20 asPoint.
	"topLeft margin: (BlInsets all: 10)."
	bottomLeft constraintsDo: [ :c |
			c anchors add: (bottomLeft rightAnchor on: blue leftAnchor).
			c anchors add: (bottomLeft topAnchor on: blue bottomAnchor) ].
	pane addChild: bottomLeft.


	bottomCenter := ToElement new
		                id: #bottomCenter;
		                yourself.
	bottomCenter background: Color blue.
	bottomCenter extent: 20 asPoint.
	"topLeft margin: (BlInsets all: 10)."
	bottomCenter constraintsDo: [ :c |
			c anchors add:
				(bottomCenter horizontalCenterAnchor on:
					 blue horizontalCenterAnchor).
			c anchors add: (bottomCenter topAnchor on: blue bottomAnchor) ].
	pane addChild: bottomCenter.

	bottomRight := ToElement new
		               id: #bottomRight;
		               yourself.
	bottomRight background: Color blue.
	bottomRight extent: 20 asPoint.
	"topLeft margin: (BlInsets all: 10)."
	bottomRight constraintsDo: [ :c |
			c anchors add: (bottomRight leftAnchor on: blue rightAnchor).
			c anchors add: (bottomRight topAnchor on: blue bottomAnchor) ].
	pane addChild: bottomRight.

	leftCenter := ToElement new
		              id: #leftCenter;
		              yourself.
	leftCenter background: Color blue.
	leftCenter extent: 20 asPoint.
	"topLeft margin: (BlInsets all: 10)."
	leftCenter constraintsDo: [ :c |
			c anchors add:
				(leftCenter verticalCenterAnchor on: blue verticalCenterAnchor).
			c anchors add: (leftCenter rightAnchor on: blue leftAnchor) ].
	pane addChild: leftCenter.

	center := ToElement new
		          id: #center;
		          yourself.
	center background: Color blue.
	center extent: 20 asPoint.
	"topLeft margin: (BlInsets all: 10)."
	center constraintsDo: [ :c |
		c anchors add: (center centerAnchor on: blue centerAnchor) ].
	pane addChild: center.


	pane openInInnerWindow
]

{ #category : #anchors }
ToSandBox class >> example_AnchorLayout3 [

	| pane blue |
	pane := ToElement new.
	pane matchParent.
	pane layout: BlAnchorLayout new.
	pane border: Color red.
	"pane padding: (BlInsets all: 10)."

	blue := ToElement new
		        id: #blue;
		        yourself.
	blue background: Color blue muchDarker darker.
	blue extent: 100 asPoint.
	blue margin: (BlInsets all: 10).
	blue constraintsDo: [ :c |
		c anchors add: (blue centerAnchor on: pane centerAnchor) ].

	pane addChild: blue.

	pane openInInnerWindow
]

{ #category : #anchors }
ToSandBox class >> example_AnchorLayout4 [

	| pane blue leftCenter |
	pane := ToElement new id: #pane.
	pane matchParent.
	pane layout: BlAnchorLayout new.
	pane border: Color red.
	"pane padding: (BlInsets all: 10)."
	blue := ToElement new
		        id: #blue;
		        yourself.
	blue background: Color blue muchDarker darker.
	blue extent: 100 asPoint.
	blue margin: (BlInsets all: 10).
	blue constraintsDo: [ :c |
			c anchors add: (blue rightAnchor on: pane rightAnchor).
			c anchors add: (blue topAnchor on: pane topAnchor).
			c anchors add: (blue heightAnchor on: pane heightAnchor).
			c anchors add: (blue heightAnchor on: pane heightAnchor) ].
	pane addChild: blue.

	leftCenter := ToElement new
		              id: #leftCenter;
		              yourself.
	leftCenter background: Color blue.
	leftCenter extent: 20 asPoint.
	leftCenter margin: (BlInsets all: 10).
	leftCenter constraintsDo: [ :c |
			c anchors add: (leftCenter rightAnchor on: blue leftAnchor).
			c anchors add:
				(leftCenter verticalCenterAnchor on: blue verticalCenterAnchor) ].
	pane addChild: leftCenter.

	pane openInInnerWindow
]

{ #category : #anchors }
ToSandBox class >> example_AnchorLayout5 [

	| pane blue |
	pane := ToElement new
		        id: #pane;
		        yourself.
	pane matchParent.
	pane layout: BlAnchorLayout new.
	pane border: Color red.
	pane padding: (BlInsets all: 20).

	blue := ToElement new
		        id: #blue;
		        yourself.
	blue background: Color blue.
	blue constraintsDo: [ :c |
			c anchors add: (blue leftAnchor on: pane leftAnchor).
			c anchors add: (blue topAnchor on: pane topAnchor).
			c anchors add: (blue heightAnchor on: pane widthAnchor).
			c anchors add: (blue widthAnchor on: pane heightAnchor) ].
	pane addChild: blue.

	pane openInInnerWindow
]

{ #category : #anchors }
ToSandBox class >> example_AnchorLayout6 [

	| pane blue yellowInBlue red blackInYellow |
	pane := ToElement new
		        id: #pane;
		        yourself.
	pane matchParent.
	pane layout: BlAnchorLayout new.
	pane border: Color red.

	blue := ToElement new
		        id: #blue;
		        yourself.
	blue layout: BlBasicLayout new.
	blue background: Color blue.
	blue constraintsDo: [ :c |
			c anchors add: (blue heightAnchor on: pane heightAnchor - 40).
			c anchors add: (blue widthAnchor on: pane widthAnchor - 40).
			c anchors add: (blue leftAnchor on: pane leftAnchor + 20).
			c anchors add: (blue topAnchor on: pane topAnchor + 20) ].
	pane addChild: blue.

	yellowInBlue := ToElement new
		                id: #yellow;
		                yourself.
	yellowInBlue layout: BlBasicLayout new.
	yellowInBlue background: Color yellow.
	yellowInBlue extent: 80 asPoint.
	yellowInBlue position: 50 asPoint.
	blue addChild: yellowInBlue.

	blackInYellow := ToElement new
		                 id: #blackInYellow;
		                 yourself.
	blackInYellow background: Color black.
	blackInYellow extent: 30 asPoint.
	blackInYellow position: 20 asPoint.
	yellowInBlue addChild: blackInYellow.

	red := ToElement new
		       id: #red;
		       yourself.
	red background: Color red.
	red extent: 30 asPoint.
	red constraintsDo: [ :c |
			c anchors add: (red topAnchor on: blackInYellow bottomAnchor + 10).
			c anchors add: (red leftAnchor on: blackInYellow leftAnchor) ].
	pane addChild: red.



	pane openInInnerWindow
]

{ #category : #anchors }
ToSandBox class >> example_AnchorLayout7 [

	| pane blue red |
	pane := ToElement new.
	pane matchParent.
	pane layout: BlAnchorLayout new.
	pane border: Color red.
	"pane padding: (BlInsets all: 10)."

	blue := ToElement new
		        id: #blue;
		        yourself.
	blue background: Color blue muchDarker darker.
	blue extent: 100 asPoint.
	blue margin: (BlInsets all: 10).
	blue constraintsDo: [ :c |
		c anchors add:
			(blue centerAnchor on: pane centerAnchor + 40 asPoint) ].

	red := ToElement new
		       id: #red;
		       layout: BlFrameLayout new;
		       yourself.
	red background: Color red.
	red extent: 20 @ 20.
	red constraintsDo: [ :c |
			c anchors add: ((red pointAnchor point: 20 asPoint) on:
					 (blue pointAnchor point: 0 asPoint)) ].


	pane addChild: blue.
	pane addChild: red.

	pane openInInnerWindow
]

{ #category : #anchors }
ToSandBox class >> example_AnchorLayout8 [

	| pane blue red |
	pane := ToElement new.
	pane matchParent.
	pane layout: BlAnchorLayout new.
	pane border: Color red.
	"pane padding: (BlInsets all: 10)."

	blue := ToElement new
		        id: #blue;
		        yourself.
	blue background: Color blue muchDarker darker.
	blue extent: 100 asPoint.
	blue margin: (BlInsets all: 10).
	blue constraintsDo: [ :c |
		c anchors add: (blue centerAnchor on: pane centerAnchor) ].

	red := ToElement new
		       id: #red;
		       layout: BlFrameLayout new;
		       yourself.
	red background: Color red.
	red extent: 20 @ 20.
	red constraintsDo: [ :c |
			c anchors add:
				(red topRightAnchor on: (blue pointAnchor point: -10 asPoint)) ].


	pane addChild: blue.
	pane addChild: red.

	pane openInInnerWindow
]

{ #category : #anchors }
ToSandBox class >> example_AnchorLayout9 [

	| pane blue red |
	pane := ToElement new.
	pane matchParent.
	pane layout: BlAnchorLayout new.
	pane border: Color red.
	"pane padding: (BlInsets all: 10)."

	blue := ToElement new
		        id: #blue;
		        yourself.
	blue background: Color blue muchDarker darker.
	blue extent: 100 asPoint.
	blue margin: (BlInsets all: 10).
	blue constraintsDo: [ :c |
		c anchors add: (blue centerAnchor on: pane centerAnchor) ].

	red := ToElement new
		       id: #red;
		       layout: BlFrameLayout new;
		       yourself.
	red background: Color red.
	red extent: 20 @ 20.
	red constraintsDo: [ :c |
			c anchors add:
				(red topRightAnchor + (0 @ 10) on:
					 (blue pointAnchor point: 0 asPoint)) ].


	pane addChild: blue.
	pane addChild: red.

	pane openInInnerWindow
]

{ #category : #anchors }
ToSandBox class >> example_AnchorWithPointTransition [

	| pane blue red |
	pane := ToElement new.
	pane matchParent.
	pane layout: BlAnchorLayout new.
	pane border: Color red.

	blue := ToElement new
		        id: #blue;
		        yourself.
	blue background: Color blue muchDarker darker.
	blue extent: 20 asPoint.
	blue position: 50 asPoint.
	pane addChild: blue.

	red := BlElement new
		       id: #red;
		       yourself.
	red background: Color red.
	red extent: 40 asPoint.
	red constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add:
				(red bottomRightAnchor on: blue topLeftAnchor - (2 @ 2)) ].
	pane addChild: red.

	red enqueueTask: (BlTaskAction new action: [
				 | anim |
				 anim := ToPointTransition new.
				 anim from: 50 asPoint.
				 anim to: 500 @ 500.
				 anim duration: 10 seconds.
				 anim onStepDo: [ :aPosition :target | target position: aPosition ].
				 anim delay: 400 milliSeconds.
				 blue addAnimation: anim ]).

	pane openInSpace
]

{ #category : #circular }
ToSandBox class >> example_AnimatedAnnulus [

	| container animation colors |
	container := ToAnnulusCircularElement new.
	container geometry: BlCircleGeometry new.
	container matchParent.
	container innerRadius: 0.05.
	container outerRadius: 1.0.

	colors := Color wheel: 8.
	1 to: colors size do: [ :n |
			| sector |
			sector := ToAnnulusSectorElement new.
			sector background: (colors at: n).
			container addChild: sector ].

	animation := BlNumberTransition new
		             beInfinite;
		             from: 0;
		             to: 360;
		             duration: 3 seconds;
		             onStepDo: [ :number :anElement |
			             anElement startAngle: number ].
	container addAnimation: animation.
	container openInSpace
]

{ #category : #filters }
ToSandBox class >> example_AnyEventFilter [

	| space e |
	space := BlSpace new.
	e := ToElement new
		     position: 100 asPoint;
		     extent: 100 asPoint;
		     background: Color red.
	space root addChild: e.
	space root addEventFilter: (ToOutsideEventFilter new
			 eventsToHandle: { BlUIEvent };
			 element: e).
	e
		addEventHandlerOn: ToAnyUIEventOutsideEvent
		do: [ :evt | evt sourceEvent traceCr ].
	space show
]

{ #category : #list }
ToSandBox class >> example_BasicListWithAllClasses [

	| l |
	l := ToListElement new.
	"l nodeFactory: [
			| node |
			node := ToBasicListNode new.
			node addEventHandlerOn: BlSecondaryClickEvent do: [ :evt |
					| t |
					t := evt currentTarget.
					t holder listElement
						notifyClickOnNode: evt currentTarget
						fromEvent: evt ].
			node ]."
	l contextMenuBuilder: [ :menu :request |
			menu addItem: (ToMenuItem new
					 labelText: 'Inspect';
					 clickAction: [ l inspect ];
					 yourself) ].
	l nodeBuilder: [ :node :dataItem :holder |
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

	l dataAccessor addAll:
		(Smalltalk globals allClasses sorted: [ :a :b | a name < b name ]).
	l selecter selectIndexes: #( 10 12 3 ).
	l withRowNumbers.
	l requestFocus.
	l openInInnerWindow.
	^ l
]

{ #category : #list }
ToSandBox class >> example_BasicListWithAllClassesWithCheckboxes [

	| l |
	l := self example_BasicListWithAllClasses.
	l toConfiguration useCheckbox: true
]

{ #category : #'wrapped list' }
ToSandBox class >> example_BasicWrappedListWithAllClasses3 [

	| l |
	l := ToWrappedListElement new nodeBuilder: [ :node :dataItem :holder |
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
	l withRowNumbers.
	l dataAccessor addAll:
		(Smalltalk globals allClasses sorted: [ :a :b | a name < b name ]).
	l selecter selectIndexes: #(10 12 3).

	l requestFocus.
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
							          onStepDo: [ :aSize :target | target extent: aSize ]).
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
	e extent: 30 @ 30.
	e background: Color blue.
	anim := ToBoundsTransition new
		        from: (10 @ 10 extent: 10 @ 10);
		        to: (300 @ 100 extent: 300 @ 400);
		        duration: 3000 milliSeconds;
		        onStepDo: [ :aRectangle :target |
				        target position: aRectangle origin.
				        target extent: aRectangle extent ].
	anim onFinishedDo: [ e background: Color red ].
	e addAnimation: anim.
	anim delay: 100 milliSeconds.

	e openInSpace
]

{ #category : #transitions }
ToSandBox class >> example_BoundsTransitionWithParallelAnimation [

	| e |
	e := BlElement new.
	e extent: 30 @ 30.
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
							          onStepDo: [ :aSize :target | target extent: aSize ]) }.
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
	toggle openInInnerWindow
]

{ #category : #checkables }
ToSandBox class >> example_CheckAction [

	| containerElement r1 |
	(containerElement := ToPane vertical) padding: (BlInsets all: 10).

	r1 := ToRadioButton new
		      id: #r1;
		      labelText: 'Dark theme';
		      checkAction: [ :evt |
			      evt currentTarget space toTheme: (evt currentTarget isChecked
						       ifTrue: [ ToRawDarkTheme new ]
						       ifFalse: [ ToRawTheme new ]) ];
		      yourself.
	r1 checked: (Toplo defaultThemeClass = ToRawDarkTheme).
	containerElement addChildren: { r1 }.
	containerElement openInSpace
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
	btn extent: 500 @ 100.
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
	btn extent: 500 @ 100.
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

{ #category : #checkables }
ToSandBox class >> example_CheckableGroupPane [

	| cgroup |
	cgroup := ToCheckableGroupPane new.
	{ #None. #Start. #Center. #End } do: [ :mode |
			| chb |
			chb := ToCheckbox new
				       labelText: mode asString;
				       id: mode.
			cgroup addChild: chb ].
	cgroup vertical: true.
	cgroup openInSpace
]

{ #category : #checkables }
ToSandBox class >> example_Checkbox [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new label: (ToLabel text: 'Checkbox').
	chb addEventHandlerOn: ToSkinEvent do: [ :evt | evt traceCr ].
	chb checkAction: [ :evt   |
		evt target isChecked traceCr ].
	chb openInInnerWindow
]

{ #category : #checkables }
ToSandBox class >> example_Checkbox2 [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new label: (ToLabel text: 'Checkbox').
	chb switchToNextCheckStateOnClick: false.
	chb addEventHandlerOn: BlClickEvent do: [ :event | chb checked: chb checked not ].
	chb addEventHandlerOn: ToSkinEvent do: [ :evt | evt traceCr ].
	chb checkAction: [ :evt   |
		evt target isChecked traceCr ].
	chb openInInnerWindow
]

{ #category : #checkables }
ToSandBox class >> example_CheckboxChecked [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new label: (ToLabel text: 'Checkbox').
	chb addEventHandlerOn: ToSkinEvent do: [ :evt | evt traceCr ].
	chb checkAction: [ :evt   |
		evt target isChecked ].
	chb checked: true.
	chb openInInnerWindow
]

{ #category : #checkables }
ToSandBox class >> example_CheckboxCheckedDisabled [

	| chb sp disBtn |
	ToTheme cleanUp.
	chb := ToCheckbox new label: (ToLabel text: 'Checkbox').
	chb addEventHandlerOn: ToSkinEvent do: [ :evt | evt traceCr ].
	chb checkAction: [ :evt  |
		'isChecked: ' trace.
		evt target isChecked traceCr ].
	chb checked: true.
	chb disabled: true.
	disBtn := ToSwitchButton new labelText: 'Enable/disable'.
	disBtn checkAction: [ chb enabled: chb isEnabled not ].
	disBtn checked: chb isEnabled.

	sp := BlSpace new.
	sp root layout: BlLinearLayout vertical.
	sp root addChild: chb.
	sp root addChild: disBtn.

	sp show
]

{ #category : #checkables }
ToSandBox class >> example_CheckboxGroupAndNoneStrategy [

	| group container buttons |
	group := ToCheckableGroup new.
	group withNoneCheckingStrategy.
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

	container := ToElement new.
	group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :evt | evt checkedList traceCr ].

	container constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChildren: group registeredCheckables.
	container openInSpace
]

{ #category : #checkables }
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
	buttons third checked: true.
	group registerAll: buttons.
	container := ToElement new.
	group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :evt | evt checkedList traceCr ].
	container constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChildren: group registeredCheckables.
	container openInSpace
]

{ #category : #checkables }
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

	container := ToElement new.
	group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :evt | evt checkedList traceCr ].
	container constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	container layout: BlLinearLayout vertical.
	container layout cellSpacing: 5.

	container addChildren: group registeredCheckables.
	container openInSpace
]

{ #category : #checkables }
ToSandBox class >> example_CheckboxNoLabel [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new.
	chb checked: true.
	chb openInInnerWindow
]

{ #category : #checkables }
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

{ #category : #checkables }
ToSandBox class >> example_CheckboxStartFlexibleWithGroupPane [

	| group |
	group := ToCheckableGroupPane vertical.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new
			       startFlexible: true;
			       hMatchParent;
			       beEndToStart;
			       labelText: idx asString;
			       id: idx asString.
		group addChild: chb ].
	group registeredCheckables second checked: true.

	group 
		groupCheckAction: [ :evt | evt checkedList traceCr ].
	group matchParent.
	group openInSpace
]

{ #category : #checkables }
ToSandBox class >> example_CheckboxUnchecked [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new
				startInterspace: 10;
		       label: (ToLabel text: 'Checkbox');
		       id: 1 asString.
	chb openInInnerWindow
]

{ #category : #checkables }
ToSandBox class >> example_CheckboxVertical [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new label: (ToLabel text: 'Checkbox').
	chb beVertical.
	chb addEventHandler: (BlEventHandler
			 on: ToSkinEvent
			 do: [ :evt | evt target = chb ifTrue: [ evt traceCr ] ]).
	chb checked: true.
	chb openInInnerWindow
]

{ #category : #checkables }
ToSandBox class >> example_CheckboxVerticalGroupHorizontal [

	| group |
	
	group := ToCheckableGroupPane horizontal.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToRadioButton new
			       beVertical;
			       labelText: idx asString;
			       id: idx asString.
		chb beEndToStart.
		group addChild: chb ].
	group registeredCheckables second checked: true.
	group groupCheckAction:[ :evt | evt checkedList traceCr ].
	group openInSpace
]

{ #category : #checkables }
ToSandBox class >> example_CheckboxWithExactWidth [

	| chb |
	ToTheme cleanUp.
	chb := ToCheckbox new
		       startInterspace: 100;
		       labelText: 'Checkbox' asString.
	chb openInInnerWindow
]

{ #category : #checkables }
ToSandBox class >> example_CheckboxWithIndeterminate [

	| but |
	but := ToCheckbox new labelText: 'Checkbox'.
	but allowIndeterminate: true.
	but openInSpace
]

{ #category : #circular }
ToSandBox class >> example_CircularElement [

	| container |
	container := ToBasicCircularElement new
		             background: Color veryLightGray;
		             yourself.
	container geometry: BlCircleGeometry new.

	container inset: 60.
	"container startAngleOffset: (360/4) negated."
	container addEventHandlerOn: BlMouseWheelEvent do: [ :evt |
			container startAngle:
				container startAngle
				+ (evt vector y * container scrollSensitivity) ].


	1 to: 20 do: [ :i |
			| child lab |
			child := BlElement new
				         extent: 60 @ 60;
				         background: Color white;
				         border: Color gray;
				         yourself.
			child layout: BlFrameLayout new.
			lab := ToLabel text: i asString.
			lab fontSize: 24.
			lab constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter ].
			child addChild: lab.
			container addChild: child ].

	container extent: 450 asPoint.
	container border: Color red.
	container openInSpace
]

{ #category : #circular }
ToSandBox class >> example_CircularListElementWithAnnulusSectors [

	| container scrollSensitivity |
	container := ToAnnulusCircularElement new.
	container matchParent.
	container innerRadius: 0.25.
	container outerRadius: 1.0.

	scrollSensitivity := 1.
	container addEventHandlerOn: BlMouseWheelEvent do: [ :evt |
			container startAngle:
				container startAngle + (evt vector y * scrollSensitivity) ].
			
	(self statesOfAmericaWithColor copyFrom: 1 to: 12) do: [ :stateColorAssoc |
			| sector check |
			sector := ToAnnulusSectorElement new.
			sector background: stateColorAssoc value.
			check := ToCheckbox new labelText: stateColorAssoc key.
			check beVertical.
			sector addChild: check.
			check constraintsDo: [ :c |
					c ignoreByLayout.
					c anchors add:
						(c anchors centerAnchor on: c anchors parent centroidAnchor) ].
			container addChild: sector ].

	container openInSpace
]

{ #category : #menu }
ToSandBox class >> example_CircularMenu [

	| rootMenu space |
	space := BlSpace new.
	space root layout: BlFrameLayout new.
	
	rootMenu := ToCircularMenuItemList new.
	rootMenu uniformSectors: true.
	rootMenu addItem: (ToMenuItem new
			 labelText: 'X1';
			 yourself).
	rootMenu addItem: (ToMenuItem new
			 labelText: 'X2';
			 yourself).
	rootMenu addItem: (ToMenuItem new
			 labelText: 'X3';
			 yourself).
	rootMenu constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].
	rootMenu extent: 200 asPoint.
	space root addChild: rootMenu.
	space show
]

{ #category : #menu }
ToSandBox class >> example_CircularMenuWithSubmenu [

	| rootMenu subMenu  space |
	space := BlSpace new.
	space root layout: BlFrameLayout new.
	
	rootMenu := ToCircularMenuItemList new.
	rootMenu uniformSectors: true.
	rootMenu addItem: (ToMenuItem new
			 labelText: 'X1';
			 yourself).
	rootMenu addItem: (ToMenuItem new
			 labelText: 'X2';
			 yourself).
	rootMenu addItem: (ToMenuItem new
			 labelText: 'X3';
			 yourself).
	rootMenu constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].
	rootMenu extent: 200 asPoint.
	rootMenu background: Color red.
	
	subMenu := ToCircularMenuItemList new.
	subMenu innerRadius: 0.5.
	subMenu uniformSectors: false.
	subMenu addItem: (ToMenuItem new
			 labelText: 'XX1';
			 yourself).
	subMenu addItem: (ToMenuItem new
			 labelText: 'XX2';
			 yourself).
	subMenu extent: 400 asPoint.
	subMenu constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	space root addChild: subMenu.
	space root addChild: rootMenu.
	
	space show
]

{ #category : #tree }
ToSandBox class >> example_ClassHierarchiesWithMethods [
	"For this example we created a new wrapper dealing with classes and methods at the same time, a new Node was also created (ToTreeSubAndMethNode) to apply a new skin (ToTreeNodeSubAndMethSkin) with new icons and a different background color for methods "

	| treeElement |
	treeElement := ToTreeElement new.
	treeElement withRowNumbers.
	treeElement contextMenuBuilder: [ :menu :request |
			| selectionModel indexes target |
			target := request currentTarget.
			selectionModel := request selectionModel.
			indexes := request selectedIndexes.
			indexes traceCr.
			menu addItem: (ToMenuItem new
					 labelText: 'Expand all';
					 clickAction: [
							 indexes
								 ifEmpty: [ target expandAll ]
								 ifNotEmpty: [
									 indexes reverseDo: [ :idx |
											 (target dataSource at: idx) expandAll ] ] ];
					 yourself).
			menu addItem: (ToMenuItem new
					 labelText: 'Collapse all';
					 clickAction: [
							 indexes
								 ifEmpty: [ target collapseAll ]
								 ifNotEmpty: [
									 indexes reverseDo: [ :idx |
											 (target dataSource at: idx) collapse ] ] ];
					 yourself) ].
	treeElement nodeManager childrenGetter: [ :dataItem |
			dataItem isClass
				ifTrue: [
						Array streamContents: [ :stream |
								stream nextPutAll: dataItem subclasses.
								stream nextPutAll:
									(dataItem methods collect: [ :each | each selector ]) sorted ] ]
				ifFalse: [ #(  ) ] ].
	treeElement nodeManager nodeFactory: [ :holder |
		ToExTreeSubAndMethNode new ].
	treeElement dataAccessor add: ProtoObject.
	treeElement dataAccessor add: BlElement.
	treeElement dataAccessor add: Collection.
	treeElement dataAccessor add: String.
	treeElement
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :evt | self selectionChangedEvent: evt ].

	treeElement openInSpace
]

{ #category : #anchors }
ToSandBox class >> example_ClockWithAnchors [

	| pane clock hoursHand minutesHand secondsHand axis f secondsAnimation minutesAnimation hoursAnimation |
	self flag: 'To be implemented in ToExClock ...'.
	pane := BlElement new.
	pane constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	clock := BlElement new
		         geometry: BlCircleGeometry new;
		         extent: 140 asPoint;
		         border: Color red;
		         yourself.
	hoursHand := BlElement new
		             position: 40 asPoint;
		             extent: 40 @ 0;
		             border: (BlBorder paint: Color black width: 4);
		             geometry: (BlLineGeometry from: 0 @ 0 to: 40 @ 0);
		             yourself.
	secondsHand := BlElement new
		               position: 100 asPoint;
		               extent: 100 @ 0;
		               border: Color red;
		               geometry: (BlLineGeometry from: 0 @ 0 to: 100 @ 0);
		               yourself.
	minutesHand := BlElement new
		               position: 50 asPoint;
		               extent: 50 @ 0;
		               border: (BlBorder paint: Color blue width: 2);
		               geometry: (BlLineGeometry from: 0 @ 0 to: 50 @ 0);
		               yourself.
	axis := BlElement new
		        geometry: BlCircleGeometry new;
		        extent: 10 asPoint;
		        border: Color red;
		        yourself.
	secondsHand clipChildren: false.

	clock margin: (BlInsets all: -10).
	1 to: 12 do: [ :m |
			| dbar lab |
			dbar := ToElement new
				        id: m asString asSymbol;
				        fitContent;
				        yourself.
			lab := ToLabel text: m asString.
			dbar addChild: lab.
			dbar constraintsDo: [ :c |
					c ignoreByLayout.
					c anchors add: (c anchors centerAnchor on:
							 (clock perimeterAnchor degrees: 360 / 12 * m)) ].
			clock addChild: dbar ].

	f := BlElement new
		     extent: 10 asPoint;
		     background: Color blue;
		geometry: BlCircleGeometry new;
		     yourself.
	f constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add: (c anchors leftAnchor on: secondsHand leftAnchor).
			c anchors add:
				(c anchors verticalCenterAnchor on:
					 secondsHand verticalCenterAnchor) ].
	axis constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add: (c anchors centerAnchor on: clock centerAnchor) ].
	secondsHand constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add: (c anchors centerAnchor on: clock centerAnchor) ].
	minutesHand constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add: (c anchors topLeftAnchor on: clock centerAnchor) ].
	hoursHand constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add: (c anchors topLeftAnchor on: clock centerAnchor) ].
	secondsAnimation := BlNumberTransition new
		                    onStepDo: [ :aSecond |
				                    secondsHand transformDo: [ :aTransform |
						                    aTransform rotateBy:
								                    aSecond * (360 / 60) - 90 ] ];
		                    from: 0;
		                    to: 60;
		                    by: 1;
		                    beInfinite;
		                    duration: 600 milliSeconds.
	minutesAnimation := BlNumberTransition new
		                    onStepDo: [ :aMinute |
				                    minutesHand transformDo: [ :aTransform |
							                    aTransform origin:
									                    (BlAffineTransformationPositionOrigin
										                     position: 0 @ 0).
							                    aTransform rotateBy:
									                    aMinute * (360 / 60) - 90 ] ];
		                    from: 0;
		                    to: 60;
		                    by: 1;
		                    beInfinite;
		                    duration: 60 seconds.
	hoursAnimation := BlNumberTransition new
		                  onStepDo: [ :aMinute |
				                  hoursHand transformDo: [ :aTransform |
							                  aTransform origin:
									                  (BlAffineTransformationPositionOrigin
										                   position: 0 @ 0).
							                  aTransform rotateBy:
									                  aMinute * (360 / 60) - 90 ] ];
		                  from: 0;
		                  to: 60;
		                  by: 1;
		                  beInfinite;
		                  duration: 60 minutes.
	secondsHand addAnimation: secondsAnimation.
	minutesHand addAnimation: minutesAnimation.
	hoursHand addAnimation: hoursAnimation.
	secondsHand addChild: f.
	clock addChild: axis.
	clock addChild: secondsHand.
	clock addChild: minutesHand.
	clock addChild: hoursHand.
	pane addChild: clock.
	pane openInSpace
]

{ #category : #album }
ToSandBox class >> example_CodeEditor [

	| pane menuPane text album menuBuilder disabox inspectBtn showStatisticsBtn fileMenu |
	pane := ToPane vertical matchParent.

	text := self methodText asRopedText.
	album := ToAlbum new.
	album styler: (BlPharoCodeStyler new
			 classOrMetaClass: self class;
			 yourself).
	album text: text copy.
	album withSaveCapability.
	album withRowNumbers.
	album whenSaveRequestedDo: [ :saveRequested |
		saveRequested accepted: true ].
	album whenCancelRequestedDo: [ :cancelRequested |
		cancelRequested editorElement text: text copy ].

	menuBuilder := [ :menu :request |
		               menu addItem: (ToMenuItem new
				                labelText: 'Select all';
				                clickAction: [ :evt |
						                album selecter
							                all;
							                apply ];
				                yourself).
		               menu addItem: (ToMenu new
				                labelText: 'Edit';
				                builder: [ :m |
						                | item |
						                item := ToMenuItem new
							                        labelText: 'Copy';
							                        clickAction: [ :evt |
								                        album editor copySelected ];
							                        yourself.
						                album hasSelection ifFalse: [ item disable ].
						                m addItem: item.
						                m addItem: (ToMenuItem new
								                 labelText: 'Cut';
								                 clickAction: [ :evt |
									                 album editor cutSelected ];
								                 yourself).
						                album hasSelection ifFalse: [
							                m items last disable ].

						                m addItem: (ToMenuItem new
								                 labelText: 'Paste';
								                 clickAction: [ :evt | album editor paste ];
								                 yourself).
						                album editor paster fromClipboard isEmpty
							                ifTrue: [ m items last disable ].
						                m addSeparator.

						                m addItem: (ToMenuItem new
								                 labelText: 'Accept';
								                 clickAction: [ album requestSave ];
								                 yourself).
						                album edited ifFalse: [ m items last disable ].

						                m addItem: (ToMenuItem new
								                 labelText: 'Cancel';
								                 clickAction: [ album requestCancel ];
								                 yourself).
						                album edited ifFalse: [ m items last disable ] ]) ].
	album contextMenuBuilder: menuBuilder.

	fileMenu := ToMenu new labelText: 'Edit'.
	fileMenu builder: menuBuilder.
	inspectBtn := ToMenuItem new
		              labelText: 'Inspect';
		              clickAction: [ album space root inspect ];
		              yourself.
	showStatisticsBtn := ToMenuItem new
		                     labelText: 'Statistics';
		                     clickAction: [
			                     album space showStatisticsWindow ];
		                     yourself.
	disabox := ToCheckMenuItem new
		           label: (ToLabel text: 'Disable');
		           checkAction: [ :evt |
			           album disabled: evt target isChecked ];
		           yourself.
	album whenConfigurationAppliedDo: [
		disabox checked: album isDisabled ].

	menuPane := ToMenuPane new.
	menuPane hMatchParent.
	menuPane addItem: fileMenu.
	menuPane addItem: inspectBtn.
	menuPane addItem: showStatisticsBtn.
	menuPane addItem: disabox.

	pane addChild: menuPane.
	pane addChild: album.
	pane openInInnerWindow
]

{ #category : #list }
ToSandBox class >> example_EditableList2WithAllClassesNames [

	| l vscrollBar space innerWin |
	l := ToListElement new.
	l beVertical.
	l
		nodeFactory: [ ToExListClassNode new ];
		nodeBuilder: [ :node :dataItem :holder |
			node forClassNameAssoc: dataItem ];
		addEventHandler: (BlEventHandler
				 on: ToListStrongSelectionEvent
				 do: [ :event |
					 event indexes size == 1 ifTrue: [
							 (l nodeContainerAt: event indexes first) node label popupEditorEvent: event ] ]).
	l	withRowNumbers.

	l dataAccessor addAll:
		(Smalltalk globals allClasses collect: [ :cls | cls -> cls name ]).

	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
		c ignoreByLayout.
		c margin: (BlInsets right: 2).
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	vscrollBar attachTo: l innerElement.
	innerWin := ToInnerWindow new.
	innerWin pane addChild: l.
	innerWin pane addChild: vscrollBar.
	space := BlSpace new.
	space root addChild: innerWin.
	space show
]

{ #category : #album }
ToSandBox class >> example_EditorWithMinHeight [

	| pane menuPane text album disabox inspectBtn showStatisticsBtn |
	pane := ToPane vertical matchParent.

	text := ''.
	album := ToAlbum new.
	album hMatchParent.
	album vFitContent.
	album next constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal matchParent ].
	album infinite constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal matchParent ].
	album text: text copy.
	album minHeight: 100.

	inspectBtn := ToMenuItem new labelText: 'Inspect'.
	showStatisticsBtn := ToMenuItem new labelText: 'Statistics'.
	disabox := ToCheckMenuItem new label: (ToLabel text: 'Disable').

	menuPane := ToMenuPane new.
	menuPane hMatchParent.
	menuPane addItem: inspectBtn.
	menuPane addItem: showStatisticsBtn.
	menuPane addItem: disabox.

	pane addChild: menuPane.
	pane addChild: album.

	inspectBtn clickAction: [ album space root inspect ].
	disabox checkAction: [ :evt  |
			           album disabled: evt target isChecked ].
	album whenConfigurationAppliedDo: [
		disabox disabled: album isDisabled ].
	showStatisticsBtn clickAction: [
		album space showStatisticsWindow ].

	pane openInSpace
]

{ #category : #album }
ToSandBox class >> example_EditorWithPlaceholder [

	| placeholderString view |
	placeholderString := ('Here is a placeholder text' , String cr
	                    , 'visible only if the text is empty').

	view := ToAlbum new
		        placeholderString: placeholderString;
		        withRowNumbers;
		        withSaveCapability;
		        whenSaveRequestedDo: [ :saveRequested |
			        saveRequested accepted: true ];
		        yourself.
	view openInInnerWindow
]

{ #category : #album }
ToSandBox class >> example_EditorWithoutSoftLine [

	| view |

	view := ToAlbum new
		        withRowNumbers;
		        withSaveCapability;
		        whenSaveRequestedDo: [ :saveRequested |
			        saveRequested accepted: true  ];
		        addEditsFeedbackLayer.
	view withoutSoftLine.
	view text: ((String loremIpsum: 10000) asRopedText fontName: 'Source Code Pro').
	view openInSpace
]

{ #category : #list }
ToSandBox class >> example_FilterOnList2WithStatesOfAmerica [
	" When filtered, update the primary selection with filtered items 
	 - the contents of the list remains unchanged"

	| listElement pane filterField data selector |
	pane := ToPane new
		        beVertical;
		        matchParent.
	filterField := ToTextField new.
	listElement := ToListElement new.
	data := self statesOfAmerica.

	listElement margin: (BlInsets all: 2).
	filterField margin: (BlInsets all: 2).

	selector := ToObservableCollectionFilterApplier new.
	listElement dataSource
		addEventHandlerOn: ToObservableCollectionFilterApplierEvent
		do: [ :event |
			listElement selecter selectOnlyIndexes: event selectedIndexes ].
	listElement dataAccessor addAll: data.
	selector onInstalledIn: listElement dataSource.

	filterField whenTextEditedDo: [
			| pattern |
			pattern := filterField text asString.
			selector pattern: pattern ].

	"handler inspect."
	pane addChild: listElement.
	pane addChild: filterField.
	pane openInSpace
]

{ #category : #float }
ToSandBox class >> example_FloatArrowsAraoundACircle [

	| pane circle |
	pane := ToPane new matchParent.

	circle := ToElement new asFloatElement
		          extent: 60 asPoint;
		          yourself.
	circle geometry: BlCircleGeometry new.
	circle visibility: BlVisibility hidden.
	circle atBottomRight.
	circle offset: 20 negated asPoint.
	circle attachToElement: pane.

	{
		('up' -> 0).
		('right' -> 90).
		('down' -> 180).
		('left' -> 270) } do: [ :assoc |
			| but |
			but := (ToIconicButton new
				        iconImage: (ToMaterialDesignIconProvider innerImageNamed:
							         'outlined_keyboardarrow' , assoc key);
				        extent: 20 asPoint;
				        yourself) asFloatElement.
			but geometry: BlCircleGeometry new.
			but offset: 0 asPoint.
			but atPerimeterAround: circle atDegrees: assoc value.
			but attachToElement: pane ].

	pane openInInnerWindow
]

{ #category : #float }
ToSandBox class >> example_Floats [

	| rightBtn leftBtn pane textField float |
	rightBtn := ToIconicButton new iconImage:
		            (ToMaterialDesignIconProvider innerImageNamed:
			             'outlined_keyboardarrowright').
	rightBtn extent: 25 asPoint.
	leftBtn := ToIconicButton new iconImage:
		           (ToMaterialDesignIconProvider innerImageNamed:
			            'outlined_keyboardarrowleft').
	leftBtn extent: 25 asPoint.
	textField := ToTextField new
		             width: 150;
		             placeholderString: 'Name';
		             yourself.

	pane := ToPane new matchParent.

	float := ToFloatElement new.
	float builder: [ :e |
			e layout: BlLinearLayout horizontal.
			e addChild: textField.
			e addChild: leftBtn.
			e addChild: rightBtn ].
	float offset: (10 @ 10) negated. 
	float attachToElement: pane.

	pane openInInnerWindow
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
	but clickAction: [ self inform: 'clicked' ].
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
	but clickAction: [ self inform: 'clicked' ].
	but openInSpace.
	^ but
]

{ #category : #list }
ToSandBox class >> example_HorizontalListWithIndexedColors [

	| l space |
	l := ToListElement new nodeBuilder: [ :node :dataItem :holder |
			     node fitContent.
			     node addChild: (ToElement new
					      extent: 70 @ 50;
					      background: (dataItem ifNil: [ Color white ])) ].
	l background: Color yellow.
	l beHorizontal.
	l hMatchParent.
	l vFitContent.
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
			(BlTextElement new text: anInteger asString asRopedText)
				labelMeasurement ].
	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
		c ignoreByLayout.
		c margin: (BlInsets left: 10).
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	vscrollBar attachTo: l innerElement.

	space := BlSpace new
		         extent: 100 @ 600;
		         title: 'List with ' , nbItems asString , ' integers'.

	space root addChild: l.
	space root addChild: vscrollBar.
	space show
]

{ #category : #window }
ToSandBox class >> example_Inline1 [

	| menu popupWindowHandler |

	menu := ToElement new
		        layout: BlLinearLayout vertical;
		        background: Color transparent;
		        id: #'red-button';
		        border: Color red;
		        extent: 100 @ 100;
		        position: 50 @ 50.

	popupWindowHandler := ToPopupWindowManager new.
	menu addEventHandler: popupWindowHandler.

	popupWindowHandler windowBuilder: [ :popup :element |
			| item |
			popup extent: 80 asPoint.
			popup border: Color black.
			item := ToElement new
				        height: 50;
				        hMatchParent.
			item background: Color yellow.
			item addEventHandler: (BlEventHandler
					 on: BlPrimaryClickEvent
					 do: [ self inform: 'Click' ]).
			popup root addChild: item ].

	menu openInSpace
]

{ #category : #list }
ToSandBox class >> example_IntegerList [

	| l nbItems space rand |
	nbItems := 50000.
	rand := Random new.
	l := ToListElement new.
	l dataAccessor addAll: (1 to: nbItems).
	l nodeBuilder: [ :node :anInteger |
		node addChild: (ToLabel new text: anInteger asString) ].
	l addEventHandler: (BlEventHandler
			 on: ToListStrongSelectionEvent
			 do: [ :event |
				 | pos nb |
				 pos := event indexes first.
				 nb := rand nextIntegerBetween: 3 and: 8.
				 1 to: nb do: [ :i |
				 l dataAccessor add: i afterIndex: pos + i - 1 ] ]).

	space := BlSpace new
		         extent: 100 @ 600;
		         title: 'List with ' , nbItems asString , ' integers'.

	space root addChild: l.
	space show
]

{ #category : #label }
ToSandBox class >> example_LabelAndSelectableLabelAndTextField [

	| lab1 lab2 txtfld pane |
	lab1 := ToSelectableLabel new text:
		        'SelectableLabel__________________'.
	lab2 := ToLabel new text: '_______________Regular Label_____________'.
	txtfld := ToTextField new text: '_______ TextField_______'.
	"{ lab1. txtfld. lab2 } do: [ :l | l hFitContent ]."
	{
		lab1.
		lab2.
		txtfld } do: [ :l |
		l constraintsDo: [ :c | c linear vertical alignCenter ] ].
	pane := ToPane horizontal.
	pane addChildren: {
			lab1.
			lab2.
			txtfld }.
	pane openInSpace
]

{ #category : #label }
ToSandBox class >> example_LabelAndSelectableLabelAndTextFieldWithNullSkin [

	| lab1 lab2 txtfld pane |
	lab1 := ToSelectableLabel new text:
		        'SelectableLabel__________________'.
	lab2 := ToLabel new text: '_______________Regular Label'.
	txtfld := ToTextField new text: '_______ TextField_______'.
	"{ lab1. txtfld. lab2 } do: [ :l | l hFitContent ]."
	{
		lab1.
		txtfld.
		lab2 } do: [ :l |
		l constraintsDo: [ :c | c linear vertical alignCenter ] ].
	pane := ToPane horizontal.
	lab1 defaultSkin: ToNullSkin new.
	lab2 defaultSkin: ToNullSkin new.
	txtfld defaultSkin: ToNullSkin new.
	pane addChildren: {
			lab1.lab2.
			txtfld.
			 }.
	pane openInSpace
]

{ #category : #'labeled icon' }
ToSandBox class >> example_LabeledIconlWithIconAndText [

	| but  |
	but := self labeledIconlWithIconAndText.
	but hMatchParent.
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
ToSandBox class >> example_LabeledIconlWithIconAndText_startAlignment [

	| but |
	but := self example_LabeledIconlWithIconAndText.
	but border: Color black.
	but startAlignment: 100.
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
ToSandBox class >> example_List12Classes [

	| l menuFactory |
	l := ToListElement new nodeBuilder: [ :node :dataItem :holder |
			     node addChild: (ToLabel new
					      text: dataItem name;
					      hMatchParent) ].
	l dataAccessor addAll: (Smalltalk globals allClasses copyFrom: 1 to: 12).
	menuFactory := [ :menu :request |
		               | selectionModel indexes target |
		               target := request currentTarget.
		               selectionModel := request selectionModel.
		               indexes := request selectedIndexes.
		               menu addItem: (ToMenuItem new
				                labelText: 'Remove';
				                clickAction: [ indexes sort reverseDo: [ :idx | target dataAccessor removeAt: idx ] ];
				                yourself).
		               menu addItem: (ToMenuItem new
				                labelText: 'Inspect list';
				                clickAction: [ target inspect ];
				                yourself) ].
	l contextMenuBuilder: menuFactory.
	l openInSpace
]

{ #category : #circular }
ToSandBox class >> example_ListElementWithCircularListElement [

	| list |
	list := ToListElement new.
	list innerElementClass: ToCircularListElement.
	list innerElement inset: 60.
	list nodeBuilder: [ :node :dataItem :holder |
			| triplet label |
			triplet := ToTripletElement new.
			label := (ToLabel text: holder position asString , ': ' , dataItem asString).
			triplet startElement: ToIconicRemoveButton new.
			triplet startElement clickAction: [ triplet startElement fireEvent: ToRemoveButtonClickedEvent new ].
			triplet middleElement: label.
			triplet startInterspace: 10.
			node addChild: triplet ].

	list dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 12).
	list openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListOneClass [

	| l |
	l := ToListElement new nodeBuilder: [ :node :dataItem  :holder |
		     node addChild: (ToLabeledIcon new
				      labelText: dataItem name;
				      startInterspace: 10;
				      hMatchParent) ].
	l dataAccessor addAll: { Smalltalk globals allClasses first }.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListOneClass2 [

	| l |
	l := ToListElement new nodeBuilder: [ :node :dataItem  :holder |
		     node addChild: (ToLabel new
				      text: dataItem name;
				      hMatchParent) ].
	l dataAccessor addAll: { Smalltalk globals allClasses first }.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListTwoClasses [

	| l |
	l := ToListElement new nodeBuilder: [ :node :dataItem :holder |
			     node
				     addChild: (ToLabeledIcon new labelText: dataItem asString);
				     hMatchParent ].
	l withRowNumbers.
	l contextMenuBuilder: self listMenuFenuFactory.
	l dataAccessor addAll: (Smalltalk globals allClasses copyFrom: 1 to: 12).
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWith3Columns [

	| list |
	list := ToListElement new
		        withRowNumbers;
		        nodeBuilder: [ :node :arr :holder |
			        | columns |
			        columns := arr collect: [ :elem |
					                   ToLabel new
						                   text: elem asString;
						                   width: 80;
						                   yourself ].
			        node addChildren: columns ].
	list dataAccessor addAll: ((1 to: 20 by: 3) collect: [ :idx |
			 {
				 idx.
				 (idx + 1).
				 (idx + 2) } ]).
	list openInSpace
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
	l := ToListElement new nodeBuilder: [ :node :dataItem :holder |
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
				      startAlignment: 30;
				      hMatchParent) ].
	l primarySelectionMode selectionOption animationDuration:
		200 milliSeconds.
	l secondarySelectionMode selectionOption animationDuration:
		150 milliSeconds.
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
			     cbox := ToCheckbox new.
			     cbox focusability: BlFocusability none.
			     cbox checked: holder isSelected.
			     cbox
				     addEventHandlerOn: ToCheckableCheckEvent
				     do: [ :event | holder selected: event checked ].
			     node addChild: cbox.
			     node addChild: (ToLabel text: dataItem name).
			node childrenDo: [ :child | child constraints linear vertical alignCenter ] ].
	l selectionOption beneath: false.
	l selectionMode selectOnPressed: false.
	l selectionMode selectOnClick: false.
	l dataAccessor addAll: Smalltalk globals allClasses.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClasses4Bis [

	| l |
	l := ToListElement new.
	l toConfiguration useCheckbox: true.
	l dataAccessor addAll: Smalltalk globals allClasses.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesAndTraitsSorted [

	| l vscrollBar space |
	l := ToListElement new nodeBuilder: [ :node :dataItem :holder |
			node ensureCanManageToploSkin.
		     node addChild: (ToClassNameViewExamplePart new
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
	vscrollBar attachTo: l innerElement.

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
	l addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :evt | evt traceCr ]).
	l selectionOption masked: true.
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesAsCheckbox [

	| l |
	l := ToCheckableListElement new.
	"l selectionOption masked: true."
	l selectionOption withEmbeddedRepresentation.
	l group withNoneCheckingStrategy.
	l addAllItems: ((Smalltalk globals allClasses) collect: [ :cls |
			 ToCheckbox new
				 label: (ToLabel new text: cls name);
				 hMatchParent ]).
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesAsToggleButton [

	| l |
	l := ToCheckableListElement new.
	l selectionOption withEmbeddedRepresentation.
	l group withNoneCheckingStrategy.
	l addAllItems: ((Smalltalk globals allClasses ) collect: [ :cls |
			 ToToggleButton new
				 label: (ToLabel new text: cls name);
				 hMatchParent ]).
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesMono [

	| l |
	l := ToListElement new.
	l primarySelectionMode beSingleSelection.
	l dataAccessor addAll:
		(Smalltalk globals allClasses collect: [ :cls | cls name ]).
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesMulti [

	| l |
	l := ToListElement new.
	l withRowNumbers.
	"l selectionModel inspect."
	l dataAccessor addAll:
		(Smalltalk globals allClasses collect: [ :cls | cls name ]).
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesNone [

	| l |
	l := ToListElement new.
	l primarySelectionMode disable.
	l dataAccessor addAll:
		(Smalltalk globals allClasses collect: [ :cls | cls name ]).
	l openInSpace
]

{ #category : #list }
ToSandBox class >> example_ListWithAllClassesWithEmbeddedSelection [

	| l |
	l := ToListElement new.
	"l useCheckbox: true."
	l nodeFactory: [ :holder | ToExListEmbeddedNode new ].
	l selectionOption withEmbeddedRepresentation.
	l dataAccessor addAll:
		(Smalltalk globals allClasses collect: [ :cls | cls name ]).
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
	vscrollBar attachTo: l innerElement.

	space := BlSpace new.

	space root addChild: l.
	space root addChild: vscrollBar.
	space show
]

{ #category : #list }
ToSandBox class >> example_ListWithEditableAndContextMenu [

	| l |
	l := self listWithEditableAndContextMenu.
	l openInInnerWindow.
	^ l
]

{ #category : #float }
ToSandBox class >> example_ListWithFloatButtons [

	| list addBtn removeBtn floatAdd floatRemove |
	list := self example_ListWithEditableAndContextMenu.
	addBtn := ToIconicButton new iconImage:
		          (ToMaterialDesignIconProvider innerImageNamed:
			           'outlined_addcircleoutline').
	addBtn extent: 25 asPoint.
	removeBtn := ToIconicButton new iconImage:
		             (ToMaterialDesignIconProvider innerImageNamed:
			              'outlined_removecircleoutline').
	removeBtn extent: 25 asPoint.

	removeBtn clickAction: [
			list selecter selectedIndexes reverseDo: [ :idx |
				list dataAccessor removeAt: idx ] ].

	addBtn clickAction: [
			list dataAccessor addFirst:
				String loremIpsum substrings first , ' (inserted as first item)' ].

	floatAdd := addBtn asFloatElement.
	floatRemove := removeBtn asFloatElement.

	floatAdd geometry: BlCircleGeometry new.
	floatRemove geometry: BlCircleGeometry new.

	floatRemove visibility: BlVisibility gone.

	list
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :evt |
				floatRemove visibility: (evt selectedIndexes
						 ifEmpty: [ BlVisibility gone ]
						 ifNotEmpty: [ BlVisibility visible ]) ].

	floatRemove placement: (ToAnchoredExplicitPlacement new constraintsAction: [ :c |
			c anchors add:
				(c anchors bottomRightAnchor on:
					 floatAdd bottomLeftAnchor - (5 @ 0)) ] ).
	
	floatAdd attachToElement: list.
	floatRemove attachToElement: list
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
	vscrollBar attachTo: l innerElement.
	space := BlSpace new.
	space root addChild: l.
	space root addChild: vscrollBar.
	space show
]

{ #category : #list }
ToSandBox class >> example_ListWithSelectionHistory [

	| statesList historyList pane |
	pane := ToPane horizontal.
	statesList := ToListElement new matchParent.

	historyList := ToListElement new matchParent.
	statesList dataAccessor addAll: self statesOfAmerica.
	pane addChildren: {
			statesList.
			historyList }.

	statesList addEventHandler:
		(ToListSelectionHistoryExampleEventHandler new historyList:
			 historyList).

	pane
		matchParent;
		addDividers.
	pane openInInnerWindow
]

{ #category : #list }
ToSandBox class >> example_ListWithSelectionTrace [

	| statesList |
	statesList := ToListElement new matchParent.
	statesList withRowNumbers.
	statesList dataAccessor addAll: self statesOfAmerica.
	statesList addEventHandler:
		ToListSelectionTraceExampleEventHandler new.
	" use of userData is ok here for the example but a subclass of ToListElement 
	would be preferable to store the traceSelectionModel as an instance variable"
	statesList userData
		at: #traceSelectionModel
		put: (ToSelectionModel new on: statesList).
	" mandatory option here: the selection are separate (one selection element for each selected node)"
	statesList selectionOption grouped: false.
	statesList selectionOption elementFactory: [
		ToListSelectionElement new defaultSkin:
			ToTraceListPrimarySelectionElementSkin new ].
	statesList openInSpace
]

{ #category : #menu }
ToSandBox class >> example_Menu0 [

	| menu container |
	container := ToInnerWindow new
		             position: 10 @ 10;
		             extent: 400 @ 200;
		             yourself.
	menu := ToMenu new.
	menu tooltipString: 'tooltip content'.
	menu icon: (ToImage inner: (self iconNamed: #solidMenu)).
	container pane addChild: menu.
	container openInSpace
]

{ #category : #menu }
ToSandBox class >> example_Menu2 [

	| menu container |
	container := ToInnerWindow new
		             position: 10 @ 10;
		             extent: 400 @ 200;
		             yourself.
	menu := ToMenu new.
	menu addItem: (ToMenuItem new
			 labelText: 'Menu item';
			 clickAction: [ :event | event traceCr ];
			 yourself).
	menu icon: (ToImage inner: (self iconNamed: #solidMenu)).
	container pane addChild: menu.
	container openInSpace.
	^ menu 
]

{ #category : #menu }
ToSandBox class >> example_Menu3 [
	<demo>
	
	| container |
	container := ToElement new matchParent.
	container contextMenuBuilder: [ :menu :elem |
			| item sub |
			item := ToMenuItem new labelText: 'MenuItem1'.
			item icon:
				(ToMaterialDesignIconProvider iconNamed: #outlined_cropfree).
			menu addItem: item.
			item := ToMenuItem new labelText: 'MenuItem2'.
			item icon:
				(ToMaterialDesignIconProvider iconNamed: #outlined_callsplit).
			menu addItem: item.
			item := ToMenuItem new labelText: 'MenuItem3'.
			item icon:
				(ToMaterialDesignIconProvider iconNamed: #outlined_delete).
			menu addItem: item.
			item := ToMenuItem new labelText: 'MenuItem4'.
			item icon: (ToMaterialDesignIconProvider iconNamed: #outlined_sms).
			menu addItem: item.
			item := ToMenuItem new labelText: 'MenuItem5'.
			menu addItem: item.

			item := ToMenu new labelText: 'Menu1'.
			sub := ToMenuItem new labelText: 'SubMenu1'.
			item addItem: sub.
			sub := ToMenuItem new labelText: 'SubMenu2'.
			item addItem: sub.
			menu addItem: item.

			item := ToMenu new labelText: 'Menu2'.
			sub := ToMenuItem new labelText: 'SubMenu1'.
			item addItem: sub.
			sub := ToMenuItem new labelText: 'SubMenu2'.
			item addItem: sub.
			sub := ToMenuItem new labelText: 'SubMenu3'.
			item addItem: sub.
			menu addItem: item.

			item := ToMenu new labelText: 'Menu3'.
			sub := ToMenuItem new labelText: 'SubMenu1'.
			item addItem: sub.
			sub := ToMenuItem new labelText: 'SubMenu2'.
			item addItem: sub.
			sub := ToMenuItem new labelText: 'SubMenu3'.
			item addItem: sub.
			sub := ToMenuItem new labelText: 'SubMenu4'.
			item addItem: sub.
			sub := ToMenuItem new labelText: 'SubMenu5'.
			item addItem: sub.
			menu addItem: item ].

	container openInSpace
	
]

{ #category : #menu }
ToSandBox class >> example_MenuPaneScrollableWithCustomItems [

	| menuPane grp right center left textField sub lbl item |
	menuPane := ToMenuPane new.
	menuPane vertical: true.
	menuPane vMatchParent.
	menuPane hMatchParent.
	menuPane isScrollable: true.
	menuPane addItem: (ToMenuItem new
			 labelText: 'Open file';
			 clickAction: [ self inform: 'Open file' ];
			 icon: (ToImage inner: (Smalltalk ui icons iconNamed: #config))).

	item := ToMenuItem new
		        labelText: 'Export';
		        clickAction: [ self inform: 'Export' ];
		        yourself.
	menuPane addItem: item.
	item disable.

	menuPane addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ menuPane space root inspect ];
			 yourself).
	menuPane addSeparator.
	menuPane addItem: (ToToggleMenuItem new
			 labelText: 'Toggle';
			 yourself).
	menuPane addItem: (ToCustomMenuItem new
			 in: [ :e |
				 e addChild: (ToSwitchButton new
							  checked: true;
							  startFlexible: true;
							  hMatchParent;
							  labelText: 'Switch';
							  yourself) ];
			 yourself).

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

	menuPane addSeparator.

	lbl := ToAttributedLabel text: 'Radio button icon first'.
	lbl
		italic;
		fontSize: 12;
		foreground: Color blue.

	menuPane addItem: (ToCustomMenuItem new in: [ :e |
			 e
				 addChild: lbl;
				 margin: (BlInsets
						  top: 2;
						  bottom: 4) ]).
	menuPane addAllItems: grp registeredCheckables.

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

	menuPane addSeparator.

	lbl := ToAttributedLabel new text:
		       ('Radio button label first' asRopedText
			        italic;
			        fontSize: 12;
			        foreground: (Color blue alpha: 0.7)).
	menuPane addItem: (ToCustomMenuItem new in: [ :e |
			 e
				 addChild: lbl;
				 margin: (BlInsets
						  top: 2;
						  bottom: 4) ]).
	menuPane addAllItems: grp registeredCheckables.
	menuPane addSeparator.
	textField := ToTextField new
		             placeholderBuilder: [ :thePlaceholder :theElement |
			             thePlaceholder addChild:
					             (ToAttributedLabel new text:
							              ('Your name' asRopedText
								               foreground: Color lightGray;
								               yourself)) ];
		             "withLineWrapping;"vFitContent;
		             hMatchParent.
	menuPane addItem:
		(ToCustomMenuItem new in: [ :e | e addChild: textField ]).
	menuPane addSeparator.
	sub := ToMenu new
		       labelText: 'Save All';
		       showExpandIcon: true;
		       yourself.
	sub beInline.

	sub addItem: (ToMenuItem new labelText: 'Locally').
	menuPane addItem: sub.
	menuPane openInInnerWindow 
]

{ #category : #menu }
ToSandBox class >> example_MenuPaneWithAccordeon3 [

	| menu item sub subsub subsubsub |
	menu := ToMenuPane new.
	menu vertical: true.
	menu width: 300.
	menu vMatchParent.
	menu isScrollable: true.
	menu addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ :evt | evt target space root inspect ];
			 yourself).
	(1 to: 5) collect: [ :i |
		item := ToCustomMenuItem new in: [ :e |
			        e addChild:
				        (self accordionWithLabelText: 'Header ' , i asString) ].
		menu addItem: item ].
	menu addItem: item.

	sub := ToMenu new labelText: 'Save All'.
	sub beInline.
	sub addItem: (ToMenuItem new
			 labelText: 'Locally';
			 yourself).

	subsub := ToMenu new
		          labelText: 'Externally';
		          icon: (ToImage inner: (self iconNamed: #solidMenu)).
	subsub beInline.
	subsubsub := ToMenu new
		             labelText: 'When';
		             icon: (ToImage inner: (self iconNamed: #solidMenu)).
	subsubsub beInline.
	subsubsub addItem: (ToMenuItem new
			 labelText: 'now';
			 yourself).
	subsubsub addItem: (ToMenuItem new
			 labelText: 'later';
			 yourself).

	subsub addItem: subsubsub.
	sub addItem: subsub.
	menu addItem: sub.

	menu openInSpace
]

{ #category : #menu }
ToSandBox class >> example_MenuPopover [

	| menu |
	menu := self example_Menu2.
	menu manager popover: true.
	^ menu
]

{ #category : #menu }
ToSandBox class >> example_MenuWithAccordeon [

	| menu pane item |
	menu := ToMenu new.
	menu icon: (ToImage inner: (self iconNamed: #solidMenu)).
	pane := self paneWithAccordionsWithLabel.
	item := ToCustomMenuItem new in: [ :e | e addChild: pane ].
	menu addItem: item.
	menu openInSpace
]

{ #category : #menu }
ToSandBox class >> example_MenuWithAccordeon2 [

	| menu pane item |
	menu := ToMenu new.
	menu icon: (ToImage inner: (self iconNamed: #solidMenu)).
	pane := self paneWithAccordionsWithLabel.
	pane childrenDo: [ :child |
		child expandIconAtStart: false.
		child addStamp: #ghost.
		child addStamp: #borderless ].
	item := ToCustomMenuItem new in: [ :e | e addChild: pane ].
	menu addItem: item.
	menu openInSpace
]

{ #category : #menu }
ToSandBox class >> example_MenuWithAccordeon3 [

	| menu item sub subsub subsubsub |
	menu := ToMenu new.
	menu addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ :evt | evt target space root inspect ];
			 yourself).
	menu icon: (ToImage inner: (self iconNamed: #solidMenu)).
	(1 to: 5) collect: [ :i |
		item := ToCustomMenuItem new in: [ :e |
			        e addChild:
				        (self accordionWithLabelText: 'Header ' , i asString) ].
		menu addItem: item ].
	menu addItem: item.

	sub := ToMenu new labelText: 'Save All'.
	sub beInline.
	sub addItem: (ToMenuItem new
			 labelText: 'Locally';
			 yourself).

	subsub := ToMenu new
		          labelText: 'Externally';
		          icon: (ToImage inner: (self iconNamed: #solidMenu)).
	subsub beInline.
	subsubsub := ToMenu new
		             labelText: 'When';
		             icon: (ToImage inner: (self iconNamed: #solidMenu)).
	subsubsub beInline.
	subsubsub addItem: (ToMenuItem new
			 labelText: 'now';
			 yourself).
	subsubsub addItem: (ToMenuItem new
			 labelText: 'later';
			 yourself).

	subsub addItem: subsubsub.
	sub addItem: subsub.
	menu addItem: sub.

	menu openInSpace
]

{ #category : #menu }
ToSandBox class >> example_MenuWithCustomItems [

	| menu grp right center left textField sub lbl item |
	menu := ToMenu new.
	menu labelText: 'File'.
	menu addItem: (ToMenuItem new
			 labelText: 'Open file';
			 clickAction: [ self inform: 'Open file' ];
			 icon: (ToImage inner: (Smalltalk ui icons iconNamed: #config))).

	item := ToMenuItem new
		        labelText: 'Export';
		        clickAction: [ self inform: 'Export' ];
		        yourself.
	menu addItem: item.
	item disable.

	menu
		addItem: (ToMenuItem new
				 labelText: 'Inspect';
				 clickAction: [ menu space root inspect ];
				 yourself).
	menu addSeparator.
	menu addItem: (ToToggleMenuItem new
			 labelText: 'Toggle';
			 yourself).
	menu addItem: (ToCustomMenuItem new
			 in: [ :e |
				 e addChild: (ToSwitchButton new
							  checked: true;
							  startFlexible: true;
							  hMatchParent;
							  labelText: 'Switch';
							  yourself) ];
			 yourself).

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

	menu addSeparator.

	lbl := ToAttributedLabel text: 'Radio button icon first'.
	lbl
		italic;
		fontSize: 12;
		foreground: Color blue.

	menu addItem: (ToCustomMenuItem new in: [ :e |
			 e
				 addChild: lbl;
				 margin: (BlInsets
						  top: 2;
						  bottom: 4) ]).
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

	menu addSeparator.

	lbl := ToAttributedLabel new text:
		       ('Radio button label first' asRopedText
			        italic;
			        fontSize: 12;
			        foreground: (Color blue alpha: 0.7)).
	menu addItem: (ToCustomMenuItem new in: [ :e |
			 e
				 addChild: lbl;
				 margin: (BlInsets
						  top: 2;
						  bottom: 4) ]).
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
	menu addItem:
		(ToCustomMenuItem new in: [ :e | e addChild: textField ]).
	menu addSeparator.
	sub := ToMenu new labelText: 'Save All'.

	sub addItem: (ToMenuItem new labelText: 'Locally').
	menu addItem: sub.

	menu position: 10 @ 10.
	menu openInInnerWindow
]

{ #category : #menu }
ToSandBox class >> example_MenuWithSelect [

	| menu selector item |
	menu := ToMenu new.
	menu icon: (ToImage inner: (self iconNamed: #solidMenu)).
	selector := ToSingleSelectElement new.
	selector placeholderString: 'Choose a level number'.
	selector filtrable: false.
	"selector manager popover: true."
	selector width: 170.
	selector popupListElement dataAccessor addAll:
		{ 1. 2. 3. 4. 5. 6. 7. 8. 9. 10. 11. 12 }.
	item := ToCustomMenuItem new in: [ :e | e addChild: selector ].
	item closeOnPicking: false.
	menu addItem: item.
	menu openInSpace
]

{ #category : #'still pressed hovered event' }
ToSandBox class >> example_MixedEventGenerator [

	| e count lab color |
	e := ToElement new
		     id: #'my-element';
		     yourself.
	e addEventHandler: (ToMixedEventGeneratorHandler new
			 needRepeatedEvent: true;
			 startDelay: 500 milliSeconds;
			 delay: 200 milliSeconds;
			 yourself).
	e layout: BlFrameLayout new.
	lab := ToLabel new text: 'Enter here'.
	lab constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	e addChild: lab.
	e extent: 200 asPoint.
	e border: Color black.
	count := 0.
	color := Color white alpha: 0.3.

	e addEventHandler: (BlEventHandler
			 on: ToGeneratorEvent
			 do: [ :event |
					 event trace.
					 event sourceEvent traceCr ]).

	e addEventHandler: (BlEventHandler
			 on: ToStillHoveredEvent
			 do: [ :event |
					 e background: color.
					 lab text: count asString asRopedText.
					 count := count + 1.
					 color := color darker.
					 count > 50 ifTrue: [ event consume ] ]).

	e addEventHandler: (BlEventHandler
			 on: ToStopStillHoveredEvent
			 do: [ :event |
					 count := 0.
					 color := Color white alpha: 0.3.
					 e background: color ]).

	e openInSpace
]

{ #category : #list }
ToSandBox class >> example_NodeContainerWithStatesOfAmerica [

	| l |
	l := ToListElement finite.
	l toConfigurationDo: [ :conf | conf isFlowable: true ].
	l matchParent.
	l dataAccessor addAll: self statesOfAmerica.
	l nodes do: [ :n | n width: 100 ].
	l openInSpace
]

{ #category : #menu }
ToSandBox class >> example_OpenSaveSaveAsCloseWithSubmenu [

	| menu container saveAs lbl |
	container := ToInnerWindow new
		             position: 10 @ 10;
		             extent: 400 @ 200;
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
	menu addItem: (ToCustomMenuItem new in: [ :e | e addChild: lbl ]).

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
	list := ToExPicsumListElement new
		        matchParent;
		        yourself.

	list selectionOption
		grouped: false;
		beneath: false;
		elementFactory: [
			ToListSelectionElement new defaultSkin:
					ToExPicsumSelectionSkin new ].

	[
	| allImagesData |
	allImagesData := (STONJSON fromString:
		                  'https://picsum.photos/list' asUrl
			                  retrieveContents) collect: [ :aDictionary |
		                 ToExPicsumImageData fromDictionary:
			                 aDictionary ].
	allImagesData sort: [ :a :b | a id > b id ].
	list dataAccessor addAll: allImagesData ] fork.

	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
		c ignoreByLayout.
		c margin: (BlInsets left: 10).
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	vscrollBar attachTo: list innerElement.

	space := BlSpace new
		         extent: 200 @ 600;
		         title: 'picsum.photos Gallery'.

	space root addChild: list.
	space root addChild: vscrollBar.
	space show
]

{ #category : #list }
ToSandBox class >> example_PicsumPhotosGallery_crashing [
	" cool example adapted from the feenk Glamorous Toolkit version BlInfiniteExample>>exampleGallery"

	" Images loaded from https://picsum.photos "

	| space list vscrollBar |
	list := ToExPicsumListElement finite
		        matchParent;
		        yourself.

	list selectionOption
		grouped: false;
		beneath: false;
		elementFactory: [
			ToListSelectionElement new defaultSkin:
					ToExPicsumSelectionSkin new ].

	[
	| allImagesData |
	allImagesData := (STONJSON fromString:
		                  'https://picsum.photos/list' asUrl
			                  retrieveContents) collect: [ :aDictionary |
		                 ToExPicsumImageData fromDictionary:
			                 aDictionary ].
	allImagesData sort: [ :a :b | a id > b id ].
	list dataAccessor addAll: allImagesData ] fork.

	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
		c ignoreByLayout.
		c margin: (BlInsets left: 10).
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	vscrollBar attachTo: list innerElement.

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
	e extent: 30 @ 30.
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
		             extent: 400 @ 200;
		             yourself.
	menu := ToElement new
		        layout: BlLinearLayout vertical;
		        id: #'red-button';
		        background: Color red;
		        extent: 100 @ 40;
		        position: 50 @ 50.
	sub := ToElement new
		       background: Color white;
		       border: Color black;
		       extent: 20 @ 20;
		       position: 10 @ 10.
	menu addChild: sub.
	popupWindowHandler := ToPopupWindowManager new.
	popupWindowHandler anchorRoot: container.
	popupWindowHandler windowBuilder: [ :popup :element |
			popup border: Color black.
			item := ToElement new extent: 150 @ 90.
			item background: Color yellow.
			popup root addChild: item ].
	menu addEventHandler: popupWindowHandler.
	container pane addChild: menu.
	container openInSpace
]

{ #category : #tree }
ToSandBox class >> example_PreviousIntegers [
	"This example shows classes as a list but using TreeNodes, 
	tree logic is not implemented at this time of writing the example"

	| l |
	l := ToTreeElement finite.
	l nodeManager childrenGetter: [ :dataItem |
			dataItem = 1
				ifTrue: [ {  } ]
				ifFalse: [ { (dataItem - 1) } ] ].
	l contextMenuBuilder: [ :menu :request |
			| selectionModel indexes target |
			target := request currentTarget.
			selectionModel := request selectionModel.
			indexes := request selectedIndexes.
			indexes traceCr.
			menu addItem: (ToMenuItem new
					 labelText: 'Expand all';
					 clickAction: [
							 indexes
								 ifEmpty: [ target expandAll ]
								 ifNotEmpty: [
									 indexes reverseDo: [ :idx |
											 (target dataSource at: idx) expandAll ] ] ];
					 yourself).
			menu addItem: (ToMenuItem new
					 labelText: 'Collapse all';
					 clickAction: [
							 indexes
								 ifEmpty: [ target collapseAll ]
								 ifNotEmpty: [
									 indexes reverseDo: [ :idx |
											 (target dataSource at: idx) collapse ] ] ];
					 yourself) ].
	l dataAccessor addAll: (1 to: 10).
	l openInSpace
]

{ #category : #tree }
ToSandBox class >> example_ProtoObjectSubclasses [
	"This example shows classes as a list but using TreeNodes, tree logic is not implemented at this time of writing the example"

	| l |
	l := ToTreeElement new.
	l nodeManager childrenGetter: [ :dataItem |
		dataItem subclasses sorted: [ :a :b | a name < b name ] ].
	l withRowNumbers.
	l contextMenuBuilder: [ :menu :request |
			| selectionModel indexes target |
			target := request currentTarget.
			selectionModel := request selectionModel.
			indexes := request selectedIndexes.
			menu addItem: (ToMenuItem new
					 labelText: 'Expand all';
					 clickAction: [ "[ target expandAll] millisecondsToRun traceCr"
							 indexes
								 ifEmpty: [ [ target expandAll ] timeToRun traceCr ]
								 ifNotEmpty: [
									 indexes do: [ :idx | (target dataSource at: idx) expandAll ] ] ];
					 yourself).
			menu addItem: (ToMenuItem new
					 labelText: 'Collapse all';
					 clickAction: [
							 indexes
								 ifEmpty: [ target collapseAll ]
								 ifNotEmpty: [
									 indexes do: [ :idx | (target dataSource at: idx) collapse ] ] ];
					 yourself).
			menu addSeparator.
			menu addItem: (ToMenuItem new
					 labelText: 'inspect';
					 clickAction: [ target inspect ];
					 yourself) ].
	l dataAccessor add: ProtoObject.
	l openInSpace
]

{ #category : #checkables }
ToSandBox class >> example_RadioButtonChecked [

	| but |
	ToTheme cleanUp.
	but := ToRadioButton new.
	but checked: true.
	but labelText: 'Radio'.
	but openInSpace
]

{ #category : #checkables }
ToSandBox class >> example_RadioButtonUnchecked [

	| but |
	ToTheme cleanUp.
	but := ToRadioButton new.
	but labelText: 'Radio'.
	but openInSpace
]

{ #category : #checkables }
ToSandBox class >> example_RadioButtonWithIndeterminate [

	| but |
	ToTheme cleanUp.
	but := ToRadioButton new.
	but allowIndeterminate: true.
	but checked: #something. " any value except a boolean (and except nil) for indeterminate state "
	but labelText: 'Radio'.
	but openInSpace
]

{ #category : #anchors }
ToSandBox class >> example_RandomPositionOnLayoutWithActionAnchor [

	| pane red |
	pane := ToElement new.
	pane matchParent.
	pane layout: BlAnchorLayout new.
	pane border: Color red.
	red := ToElement new
		       id: #red;
		       layout: BlFrameLayout new;
		       yourself.
	red background: Color red.
	red extent: 20 @ 20.
	red constraintsDo: [ :c |
			| rand |
			rand := Random new.
			c anchors add: (red topLeftAnchor on: (red actionAnchor: [ :v :e |
							  (rand nextIntegerBetween: 1 and: pane measuredWidth)
							  @ (rand nextIntegerBetween: 1 and: pane measuredHeight) ])) ].
	pane addChild: red.

	pane openInInnerWindow
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
						 e extent: anArray third @ anArray fourth ].
				 anim delay: 200 milliSeconds.
				 e addAnimation: anim ]).

	e openInSpace
]

{ #category : #filters }
ToSandBox class >> example_RootFilterAnd2StackedPanes [

	| menuPane subMenuPane filter main |
	main := ToPane horizontal.
	main matchParent.

	menuPane := ToMenuPane new.
	menuPane addChild: (ToLabel text: 'Menu').
	menuPane width: 200.
	menuPane vMatchParent.

	filter := ToOutsideEventFilter new
		          eventsToHandle: { BlMouseUpEvent };
		          element: menuPane;
		          checkTopElementOnly: false;
		          yourself.

	menuPane
		addEventHandlerOn: ToAddedToSpaceEvent
		do: [ :evt | menuPane space root addEventFilter: filter ].

	menuPane
		addEventHandlerOn: ToMouseUpOutsideEvent
		do: [ :evt | evt currentTarget removeFromParent ].

	subMenuPane := ToMenuPane new.
	subMenuPane addChild: (ToLabel text: 'Sub Menu').
	subMenuPane
		addEventHandlerOn: ToMouseUpOutsideEvent
		do: [ :evt | evt currentTarget removeFromParent ].

	filter pushElement: subMenuPane.
	subMenuPane width: 100.
	subMenuPane vMatchParent.

	menuPane withNullSkin.
	menuPane background: Color red.
	subMenuPane withNullSkin.
	subMenuPane background: Color blue.

	main addChild: subMenuPane.
	main addChild: menuPane.

	main openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectAntDesignIconMonoFiltrable [

	| select |
	select := ToSingleSelectElement new.
	self
		buildSelectListElementIn: select
		withIconProvider: ToAntDesignIconProvider.

	select filtrable: true.
	select sample: (select popupListElement dataAccessor at: 1).
	select dataViewBuilder: [ :dataItemView :iconDesc |
			dataItemView addChild:
				((iconDesc icon extent: 48 asPoint) background:
					 Color veryLightGray).
			dataItemView addChild:
				((ToLabel text: iconDesc style prefix , ' ' , iconDesc name)
					 margin: (BlInsets all: 3);
					 yourself).
			dataItemView childrenDo: [ :child |
				child constraintsDo: [ :c | c linear vertical alignCenter ] ] ].

	select hMatchParent.
	select placeholderString: 'Select an icon'.

	select openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectAntDesignIconMultiFiltrable [

	| select |
	select := ToMultiSelectElement new.
	self
		buildSelectListElementIn: select
		withIconProvider: ToAntDesignIconProvider.

	select filtrable: true.

	select nodeBuilder: [ :tag :iconDesc :holder |
			tag icon: (iconDesc icon extent: 48 asPoint).
			tag removable: true ].
	select sample: select popupListElement dataAccessor first.

	select hMatchParent.
	select placeholderString: 'Select icons'.
	select openInInnerWindow
]

{ #category : #select }
ToSandBox class >> example_SelectMaterialDesignIconMonoFiltrable [

	| select |
	select := ToSingleSelectElement new.
	self
		buildSelectListElementIn: select
		withIconProvider: ToMaterialDesignIconProvider.

	select filtrable: true.
	select sample: select popupListElement dataAccessor first.

	select dataViewBuilder: [ :dataItemView :iconDesc |
			dataItemView addChild:
				((iconDesc icon extent: 48 asPoint) background:
					 Color veryLightGray).
			dataItemView addChild:
				((ToLabel text: iconDesc style prefix , ' ' , iconDesc name)
					 margin: (BlInsets all: 3);
					 yourself).
			dataItemView childrenDo: [ :child |
				child constraintsDo: [ :c | c linear vertical alignCenter ] ] ].


	select hMatchParent.
	select placeholderString: 'Select an icon'.

	select openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMaterialDesignIconMultiFiltrable [

	| select |
	select := ToMultiSelectElement new.

	select isFlowable: true.
	select filtrable: true.
	select nodeBuilder: [ :node :iconDesc :holder |
			node icon: (iconDesc icon extent: 48 asPoint).
			node removable: true ].

	self
		buildSelectListElementIn: select
		withIconProvider: ToMaterialDesignIconProvider.
	select sample: select popupListElement dataAccessor first.


	select hMatchParent.
	select placeholderString: 'Select icons'.
	select openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMonoFiltrable [

	| select innerWindow phtext |
	select := ToSingleSelectElement new.
	select
		addEventHandlerOn: ToSelectChangedEvent
		do: [ :event | event selectedIndexes traceCr ].


	select manager minHeight: 35.
	phtext := ('No Data' asRopedText
		           foreground: Color lightGray;
		           yourself)
		          fontSize: 24;
		          yourself.
	select sample: 'X'.

	select dataViewBuilder: [ :dataItemView :aString |
		dataItemView addChild: ((ToLabel text: aString)
				 fontSize: 18;
				 yourself) ].
	select filtrable: true.

	select popupListElement dataAccessor addAll: self statesOfAmerica.
	select selecter selectIndex: 2.
	select placeholderString: 'Select a state'.
	innerWindow := ToInnerWindow new.
	select anchorRoot: innerWindow root.
	select width: 300.
	"select position: 50 @ 50."
	innerWindow pane addChild: select.
	innerWindow height: 500.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMonoNotFiltrable [

	| select innerWindow |
	select := ToSingleSelectElement new.
	select popupListElement dataAccessor addAll: self statesOfAmerica.
	select placeholderString: 'Select a state'.
	innerWindow := ToInnerWindow new.
	select anchorRoot: innerWindow root.
	select width: 300.
	select position: 50 @ 50.
	innerWindow pane addChild: select.
	innerWindow height: 500.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrable [

	| select innerWindow tagBuilder |
	select := ToMultiSelectElement new.

	select filtrable: true.
	select isFlowable: false.
	select isScrollable: false.
	select keepPickOrder: false.
	select hideSelected: false.
	select popupMaxHeight: 200.
	select placeholderString: 'Select a state'.

	select popupListElement selectionOption grouped: false.
	select popupListElement selectionOption beneath: false.
	select popupListElement selectionOption elementFactory: [
			ToListSelectionElement new defaultSkin:
				ToMultiSelectElementCheckSkin new ].

	select sample: 'X' -> Color white.
	tagBuilder := [ :tag :stateColorAssoc |
		              stateColorAssoc ifNotNil: [
				              tag labelText: stateColorAssoc key asString.
				              tag borderless: true.
				              tag foregroundColor: stateColorAssoc value.
				              tag backgroundColor:
					              (stateColorAssoc value veryMuchLighter alpha: 0.5) ] ].

	select header nodeBuilder: [ :node :stateColorAssoc :holder |
			tagBuilder value: node value: stateColorAssoc.
			node borderless: false.
			node removable: true ].

	select popupListElement nodeBuilder: [ :node :stateColorAssoc :holder |
			| tag |
			tag := ToTagElement new
				       hMatchParent;
				       yourself.
			tagBuilder value: tag value: stateColorAssoc.
			node addChild: tag ].

	select sieve filter: [ :stateAssoc :pattern |
		stateAssoc key beginsWith: pattern caseSensitive: false ].

	select popupListElement dataAccessor addAll:
		self statesOfAmericaWithColor.

	innerWindow := ToInnerWindow new.
	select anchorRoot: innerWindow root.
	select hMatchParent.
	innerWindow pane addChild: select.

	innerWindow openInSpace.
	^ select
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableAutoDistribution [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select isFlowable: false.
	select autoDistribute: true.
	select hideSelected: false.
	select popupListElement dataAccessor addAll: self statesOfAmerica.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderString: 'Select a state'.
	innerWindow := ToInnerWindow new.
	select anchorRoot: innerWindow root.
	select hMatchParent.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableAutoDistributionWithMax [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select maxSelectedCount: 4.
	select isFlowable: false.
	select autoDistribute: true.
	select hideSelected: false.
	select popupListElement dataAccessor addAll: self statesOfAmerica.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderString: 'Select a state'.
	innerWindow := ToInnerWindow new.
	select anchorRoot: innerWindow root.
	select hMatchParent.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableNoWrapping [

	| select innerWindow |
	select := ToMultiSelectElement new.
	"select maxSelectedCount: 6."
	select isFlowable: false.
	select hideSelected: false.
	select popupListElement dataAccessor addAll: self statesOfAmerica.
	select sample: 'X'.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderString: 'Select a state'.
	innerWindow := ToInnerWindow new.
	select anchorRoot: innerWindow root.
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
	select isFlowable: false.
	select hideSelected: false.
	select popupListElement dataAccessor addAll: self statesOfAmerica.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderString: 'Select a state'.
	innerWindow := ToInnerWindow new.
	select anchorRoot: innerWindow root.
	select hMatchParent.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableScrolling [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select isScrollable: true.
	select isFlowable: false.
	select hideSelected: false.
	select popupListElement dataAccessor addAll: self statesOfAmerica.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderString: 'Select a state'.
	innerWindow := ToInnerWindow new.
	select anchorRoot: innerWindow root.
	select hMatchParent.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableWithCheckboxes [

	| select skinBuilder |
	select := ToMultiSelectElement new.
	select popupListElement selectionOption withEmbeddedRepresentation.
	select popupListElement dataAccessor addAll: self statesOfAmerica.

	skinBuilder := [
		               ToScriptableSkin new
			               onInstallSkinEvent: [ :e :evt |
					               e icon:
							               (ToImage inner:
									                (e valueOfTokenNamed:
											                 #'checkbox-unchecked-image')).
					               e icon extent:
							               (e valueOfTokenNamed: #'menu-icon-size').
					               e icon innerImageColor:
							               (e valueOfTokenNamed: #'color-primary') ];
			               onSelectedSkinEvent: [ :e :evt |
					               e icon
						               innerImage:
							               (e valueOfTokenNamed: #'checkbox-checked-image');
						               innerImageColor:
							               (e valueOfTokenNamed: #'color-primary') ];
			               onDeselectedSkinEvent: [ :e :evt |
					               e icon
						               innerImage:
							               (e valueOfTokenNamed:
									                #'checkbox-unchecked-image');
						               innerImageColor:
							               (e valueOfTokenNamed: #'color-primary') ];
			               yourself ].
	select popupListElement nodeBuilder: [ :node :aState :holder |
			| box |
			box := ToLabeledIcon new
				       labelText: aState;
				       startFlexible: true;
				       hMatchParent;
				       beEndToStart;
				       yourself.

			node addChild: box.
			box defaultSkin: skinBuilder value ].
	select openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableWithCheckboxesBis [

	| select |
	select := ToMultiSelectElement new.
	select popupListElement useCheckbox: true.
	select popupListElement dataAccessor addAll: self statesOfAmerica.
	select filtrable: false.
	select popupListElement nodeBuilder: [ :node :aState :holder |
			| label |
			label := ToLabeledIcon new
				       labelText: aState;
				       startFlexible: true;
				       hMatchParent;
				       yourself.
			node addChild: label ].
	select sample: 'X'.
	select openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableWithHideSelected [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select isFlowable: true.
	select hideSelected: true.
	select popupListElement dataAccessor updateAllWith:
		self statesOfAmerica.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderString: 'Selected are removed'.
	innerWindow := ToInnerWindow new.
	select anchorRoot: innerWindow root.
	select hMatchParent.
	select popupListElement withRowNumbers.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableWithHideSelected2 [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select hideSelected: true.
	select popupListElement dataAccessor addAll:
		{ 'Apples'. 'Nails'. 'Bananas'. 'Helicopter' }.
	select filtrable: true.
	select popupMaxHeight: 200.
	select placeholderString: 'Selected are removed'.
	innerWindow := ToInnerWindow new.
	select anchorRoot: innerWindow root.
	select width: 300.
	select position: 50 @ 10.
	innerWindow pane addChild: select.
	innerWindow height: 600.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableWithMatchParentMaxHeight [

	| select |
	select := self example_SelectMultiFiltrable.
	select popupListElement dataAccessor updateAllWith:
		(self statesOfAmericaWithColor copyFrom: 1 to: 15).
	select manager withMatchParentMaxHeight.
]

{ #category : #select }
ToSandBox class >> example_SelectMultiFiltrableWithMax [

	| select |
	select := self example_SelectMultiFiltrable.
	select maxSelectedCount: 3.
	select selecter selectIndex: 3.
	select selecter selectIndex: 5.
	select selecter selectIndex: 4.
	select selecter selectIndex: 6.

]

{ #category : #select }
ToSandBox class >> example_SelectMultiNotFiltrable [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select maxSelectedCount: 4.
	select filtrable: false.
	select isFlowable: true.
	select popupListElement dataAccessor addAll: self statesOfAmerica.
	select placeholderString: 'Select states'.
	select popupListElement nodeBuilder: [ :node :dataItem :holder |
		node addChild: (ToLabel text: dataItem asString) hMatchParent ].
	innerWindow := ToInnerWindow new.
	select anchorRoot: innerWindow root.
	select hExact: 300.
	select position: 50 @ 50.

	innerWindow pane addChild: select.
	innerWindow height: 500.
	innerWindow openInSpace
]

{ #category : #select }
ToSandBox class >> example_SelectMultiNotFiltrableWithGroups [

	| select innerWindow  |
	select := ToMultiSelectElement new.
	select withGroups: true.
	select manager minHeight: 85.
	select manager withMatchParentMaxHeight.

	select filtrable: false.
	self statesOfAmericaWithGroups do: [ :assoc |
		select popupListElement dataAccessor add: assoc key.
		select setGroupIndex: select popupListElement dataAccessor itemCount.
		select popupListElement dataAccessor addAll: assoc value ].

	select placeholderString: 'Select states'.
	innerWindow := ToInnerWindow new.
	select anchorRoot: innerWindow root.
	innerWindow root padding:( BlInsets all: 10).
	select filterTextField requestFocus.
	innerWindow pane addChild: select.
	innerWindow height: 590.
	innerWindow openInSpace
]

{ #category : #label }
ToSandBox class >> example_SelectableLabel [

	| t |
	t := ToSelectableLabel new text: 'AAAA BBBBB CCCCCC DDDDD EEEEEEE FFFFFF GGGGGG'.
	t openInInnerWindow 
]

{ #category : #'labeled icon' }
ToSandBox class >> example_SelectableLabeledIconlWithIconAndText [

	| but  |
	but := self selectableLabeledIconlWithIconAndText.
	but hMatchParent.
	but openInSpace.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_SelectableLabeledIconlWithIconAndText_labelFirst [

	| but  |
	but := self example_SelectableLabeledIconlWithIconAndText.
	but endToStart: true.
	^ but
]

{ #category : #'labeled icon' }
ToSandBox class >> example_SelectableLabeledIconlWithIconAndText_labelFirst_startFlexible [

	| but  |
	but := self example_SelectableLabeledIconlWithIconAndText_labelFirst.
	but startFlexible: true.
	but matchParent.
	^ but
]

{ #category : #list }
ToSandBox class >> example_SieveOnList2WithStatesOfAmerica [

	"Pay attention this method is not super slow
	and not part of the example tests
	"
	| listElement pane filterField data sieve |
	pane := ToPane new
		        beVertical;
		        matchParent.
	listElement := ToListElement finite.
	data := self statesOfAmerica.
	listElement margin: (BlInsets all: 2).
	listElement withRowNumbers.

	sieve := listElement dataAccessor newSieve.
	listElement dataAccessor addAll: data.
	filterField := sieve newTextField.

	listElement placeholderBuilder: [ :ph :e |
		| lab |
		lab := ToAttributedLabel new text: ('No Data' asRopedText
				        foreground: Color lightGray;
				        fontSize: 24;
				        yourself).
		ph empty label: lab ].

	pane addChild: listElement.
	pane addChild: filterField.
	pane openInSpace.
	^ listElement->sieve
]

{ #category : #list }
ToSandBox class >> example_SieveOnList2With_175000_Items [

	| listElement pane filterField data sieve |
	pane := ToPane new
		        beVertical;
		        matchParent.
	listElement := ToListElement new.
	data := OrderedCollection new.
	" pay attention that the data computation is very slow "
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
	sieve := listElement dataAccessor newSieve.
	listElement dataAccessor addAll: data.
	filterField := sieve newTextField.

	listElement placeholderBuilder: [ :ph :e |
		| lab |
		lab := ToAttributedLabel new text: ('No Data' asRopedText
				        foreground: Color lightGray;
				        fontSize: 24;
				        yourself).
		ph empty label: lab  ].

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

	listElement := ToListElement new.
	data := SystemNavigation default allMethods.
	listElement withRowNumbers.
	listElement dataAccessor addAll:
		(Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]).

	sieve := listElement dataAccessor newSieve.

	filterField := sieve newTextField.
	filterField placeholderString: 'Method name filter'.

	listElement nodeBuilder: [ :node :dataItem :holder |
		node addChild: (ToLabel new text: dataItem printString) ].

	sieve filter: [ :aClass :aPattern |
		aClass name includesSubstring: aPattern caseSensitive: false ].


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

	listElement := ToListElement new.
	data := SystemNavigation default allMethods.
	listElement withRowNumbers.
	sieve := listElement dataAccessor newSieve.
	filterField := sieve newTextField.
	filterField placeholderString: 'Method name filter'.
	listElement dataAccessor addAll: data.
	listElement
		addEventHandlerOn: ToSieveSelectionChangedEvent
		do: [ :event |
			'selected: ' trace.
			event selectionModel selectedIndexes traceCr ].
	listElement nodeBuilder: [ :node :dataItem :holder |
		node addChild: (ToLabel new text: dataItem printString) ].
	sieve filter: [ :aCompiledMethod :aPattern |
		aCompiledMethod selector beginsWith: aPattern caseSensitive: true ].
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
	listElement primarySelectionMode beSingleSelection
]

{ #category : #list }
ToSandBox class >> example_SieveOnList2With_AllMethods_OnCR [

	| listElement pane filterField data sieve |
	pane := ToPane new
		        beVertical;
		        matchParent.

	listElement := ToListElement new.
	data := SystemNavigation default allMethods.
	listElement withRowNumbers.

	sieve := listElement dataAccessor newSieve.
	filterField := sieve newTextField.
	listElement dataAccessor addAll: data.

	sieve filter: [ :aCompiledMethod :aPattern |
		aCompiledMethod selector beginsWith: aPattern caseSensitive: true ].

	listElement nodeBuilder: [ :node :dataItem :holder |
		node addChild: (ToLabel new text: dataItem printString) ].

	filterField addEditorShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination return;
			 action: [ :event |
				 | pattern |
				 pattern := event currentTarget text asString.
				 self inform: pattern.
				 sieve pattern: pattern ] yourself).

	pane addChild: listElement.
	pane addChild: filterField.
	pane openInSpace
]

{ #category : #tree }
ToSandBox class >> example_SieveOnTree [

	| treeElement pane filterField data sieve |
	pane := ToPane new
		        beVertical;
		        matchParent.

	treeElement := ToTreeElement new.
	treeElement sample: #A.
	treeElement childrenGetter: [ :dataItem |
			Array streamContents: [ :stream |
				dataItem do: [ :c | stream nextPut: c asSymbol ] ] ].
	treeElement placeholderBuilder: [ :placeholder :e |
		placeholder empty ].
	treeElement
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :evt | evt selectedIndexes traceCr ].

	data := SystemNavigation default allMethods.
	treeElement contextMenuBuilder: [ :menu :request |
			| selectionModel indexes target |
			target := request currentTarget.
			selectionModel := request selectionModel.
			indexes := request selectedIndexes.
			menu addItem: (ToMenuItem new
					 labelText: 'Expand all';
					 clickAction: [ "[ target expandAll] millisecondsToRun traceCr"
							 indexes
								 ifEmpty: [ [ target expandAll ] timeToRun traceCr ]
								 ifNotEmpty: [
									 indexes do: [ :idx | (target dataSource at: idx) expandAll ] ] ];
					 yourself).
			menu addItem: (ToMenuItem new
					 labelText: 'Collapse all';
					 clickAction: [
							 indexes
								 ifEmpty: [ target collapseAll ]
								 ifNotEmpty: [
									 indexes reverseDo: [ :idx |
											 (target dataSource at: idx) collapse ] ] ];
					 yourself) ].
	treeElement withRowNumbers.
	sieve := treeElement dataAccessor newSieve.
	filterField := sieve newTextField.
	filterField placeholderString: 'Method name filter'.
	treeElement dataAccessor addAll:
		{ #AAA. #BBB. #CCC. #ABB. #ACC. #BAA. #BCC }.

	sieve filter: [ :aString :aPattern |
		aString includesSubstring: aPattern caseSensitive: false ].

	treeElement nodeBuilder: [ :node :dataItem :holder |
		node addChild: (ToLabel new text: dataItem printString) ].

	treeElement
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :evt | self selectionChangedEvent: evt ].

	pane addChild: treeElement.
	pane addChild: filterField.
	pane openInSpace
]

{ #category : #tree }
ToSandBox class >> example_SieveOnTreeWithClasses [

	| treeElement pane filterField data sieve |
	pane := ToPane new
		        beVertical;
		        matchParent.

	treeElement := ToTreeElement new.
	treeElement childrenGetter: [ :dataItem | dataItem subclasses ].
	data := SystemNavigation default allMethods.
	treeElement withRowNumbers.
	sieve := treeElement dataAccessor newSieve.
	filterField := sieve newTextField.
	filterField placeholderString: 'Class name filter'.
	treeElement dataAccessor addAll:
		(Smalltalk globals allClasses sorted: [ :a :b | a name < b name ]).

	sieve filter: [ :aClass :aPattern |
		aClass name includesSubstring: aPattern caseSensitive: false ].

	treeElement nodeBuilder: [ :node :dataItem :holder |
		node addChild: (ToLabel new text: dataItem printString) ].

	pane addChild: treeElement.
	pane addChild: filterField.
	pane openInSpace
]

{ #category : #float }
ToSandBox class >> example_SimpleFloat [

	| plusBtn pane float |
	plusBtn := ToButton new
		           labelText: '+';
		           yourself.
	plusBtn addStamp: #circle.
	pane := ToPane new matchParent.

	float := plusBtn asFloatElement
		         geometry: BlCircleGeometry new;
		         yourself.
	float attachToElement: pane.
	pane openInInnerWindow
]

{ #category : #menu }
ToSandBox class >> example_SimpleOpenSaveSaveAsClose [

	| menu container |
	container := ToInnerWindow new
		             position: 10 @ 10;
		             extent: 400 @ 200;
		             yourself.
	menu := ToMenu new background: Color random.
	menu label: (ToLabel text: 'Menu').
	menu addItem: (ToMenuItem new
			 icon: (ToImage inner: (self iconNamed: #solidMenu));
			 label: (ToLabel text: 'Open')).
	menu addItem: (ToMenuItem new
			 icon: (ToImage inner: (self iconNamed: #solidMenu));
			 label: (ToLabel text: 'Save');
			 background: (Color random alpha: 0.2)).
	menu addItem: (ToMenuItem new
			 icon: (ToImage inner: (self iconNamed: #solidMenu));
			 label: (ToLabel text: 'Save as');
			 background: (Color random alpha: 0.2)).
	menu items last clickAction: [ :evt | evt target inspect ].
	menu addSeparator.
	menu addItem: (ToMenuItem new
			 label: (ToLabel text: 'Close');
			 background: (Color random alpha: 0.2)).
	menu items last clickAction: [ :evt | evt target inspect ].
	container pane addChild: menu.

	container openInSpace
]

{ #category : #window }
ToSandBox class >> example_SimplePopupBottomCenter [

	| p |
	p := self newPopup.
	p placement: ToAnchoredBottomCenterPlacement new.
	p measurement:
		(ToActionMeasurement new action: [ :spec :w :e | 
			spec widthSpec beExact: 130 ]).
	p anchorElement openInSpace
]

{ #category : #window }
ToSandBox class >> example_SimplePopupBottomLeft [

	| p |
	p := self newPopup.
	p placement: ToAnchoredBottomLeftPlacement new.
	p anchorElement openInSpace
]

{ #category : #window }
ToSandBox class >> example_SimplePopupBottomRight [

	| p |
	p := self newPopup.
	p placement: ToAnchoredBottomRightPlacement new.
	p anchorElement openInSpace
]

{ #category : #window }
ToSandBox class >> example_SimplePopupTopCenter [

	| p |
	p := self newPopup.
	p placement: ToAnchoredTopCenterPlacement new.
	p anchorElement openInSpace
]

{ #category : #window }
ToSandBox class >> example_SimplePopupTopLeft [

	| p |
	p := self newPopup.
	p placement: ToAnchoredTopLeftPlacement new.
	p anchorElement openInSpace
]

{ #category : #window }
ToSandBox class >> example_SimplePopupTopLeftOver [

	| p |
	p := self newPopup.
	p placement: (ToActionPlacement new action: [ :theWin :evt :aBoundsUpdater|
			 | theElem theRoot |
			 theElem := theWin anchorElement.
			 theRoot := theWin anchorRoot.
			 theWin position:
				 theElem bounds inSpace bounds topLeft - (0 @ theWin height) ]).
	p anchorElement openInSpace
]

{ #category : #window }
ToSandBox class >> example_SimplePopupTopRight [

	| p |
	p := self newPopup.
	p placement: ToAnchoredTopRightPlacement new.
	p anchorElement openInSpace
]

{ #category : #tabPane }
ToSandBox class >> example_SimpleTabPane [

	| tabPane space |
	space := BlSpace new.
	tabPane := ToTabPaneElement new.
	tabPane isFlowable: false.
	tabPane matchParent.
	space root addChild: tabPane.
	tabPane itemBuilder: [ :tabItem :data |
			tabItem
				id: data asSymbol;
				labelText: data asString;
				paneBuilder: [ :body :btn :holder |
						body addChild: (ToElement new
									 background: Color random;
									 matchParent;
									 yourself) ] ].

	tabPane addTabItemData: 'First'.
	tabPane addTabItemData: 'Second'.
	tabPane items second checked: true.
	"tabPane selecter selectOnlyIndex: 2."
	space show.
	^ tabPane
]

{ #category : #tabPane }
ToSandBox class >> example_SimpleTabPaneWithRemoveButtons [

	| tabPane space |
	space := BlSpace new.
	tabPane := self example_SimpleTabPane.
	tabPane items do: [ :tabItem | tabItem removable: true ].

	^ tabPane
]

{ #category : #tag }
ToSandBox class >> example_SimpleTagsInPane [

	| tag pane |
	pane := ToPane horizontal.
	#('Green' 'Yellow' 'Black') do: [ :colorName |
		tag := ToTagElement new labelText: colorName.
		pane addChild: tag ].
	pane openInSpace
]

{ #category : #'skin event' }
ToSandBox class >> example_SkinEventTrace [

	| but |
	but := ToButton new.
	but icon: (ToImage new innerImage: (self iconNamed: #solidMenu)).
	but label: (ToLabel text: 'Button with label').
	but addEventHandler: (BlEventHandler
			 on: ToSkinEvent
			 do: [ :evt | evt target = but ifTrue: [ evt traceCr ] ]).
	but openInSpace
]

{ #category : #label }
ToSandBox class >> example_SkinIsRenewWhenLableTextChange [

	| labelToChange buttonToChange button space |
	labelToChange := ToLabel new
		                 text: '#danger';
		                 addStamp: #danger;
		                 yourself.
	buttonToChange := ToButton new
		                  labelText: '#primary';
		                  addStamp: #primary;
		                  yourself.
	button := ToButton new
		          labelText: 'Change the label';
		          addEventHandlerOn: BlClickEvent do: [
				          labelToChange text:
						          labelToChange text asString , '- remains #danger'.
				          buttonToChange labelText:
						          buttonToChange labelText asString
						          , '- remains #primary' ];
		          yourself.


	space := BlSpace new.
	space root layout: BlLinearLayout horizontal.
	space root addChild: button.
	space root addChild: labelToChange.
	space root addChild: buttonToChange.
	space show.

	space toTheme: ToBeeTheme new
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
		im := ToImage new innerImage: (self iconNamed: k).
		lab := ToLabel new text: k asString.
		node := ToButton new icon: im; label: lab; yourself.
		node width: 600.
		node startFlexible: true.
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

{ #category : #tabPane }
ToSandBox class >> example_TabGroupElement [

	| tabs dashBoard |
	tabs := ToTabGroupElement new.
	tabs itemBuilder: [ :tabItem :data |
			tabItem labelText: data asString.
			tabItem removable: true ].
	50 to: 70 do: [ :i | tabs addTabItemData: i ].
	tabs selecter selectIndex: 5.
	tabs requestFocus.
	dashBoard := self tabGroupElementDashBoardFor: tabs.
	dashBoard openInSpace.
	^ tabs
]

{ #category : #tabPane }
ToSandBox class >> example_TabGroupElementWithDaily [

	| tabs dashBoard |
	tabs := ToTabGroupElement new.
	tabs itemBuilder: [ :tabItem :data :holder |
			tabItem labelText: data asString.
			tabItem removable: true ].

	{ 'Daily'. 'Weekly'. 'Monthly'. 'Quaterly'. 'Yearly' } do: [ :l |
		tabs addTabItemData: l ].

	(tabs items at: 2) disable.
	tabs selecter selectIndex: 3.
	tabs requestFocus.
	dashBoard := self tabGroupElementDashBoardFor: tabs.
	tabs disabled: true.
	dashBoard openInSpace.
	^ tabs
]

{ #category : #tabPane }
ToSandBox class >> example_TabGroupElementWithStartAndEndExtras [

	| tabs |
	tabs := self example_TabGroupElementWithUSStates.

	tabs startExtraBuilder: [ :extra |
			| im menu menuPane |
			menuPane := ToMenuPane new.
			im := ToMaterialDesignIconProvider innerImageNamed:
				      'filled_checklist'.
			menu := ToMenu new iconImage: im.
			menu icon extent: 20 asPoint.
			menuPane addItem: menu.
			extra addChild: menuPane ].

	tabs endExtraBuilder: [ :extra |
		extra addChild: (ToButton new labelText: 'Bookmarks') ].
	^ tabs
]

{ #category : #tabPane }
ToSandBox class >> example_TabGroupElementWithUSStates [

	| tabs dashBoard |
	tabs := ToTabGroupElement new.
	tabs itemBuilder: [ :tabItem :data :holder |
			tabItem labelText: data asString.
			tabItem removable: true ].

	self statesOfAmerica do: [ :l | tabs addTabItemData: l ]. 
	(tabs items at: 2) disable.
	dashBoard := self tabGroupElementDashBoardFor: tabs.
	tabs items third checked: true.

	dashBoard openInSpace.
	^ tabs
]

{ #category : #tabPane }
ToSandBox class >> example_TabListElement [

	| tabs board |
	tabs := ToTabListElement new.
	tabs horizontal: false.
	{ 'Daily'. 'Weekly'. 'Monthly'. 'Quaterly'. 'Yearly' } do: [ :l |
			tabs addItem: (ToTabItemElement new
					 removable: true;
					 middleElement: (ToLabel text: l);
					 yourself) ].
	tabs sample: (ToTabItemElement new
			 width: 100;
			 removable: true;
			 yourself).
	board := self tabBarElementDashBoardFor: tabs.
	board openInSpace
]

{ #category : #tabPane }
ToSandBox class >> example_TabPaneElementWithUSStates [

	| tpane dashBoard |
	tpane := self tabPaneElementWithUSStates.
	tpane matchParent.
	tpane selecter selectOnlyIndex: 2.
	dashBoard := self tabPaneElementDashBoardFor: tpane.
	dashBoard openInSpace.
	tpane tabGroup requestFocus.
	^ tpane
]

{ #category : #tabPane }
ToSandBox class >> example_TabPaneElementWithUSStates0 [

	| tpane |
	tpane := self tabPaneElementWithUSStates.
	tpane selecter selectIndex: 3.
	"tpane items third checked: true."
	tpane matchParent.
	tpane openInSpace.
	tpane tabGroup requestFocus.
	^ tpane
]

{ #category : #tabPane }
ToSandBox class >> example_TabPaneVerticalWithCompactHeaderLayoutMode [

	| tabPane |
	tabPane := self example_TabPaneWithCompactHeaderLayoutMode.
	tabPane vertical: false.
	^ tabPane.
	

]

{ #category : #tabPane }
ToSandBox class >> example_TabPaneWithAlignment [

	| tabPane |
	tabPane := ToTabPaneElement new.
	tabPane vertical: true.
	tabPane matchParent.
	tabPane alignMiddle.
	tabPane isFlowable: false.

	tabPane itemBuilder: [ :tabButton :aData :holder |
			tabButton removable: true.
			tabButton label: (ToLabel text: aData asString).
			tabButton paneBuilder: [ :pane |
					| e |
					e := ToElement new matchParent.
					e background: Color random.
					pane addChild: e ] ].

	tabPane header startExtraBuilder: [ :extra |
			| e |
			e := ToElement new withNullSkin.
			e extent: 100 @ 30.
			e background: Color pink.
			extra addChild: e ].

	tabPane tabGroup startExtraBuilder: [ :extra |
			| e |
			e := ToElement new withNullSkin.
			e extent: 40 @ 30.
			e background: Color yellow.
			extra addChild: e ].

	tabPane header endExtraBuilder: [ :extra |
			| e |
			e := ToElement new withNullSkin.
			e extent: 20 @ 30.
			e background: Color pink.
			extra addChild: e ].

	tabPane tabGroup endExtraBuilder: [ :extra |
			| e |
			e := ToElement new withNullSkin.
			e extent: 40 @ 30.
			e background: Color yellow.
			extra addChild: e ].

	tabPane header endFillerBuilder: [ :filler |
			| e |
			e := ToElement new withNullSkin.
			e matchParent.
			e background: Color blue.
			filler addChild: e ].

	tabPane header startFillerBuilder: [ :filler |
			| e |
			e := ToElement new withNullSkin.
			e matchParent.
			e background: Color blue.
			filler addChild: e ].

	tabPane addTabItemData: 'Tab'.
	tabPane openInInnerWindow
]

{ #category : #tabPane }
ToSandBox class >> example_TabPaneWithCompactHeaderLayoutMode [

	| tabPane |
	tabPane := ToTabPaneElement new.

	tabPane matchParent.
	tabPane compactHeaderLayoutMode: true.
	tabPane showAddTabItemButton: true.
	tabPane isFlowable: false.
	tabPane isScrollable: true.
	tabPane atStartSide: true.
	tabPane vertical: true.

	tabPane itemBuilder: [ :tabButton :aData :holder |
			tabButton removable: true.
			tabButton label: (ToLabel text: aData asString).
			tabButton paneBuilder: [ :pane |
					| e |
					e := ToElement new matchParent.
					e background: Color random.
					pane addChild: e ] ].

	tabPane header startExtraBuilder: [ :extra |
			| e |
			e := ToElement new withNullSkin.
			e extent: 30 asPoint.
			e background: Color yellow.
			e border: Color black.
			extra addChild: e ].
	tabPane tabGroup startExtraBuilder: [ :extra |
			| e |
			e := ToElement new withNullSkin.
			e extent: 30 asPoint.
			e background: Color red.
			extra addChild: e ].
	tabPane tabGroup endExtraBuilder: [ :extra |
			| e |
			e := ToElement new withNullSkin.
			e extent: 30 asPoint.
			e background: Color red.
			extra addChild: e ].
	tabPane header endExtraBuilder: [ :extra |
			| e |
			e := ToElement new withNullSkin.
			e extent: 30 asPoint.
			e border: Color black.
			e background: Color yellow.
			extra addChild: e ].

	{ 'Daily'. 'Weekly'. 'Monthly'. 'Quaterly'. 'Yearly' } do: [ :l |
		tabPane addTabItemData: l ].
	tabPane openInInnerWindow.
	^ tabPane
]

{ #category : #tag }
ToSandBox class >> example_TagFiniteList [

	self finiteTagListWithData: ToSandBox statesOfAmerica
]

{ #category : #select }
ToSandBox class >> example_ThemeSelectNoDeselection [

	| select |
	select := self themeSelect.
	select placeholderString: 'Select a Toplo theme'.
	select
		addEventHandlerOn: ToSelectChangedEvent
		do: [ :event | event selectedData asString traceCr ].
	select selecter selectIndex: 4.
	select allowDeselection: false.
	select openInSpace.
	^ select
]

{ #category : #select }
ToSandBox class >> example_ThemeSelectNoDeselectionPopupOnTop [

	| select |
	select := self themeSelectNoDeselectionPopupOnTop.
	select openInSpace
]

{ #category : #select }
ToSandBox class >> example_ThemeSelectPopover [

	| select |
	select := self example_ThemeSelectNoDeselection.
	select manager popover: true.
	^ select
]

{ #category : #select }
ToSandBox class >> example_ThemeSelectWithPlaceholder [

	| win choice |
	win := ToInnerWindow new title: 'Operating system'.

	choice := ToSingleSelectElement new.
	choice placeholderString: 'Select an OS'.
	choice popupDataAccessor addAll: { 'OS-X'. 'Windows'. 'Linux' }.
	win pane addChild: choice.
	win openInSpace
]

{ #category : #'toggle button' }
ToSandBox class >> example_ToggleButton [

	| toggle |
	ToTheme cleanUp.
	toggle := ToToggleButton new label: (ToLabel text: 'Toggle button').
	toggle icon: (ToImage new innerImage: (self iconNamed: #solidMenu)).
	toggle checked: false.
	toggle openInSpace
]

{ #category : #'toggle button' }
ToSandBox class >> example_ToggleButtonChecked [

	| toggle |
	ToTheme cleanUp.
	toggle := ToToggleButton new label: (ToLabel text: 'Toggle button').
	toggle icon: (ToImage new innerImage: (self iconNamed: #solidMenu)).
	toggle checked: true.
	toggle openInInnerWindow
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
	groupContainer := ToPane vertical.
	group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :evt | evt checkedList traceCr ].

	groupContainer width: 150.
	groupContainer addChildren: group registeredCheckables.
	groupContainer openInSpace
]

{ #category : #'toggle button' }
ToSandBox class >> example_ToggleButtonGroupPaneAndStrictStrategy [

	| group |
	group := ToCheckableGroupPane vertical.
	{ 'Monday'. 'Tuesday'. 'Wednesday'. 'Thursday'. 'Friday' } do: [ :day |
		group addChild: (ToToggleButton new
				 labelText: day;
				 hMatchParent;
				 yourself) ].
	group
		groupCheckAction: [ :evt | evt checkedList traceCr ].
	group openInSpace.
	group registeredCheckables second checked: true.
]

{ #category : #'toggle button' }
ToSandBox class >> example_ToggleButtonInListElement [

	| group moveListElement space |
	group := ToCheckableGroup new.
	moveListElement := ToListElement new.
	moveListElement primarySelectionMode selectOnPressed: false.
	moveListElement nodeBuilder: [ :node :move :holder |
			| moveElement moveNumberLabel whiteMoveLabel moveButtons blackMoveLabel inspectButton |
			moveButtons := OrderedCollection new.
			moveElement := BlElement new.
			moveElement layout: BlLinearLayout horizontal.
			moveElement margin: (BlInsets all: 5).
			moveElement constraintsDo: [ :c |
					c vertical fitContent.
					c horizontal fitContent ].

			moveNumberLabel := BlTextElement new.
			moveNumberLabel text: move first asString asRopedText.
			moveNumberLabel constraintsDo: [ :c |
					c linear vertical alignCenter.
					c horizontal exact: 30 ].

			whiteMoveLabel := ToToggleButton new.
			whiteMoveLabel labelText: move second asString asRopedText.
			moveButtons add: whiteMoveLabel.

			blackMoveLabel := ToToggleButton new.
			blackMoveLabel labelText: move third asString asRopedText.
			moveButtons add: blackMoveLabel.
			blackMoveLabel addStamp: #link.

			moveElement addChild: moveNumberLabel.
			moveElement addChild: whiteMoveLabel.
			moveElement addChild: blackMoveLabel.
			inspectButton := ToButton new
				                 labelText: 'Inspect';
				                 clickAction: [ node inspect ];
				                 yourself.
			moveNumberLabel constraintsDo: [ :c |
				c linear vertical alignCenter ].

			moveButtons do: [ :e | group register: e ].
			node addChild: moveElement.
			node addChild: inspectButton ].
	moveListElement matchParent.
	moveListElement dataAccessor addAll: {
			{ 1. 'e4'. 'e5' } }.

	space := BlSpace new.
	space root addChild: moveListElement.
	space pulse.
	space resizable: true.
	space show
]

{ #category : #'toggle button' }
ToSandBox class >> example_ToggleButtonWithIndeterminate [

	| toggle |
	ToTheme cleanUp.
	toggle := ToToggleButton new label: (ToLabel text: 'Toggle button').
	toggle icon: (ToImage new innerImage: (self iconNamed: #solidMenu)).
	toggle allowIndeterminate: true.
	toggle openInInnerWindow
]

{ #category : #tooltip }
ToSandBox class >> example_TooltipPopupOnMouseDown [

	| but |
	but := ToButton new.
	but tooltipManagerDo: [ :m |
			m popupOnPressed: true.
			m popover: true.
			m closeOnLeaved: false.
			m closeOnReleased: false.
			m popupDelay: 800 milliSeconds ].
	but labelText: 'Button with tooltip'.
	but tooltipBuilder: [ :window :request |
			window root addChild: (BlElement new
					 background: Color random;
					 extent: 70 @ 100;
					 yourself) ].
	but openInInnerWindow
]

{ #category : #triplet }
ToSandBox class >> example_TripletElementWith2IconsAnd1LabelInInnerWindow [

	| but  |
	but := self tripletWith2IconsAnd1Label.
	but hMatchParent.
	but flexible: true.
	but openInInnerWindow.
	^ but
]

{ #category : #triplet }
ToSandBox class >> example_TripletElementWithIconAndText [

	| but  |
	but := self tripletWith2Labels.
	but hMatchParent.
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
ToSandBox class >> example_TripletElementWithIconAndText_startAlignment [

	| but  |
	but := self example_TripletElementWithIconAndText.
	but startAlignment: 50.
	but border: Color red.
	but vFitContent.
	but hFitContent.
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
	but := self tripletWith2Labels.
	but beVertical.
	but openInSpace.
	^ but
]

{ #category : #triplet }
ToSandBox class >> example_TripletElementWithMiddleShrinkLayer [

	| but  |
	but := self example_TripletElementWith2IconsAnd1LabelInInnerWindow.
	but middleElement enableShrinkLayer: true.
	but startInterspace: 5.
	but endInterspace: 5.
	but middleElement hMatchParent.
	but flexible: false.
	but middleContainer constraintsDo: [ :c | c horizontal matchParent ].
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
				 list2 requestUpdateAllSelections ]).
	list2 addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :e |
				 list1 selectionModel deselectAll.
				 list1 requestUpdateAllSelections ]).
	panel addChild: list1.
	panel addChild: list2.
	list1 selecter selectIndex: 1.
	list2 selecter selectIndex: 2.
	panel openInSpace
]

{ #category : #menu }
ToSandBox class >> example_WithCheckBox [

	| menu sub subsub grp right center left frame subsubsub |
	menu := ToMenu new.
	menu labelText: 'File'.
	menu addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ menu space root inspect ];
			 yourself).
	menu addItem: (ToToggleMenuItem new
			 labelText: 'Toggle';
			 yourself).
	menu addItem: (ToMenuItem new labelText: 'Open file').
	menu items last icon: (ToImage inner: (self iconNamed: #solidMenu)).
	menu addItem: (ToMenuItem new labelText: 'Disabled').
	menu items last icon: (ToImage inner: (self iconNamed: #solidMenu)).
	"menu disableAtPosition: menu items last positionInItemList."
	menu items last disable.

	menu addSeparator.

	sub := ToMenu new labelText: 'Save All'.
	sub beInline.
	sub addItem: (ToMenuItem new
			 labelText: 'Locally';
			 yourself).

	subsub := ToMenu new
		          labelText: 'Externally';
		          icon: (ToImage inner: (self iconNamed: #solidMenu)).
	subsub beInline.
	subsubsub := ToMenu new
		             labelText: 'When';
		             icon: (ToImage inner: (self iconNamed: #solidMenu)).
	subsubsub beInline.
	subsubsub addItem: (ToMenuItem new
			 labelText: 'now';
			 yourself).
	subsubsub addItem: (ToMenuItem new
			 labelText: 'later';
			 yourself).

	subsub addItem: subsubsub.
	sub addItem: subsub.
	menu addItem: sub.
	menu addSeparator.

	menu addItem: (ToRadioMenuItem new
			 label: (ToLabel text: 'Check');
			 checkAction: [ :evt | evt target isChecked traceCr ];
			 yourself).
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

	grp register: right.
	grp register: center.
	grp register: left.

	menu addSeparator.
	menu addAllItems: {
			right.
			center.
			left }.
	menu addSeparator.

	menu position: 10 @ 10.
	frame := ToInnerWindow new.
	menu anchorRoot: frame pane.
	frame pane addChild: menu.
	frame openInSpace
]

{ #category : #menu }
ToSandBox class >> example_WithSeparator [

	| menu container |
	container := ToInnerWindow new
		             position: 10 @ 10;
		             extent: 400 @ 200;
		             yourself.
	menu := ToMenu new.
	menu tooltipString: 'tooltip content'.
	menu icon: (ToImage inner: (self iconNamed: #solidMenu)).
	menu addItem: (ToMenuItem new label: (ToLabel text: 'Open')) disable.

	menu addSeparator.
	menu addItem: (ToMenuItem new
			 label: (ToLabel text: 'Close');
			 clickAction: [ :evt |
					 'Close action ' trace.
					 evt traceCr ];
			 yourself).
	container pane addChild: menu.
	container openInSpace
]

{ #category : #badge }
ToSandBox class >> example_badgeOnAButton [

	| badge btn space |
	space := BlSpace new.
	badge := ToNumericalBadge new.
	btn := ToButton new labelText: 'Click to add/remove a badge'.
	btn clickAction: [
			badge isAttached
				ifFalse: [
						badge increment.
						badge attachToElement: btn ]
				ifTrue: [ badge detachFromElement ] ].
	btn position: 100 asPoint.
	badge attachToElement: btn.
	space root addChild: btn.
	space show
]

{ #category : #badge }
ToSandBox class >> example_badgeOnAnElement [

	| badge pane space badged |
	badge := ToNumericalBadge new count: 2222.
	pane := ToElement new.
	space := BlSpace new.
	space root addChild: pane.
	pane extent: 150 asPoint.
	pane position: 100 asPoint.
	pane border: Color black.
	badged := ToElement new.
	badged extent: 40 asPoint.
	badged constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].
	badged border: Color red.
	badge attachToElement: badged.
	pane addChild: badged.
	space show
]

{ #category : #badge }
ToSandBox class >> example_badgeOnAnIgnoredElement [

	| badge pane space badged |
	badge := ToNumericalBadge new count: 2222.
	pane := BlElement new.
	pane layout: BlFrameLayout new.
	space := BlSpace new.
	space root addChild: pane.
	pane extent: 150 asPoint.
	pane position: 100 asPoint.
	pane border: Color black.
	badged := BlElement new.
	badged constraintsDo: [ :c | c ignoredByLayout ].
	badged extent: 40 asPoint.
	badged position: 50@50.
	badged border: Color red.
	badge attachToElement: badged.
	pane addChild: badged.
	space show
]

{ #category : #button }
ToSandBox class >> example_buttonWith2Icons [

	| but  |
	but := self example_buttonWithIcon.
	but clickAction: [ :evt | evt currentTarget requestFocus ].
	but addEventHandlerOn: ToSkinEvent do: [ :event | event traceCr ].
	but clickAction: [ :evt | evt target traceCr ].
	but addEventHandlerOn: BlDoubleClickEvent do: [ :event | event traceCr ].
	but label: (ToLabel text: 'Button with 2 icons').
	but endElement: (ToImage inner: ToThemeIcons searchOutlined16x16).
	^ but
]

{ #category : #button }
ToSandBox class >> example_buttonWith2IconsFlexible [

	| but  |
	but := self example_buttonWith2Icons.
	but flexible: true.
	but hMatchParent
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
	but clickAction: [ self inform: 'Action runned' ].
	but openInSpace.
	^ but
]

{ #category : #button }
ToSandBox class >> example_buttonWithDisableEnable [

	| space button pane disabox |
	space := BlSpace new.
	space root layout: BlLinearLayout vertical.

	pane := ToPane vertical.
	pane layout cellSpacing: 5.
	pane padding: (BlInsets all: 5).

	disabox := ToCheckbox new label: (ToLabel text: 'Disable').
	button := (ToButton id: #buttonA)
		          labelText: 'Button';
		          yourself.
	disabox checkAction: [ :evt | button disabled: evt target isChecked ].
	button clickAction: [ :evt | disabox checked: true. button disabled: true ].
	button addEventHandlerOn: ToHoveredSkinEvent do: [ :evt |  ].
	pane addChild: disabox.
	pane addChild: button.
	disabox checked: true.
	button addEventHandlerOn: ToSkinEvent do: [ :event | event traceCr ].
	space root addChild: pane.
	space show
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
	but clickAction: [ self inform: 'Action runned' ].
	^ but
]

{ #category : #button }
ToSandBox class >> example_buttonWithIconAndLabelCentered [

	| but  |
	but := self example_buttonWithIconAndLabel.
	but hMatchParent.
	but alignCenter: true.
	^ but
]

{ #category : #button }
ToSandBox class >> example_buttonWithIconAndLabelDisabled [

	| but  |
	but := self example_buttonWithIconDisabled.
	but label: (ToLabel text: 'Button with label').
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

{ #category : #'finite list' }
ToSandBox class >> example_checkableListElement [

	| space bar |
	space := BlSpace new.
	bar := ToCheckableListElement new.
	space root addChild: bar.
	bar matchParent.
	self statesOfAmerica do: [ :l |
			| item |
			item := ToToggleButton new labelText: l.
			item width: 150.
			item height: 50.
			bar addItem: item ].
	space show.
	bar
]

{ #category : #button }
ToSandBox class >> example_clickAction [

	| pane e action |
	pane := ToPane vertical.
	e := ToElement new.
	e extent: 50 asPoint.
	e background: Color blue.
	action := e clickAction: [ :evt | evt traceCr ].
	e addEventHandlerOn: BlClickEvent do: [ :event |
			action run.
			action runWithEvent: event ].
	pane addChild: e.
	pane openInSpace
]

{ #category : #badge }
ToSandBox class >> example_compositeBadgeOnAButton [

	| badge btn space |
	space := BlSpace new.
	badge := ToCompositeBadge new.
	badge addChild: (ToNumericalBadge new incrementBy: 5; yourself).
	badge addChild: (ToLabelledBadge new labelText: 'X'; yourself).
	
	btn := ToButton new labelText: 'Button with Composite Badge'.
	btn clickAction: [ :evt | evt target space root inspect ].
	btn position: 100 asPoint.
	space root addChild: btn.
	badge attachToElement: btn.
	space show
]

{ #category : #list }
ToSandBox class >> example_contactList [

	| panel updateButton addPredefinedButton addPredefinedAction dataBlock list contact nameTxtF phoneTxtF addressTxtF inputPane data |
	panel := ToPane vertical.
	panel constraints horizontal matchParent.
	panel layout cellSpacing: 10.

	list := ToListElement new.
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

	updateButton := ToButton new
		                labelText: 'Update table';
		                yourself.
	updateButton clickAction: [
			| n p a c idx |
			n := nameTxtF text asString.
			p := phoneTxtF text asString.
			a := addressTxtF text asString.
			idx := list dataAccessor
				       detectIndex: [ :e | e name = n ]
				       ifNone: [ ].
			c := ToContactExampleObject new
				     name: n;
				     phoneNumber: p;
				     address: a;
				     yourself.
			idx
				ifNotNil: [ list dataAccessor at: idx put: c ]
				ifNil: [ list dataAccessor add: c ] ].

	data := {
		        { 'Patty'. '0299041101'. 'Brest' }.
		        { 'Paulie'. '0298010101'. 'Brest' }.
		        { 'Charly'. '0294561101'. 'Brest' }.
		        { 'Fraise'. '0298010528'. 'Brest' } }.
	addPredefinedButton := ToButton new
		                       labelText: 'add predefined items';
		                       yourself.
	dataBlock := [
		             | items |
		             items := data collect: [ :triplet |
				                      contact := ToContactExampleObject new.
				                      contact name: triplet first.
				                      contact phoneNumber: triplet second.
				                      contact address: triplet third.
				                      contact ].
		             list dataAccessor addAll: items ].

	addPredefinedAction := addPredefinedButton newClickAction: [
		                       dataBlock value ].
	addPredefinedAction requestNextRun.
	inputPane := ToPane horizontal.
	inputPane layout cellSpacing: 10.
	inputPane addChildren: {
			nameTxtF.
			phoneTxtF.
			addressTxtF.
			updateButton.
			addPredefinedButton }.
	inputPane childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ].

	list contextMenuBuilder: [ :menu :request |
			| selectionModel indexes target |
			target := request currentTarget.
			selectionModel := request selectionModel.
			indexes := request selectedIndexes.
			menu addItem: (ToMenuItem new
					 labelText: 'Remove';
					 clickAction: [
						 indexes sort reverseDo: [ :idx |
								 target dataAccessor removeAt: idx ] ];
					 yourself).
			menu addItem: (ToMenuItem new
					 labelText: 'Inspect';
					 clickAction: [ target inspect ];
					 yourself) ].

	list nodeBuilder: [ :node :dataItem :holder |
			| line remBut |
			node ensureCanManageToploSkin.
			line := ToElement new
				        layout: BlLinearLayout horizontal;
				        hMatchParent;
				        vFitContent.
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
			remBut := ToIconicRemoveButton new.
			remBut constraintsDo: [ :c | c linear vertical alignCenter ].
			remBut clickAction: [ :event |
				holder listElement dataAccessor removeAt: holder position ].
			line addChild: remBut.
			node addChild: line ].

	panel addChild: inputPane.
	panel addChild: list.
	panel openInSpace
]

{ #category : #'context menu' }
ToSandBox class >> example_contextMenu [

	| container |
	container := ToElement new matchParent.
	container contextMenuBuilder: [ :win :request |
			win addItem: (ToMenuItem new
					 labelText: 'Open';
					 clickAction: [ self inform: 'Open' ];
					 yourself) ].

	container openInSpace
]

{ #category : #diff }
ToSandBox class >> example_diff [

	| diff |
	diff := ToDiffElement new.
	diff
		from: 'hello world
coucou le monde'
		to: 'hello world
salut le monde'.
	diff openInSpace.
	^ diff
]

{ #category : #diff }
ToSandBox class >> example_diffAddition [

	| diff |
	diff := ToDiffElement new.
	diff
		from: ''
		to: 'hello world
coucou le monde'.
	diff openInSpace.
	^ diff
]

{ #category : #diff }
ToSandBox class >> example_diffRemove [

	| diff |
	diff := ToDiffElement new.
	diff
		from: 'hello world
coucou le monde'
		to: ''.
	diff openInSpace.
	^ diff
]

{ #category : #diff }
ToSandBox class >> example_diffWithlabel [

	| diff |
	diff := ToDiffElement new.
	diff
		from: 'hello world
coucou le monde'
		to: 'hello world
salut le monde'.
	diff leftLabel: 'source'.
	diff rightLabel: 'target'.
	diff openInSpace.
	^ diff
]

{ #category : #window }
ToSandBox class >> example_elementWithEditor [

	| e editorWindowManager |
	e := ToElementWithEditor new
		     background: Color blue;
		     extent: 100 asPoint;
		     position: 20 asPoint;
		     yourself.
	editorWindowManager := ToContentEditorManager new.
	e addEventHandler: editorWindowManager.
	e
		addEventHandlerOn: BlClickEvent
		do: [ :event | (editorWindowManager createNewWindowOnEvent: event) ifNotNil: [ :win | win popupEvent: event ] ].
	e openInSpace
]

{ #category : #empty }
ToSandBox class >> example_empty [

	| empty |
	empty := ToEmpty new.
	empty openInSpace
]

{ #category : #empty }
ToSandBox class >> example_emptyBox [

	| box |
	box := self newEmptyBox.
	box openInSpace
]

{ #category : #empty }
ToSandBox class >> example_emptyBoxWithButton [

	| box |
	box := self newEmptyBox.
	box builder: [ :e | e addChild: (ToButton labelText: 'Add new item') ].
	box openInSpace
]

{ #category : #empty }
ToSandBox class >> example_emptyBoxWithCustomLabel [

	| box labelText |
	box := self newEmptyBox.
	labelText := 'Nothing in the box' asRopedText
		             fontSize: 24;
		             yourself.
	box labelText: labelText.
	box openInSpace
]

{ #category : #diff }
ToSandBox class >> example_emptyDiff [

	| diff |
	diff := ToDiffElement new.
	diff openInSpace.
	^ diff
]

{ #category : #empty }
ToSandBox class >> example_emptyWithWaitingAnimation [

	| empty |
	empty := ToEmpty waiting.
	empty openInSpace
]

{ #category : #checkables }
ToSandBox class >> example_group [

	| group container |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToRadioButton new
			       beVertical;
			       labelText: idx asString;
			       id: idx asString.
		group register: chb ].
	container := ToPane horizontal.
	group registeredCheckables last checked: true.
	container addChildren: group registeredCheckables.
	group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :evt | evt checkedList traceCr ].
	container openInInnerWindow
]

{ #category : #checkables }
ToSandBox class >> example_group2 [

	| containerElement group |
	containerElement := ToPane vertical.

	(group := ToCheckableGroup new)
		withStrictCheckingStrategy;
		registerAll: {
				(ToRadioButton new
					 labelText: 'Light theme';
					 in: [ :btn | btn userData at: #theme put: ToRawTheme ];
					 yourself).
				(ToRadioButton new
					 labelText: 'Dark theme';
					 in: [ :btn | btn userData at: #theme put: ToRawDarkTheme ];
					 yourself) }.
	containerElement addChildren: group registeredCheckables.

	group addEventHandlerOn: ToCheckableGroupChangedEvent do: [ :evt |
		Toplo defaultThemeClass: (evt checkedList first userData at: #theme) ].
	group registeredCheckables second checked: true.

	containerElement openInSpace
]

{ #category : #checkables }
ToSandBox class >> example_group3 [

	| containerElement group |
	containerElement := ToPane vertical.

	(group := ToCheckableGroup new)
		withStrictCheckingStrategy;
		registerAll: {
				(ToRadioButton new
					 id: #r1;
					 labelText: 'Light theme';
					 checkAction: [ :evt |
							 | space |
							 space := evt currentTarget space.
							 evt currentTarget isChecked ifTrue: [
									 space toTheme: ToRawTheme new ] ];
					 yourself).
				(ToRadioButton new
					 id: #r2;
					 labelText: 'Dark theme';
					 checkAction: [ :evt |
							 | space |
							 space := evt currentTarget space.
							 evt currentTarget isChecked ifTrue: [
									 space toTheme: ToRawDarkTheme new ] ];
					 yourself) }.
	group registeredCheckables first checked: (Toplo defaultThemeClass = ToRawTheme).
	group registeredCheckables second checked: (Toplo defaultThemeClass = ToRawDarkTheme).
	containerElement addChildren: group registeredCheckables.

	containerElement openInSpace
]

{ #category : #checkables }
ToSandBox class >> example_group4 [

	| containerElement group |
	containerElement := ToPane vertical.
	
	(group := ToCheckableGroup new)
		withStrictCheckingStrategy;
		registerAll: {
				(ToRadioButton new
					 labelText: 'Light theme';
					 checkAction: [ :evt | containerElement localTheme: ToRawTheme new];
					 yourself).
				(ToRadioButton new
					 labelText: 'Dark theme';
					 checkAction: [ :evt| containerElement localTheme: ToRawDarkTheme new];
					 yourself) }.

	containerElement addChildren: group registeredCheckables.
	containerElement localTheme: ToRawDarkTheme new.
	group registeredCheckables second checked: true.

	containerElement openInSpace
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
	btn clickAction: [ pane orientation: pane orientation inverted ].
	pane addChild: btn.
	btn := ToButton new labelText: 'Change direction'.
	btn clickAction: [ pane direction: pane direction inverted ].
	pane addChild: btn.

	pane addDividers.
	pane dividers first weight: 2.
	pane dividers second weight: 1.
	pane dividers third weight: 0.5.
	pane openInSpace
]

{ #category : #pane }
ToSandBox class >> example_hugePane [

	| space pane |
	space := BlSpace new.
	pane := ToPane vertical.
	space root addChild: pane.
	space show.

	space root inUIProcessDo: [
			1 to: 100 do: [ :i | 
					| label button |
					label := 'Button ' , i asString.
					button := ToButton labelText: label.
					pane addChild: button.
					pane horizontal: i odd ] ]
]

{ #category : #menu }
ToSandBox class >> example_inline1 [

	| menu sub subsub space |
	menu := ToMenu new.
	space := BlSpace new.
	menu labelText: 'Menu with inline items'.

	menu addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ space root inspect ];
			 yourself).
	sub := ToMenu new
		       labelText: 'Inline menu';
		       icon: (ToImage inner: (self iconNamed: #solidMenu));
		       yourself.
	sub beInline.
	subsub := ToMenuItem new
		          labelText: 'A';
		          yourself.

	sub addItem: subsub.
	subsub := ToMenuItem new
		          labelText: 'B';
		          yourself.
	sub addItem: subsub.
	subsub := ToMenuItem new
		          labelText: 'C';
		          yourself.
	sub addItem: subsub.

	menu addItem: sub.
	space root addChild: menu.
	space show
]

{ #category : #menu }
ToSandBox class >> example_inline2 [

	| menu sub subsub frame subsubsub |
	menu := ToMenu new.
	menu labelText: 'Menu with inline'.
	menu addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ menu space root inspect ];
			 yourself).
	sub := ToMenu new labelText: 'Inline menu'.
	sub beInline.
	sub addItem: (ToMenuItem new
			 labelText: 'Item';
			 yourself).

	subsub := ToMenu new
		          labelText: 'Sub inline menu';
		          icon: (ToImage inner: (self iconNamed: #solidMenu)).
	subsub beInline.
	subsubsub := ToMenu new
		             labelText: 'sub sub inline menu';
		             icon: (ToImage inner: (self iconNamed: #solidMenu)).
	subsubsub beInline.
	subsubsub addItem: (ToMenuItem new
			 labelText: 'A';
			 yourself).
	subsubsub addItem: (ToMenuItem new
			 labelText: 'B';
			 yourself).

	subsub addItem: subsubsub.
	sub addItem: subsub.
	menu addItem: sub.
	menu addSeparator.

	menu position: 10 @ 10.
	frame := ToInnerWindow new.
	frame pane addChild: menu.
	frame openInSpace
]

{ #category : #menu }
ToSandBox class >> example_inline3 [

	| menu sub subsub frame subsubsub |
	menu := ToMenu new.
	menu labelText: 'Menu with inline'.
	menu addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ menu space root inspect ];
			 yourself).
	sub := ToMenu new labelText: 'Inline menu'.
	sub beInline.
	sub addItem: (ToMenuItem new
			 labelText: 'Item with long label';
			 yourself).

	subsub := ToMenu new
		          labelText: 'Sub inline menu';
		          icon: (ToImage inner: (self iconNamed: #solidMenu)).
	subsub beInline.
	subsubsub := ToMenu new
		             labelText: 'sub sub inline menu';
		             icon: (ToImage inner: (self iconNamed: #solidMenu)).
	subsubsub beInline.
	subsubsub addItem: (ToMenuItem new
			 labelText: 'A';
			 yourself).
	subsubsub addItem: (ToMenuItem new
			 labelText: 'B';
			 yourself).

	subsub addItem: subsubsub.
	sub addItem: subsub.
	menu addItem: sub.
	menu addSeparator.

	menu position: 10 @ 10.
	frame := ToInnerWindow new.
	frame pane addChild: menu.
	frame openInSpace
]

{ #category : #menu }
ToSandBox class >> example_inlineInMenuPane [

	| menu sub subsub frame subsubsub |
	menu := ToMenuPane new.
	menu vertical: true.
	menu hFitContent.
	menu vMatchParent.
	menu addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ menu space root inspect ];
			 yourself).
	sub := ToMenu new labelText: 'Save All'.
	sub beInline.
	sub addItem: (ToMenuItem new
			 labelText: 'Locallyyyyyyyyyyyyyyyyyyy';
			 yourself).

	subsub := ToMenu new
		          labelText: 'Externally'.
	subsub beInline.
	subsubsub := ToMenu new
		             labelText: 'When'.
	subsubsub beInline.
	subsubsub addItem: (ToMenuItem new
			 labelText: 'now';
			 yourself).
	subsubsub addItem: (ToMenuItem new
			 labelText: 'later';
			 yourself).

	subsub addItem: subsubsub.
	sub addItem: subsub.
	menu addItem: sub.

	frame := ToInnerWindow new.
	frame pane addChild: menu.
	frame openInSpace
]

{ #category : #label }
ToSandBox class >> example_labelFieldWithShrinkFeedback [

	| t innerWindow |
	t := ToLabel new text: 'Make the inner window smaller or edit myself'.
	t beEditable.
	t enableShrinkLayer: true.
	t shrinkTolerance: 2.0.
	t whenEditorOpenedDo: [ :editorEvent |
		editorEvent editorElement whenSaveRequestedDo: [ :request |
			request accepted: true ].
		editorEvent editorElement whenSaveAcceptedDo: [ :acceptedEvent |
			editorEvent target text: acceptedEvent target text ] ].
	t matchParent.
	innerWindow := t openInInnerWindow.

]

{ #category : #'finite list' }
ToSandBox class >> example_listInDashBoard [

	self listWithData: (ToSandBox statesOfAmerica "copyFrom: 1 to: 1")

]

{ #category : #'finite list' }
ToSandBox class >> example_listWithAllClasses [

	| l |
	l := self listWithData: 
		((Smalltalk globals allClasses sorted: [ :a :b | a name < b name ]) copyFrom: 1 to: 2000).
	l  useCheckbox: true

]

{ #category : #menu }
ToSandBox class >> example_menuPane0 [

	| bar menu sub |
	bar := ToMenuPane new.
	bar hMatchParent.
	menu := ToMenu new labelText: 'Menu 2'.
	menu addItem: (ToMenuItem new labelText: 'item 1').
	menu addItem: ToSeparatorMenuItem new.
	sub := ToMenuItem new labelText: 'item 2'.
	sub disable.
	menu addItem: sub.

	bar addItem: menu.
	menu := ToMenuItem new labelText: 'Menu 1'.
	bar addItem: menu.
	menu disabled: true.
	bar openInSpace
]

{ #category : #menu }
ToSandBox class >> example_menuPane1 [

	| win bar fileMenu |
	win := ToInnerWindow new.
	win title: 'Menu bar example'.
	win width: 600.

	bar := ToMenuPane new
		       hMatchParent;
		       yourself.

	bar addItem: (fileMenu := ToMenu new
			             labelText: 'File';
			             tooltipString: 'File stuffs';
			             yourself).

	fileMenu addItem: (ToMenuItem new
			 labelText: 'Open';
			 tooltipString: 'open stuffs';
			 clickAction: [ :evt :target | target traceCr ]).
	fileMenu addSeparator.
	fileMenu addItem: (ToMenuItem new
			 labelText: 'Close';
			 tooltipString: 'close stuffs';
			 clickAction: [ :evt :target | target traceCr ]).

	bar addFiller.
	bar addItem: (ToMenu new
			 labelText: 'Help';
			 tooltipString: 'help stuffs';
			 yourself).

	bar items last addItem: (ToCustomMenuItem new
			 in: [ :e | e addChild: (ToLabel text: 'Some help...') ];
			 yourself).
	bar border: (BlBorder paint: Color red).

	win pane addChild: bar.
	win openInSpace
]

{ #category : #menu }
ToSandBox class >> example_menuPane2 [

	| menu frame bar |
	bar := ToMenuPane new
		       hMatchParent;
		       vFitContent.
	frame := ToInnerWindow new.

	2 timesRepeat: [
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
				subMenu addItem: ((ToMenuItem new labelText: stream)
						 clickAction: [ self inform: selector asSymbol ];
						 yourself) ].
			menu addItem: subMenu ].

		bar addItem: menu ].

	frame pane addChild: bar.
	frame openInSpace 
]

{ #category : #menu }
ToSandBox class >> example_menuPane3 [

	| menu frame bar rand |
	bar := ToMenuPane new.
	"bar beVertical."
	rand := Random new.
	frame := ToInnerWindow new.
	bar addFiller.
	bar addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ frame space root inspect ];
			 yourself).
	bar addFiller.
	3 timesRepeat: [
			menu := ToMenu new.
			menu anchorRoot: frame pane.
			menu vertical: false.
			menu showExpandIcon: true.
			menu alignCenter: true.
			menu label: (ToLabel text: 'Levels').
			menu icon:
				(ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).

			menu builder: [ :m |
					1 to: (rand nextIntegerBetween: 2 and: 16) do: [ :index |
							| subMenu |
							subMenu := ToMenu new label:
								           (ToLabel new text:
									            (String streamContents: [ :out |
											             out
												             print: index;
												             nextPut: $x;
												             print: index ])).
							subMenu builder: [ :sm |
									1 to: (rand nextIntegerBetween: 1 and: 20) do: [ :i |
											| stream selector iconImage color |
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
											color := Color random.
											iconImage := BlElement new
												             padding: (BlInsets all: 2);
												             geometry:
													             (BlRoundedRectangleGeometry cornerRadius: 3);
												             background: color;
												             extent: 16 asPoint;
												             yourself.
											sm addItem: ((ToMenuItem new
													  labelText: stream;
													  iconImage: iconImage)
													 clickAction: [ frame background: color ];
													 yourself) ] ].
							m addItem: subMenu ] ].

			bar addItem: menu ].
	bar addFiller.
	bar hMatchParent.
	frame pane addChild: bar.
	frame openInSpace
]

{ #category : #menu }
ToSandBox class >> example_menuPaneVertical [

	| menu frame bar |
	bar := ToMenuPane new.

	frame := ToInnerWindow new.
	bar addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ frame space root inspect ];
			 yourself).
	1 to: 3 do: [ :count |
			menu := ToMenu new.
			menu showExpandIcon: true.
			count = 2 ifTrue: [ menu beInline ].
			menu label: (ToLabel text: 'Levels').
			menu icon:
				(ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).

			menu builder: [ :m |
					1 to: 6 do: [ :index |
							| subMenu |
							subMenu := ToMenu new label:
								           (ToLabel new text:
									            (String streamContents: [ :out |
											             out
												             nextPutAll: 'Level ';
												             print: index;
												             nextPutAll: 'x';
												             print: index ])).
							subMenu builder: [ :sm |
									1 to: 10 do: [ :i |
											| stream selector iconImage color |
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
											color := Color random.
											iconImage := BlElement new
												             padding: (BlInsets all: 2);
												             geometry:
													             (BlRoundedRectangleGeometry cornerRadius: 3);
												             background: color;
												             extent: 16 asPoint;
												             yourself.
											sm addItem: ((ToMenuItem new
													  labelText: stream;
													  iconImage: iconImage)
													 clickAction: [ frame background: color ];
													 yourself) ] ].
							m addItem: subMenu ] ].

			bar addItem: menu ].
	"bar addFiller."
	bar vertical: true.
	bar vFitContent.
	frame pane addChild: bar.
	frame openInSpace
]

{ #category : #menu }
ToSandBox class >> example_menuPaneVertical0 [

	| menu frame bar |
	bar := ToMenuPane new.

	frame := ToInnerWindow new.
	1 to: 1 do: [ :count |
			menu := ToMenu new.
			menu showExpandIcon: true.
			count = 2 ifTrue: [ menu beInline ].
			menu label: (ToLabel text: 'Levels').
			menu icon:
				(ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).

			menu builder: [ :m |
					1 to: 6 do: [ :index |
							| subMenu |
							subMenu := ToMenu new label:
								           (ToLabel new text:
									            (String streamContents: [ :out |
											             out
												             nextPutAll: 'Level ';
												             print: index;
												             nextPutAll: 'x';
												             print: index ])).
							subMenu builder: [ :sm |
									1 to: 10 do: [ :i |
											| stream selector iconImage color |
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
											color := Color random.
											iconImage := BlElement new
												             padding: (BlInsets all: 2);
												             geometry:
													             (BlRoundedRectangleGeometry cornerRadius: 3);
												             background: color;
												             extent: 16 asPoint;
												             yourself.
											sm addItem: ((ToMenuItem new
													  labelText: stream;
													  iconImage: iconImage)
													 clickAction: [ frame background: color ];
													 yourself) ] ].
							m addItem: subMenu ] ].

			bar addItem: menu ].
	"bar addFiller."
	bar vertical: true.
	bar vFitContent.
	frame pane addChild: bar.
	frame openInSpace
	"frame inspect"
]

{ #category : #menu }
ToSandBox class >> example_menuPaneVertical2 [

	| frame bar sub subsub subsubsub |
	bar := ToMenuPane new.

	frame := ToInnerWindow new.
	bar addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ frame space root inspect ];
			 yourself).
	bar vertical: true.
	sub := ToMenu new labelText: 'Save All'.
	sub beInline.
	sub addItem: (ToMenuItem new
			 labelText: 'Locally';
			 yourself).

	subsub := ToMenu new
		          labelText: 'Externally';
		          icon: (ToImage inner: (self iconNamed: #solidMenu)).
	subsub beInline.
	subsubsub := ToMenu new
		             labelText: 'When';
		             icon: (ToImage inner: (self iconNamed: #solidMenu)).
	subsubsub beInline.
	subsubsub addItem: (ToMenuItem new
			 labelText: 'now';
			 yourself).
	subsubsub addItem: (ToMenuItem new
			 labelText: 'later';
			 yourself).

	subsub addItem: subsubsub.
	sub addItem: subsub.
	bar addItem: sub.
	bar addSeparator.
	bar isScrollable: true.
	bar vMatchParent.
	frame pane addChild: bar.
	frame openInSpace
]

{ #category : #menu }
ToSandBox class >> example_menuPaneVerticalScrollable [

	| menu frame bar |
	bar := ToMenuPane new.

	frame := ToInnerWindow new.
	bar addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ frame space root inspect ];
			 yourself).
	1 to: 20 do: [ :count |
			menu := ToMenu new.
			menu beInline.
			menu label: (ToLabel text: 'Levels').
			menu icon:
				(ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).

			menu builder: [ :m |
					1 to: 6 do: [ :index |
							| subMenu |
							subMenu := ToMenu new label:
								           (ToLabel new text:
									            (String streamContents: [ :out |
											             out
												             nextPutAll: 'Level ';
												             print: index;
												             nextPutAll: 'x';
												             print: index ])).
							subMenu builder: [ :sm |
									1 to: 10 do: [ :i |
											| stream selector iconImage color |
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
											color := Color random.
											iconImage := BlElement new
												             padding: (BlInsets all: 2);
												             geometry:
													             (BlRoundedRectangleGeometry cornerRadius: 3);
												             background: color;
												             extent: 16 asPoint;
												             yourself.
											sm addItem: ((ToMenuItem new
													  labelText: stream;
													  iconImage: iconImage)
													 clickAction: [ frame background: color ];
													 yourself) ] ].
							m addItem: subMenu ] ].

			bar addItem: menu ].
	"bar addFiller."
	bar vertical: true.
	bar vMatchParent.
	bar isScrollable: true.
	bar isFlowable: false.

	frame pane addChild: bar.
	frame openInSpace
]

{ #category : #window }
ToSandBox class >> example_overlayWindow1 [

	| e windowManager |
	e := ToElement new
		     extent: 200 @ 200;
		     position: 50 @ 50;
		     background: Color yellow;
		     border: (BlBorder paint: Color red).
	windowManager := ToAnchoredWindowManager new.
	e addEventHandler: windowManager.
	windowManager windowBuilder: [ :anchWin :element |
			anchWin withNullSkin.
			anchWin addEventHandlerOn: BlClickEvent do: [ anchWin close ].
			anchWin background: Color red.
			anchWin border: (BlBorder paint: Color black width: 4).
			anchWin padding: (BlInsets all: 5).
			anchWin root addChild: (ToLabel new
					 text: 'Click to close me';
					 yourself) ].
	e openInInnerWindow.
	(windowManager createNewWindowOnEvent: nil) popup
]

{ #category : #window }
ToSandBox class >> example_overlayWindow2 [

	| e windowManager |
	e := ToInnerWindow new
		     extent: 300 @ 300;
		     position: 50 @ 50.
	windowManager := ToAnchoredWindowManager new.
	windowManager measurement:
		(ToActionMeasurement new action: [ :spec :theWin :evt |
				 | theElem |
				 theElem := theWin anchorElement.
				 spec widthSpec beExact: theElem measuredWidth - 40.
				 spec heightSpec beExact: theElem measuredHeight - 60 ]).
	windowManager placement:
		(ToActionPlacement new action: [ :theWin :evt :aBoundsUpdater |
				 | theElem theRoot |
				 theElem := theWin anchorElement.
				 theRoot := theWin anchorRoot.
				 theWin position:
					 (theElem bounds inParent: theRoot) bounds topLeft + (20 @ 40) ]).

	windowManager anchorRoot: e.
	e addEventHandler: windowManager.
	windowManager windowBuilder: [ :anchWin :element |
			anchWin withNullSkin.
			anchWin background: Color red.
			anchWin border: (BlBorder paint: Color black width: 2) ].
	e openInInnerWindow.
	(windowManager createNewWindowOnEvent: nil) popup
]

{ #category : #window }
ToSandBox class >> example_rootFrame1 [

	| e |
	(e := ToInnerWindow new)
		title: 'Internal Frame example';
		openInSpace
]

{ #category : #menu }
ToSandBox class >> example_rootFrameWithContextMenu [

	| win sub subsub bar textField helpMenu inner |
	win := ToInnerWindow new title: 'Context menu Example'.
	win width: 600.

	win pane contextMenuBuilder: [ :menu :request |
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

	bar := ToMenuPane new
		       hMatchParent;
		       vFitContent.
	bar isFlowable: false.
	bar itemList hMatchParent.

	bar addItem: (ToCustomMenuItem new in: [ :e |
			 e addChild: (ToSelectableLabel new text: 'File') ]).
	bar addItem: (ToMenu new
			 labelText: 'File';
			 tooltipString: 'file stuffs').
	bar addItem: (ToMenu new
			 labelText: 'Edit';
			 tooltipString: 'editing stuffs').

	bar addFiller.

	inner := ToPane horizontal.
	textField := ToTextField new
		             withLineWrapping;
		             width: 200.
	inner addChild: (ToLabel new text: 'Token: ').
	inner addChild: (ToSelectableLabel new text: 'Token: ').
	inner addChild: textField.
	inner childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ].

	bar addItem: (ToCustomMenuItem new
			 in: [ :e | e addChild: inner ];
			 yourself).
	helpMenu := ToMenu new
		            labelText: 'Help';
		            tooltipString: 'help stuffs'.
	helpMenu addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ bar inspect ];
			 yourself).
	bar addItem: helpMenu.

	bar position: 0 @ 0.
	bar border: (BlBorder paint: Color black).
	win pane addChild: bar.
	win openInSpace
]

{ #category : #menu }
ToSandBox class >> example_rootFrameWithContextMenu_menuPaneVertical [

	| win sub subsub bar |
	win := ToInnerWindow new title: 'Context menu Example'.


	win pane contextMenuBuilder: [ :contextMenu :request |
			contextMenu addItem: (ToMenuItem new
					 labelText: 'Open file';
					 icon: (ToImage inner: (Smalltalk ui icons iconNamed: #config))).
			contextMenu addItem: (ToMenuItem new labelText: 'Export').
			contextMenu addSeparator.
			sub := ToMenu new labelText: 'Save All'.
			sub addItem: (ToMenuItem new labelText: 'Locally').
			subsub := ToMenu new
				          labelText: 'Externally';
				          icon:
					          (ToImage inner:
							           (Smalltalk ui icons iconNamed: #solidMenu)).
			subsub addItem: (ToMenuItem new labelText: 'Here').
			sub addItem: subsub.
			contextMenu addItem: sub ].

	bar := ToMenuPane new
		       hMatchParent;
		       vFitContent.
	bar addItem: (ToMenu new
			 labelText: 'File';
			 tooltipString: 'file stuffs').
	bar addItem: (ToMenu new
			 labelText: 'Edit';
			 tooltipString: 'editing stuffs').
	bar addFiller.
	bar addSeparator.
	bar addItem: (ToMenu new
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
	im addEventHandlerOn: BlClickEvent do: [ :event |
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

	| seg dashBoard |
	seg := ToSegmentedListElement new.
	{ 'Daily'. 'Weekly'. 'Monthly'. 'Quaterly'. 'Yearly' } do: [ :l |
		seg addItem: (ToCheckbox new
				 labelText: l;
				 yourself) ].
	(seg items at: 2) disable.
	dashBoard := self segmentedDashBoardFor: seg.
	dashBoard openInSpace
]

{ #category : #segmented }
ToSandBox class >> example_segmentedWithLabels [

	| seg dashBoard rootPane feedbackPane maj feedbackLabel |
	seg := ToSegmentedListElement new.
	{ 'Daily'. 'Weekly'. 'Monthly'. 'Quaterly'. 'Yearly' } do: [ :l |
			seg addItem: (ToToggleButton new
					 labelText: l;
					 yourself) ].

	(seg items at: 2) disable.
	dashBoard := self segmentedDashBoardFor: seg.

	feedbackPane := ToPane horizontal.
	feedbackPane layout alignCenter.
	feedbackPane addChild: (feedbackLabel := ToLabel new).
	maj := [
		       | t |
		       t := String streamContents: [ :stream |
				            seg dataAccessor withIndexDo: [ :e :idx |
						            stream
							            nextPutAll: e label text asString;
							            nextPutAll: ': '.
						            (seg selectionModel containsIndex: idx)
							            ifTrue: [ stream nextPutAll: 'X    ' ]
							            ifFalse: [ stream nextPutAll: '     ' ] ] ].
		       feedbackLabel text: t ].

	seg addEventHandler: (BlEventHandler
			 on: ToListStrongSelectionEvent
			 do: [ :event |
					 ' double click ' trace.
					 event indexes traceCr ]).

	seg addEventHandlerOn: ToListPrimarySelectionChangedEvent do: maj.
	seg addEventHandlerOn: ToAddedToSpaceEvent do: maj.
	rootPane := ToPane vertical.
	rootPane matchParent.
	rootPane addChildren: {
			dashBoard.
			feedbackPane }.
	rootPane openInSpace
]

{ #category : #segmented }
ToSandBox class >> example_segmentedWithLabelsAndIcons [

	| seg dashBoard rootPane feedbackPane maj |
	seg := ToSegmentedListElement new.
	seg horizontal: true.
	{ 'Daily'. 'Weekly'. 'Monthly'. 'Quaterly'. 'Yearly' } do: [ :l |
		seg addItem: (ToToggleButton new
				 iconImage: ToThemeIcons searchOutlined16x16;
				 labelText: l;
				 yourself) ].

	dashBoard := self segmentedDashBoardFor: seg.

	feedbackPane := ToPane horizontal.
	feedbackPane layout alignCenter.
	maj := [
	       | t |
	       feedbackPane removeChildren.
	       t := String streamContents: [ :stream |
		            seg dataAccessor withIndexDo: [ :e :idx |
			            stream
				            nextPutAll: e label text asString;
				            nextPutAll: ': '.
			            (seg selectionModel containsIndex: idx)
				            ifTrue: [ stream nextPutAll: 'V ' ]
				            ifFalse: [ stream nextPutAll: 'X ' ].
			            stream nextPutAll: e checked asString.
			            stream nextPutAll: ' '.
			            idx < seg dataAccessor itemCount ifTrue: [
				            stream nextPutAll: '- ' ] ] ].
	       feedbackPane addChild: (ToLabel text: t) ].

	seg addEventHandler: (BlEventHandler
			 on: ToListStrongSelectionEvent
			 do: [ :event |
				 ' double click ' trace.
				 event indexes traceCr ]).

	seg addEventHandlerOn: ToListPrimarySelectionChangedEvent do: maj.
	seg addEventHandlerOn: ToAddedToSpaceEvent do: maj.
	rootPane := ToPane vertical.
	rootPane matchParent.
	rootPane addChildren: {
			dashBoard.
			feedbackPane }.
	rootPane openInSpace
]

{ #category : #segmented }
ToSandBox class >> example_segmentedWithRadioButtons [

	| seg dashBoard |
	seg := ToSegmentedListElement new.
	{ 'Daily'. 'Weekly'. 'Monthly'. 'Quaterly'. 'Yearly' } do: [ :l |
		seg addItem: (ToRadioButton new
				 labelText: l;
				 yourself) ].
	(seg items at: 2) disable.
	dashBoard := self segmentedDashBoardFor: seg.
	dashBoard openInSpace
]

{ #category : #select }
ToSandBox class >> example_selectWith5Nodes [

	| select innerWindow |
	select := ToMultiSelectElement new.
	select popupListElement nodeBuilder: [ :node :dataItem :holder |
		node addChild: (ToLabel text: dataItem asString) hMatchParent ].
	innerWindow := ToInnerWindow new.
	select anchorRoot: innerWindow root.
	select width: 300.
	select position: 50 @ 50.
	select manager minHeight: 10.

	select popupListElement dataAccessor addAll:
		(self statesOfAmerica copyFrom: 1 to: 5).
	innerWindow pane addChild: select.
	innerWindow openInSpace.
	^ select
]

{ #category : #select }
ToSandBox class >> example_selectWith5NodesWithMatchParentMaxHeight [

	| select |
	select := self example_selectWith5Nodes.
	select manager withMatchParentMaxHeight.
	^ select
]

{ #category : #select }
ToSandBox class >> example_selectWithEditingMultiSelectionWithAllClassNames [

	| select innerWindow space |
	self flag: 'To check'.
	select := self selectWithEditingMultiSelection.
	select popupMinHeight: 100.
	select filtrable: true.
	select placeholderString: 'Choose a class'.
	select popupListElement placeholderBuilder: [ :placeholder :e |
			placeholder layout alignCenter.
			placeholder empty label:
				(ToAttributedLabel text: ('No Data' asRopedText
						  fontSize: 24;
						  foreground: Color lightGray;
						  yourself)) ].
	select sieve filter: [ :aClass :aPattern |
		aClass name
			includesSubstring: aPattern asString
			caseSensitive: false ].
	innerWindow := ToInnerWindow new.
	select anchorRoot: innerWindow root.
	select hMatchParent.
	select popupListElement dataAccessor updateAllWith:
		Smalltalk globals allClasses.

	innerWindow pane addChild: select.
	innerWindow height: 800.
	space := BlSpace new.
	space extent: 800 @ 900.
	space root addChild: innerWindow.
	space show
]

{ #category : #space }
ToSandBox class >> example_spaceRootSkin [

	| space  |
	space := BlSpace new.
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
	e := ToElement new layout: BlBasicLayout new.
	e addChild: (BlElement new
			 extent: 30 asPoint;
			 position: 40 asPoint;
			 background: Color gray;
			 yourself).
	e addEventHandler: (ToStillHoveredEventHandler new
			 startDelay: 500 milliSeconds;
			 yourself).

	lab := ToLabel new text: 'Keep mouse inside'.
	lab constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	e addChild: lab.
	e extent: 200 asPoint.
	e border: Color black.
	count := 0.
	e addEventHandler: (BlEventHandler
			 on: ToGeneratorEvent
			 do: [ :event |
					 event trace.
					 ' ' trace.
					 event sourceEvent traceCr ]).
	e addEventHandler: (BlEventHandler
			 on: ToStillHoveredEvent
			 do: [ :event |
					 lab text: count asString asRopedText.
					 count := count + 1.
					 count > 20 ifTrue: [
							 event consume.
							 count := 0 ] ]).
	e openInSpace
]

{ #category : #'still pressed hovered event' }
ToSandBox class >> example_stillHoveredEventWithMixedHandler [

	| e count lab |
	e := ToElement new layout: BlBasicLayout new.
	e addChild: (BlElement new
			 extent: 30 asPoint;
			 position: 40 asPoint;
			 background: Color gray;
			 yourself).
	e addEventHandler: (ToMixedEventGeneratorHandler new
			 needRepeatedEvent: true;
			 startDelay: 500 milliSeconds;
			 activateOnPressed: false;
			 yourself).

	lab := ToLabel new text: 'Keep mouse inside'.
	lab constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	e addChild: lab.
	e extent: 200 asPoint.
	e border: Color black.
	count := 0.
	e addEventHandler: (BlEventHandler
			 on: ToGeneratorEvent
			 do: [ :event |
					 event trace.
					 ' ' trace.
					 event sourceEvent traceCr ]).
	e addEventHandler: (BlEventHandler
			 on: ToStillHoveredEvent
			 do: [ :event |
					 lab text: count asString asRopedText.
					 count := count + 1.
					 count > 80 ifTrue: [
							 event consume.
							 count := 0 ] ]).
	e openInSpace
]

{ #category : #'still pressed hovered event' }
ToSandBox class >> example_stillPressedEvent [

	| e count lab color |
	e := ToElement new
		     id: #'my-element';
		     yourself.
	e addEventHandler: (ToStillPressedEventHandler new
			 startDelay: 500 milliSeconds;
			 delay: 200 milliSeconds;
			 yourself).
	e layout: BlFrameLayout new.
	lab := ToLabel new text: 'Keep mouse pressed here'.
	lab constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	e addChild: lab.
	e extent: 200 asPoint.
	e border: Color black.
	count := 0.
	color := Color white alpha: 0.3.

	e addEventHandler: (BlEventHandler
			 on: ToGeneratorEvent
			 do: [ :event |
					 event trace.
					 event sourceEvent traceCr ]).

	e addEventHandler: (BlEventHandler
			 on: ToStillPressedEvent
			 do: [ :event |
					 e background: color.
					 lab text: count asString asRopedText.
					 count := count + 1.
					 color := color darker.
					 count > 50 ifTrue: [ event consume ] ]).

	e addEventHandler: (BlEventHandler
			 on: ToStopStillPressedEvent
			 do: [ :event |
					 count := 0.
					 color := Color white alpha: 0.3.
					 e background: color ]).

	e openInSpace
]

{ #category : #'still pressed hovered event' }
ToSandBox class >> example_stillPressedEventWithMixedHandler [

	| e count lab color |
	e := ToElement new
		     id: #'my-element';
		     yourself.
	e addEventHandler: (ToMixedEventGeneratorHandler new
			 needRepeatedEvent: true;
			 startDelay: 500 milliSeconds;
			 delay: 200 milliSeconds;
			 activateOnHovered: false;
			 yourself).
	e layout: BlFrameLayout new.
	lab := ToLabel new text: 'Keep mouse pressed here'.
	lab constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	e addChild: lab.
	e extent: 200 asPoint.
	e border: Color black.
	count := 0.
	color := Color white alpha: 0.3.

	e addEventHandler: (BlEventHandler
			 on: ToGeneratorEvent
			 do: [ :event |
					 event trace.
					 event sourceEvent traceCr ]).

	e addEventHandler: (BlEventHandler
			 on: ToStillPressedEvent
			 do: [ :event |
					 e background: color.
					 lab text: count asString asRopedText.
					 count := count + 1.
					 color := color darker.
					 count > 50 ifTrue: [ event consume ] ]).

	e addEventHandler: (BlEventHandler
			 on: ToStopStillPressedEvent
			 do: [ :event |
					 count := 0.
					 color := Color white alpha: 0.3.
					 e background: color ]).

	e openInSpace
]

{ #category : #stylesheet }
ToSandBox class >> example_stylesheet [

	| theme elem space verticalElem horizontalElem biggerElem |
	theme := ToStyleSheetTheme new.
	theme styleSheet addWritableProperty:
		(ToFeatureProperty name: #background).
	theme styleSheet select: ToElement asTypeSelector style: [ :sr |
			sr
				when: ToInstallSkinEvent
				write: (theme property: #background)
				with: [ :e | Color red ].
			sr
				select:
					(ToActionSelector new action: [ :e | "e halt." e width = 50 ])
					|| (ToActionSelector new action: [ :e | e height = 50 ])
				style: [ :squared |
						squared
							when: ToInstallSkinEvent
							write: (theme property: #background)
							with: [ :e | Color green ].

						squared
							select: [ :e | e width = 50 ] asActionSelector not
							style: [ :vertical |
									vertical
										when: ToInstallSkinEvent
										write: (theme property: #background)
										with: [ :e | Color blue ] ].
						squared
							select: [ :e | e height = 50 ] asActionSelector not
							style: [ :horizontal |
									horizontal
										when: ToInstallSkinEvent
										write: (theme property: #background)
										with: [ :e | Color yellow ] ] ] ].

	elem := ToElement new
		        extent: 50 asPoint;
		        position: 50 asPoint.
	verticalElem := ToElement new
		                extent: 50 @ 100;
		                position: 50 @ 150.
	horizontalElem := ToElement new
		                  extent: 100 @ 50;
		                  position: 150 @ 50.
	biggerElem := ToElement new
		              extent: 100 asPoint;
		              position: 150 asPoint.

	space := BlSpace new.
	space root whenLayoutedDoOnce: [ space toTheme: theme ].
	space root addChild: elem.
	space root addChild: verticalElem.
	space root addChild: horizontalElem.
	space root addChild: biggerElem.
	space show
]

{ #category : #menu }
ToSandBox class >> example_subMenuPane [

	| topMenuBar |
	topMenuBar := ToMenuPane new.

	3 timesRepeat: [
		| mb |
		mb := ToMenuPane new.
		mb horizontal: true.
		1 to: 3 do: [ :i |
			| m |
			m := ToMenu new labelText: 'Menu' , i asString.
			1 to: 3 do: [ :j |
			m addItem: (ToMenuItem new labelText: 'item ' , j asString) ].
			mb addItem: m ].

		topMenuBar addItem: mb.
		(mb items at: 2) disable.		
		topMenuBar addFiller ].
	
	topMenuBar addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ topMenuBar inspect ];
			 yourself).
	topMenuBar hMatchParent.

	topMenuBar openInSpace
]

{ #category : #menu }
ToSandBox class >> example_subMenuPaneVertical [

	| topMenuBar |
	topMenuBar := ToMenuPane new.
	topMenuBar beVertical.
	topMenuBar isFlowable: false.
	
	3 timesRepeat: [
		| mb |
		mb := ToMenuPane new.
		mb beVertical.

		1 to: 3 do: [ :i |
			| m |
			m := ToMenu new labelText: 'Menu' , i asString.
			m showExpandIcon: true.
			1 to: 3 do: [ :j |
			m addItem: (ToMenuItem new labelText: 'item ' , j asString) ].
			mb addItem: m ].
		topMenuBar addItem: mb.
		topMenuBar addFiller ].

	topMenuBar addFiller.
	topMenuBar addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ topMenuBar inspect ];
			 yourself).

	topMenuBar vMatchParent.

	topMenuBar openInSpace
]

{ #category : #'switch button' }
ToSandBox class >> example_switchButton [

	| th |
	th := ToSwitchButton new.
	th
		addEventHandlerOn: ToSkinEvent
		do: [ :event | event traceCr ].
	th checked: true.
	th openInSpace
]

{ #category : #'switch button' }
ToSandBox class >> example_switchButton2 [

	| th sp |
	th := ToSwitchButton new.
	th wishedTrackExtent: 100 @ 30.
	th checkedContainer addChild:
		((ToImage inner: (self iconNamed: #glamorousAccept))
			 innerImageColor: Color white).
	th uncheckedContainer addChild:
		((ToImage inner: (self iconNamed: #glamorousClose))
			 innerImageColor: Color white).

	sp := th openInSpace
]

{ #category : #'switch button' }
ToSandBox class >> example_switchButton3 [

	| but onLab offLab onHandleIm handler |
	but := ToSwitchButton new.
	but wishedTrackExtent: 350@50.
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
	th wishedTrackExtent: 100@30.
	th checked: true.
	th openInSpace
]

{ #category : #'finite list' }
ToSandBox class >> example_tabListElement [

	| tabs |
	tabs := ToTabListElement new.
	tabs horizontal: true.
	tabs matchParent.

	{ 'Daily'. 'Weekly'. 'Monthly'. 'Quaterly'. 'Yearly' } do: [ :l |
			| item |
			item := ToTabItemElement new
				        removable: true;
				        middleElement: (ToLabel text: l);
				        yourself.
			item width: 100.
			item height: 100.
			tabs addItem: item ].
	tabs openInInnerWindow
]

{ #category : #'text field' }
ToSandBox class >> example_textField0 [

	| t |
	t := ToTextField new text: 'AAAA'.
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
				 t atTextIndex: event index do: [ :e :lidx |
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
	t := ToTextField new withLineWrapping.
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
	text := ''.
	t placeholderBuilder: [ :thePlaceholder :myself |
		thePlaceholder addChild: (ToAttributedLabel text:
				 ('Enter to accept' asRopedText foreground: Color lightGray)) ].
	t whenSaveRequestedDo: [ :saveRequested |
		saveRequested editorElement text ifNotEmpty: [
			saveRequested editorElement saveResult: true.
			text := saveRequested editorElement text copy ] ].
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
		text := saveRequested editorElement text copy ].
	t whenSaveAcceptedDo: [ :saveAccepted |
		text := saveAccepted editorElement text copy ].
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
		     withoutLineWrapping.
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

{ #category : #'text field' }
ToSandBox class >> example_textFieldsInListElement [

	| pane l |
	self flag: #ToBeChecked.
	pane := ToPane vertical.
	pane matchParent.
	l := ToListElement new.
	l nodeBuilder: [ :node :string :holder |
		| txtf |
		txtf := ToTextField new
			        text: string;
			        yourself.
		node addChild: txtf.
		txtf withSaveCapability.
		txtf whenSaveRequestedDo: [ :event | event accepted: event currentTarget text isNotEmpty ].
		txtf whenSaveAcceptedDo: [ :event |
			l dataAccessor
				at: holder position
				put: event editorElement text asString ] ].
	l dataAccessor addAll: (String loremIpsum: 20000) substrings.
	l matchParent.
	l withRowNumbers.
	pane addChild: l.
	pane openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_toBasicButton0 [

	| but |
	but := ToGeneralButton new.
	but clickAction: [ self inform: 'clicked' ].
	but openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_toBasicButton1 [

	| but |
	but := ToGeneralButton new.
	but addChild: (BlElement new
			 extent: 30 @ 30;
			 yourself).
	but clickAction: [ self inform: 'clicked' ].
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
	but clickAction: [ self inform: 'clicked' ].
	but openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_toBasicButton3 [

	| but |
	but := ToButton new label: (ToLabel new text: ('Button' asRopedText
				         fontSize: 40;
				         yourself)).
	but matchParent.
	but alignCenter: true.
	but clickAction: [ self inform: 'clicked' ].
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
	but matchParent.
	but addChild: pane.
	but layout alignCenter.
	but clickAction: [ self inform: 'clicked' ].
	but openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButtonOrientationChanger [

	| but space iconImage count |
	but := ToButton new.
	but label: (ToLabel text: 'Button' asRopedText bold).
	iconImage := BlElement new
		             extent: 20 @ 20;
		             background: Color lightGray;
		             yourself.
	but iconImage: iconImage.
	count := 0.
	but clickAction: [ :evt |
			count := count + 1.
			count traceCr.
			but orientation: but orientation inverted ].
	space := BlSpace new.
	space root addChild: but.
	space show.
	space showStatisticsWindow
]

{ #category : #tooltip }
ToSandBox class >> example_toButtonWithElementTooltip [

	| but |
	but := ToButton new.
	but labelText: 'Button with tooltip'.
	but tooltipBuilder: [ :window :request |
			window root addChild: (BlElement new
					 background: Color random;
					 extent: 70 @ 100;
					 yourself) ].
	but openInInnerWindow
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButtonWithIconAndText [

	| but space icon |
	but := ToButton new.

	but label: (ToLabel text: 'Button').
	icon := ToImage new innerImage: ToThemeIcons searchOutlined16x16.
	but icon: icon.
	but effect: (BlGaussianShadowEffect
					color: Color green
					width: 4.5
					offset: 0 @ 0).
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

	| but space |
	but := ToButton new.
	but label: (ToLabel text: 'Button').
	but iconImage: ToThemeIcons searchOutlined16x16.
	but endElement: (BlElement new
			 extent: 8 @ 9;
			 background: ToThemeIcons plainTriangle5x9;
			 yourself).
	space := BlSpace new.
	space root addChild: but.
	space show
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButtonWithIconOnly [

	| but space container |
	container := BlElement new
		             extent: 200 @ 200;
		             border: (BlBorder paint: Color gray);
		             background: (Color gray alpha: 0.1).
	but := ToButton new.
	"but addLook: ToButtonLinkLook new."
	"but addLook: ToButtonDashedLook new."
	"but addLook: ToButtonFixedSizeLook new."
	"but addLook: ToButtonPrimaryLook new."
	"but addLook: ToButtonDangerLook new."
	"but addLook: ToButtonLinkLook new."

	but icon:
		(ToImage new innerImage: (Smalltalk ui icons iconNamed: #solidMenu)).
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
			 extent: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself).
	but beRightToLeft.
	but layout cellSpacing: 10.
	count := 0.
	but addEventHandlerOn: BlClickEvent do: [ :event |
			count := count + 1.
			count traceCr ].
	but clickAction: [ but icon background: Color random ].
	space := BlSpace new.
	space root addChild: but.
	space show
]

{ #category : #'button-dep' }
ToSandBox class >> example_toButtonWithTextAndIconVertical [

	| but space |
	but := ToButton new
		       padding: (BlInsets all: 4);
		       beVertical.
	but label: (ToLabel text: 'Button').
	but iconImage: (BlElement new
			 extent: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself).
	but layout cellSpacing: 10.
	but clickAction: [ but icon background: Color random ].
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
	but clickAction: [ self inform: 'clicked' ].

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
	but clickAction: [ self inform: 'Button clicked' ].
	but openInInnerWindow 
 
]

{ #category : #tooltip }
ToSandBox class >> example_toButtonWithTooltipText [

	| but  |
	but := ToButton new.
	but labelText: 'Button with tooltip text'.
	but tooltipText: ('This is a button', String cr, 'so, click on me...') asRopedText. 
	but clickAction: [ self inform: 'Button clicked' ].
	but openInSpace
 
]

{ #category : #image }
ToSandBox class >> example_toImage0 [

	| im |
	im := ToImage new.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImage1 [

	| im |
	im := ToImage new innerImage: (BlElement new
			       extent: 16 @ 16;
			       background: (Color green alpha: 0.5);
			       geometry: BlCircleGeometry new).
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImageFromUrl [

	| im |
	im := ToImage fromUrl: 'https://unsplash.it/400/300?image=1083'.
	im extent: 400 @ 300.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImageFromUrl2 [

	| im |
	im := ToImage fromUrl: 'https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/check.svg'.
	im matchParent.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImageWithSVG [

	| im |
	im := ToImage inner: (self pathBugSVG).
	im matchParent.
	im withNullSkin.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImageWithSVG10 [

	| im |
	im := ToImage inner: self path_draghorizontal.
	"im innerImageColor: Color red."
	im matchParent.
	im withNullSkin.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImageWithSVG2 [

	| im |
	im := ToImage inner: (self pathCheckSVG).
	im matchParent.
	im withNullSkin.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImageWithSVG4 [

	| im |
	im := ToImage inner: (self pathCloseSVG).
	im matchParent.
	im withNullSkin.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImageWithSVG5 [

	| im |
	im := ToImage inner: (self pathAddLinkSVG).
	im matchParent.
	im withNullSkin.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImageWithSVG6 [

	| im |
	im := ToImage inner: (self path_sharp_electric_bike_SVG
).
	im matchParent.
	im withNullSkin.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImageWithSVG7 [

	| im |
	im := ToImage inner: self pathFailureSVG.
	im innerImageColor: Color red.
	im matchParent.
	im withNullSkin.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImageWithSVG8 [

	| im |
	im := ToImage inner: self pathPendingWorkSVG.
	"im innerImageColor: Color red."
	im matchParent.
	im withNullSkin.
	im openInSpace
]

{ #category : #image }
ToSandBox class >> example_toImageWithSVG9 [

	| im |
	im := ToImage inner: self path_dragvertical.
	"im innerImageColor: Color red."
	im matchParent.
	im withNullSkin.
	im openInSpace
]

{ #category : #tooltip }
ToSandBox class >> example_toKeepTooltipWindowOnMouseLeave [

	| but |
	but := ToButton new.
	but tooltipManagerDo: [ :m | m closeOnLeaved: false ].
	but labelText: 'Button with tooltip with selectable text'.
	but tooltipBuilder: [ :window :request |
			| txtfld |
			txtfld := ToSelectableLabel new text: 'Selectable text'.
			window root addChild: txtfld ].
	but openInSpace
]

{ #category : #tooltip }
ToSandBox class >> example_toKeepTooltipWindowOnMouseLeaveWithEditableLabel [

	| but text origString win |
	but := ToButton new.
	but labelText: 'Button with editable tooltip'.
	but tooltipManagerDo: [ :m | m closeOnLeaved: false ].


	origString := 'Edit <Mouse still pressed> - Accept <Return>'.
	text := origString asRopedText.

	but tooltipBuilder: [ :window :request |
			| editedLabel resetBtn |
			editedLabel := ToLabel text: text.
			editedLabel addEventHandler: (ToStillPressedEventHandler new
					 startDelay: 800 milliSeconds;
					 yourself).
			editedLabel
				beEditable;
				addEventHandlerOn: ToStartStillPressedEvent do: [ :event |
						event consume.
						editedLabel popupEditorEvent: event ];
				whenEditorOpenedDo: [ :editorEvent |
						window checkOutsideEvent: false.
						editorEvent editorElement addStamp: #preformatted.
						editorEvent editorElement whenCancelRequestedDo: [
									:cancelRequest |
									text := origString asRopedText.
									editorEvent target text: text ].
						editorEvent editorElement whenSaveRequestedDo: [ :saveRequest |
								saveRequest accepted: true ].
						editorEvent editorElement whenSaveAcceptedDo: [ :acceptedEvent |
									editorEvent target text: acceptedEvent target text.
									text := acceptedEvent target text ] ];
				whenEditorClosedDo: [ :event | window checkOutsideEvent: true ].

			resetBtn := ToButton new
				            labelText: 'Reset';
				            clickAction: [
						            text := origString asRopedText.
						            editedLabel text: text ];
				            yourself.
			editedLabel margin: (BlInsets vertical: 5).
			window root addChild: editedLabel.
			window root addChild: resetBtn ].

	but clickAction: [ 'Button clicked' traceCr ].
	win := but openInInnerWindow.
	but ensuredTooltipManager anchorRoot: win
]

{ #category : #label }
ToSandBox class >> example_toLabel0 [

	| lab |
	lab := ToLabel new.
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
	lab := ToAttributedLabel new text:
		       ('This is a bold gray label' asRopedText
			        fontSize: 20;
			        bold;
			        foreground: Color gray;
			        yourself).
lab isEditable: true.
	lab whenEditorOpenedDo: [ :editorEvent |
		editorEvent editorElement addStamp: #preformatted.
		editorEvent editorElement whenSaveRequestedDo: [ :request |
			request accepted: true ].
		editorEvent editorElement whenSaveAcceptedDo: [ :acceptedEvent |
			editorEvent target text: acceptedEvent target text ] ].

	lab background: Color lightBlue.
	lab hMatchParent.
	
	lab innerElement constraintsDo: [ :c |
		c frame horizontal alignCenter ].
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
	lab1 innerElement constraintsDo: [ :c |
		c frame horizontal alignCenter ].
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

	{
		lab1.
		lab2 } do: [ :l |
		l whenEditorOpenedDo: [ :editorEvent |
			editorEvent editorElement addStamp: #preformatted.
			editorEvent editorElement whenSaveRequestedDo: [ :request |
				request accepted: true ].
			editorEvent editorElement whenSaveAcceptedDo: [ :acceptedEvent |
				editorEvent target text: acceptedEvent target text ] ] ].

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
	lab2
		addEventHandlerOn: ToLabelEditorOpenedEvent
		do: [ :event | event editorElement addStamp: #preformatted ].

	{
		lab1.
		lab2 } do: [ :l |
		l whenEditorOpenedDo: [ :editorEvent |
			editorEvent editorElement whenSaveRequestedDo: [ :request |
				request accepted: true ].
			editorEvent editorElement whenSaveAcceptedDo: [ :acceptedEvent |
				editorEvent target text: acceptedEvent target text ] ] ].

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
	lab whenEditorOpenedDo: [ :editorEvent |
		editorEvent editorElement whenSaveRequestedDo: [ :request |
			request accepted: true ].
		editorEvent editorElement whenSaveAcceptedDo: [ :acceptedEvent |
			editorEvent target text: acceptedEvent target text ] ].

	lab openInSpace
]

{ #category : #table }
ToSandBox class >> example_toTable1 [

	| table |
	table := ToTableElement new.
	table list contextMenuBuilder: [ :menu :request |
			menu addItem: (ToMenuItem new
					 labelText: 'Inspect';
					 clickAction: [ table inspect ];
					 yourself) ].
	"table nodeManager nodeFactory: [
			| node |
			node := ToTableRowNode new.
			node addEventHandlerOn: BlSecondaryClickEvent 
				do: [ :evt |
					| t |
					t := evt currentTarget.
					t holder listElement
						notifyClickOnNode: evt currentTarget
						fromEvent: evt ].
			node ]."

	table columns: {
			(ToTableColumn new
				 title: 'Name';
				 key: 'name';
				 dataIndex: 'name';
				 sorterBlock: #name descending;
				 containerBuilder: [ :container :column |
					 container background: (Color veryLightGray alpha: 0.2) ];
				 minWidth: 50;
				 yourself).
			(ToTableColumn new
				 title: 'Number of methods';
				 key: 'methods';
				 dataIndex: 'numberOfMethods';
				 minWidth: 50;
				 yourself).
			(ToTableColumn new
				 title: 'Space used';
				 key: 'space';
				 dataIndex: 'spaceUsed';
				 containerBuilder: [ :container :column |
					 container background: (Color veryLightGray alpha: 0.2) ];
				 minWidth: 50;
				 yourself).
			(ToTableColumn new
				 title: 'Package';
				 key: 'package';
				 dataIndex: [ :cls | cls packageName ];
				 minWidth: 50;
				 yourself) }.
	table dataAccessor addAll:
		(Smalltalk globals allClasses "copyFrom: 1 to: 30").
	table openInSpace.
	^ table
]

{ #category : #table }
ToSandBox class >> example_toTable1WithCheckbox [

	self example_toTable1 useCheckbox: true
]

{ #category : #table }
ToSandBox class >> example_toTableWithBuilder [

	| table |
	table := ToTableElement new.
	table columns: {
			(ToTableColumn new
				 title: 'Name';
				 key: 'name';
				 dataIndex: 'name';
				 sorterBlock: #name descending;
				 yourself).
			(ToTableColumn new
				 key: 'methods';
				 dataIndex: 'numberOfMethods';
				 headerCellBuilder: [ :header :column |
					 header addChild: (ToLabel text: 'Nb') ];
				 cellBuilder: [ :elem :data :holder |
						 | lab |
						 " use a ToLabel to fit the theme constraints "
						 lab := data > 30
							        ifTrue: [
									        (ToAttributedLabel text: data asString)
										        foreground: Color red;
										        yourself ]
							        ifFalse: [ ToLabel text: data asString ].
						 elem addChild: lab ];
				 width: 130;
				 yourself) }.
	table dataAccessor addAll:
		(Smalltalk globals allClasses select: [ :cls |
			 cls numberOfMethods >= 20 ]) shuffle.
	table openInSpace
]

{ #category : #table }
ToSandBox class >> example_toTableWithSort [

	| table |
	table := ToTableElement new.
	table columns: {
			(ToTableColumn new
				 title: 'Name';
				 key: 'name';
				 dataIndex: 'name';
				 sorterBlock: #name descending;
				 yourself).
			(ToTableColumn new
				 title: 'Number of methods';
				 key: 'methods';
				 dataIndex: 'numberOfMethods';
				 yourself) }.
	table dataAccessor addAll: (Smalltalk globals allClasses copyFrom: 1 to: 30).
	table openInSpace.
	^ table
]

{ #category : #table }
ToSandBox class >> example_toTreeTable1 [

	| table |
	table := ToTreeTableElement new.
	table nodeManager childrenGetter: [ :dataItem |
		dataItem subclasses sorted: [ :a :b | a name < b name ] ].
	table columns: {
			(ToTableColumn new
				 title: 'Name';
				 key: 'name';
				 dataIndex: #name;
				 yourself).
			(ToTableColumn new
				 title: 'Number of methods';
				 key: 'methods';
				 dataIndex: #numberOfMethods;
				 containerBuilder: [ :container |
					 container background: (Color veryLightGray alpha: 0.2) ];
				 yourself).
			(ToTableColumn new
				 title: 'Space used';
				 key: 'space';
				 dataIndex: #spaceUsed;
				 yourself).
			(ToTableColumn new
				 title: 'Package';
				 key: 'package';
				 dataIndex: [ :cls | cls packageName ];
				 containerBuilder: [ :container :column |
					 container background: (Color veryLightGray alpha: 0.2) ];
				 yourself) }.
	table dataAccessor add: ProtoObject.
	table dataAccessor add: BlElement.
	table dataAccessor add: Collection.
	table dataAccessor add: String.

	table openInSpace.
	^ table
]

{ #category : #table }
ToSandBox class >> example_toTreeTable1WithCheckbox [

	| table |
	table := self example_toTreeTable1 useCheckbox: true.
	table list contextMenuBuilder: [ :menu :request |
			menu addItem: (ToMenuItem new
					 labelText: 'Inspect';
					 clickAction: [ table inspect ];
					 yourself) ]
]

{ #category : #table }
ToSandBox class >> example_toTreeTable2 [

	| table |
	table := ToTreeTableElement new.
	table nodeManager childrenGetter: [ :dataItem |
		dataItem subclasses sorted: [ :a :b | a name < b name ] ].
	table columns: {
			(ToTableColumn new
				 title: 'Name';
				 key: 'name';
				 dataIndex: #name;
				 cellBuilder: [ :cell :cls :holder |
						 cell addChild: (ToLabeledIcon new
									  startInterspace: 6;
									  labelText: cls asString;
									  iconImage: (self iconNamed: cls systemIconName);
									  yourself) ];
				 yourself).
			(ToTableColumn new
				 title: 'Number of methods';
				 key: 'methods';
				 dataIndex: #numberOfMethods;
				 yourself).
			(ToTableColumn new
				 title: 'Space used';
				 key: 'space';
				 dataIndex: #spaceUsed;
				 yourself).
			(ToTableColumn new
				 title: 'Package';
				 key: 'package';
				 dataIndex: [ :cls | cls packageName ];
				 yourself) }.
	table dataAccessor add: ProtoObject.
	table dataAccessor add: BlElement.
	table dataAccessor add: Collection.
	table dataAccessor add: String.

	table openInSpace
]

{ #category : #'button-dep' }
ToSandBox class >> example_toWidgetAsButton0 [

	| but |
	but := ToElement new.
	but
		addEventHandlerOn: BlPrimaryClickEvent
		do: [ self inform: 'Click' ].
	but background: Color blue.
	but extent: 50 @ 50.
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
	pane withNullSkin.
	pane padding: (BlInsets all: 5).
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
	btn clickAction: [ pane orientation: pane orientation inverted ].
	pane addChild: btn.
	btn := ToButton new labelText: 'Change direction'.
	btn clickAction: [ pane direction: pane direction inverted ].
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

{ #category : #tag }
ToSandBox class >> finiteTagListWithData: aCollection [

	| bar confBoard barPane rootPane selectionModeBoard rand tags |
	rand := Random new.
	bar := ToItemListElement finite.
	bar addStamp: #background withValue: (Color veryLightGray alpha: 0.1).
	tags := aCollection collect: [ :s |
			        ToTagElement new
				        labelText: s;
				        yourself ].
	bar addAllItems: tags.

	bar contextMenuBuilder: [ :menu :request |
			| idxes target |
			target := request currentTarget.
			idxes := request selectedIndexes.
			menu addItem: (ToMenuItem new
					 labelText: 'Inspect list';
					 clickAction: [ target inspect ];
					 yourself).
			menu addItem: (ToMenuItem new
					 labelText: 'Remove all';
					 clickAction: [ target dataAccessor removeAll ];
					 yourself).

			idxes ifNotEmpty: [
					menu addItem: (ToMenu new
							 labelText: 'Selected node';
							 in: [ :m |
									 m addItem: (ToMenuItem new
												  labelText: 'Inspect';
												  clickAction: [
														  Array withAll:
																  (idxes collect: [ :idx |
																		   target nodeContainerAt: idx ]) inspect ];
												  yourself).
									 m addItem: (ToMenuItem new
											  labelText: 'Remove';
											  clickAction: [
												  idxes reverseDo: [ :idx |
														  bar dataAccessor removeAt: idx ] ];
											  yourself).
									 m addItem: (ToMenuItem new
											  labelText: 'Unable/disable';
											  clickAction: [
													  idxes do: [ :idx |
																  (bar nodeContainerAt: idx) disabled:
																		  (bar nodeContainerAt: idx) isEnabled ] ];
											  yourself).
									 m addItem: (ToMenuItem new
											  labelText: 'Unselectable';
											  clickAction: [
												  idxes do: [ :idx |
														  bar unselectableSelecter selectIndex: idx ] ];
											  yourself).
									 m addItem: (ToMenuItem new
											  labelText: 'Insert before';
											  clickAction: [
													  | idx |
													  idx := idxes first.
													  target dataAccessor
														  add: (ToTagElement new labelText:
																	   String loremIpsum substrings first
																	   , ' (inserted before)')
														  beforeIndex: idx ];
											  yourself).
									 m addItem: (ToMenuItem new
											  labelText: 'Insert after';
											  clickAction: [
													  | idx |
													  idx := idxes last.
													  target dataAccessor
														  add: (ToTagElement new labelText:
																	   String loremIpsum substrings first
																	   , ' (inserted before)')
														  afterIndex: idx ];
											  yourself) ];
							 yourself) ] ].

	confBoard := self listConfigurationBoardFor: bar.
	selectionModeBoard := self selectionModeChooserFor: bar.
	confBoard addChild: selectionModeBoard.

	bar toConfiguration isFlowable: true.
	rootPane := ToPane horizontal.
	rootPane padding: (BlInsets all: 5).
	rootPane matchParent.
	barPane := ToPane horizontal.
	barPane padding: (BlInsets all: 5).
	barPane matchParent.
	barPane addChild: bar.

	rootPane addChild: confBoard.
	rootPane addChild: barPane.
	rootPane addDividers first weight: 0.5.
	rootPane openInSpace
]

{ #category : #'labeled icon' }
ToSandBox class >> labeledIconlWithIconAndText [

	| but |
	but := ToLabeledIcon new.
	but label: (ToLabel text: 'Labeled icon').
	but icon: (ToImage inner: (BlElement new
				  extent: 60 @ 60;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	^ but
]

{ #category : #'finite list' }
ToSandBox class >> listConfigurationBoardFor: aList [

	| menu confPane animSwitch |
	confPane := ToPane vertical.
	confPane id: #configurationPane.
	confPane matchParent.
	confPane padding: (BlInsets all: 5).

	menu := ToMenu new.
	menu icon: (ToImage inner: (self iconNamed: #solidMenu)).
	menu addItem: (ToRadioMenuItem new
			 label: (ToLabel text: 'Dark theme');
			 checkAction: [ :evt |
					 evt currentTarget space toTheme: (evt target isChecked
								  ifTrue: [ ToRawDarkTheme new ]
								  ifFalse: [ ToRawTheme new ]) ];
			 in: [ :rad |
				 rad checked: Toplo defaultThemeClass = ToRawDarkTheme ];
			 yourself).
	menu addItem: (ToMenuItem new
			 label: (ToLabel text: 'Space statistics');
			 clickAction: [ aList space showStatisticsWindow ];
			 yourself).
	menu addItem: (ToMenuItem new
			 label: (ToLabel text: 'Inspect');
			 clickAction: [ aList space root inspect ];
			 yourself).
	menu addItem: (ToRadioMenuItem new
			 label: (ToLabel text: 'Disabled bar');
			 checkAction: [ :evt | aList disabled: evt target isChecked ];
			 yourself).
	confPane addChild: menu.

	{
		([ aList useInfiniteLayout ] -> [ :v | aList useInfiniteLayout: v ]
		 -> 'Use infinite layout').
		([ aList isVertical ] -> [ :v | aList isVertical: v ] -> 'Vertical').
		([ aList toConfiguration isFlowable ]
		 -> [ :v | aList toConfiguration isFlowable: v ] -> 'Flowable').
		([ aList toConfiguration isScrollable ]
		 -> [ :v | aList toConfiguration isScrollable: v ] -> 'Scrollable').
		([ aList toConfiguration autoDistribute ]
		 -> [ :v | aList toConfiguration autoDistribute: v ]
		 -> 'Auto-distribute').
		([ aList useCheckbox ]
		 -> [ :v | aList useCheckbox: v ]
		 -> 'Use checkbox selection').
		([ aList selectionMode selectOnPressed ]
		 -> [ :v | aList selectionMode selectOnPressed: v ]
		 -> 'Select on pressed').
		([ aList selectionMode deselectOnPressed ]
		 -> [ :v | aList selectionMode deselectOnPressed: v ]
		 -> 'Deselect on pressed').
		([ aList selectionMode makeDisabledUnselectable ]
		 -> [ :v | aList selectionMode makeDisabledUnselectable: v ]
		 -> 'Disabled items are unselectable') } do: [ :assoc |
			| switch |
			switch := ToSwitchButton new labelText: assoc value value.
			switch checkAction: [ :evt |
				assoc key value value: evt target isChecked ].

			switch startFlexible: true.
			switch hMatchParent.
			confPane addChild: switch.

			aList whenConfigurationAppliedDo: [
				switch checked: assoc key key value ] ].

	animSwitch := ToSwitchButton new labelText: 'Animate transition'.
	animSwitch checkAction: [ :evt |
			| d |
			d := evt target isChecked
				     ifTrue: [ 200 milliSeconds ]
				     ifFalse: [ 0 milliSeconds ].
			aList selectionOption animationDuration: d.
			aList secondarySelectionOption animationDuration: d ].

	animSwitch startFlexible: true.
	animSwitch hMatchParent.
	confPane addChild: animSwitch.
	confPane addChild: (self resizerBoardFor: aList).
	^ confPane
]

{ #category : #'finite list' }
ToSandBox class >> listDashBoardFor: aBar [

	| mainPane barPane confPane |
	mainPane := ToPane horizontal.
	mainPane matchParent.
	barPane := ToPane horizontal.
	barPane matchParent.
	barPane addChild: aBar.

	confPane := self listConfigurationBoardFor: aBar.
	confPane padding: (BlInsets all: 5).
	mainPane addChildren: {
			confPane.
			barPane }.
	^ mainPane
]

{ #category : #list }
ToSandBox class >> listMenuFenuFactory [

	^ [ :menu :request |
	  | selectionModel indexes target |
	  target := request currentTarget.
	  selectionModel := request selectionModel.
	  indexes := request selectedIndexes.
	  menu addItem: (ToMenuItem new
			   labelText: 'Add initial Items';
			   clickAction: [
				   target dataAccessor addAll:
						   (String loremIpsum: 20000) substrings ];
			   yourself).
	  menu addItem: (ToMenuItem new
			   labelText: 'Inspect list';
			   clickAction: [ target inspect ];
			   yourself).
	  menu addItem: (ToMenuItem new
			   labelText: 'Statistics window';
			   clickAction: [ target space showStatisticsWindow ];
			   yourself).
	  target dataAccessor ifNotEmpty: [
		  menu addItem: (ToMenuItem new
				   labelText: 'Select all';
				   clickAction: [ target selecter selectAll ];
				   yourself).
		  menu addItem: (ToMenuItem new
				   labelText: 'Remove all';
				   clickAction: [ target dataAccessor removeAll ];
				   yourself).
		  menu addItem: (ToMenuItem new
				   labelText: 'Show all';
				   clickAction: [ target hiddenSelecter deselectAll ];
				   yourself).
		  target selectionOption isMasked
			  ifTrue: [
				  menu addItem: (ToMenuItem new
						   labelText: 'stop primary selection masking';
						   clickAction: [ target selectionOption masked: false ];
						   yourself) ]
			  ifFalse: [
				  menu addItem: (ToMenuItem new
						   labelText: 'start primary selection masking';
						   clickAction: [ target selectionOption masked: true ];
						   yourself) ].
		  target selectionOption isAnimated
			  ifTrue: [
				  menu addItem: (ToMenuItem new
						   labelText: 'stop selection transition animation';
						   clickAction: [
							   target selectionMode selectionElementOption
								   animationDuration: 0 milliSeconds ];
						   yourself) ]
			  ifFalse: [
				  menu addItem: (ToMenuItem new
						   labelText: 'start selection transition animation';
						   clickAction: [
							   target primarySelectionMode selectionOption
								   animationDuration: 200 milliSeconds ];
						   yourself) ] ].
	  indexes ifNotEmpty: [
		  | selectionMenu |
		  selectionMenu := ToMenu new.
		  selectionMenu label: (ToLabel new text: 'Selection').
		  indexes size = 1 ifTrue: [
			  | container idx label |
			  idx := indexes first.
			  container := target nodeContainerAt: idx.
			  label := container childWithId: #nodeLabel.
			  selectionMenu addItem: (ToMenuItem new
					   labelText: 'Inspect node';
					   clickAction: [ container inspect ];
					   yourself).
			  selectionMenu addItem: (ToMenuItem new
					   labelText: 'Edit';
					   clickAction: [ label popupEditorEvent: nil ];
					   yourself).
			  selectionMenu addItem: (ToMenuItem new
					   labelText: (label isMonoLine
							    ifTrue: [ 'Be multiline' ]
							    ifFalse: [ 'Be monoline' ]);
					   clickAction: [
						   container firstChild label monoLine: label isMonoLine not ];
					   yourself).
			  selectionMenu addItem: (ToMenuItem new
					   labelText: 'Inspect';
					   clickAction: [ container inspect ];
					   yourself).
			  selectionMenu addSeparator ].

		  selectionMenu addItem: (ToMenuItem new
				   labelText: 'Enable/Disable';
				   clickAction: [
					   indexes do: [ :idx |
							   | di |
							   di := (target nodeContainerAt: idx) isDisabled.
							   (target nodeContainerAt: idx) disabled: di not ] ];
				   yourself).
		  selectionMenu addItem: (ToMenuItem new
				   labelText: 'Set unselectable';
				   clickAction: [
					   indexes do: [ :idx |
							   target unselectableSelecter selectIndex: idx ] ];
				   yourself).
		  selectionMenu addItem: (ToMenuItem new
				   labelText: 'Hide';
				   clickAction: [
					   indexes do: [ :idx | target hiddenSelecter selectIndex: idx ] ];
				   yourself).
		  selectionMenu addItem: (ToMenuItem new
				   labelText: 'Insert before';
				   clickAction: [
					   | idx |
					   idx := indexes first.
					   target dataAccessor
						   add:
							   String loremIpsum substrings first , ' (inserted before)'
						   beforeIndex: idx ];
				   yourself).
		  selectionMenu addItem: (ToMenuItem new
				   labelText: 'Insert after';
				   clickAction: [
					   | idx |
					   idx := indexes last.
					   target dataAccessor
						   add: String loremIpsum substrings first , ' (inserted after)'
						   afterIndex: idx ];
				   yourself).
		  selectionMenu addSeparator.
		  selectionMenu addItem: (ToMenuItem new
				   labelText: 'Remove';
				   clickAction: [
					   indexes sort reverseDo: [ :idx |
							   target dataAccessor removeAt: idx ] ];
				   yourself).
		  menu addSeparator.
		  menu addItem: selectionMenu ] ]
]

{ #category : #'finite list' }
ToSandBox class >> listWithData: aCollection [

	| bar confBoard barPane rootPane selectionModeBoard rand |
	rand := Random new.
	bar := ToListElement finite.
	bar matchParent.
	bar nodeManager nodeHolderFactory: [ ToExNodeWithFontSizeHolder new ].
	bar addStamp: #background withValue: (Color veryLightGray alpha: 0.1).
	bar nodeBuilder: [ :node :dataItem :holder |
			| triplet label |
			node tooltipString: dataItem asString.
			triplet := ToTripletElement new.
			triplet
				hMatchParent;
				vFitContent.
			holder fontSize ifNil: [ holder fontSize: (rand nextIntegerBetween: 10 and: 16) ].
			label := (ToLabel text: holder position asString , ': ' , dataItem asString)
				         fontSize: holder fontSize;
				         yourself.
			triplet startElement: ToIconicRemoveButton new.
			triplet startElement clickAction: [ triplet startElement fireEvent: ToRemoveButtonClickedEvent new ].
			triplet middleElement: label.
			triplet startInterspace: 10.
			triplet constraintsDo: [ :c | c linear vertical alignCenter ].
			node addChild: triplet ].

	bar contextMenuBuilder: [ :menu :request |
			| idxes target |
			target := request currentTarget.
			idxes := request selectedIndexes.
			menu addItem: (ToMenuItem new
					 labelText: 'Inspect list';
					 clickAction: [ target inspect ];
					 yourself).
			menu addItem: (ToMenuItem new
					 labelText: 'Remove all';
					 clickAction: [ target dataAccessor removeAll ];
					 yourself).
			menu addItem: (ToMenuItem new
					 labelText: 'Add first a new item';
					 clickAction: [ target dataAccessor addFirst: String loremIpsum substrings first , ' (added first)' ];
					 yourself).
			menu addItem: (ToMenuItem new
					 labelText: 'Add last a new item';
					 clickAction: [ target dataAccessor add: String loremIpsum substrings first , ' (added last)' ];
					 yourself).
			idxes ifNotEmpty: [
					menu addItem: (ToMenu new
							 labelText: 'Selected node';
							 in: [ :m |
									 m addItem: (ToMenuItem new
												  labelText: 'Inspect';
												  clickAction: [ Array withAll: (idxes collect: [ :idx | target nodeContainerAt: idx ]) inspect ];
												  yourself).
									 m addItem: (ToMenuItem new
											  labelText: 'Remove';
											  clickAction: [ idxes reverseDo: [ :idx | bar dataAccessor removeAt: idx ] ];
											  yourself).
									 m addItem: (ToMenuItem new
											  labelText: 'Unable/disable';
											  clickAction: [ idxes do: [ :idx | (bar nodeContainerAt: idx) disabled: (bar nodeContainerAt: idx) isEnabled ] ];
											  yourself).
									 m addItem: (ToMenuItem new
											  labelText: 'Unselectable';
											  clickAction: [ idxes do: [ :idx | bar unselectableSelecter selectIndex: idx ] ];
											  yourself).
									 m addItem: (ToMenuItem new
											  labelText: 'Insert before';
											  clickAction: [
													  | idx |
													  idx := idxes first.
													  target dataAccessor add: String loremIpsum substrings first , ' (inserted before)' beforeIndex: idx ];
											  yourself).
									 m addItem: (ToMenuItem new
											  labelText: 'Insert after';
											  clickAction: [
													  | idx |
													  idx := idxes last.
													  target dataAccessor add: String loremIpsum substrings first , ' (inserted after)' afterIndex: idx ];
											  yourself) ];
							 yourself) ] ].

	confBoard := self listConfigurationBoardFor: bar.
	selectionModeBoard := self selectionModeChooserFor: bar.
	confBoard addChild: selectionModeBoard.

	bar dataAccessor addAll: aCollection.
	rootPane := ToPane horizontal.
	rootPane padding: (BlInsets all: 5).
	rootPane matchParent.
	barPane := ToPane horizontal.
	barPane padding: (BlInsets all: 5).
	barPane matchParent.
	barPane addChild: bar.

	rootPane addChild: confBoard.
	rootPane addChild: barPane.
	rootPane addDividers first weight: 0.5. "bar toConfiguration useCheckbox: true."
	rootPane openInSpace.
	^ bar
]

{ #category : #list }
ToSandBox class >> listWithEditableAndContextMenu [

	| l menuFactory option |
	l := ToListElement new.

	option := l disabledSelectionMode selectionOption.
	option grouped: false.
	option beneath: false.
	option masked: false.
	option elementFactory: [
			ToListSelectionElement new defaultSkin:
				ToListDisabledSelectionElementExampleSkin new ].

	option := l unselectableSelectionMode selectionOption.
	option selectionSkinEventClass: ToUnselectableSkinEvent.
	option deselectionSkinEventClass: ToSelectableSkinEvent.
	option grouped: false.
	option beneath: false.
	option masked: false.
	option elementFactory: [
			ToListSelectionElement new defaultSkin:
				ToListUnselectableSelectionElementExampleSkin new ].

	l placeholderBuilder: [ :placeholder :e |
			placeholder empty labelText:
				'Invoke the context menu ' , String cr , 'to initialize the list' ].

	l nodeBuilder: [ :node :dataItem :holder |
			| lab |
			lab := (ToLabel text: dataItem)
				       id: #nodeLabel;
				       yourself.
			lab beMultiLine.
			lab beEditable.
			holder isSelectable ifTrue: [
					lab addEventHandler: (BlEventHandler
							 on: ToStillPressedEvent
							 do: [ :event |
									 event consume.
									 lab popupEditorEvent: event ]).
					lab whenEditorOpenedDo: [ :editorEvent |
							l disableScrolledEvent.
							editorEvent editorElement whenSaveRequestedDo: [ :request |
								request accepted: true ].
							editorEvent editorElement whenSaveAcceptedDo: [ :acceptedEvent |
									editorEvent target text: acceptedEvent target text.
									l dataAccessor at: holder position put: lab text asString ] ] ].
			lab whenEditorClosedDo: [ l enableScrolledEvent ].

			node addChild: (ToLabeledIcon new
					 label: lab;
					 hMatchParent) ].

	l addEventHandler: (BlEventHandler
			 on: ToListStrongSelectionEvent
			 do: [ :event |
					 self inform:
						 'Double click on: ' , (event indexes asString contractTo: 150) ]).

	menuFactory := self listMenuFenuFactory.
	l contextMenuBuilder: menuFactory.
	l withRowNumbers.
	^ l
]

{ #category : #accessing }
ToSandBox class >> methodText [
	^ self  class sourceCodeAt: #example_CodeEditor
]

{ #category : #empty }
ToSandBox class >> newEmptyBox [

	^ ToEmpty box
]

{ #category : #window }
ToSandBox class >> newPopup [

	| e popupWindowHandler |
	e := ToLabel new
		     text: 'Popup button';
		     id: #popup;
		     geometry: (BlRoundedRectangleGeometry cornerRadius: 6);
		     background: (Color red alpha: 0.2);
		     position: 200 @ 140;
		     yourself.
	popupWindowHandler := ToPopupWindowManager new.
	popupWindowHandler windowBuilder: [ :popup :request |
		popup border: Color gray.
		popup hFitContent.
		popup height: 100.
		popup addChild: (ToLabel new text: 'A popup window') ].
	e addEventHandler: popupWindowHandler.
	^ popupWindowHandler
]

{ #category : #accordion }
ToSandBox class >> paneWithAccordionsWithLabel [

	| pane |
	pane := ToPane new.
	pane layout: BlLinearLayout vertical.
	pane hMatchParent.
	pane vFitContent.
	(1 to: 5) collect: [ :i |
		pane addChild: ((self accordionWithLabelText: 'Header ' , i asString) isExpanded: false)].
	^ pane
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
ToSandBox class >> pathFailureSVG [

	<sampleInstance>
	^ '<?xml version="1.0" encoding="utf-8"?><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="122.881px" height="122.88px" viewBox="0 0 122.881 122.88" enable-background="new 0 0 122.881 122.88" xml:space="preserve"><g><path fill-rule="evenodd" clip-rule="evenodd" d="M61.44,0c33.933,0,61.441,27.507,61.441,61.439 c0,33.933-27.508,61.44-61.441,61.44C27.508,122.88,0,95.372,0,61.439C0,27.507,27.508,0,61.44,0L61.44,0z M81.719,36.226 c1.363-1.363,3.572-1.363,4.936,0c1.363,1.363,1.363,3.573,0,4.936L66.375,61.439l20.279,20.278c1.363,1.363,1.363,3.573,0,4.937 c-1.363,1.362-3.572,1.362-4.936,0L61.44,66.376L41.162,86.654c-1.362,1.362-3.573,1.362-4.936,0c-1.363-1.363-1.363-3.573,0-4.937 l20.278-20.278L36.226,41.162c-1.363-1.363-1.363-3.573,0-4.936c1.363-1.363,3.573-1.363,4.936,0L61.44,56.504L81.719,36.226 L81.719,36.226z"/></g></svg>'
]

{ #category : #accessing }
ToSandBox class >> pathFlagSVG [

	<sampleInstance>
	^ '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1000" height="700"><path d="M0 0h1000v700H0V0z" fill="#d50032"/><path d="M0 0h680v700H0V0z" class="F"/><path d="M0 0h320v700H0V0z" fill="#10069f"/><path d="M469.37 188.48c12.051 0 16.979 10.338 29.029 10.338 7.44 0 11.777-2.43 18.261-6.087 4.524-2.562 7.41-3.927 12.605-3.927 5.319 0 8.58 1.608 11.301 6.167 1.537 2.58 2.814 7.628 2.138 10.525a62.488 62.488 0 0 1-4.262 12.953c-1.043 2.438-2.028 3.898-2.028 6.566 0 6.396 8.704 8.594 14.622 8.685 1.29.02 12.139.198 18.815-6.56-3.622-.16-7.675-2.965-7.675-6.588 0-4.099 2.88-6.873 6.785-8.057.742-.212 2.006.443 2.677.09.954-.495.508-1.568 1.356-2.24 1.944-1.555 3.207-2.525 5.699-2.525a5.732 5.732 0 0 1 3.885 1.165c.69.495.943 1.107 1.79 1.107 1.786 0 2.67-1.13 4.454-1.13a6.876 6.876 0 0 1 3.604.848c1.06.548 1.037 2.349 2.238 2.349.601 0 3.779-1.296 5.44-1.296 3.446 0 5.285 1.248 7.512 3.863.6.707.985 2.137 1.596 2.137a9.72 9.72 0 0 1 5.832 2.559 9.871 9.871 0 0 1 1.68 2.038c.406.654 1.03 2.25 1.748 2.526.927.193 1.822.52 2.655.971a9.315 9.315 0 0 1 4.377 7.611 15.88 15.88 0 0 1-.75 3.31c-2.942 10.284-9.94 13.548-17.009 22.382-3.004 3.763-5.375 6.767-5.375 11.59 0 1.167 1.436 3.303 2.073 4.275-.389-2.267.647-5.051 3.043-5.18a6.09 6.09 0 0 1 6.259 5.568 7.025 7.025 0 0 1-.519 2.85 14.911 14.911 0 0 1 6.217-2.202 19.38 19.38 0 0 1 2.979-.13c5.245.13 11.034 3.08 14.547 6.064 10.749 9.13 12.049 22.492 11.462 26.203-1.305 8.246-.484 23.168-21.56 29.117 3.897 1.641 6.55 4.573 6.55 8.178a7.11 7.11 0 0 1-6.927 7.28 6.825 6.825 0 0 1-5.372-2.12c-4.382 4.381-5.23 8.852-5.23 15.054a19.283 19.283 0 0 0 2.261 9.258c1.644 3.552 2.827 5.637 5.796 8.2 1.573-2.369 3.234-4.1 6.078-4.1 2.757 0 5.09.883 6.22 3.392.336.76.035 1.379.424 2.12.495.955 1.326 1.167 1.838 2.121.795 1.467.018 2.721.707 4.24.441.99 1.413 1.132 1.837 2.121a9.168 9.168 0 0 1 .849 4.24c0 4.701-4.277 8.058-8.977 8.058-1.413 0-2.19-.565-3.604-.424 2.686 2.686 4.735 3.852 6.785 7.068 2.968 4.647 3.71 7.951 4.382 13.429.11.891.157 1.788.142 2.686 0 7.032-1.096 11.238-4.241 17.528-3.004 6.025-5.566 9.365-11.026 13.287-8.517 6.131-14.72 7.899-25.02 9.895a116.172 116.172 0 0 1-17.105 2.262l-22.052 1.13c-11.238.76-19.03 2.35-27 10.32 3.765 2.756 6.362 5.46 6.362 10.107 0 4.77-2.951 8.18-7.492 9.683-1.06.353-1.838.035-2.827.565-1.184.618-1.131 1.979-2.262 2.686a9.7 9.7 0 0 1-5.937 1.555c-4.205 0-7.068-.99-10.037-3.959-3.445 2.863-4.612 5.443-8.481 7.634-1.273.707-1.927 1.696-3.393 1.696-2.315 0-3.375-1.466-5.23-2.827a35.88 35.88 0 0 1-6.927-6.36c-3.516 2.102-5.672 3.816-9.754 3.816a10.173 10.173 0 0 1-6.22-1.697c-1.113-.689-1.29-1.714-2.403-2.403-1.166-.724-2.138-.459-3.392-.99-4.718-2.031-7.775-5.53-7.775-10.671 0-4.506 2.845-7.369 6.927-9.26-7.828-7.827-15.532-9.187-26.576-9.894l-21.911-1.131a154.24 154.24 0 0 1-17.246-2.262c-5.072-.83-8.075-1.095-12.722-3.251-15.991-7.457-26.187-17.687-28.272-35.198a28.508 28.508 0 0 1-.142-3.887c0-9.118 3.587-14.683 10.036-21.133-1.66-.39-2.774.159-4.382-.424-4.029-1.467-6.926-4.259-6.926-8.553a7.173 7.173 0 0 1 .848-4.028c.548-.972 1.59-1.167 1.837-2.262.318-1.449-.106-2.474.566-3.817.442-.9 1.272-1.078 1.696-1.979 1.396-2.897 3.146-5.23 6.361-5.23 2.757 0 4.524 1.449 5.937 3.817 2.686-1.237 3.428-3.252 4.948-5.796 2.527-4.223 3.675-7.174 3.675-12.086a23.87 23.87 0 0 0-1.413-8.693c-.778-2.333-1.096-3.923-2.827-5.654a6.825 6.825 0 0 1-5.372 2.12 8.135 8.135 0 0 1-7.916-8.34 7.516 7.516 0 0 1 4.665-7.21c-2.421-2.084-4.524-2.261-7.21-3.957-4.081-2.58-5.512-5.301-8.198-9.33-1.75-2.633-2.21-4.47-3.11-7.492a29.36 29.36 0 0 1-1.697-9.612 17.52 17.52 0 0 1 .141-2.545c1.008-7.668 2.386-12.475 7.21-18.518 2.862-3.587 4.806-5.795 9.047-7.633 3.604-1.555 5.76-2.686 9.683-2.686a21.67 21.67 0 0 1 3.04.142c1.583.086 3.127.52 4.523 1.272.6.336 1.696 1.343 1.696.636 0-.813-.424-1.237-.424-2.05 0-3.25 2.332-6.22 5.584-6.22 2.35 0 3.304 2.068 4.453 4.1a6.091 6.091 0 0 0 1.13-3.534c0-5.372-2.88-8.11-6.22-12.298-7.28-9.1-16.397-13.358-16.397-25.02 0-3.48 1.678-5.849 4.665-7.633.865-.513 2.03 0 2.877-.543.725-.46.642-1.395 1.101-2.137a10.415 10.415 0 0 1 2.373-2.525c1.661-1.449 3.12-1.015 4.957-2.287.919-.636 1.136-1.463 1.843-2.31 2.05-2.474 3.89-3.669 7.123-3.669a9.254 9.254 0 0 1 4.04.607c.512.195 1.47.967 1.594.818a7.35 7.35 0 0 1 2.243-1.813 6.37 6.37 0 0 1 3.432-.907c1.732 0 2.866.971 4.598.971.636 0 .783-.635 1.295-.971 1.537-1.042 2.422-1.632 4.295-1.632a7.157 7.157 0 0 1 4.318 1.567c1.43.902 1.637 2.108 3.103 2.957.813.477 1.502.265 2.404.565 4.028 1.343 7.068 4.029 7.068 8.27a6.487 6.487 0 0 1-2.262 5.442c-1.361 1.201-2.65.99-4.382 1.555 5.619 4.488 10.508 5.601 17.682 5.601 6.573 0 14.612-2.687 14.612-9.26 0-3.057-1.69-4.7-2.892-7.509-2.156-5-3.325-7.942-3.325-13.384 0-4.311.47-6.927 2.979-10.426 2.58-3.604 5.731-4.445 10.167-4.445l.002.001z" class="J"/><g class="C H"><path d="M425.59 223.46a5.564 5.564 0 0 0 3.82 3.807 5.894 5.894 0 0 0 5.986-2.177 6.92 6.92 0 0 0 .833-6.297 7.32 7.32 0 0 0-2.698-3.468l-7.938 8.057-.002.079-.001-.001z" stroke-linejoin="round" class="K"/><path d="M626.61 343.94c-1.866-4.51-6.686-2.488-6.983 0-.683 5.732 4.34 7.464 7.916 6.53a6.22 6.22 0 0 0 3.896-3.03 7.55 7.55 0 0 0 .61-5.824 8.38 8.38 0 0 0-3.325-4.471c-1.375-.878-2.874-.965-5.224-.965-8.708 0-16.327 10.289-18.886 20.977a46.074 46.074 0 0 0-.396 18.815 35.044 35.044 0 0 0 9.16 17.585 39.21 39.21 0 0 0 8.99 6.435 38.76 38.76 0 0 0 6.496 2.683 12.41 12.41 0 0 0 6.159.142c5.16-1.12 7.559-5.92 4.96-10.83-2.129-4.02-8.397-6.219-11.352-1.088a5.1 5.1 0 0 0-.628 2.411 4.65 4.65 0 0 0 1.561 3.64c2.246 1.428 5.838 1.024 5.672-2.941" class="B L"/><path d="M599.69 403.07a17.66 17.66 0 0 1 10.343-5.703c4.654-.572 8.699.783 12.828 3.004 8.06 4.335 12.554 8.995 15.549 17.641a26.91 26.91 0 0 1 1.304 9.022c-.14 5.604-1.563 11.73-3.092 14.692-1.334 2.583-4.82 13.994-23.946 21.868-11.161 4.594-28.3 5.653-40.118 6.12-16.256.642-31.254 1.244-39.962 11.973" stroke-width="1.276"/><g stroke-width="1.121"><path d="M603.75 421.45c-.466-1.71-.035-3.35 1.322-5.209 1.814-2.486 5.675-3.343 9.174-1.4a11.61 11.61 0 0 1 3.965 3.266l1.788 2.488a19.33 19.33 0 0 1 1.703 3.887c3.846 10.928-2.265 22.771-10.255 27.522-6.206 3.69-13.608 5.336-22.469 6.375-3.982.468-6.256.437-10.263.623-3.223.149-6.008.096-8.63.064l-6.297-.064a110.46 110.46 0 0 0-11.274.155c-4.55.331-7.972.448-11.818 1.089-2.511.418-5.455.822-8.542 1.515-.926.207-1.865.377-2.809.661l-1.881.575a62.311 62.311 0 0 0-15.257 6.521 27.29 27.29 0 0 0-3.877 2.708c-.665.627-1.472 1.256-2.124 1.898-2.99 2.941-6.047 6.126-6.762 10.438a15.452 15.452 0 0 0-.132 2.507c0 2.798 2.278 6.608 8.42 7.852m8.638-265.811c1.285 2.324 1.992 3.738 1.244 6.142-.847 2.723-2.778 4.354-5.52 4.354-6.22 0-9.878-7.364-7.075-12.051 4.976-8.319 14.539-3.647 23.402.474-.428-2.134-1.174-2.828-1.096-5.471.193-6.565 5.061-9.542 7.005-15.605 1.157-3.613 1.618-6.75-1.025-9.316-2.308-2.24-4.982-2.205-7.994-1.025-6.018 2.359-13.246 9.138-25.97 9.326-12.724-.188-20.012-6.967-26.03-9.326-3.012-1.18-5.686-1.214-7.994 1.025-2.643 2.566-2.183 5.703-1.025 9.316 1.944 6.064 6.812 9.04 7.005 15.605.077 2.643-.669 3.337-1.096 5.47 8.863-4.12 18.798-9.211 23.402-.473 2.565 4.869-.855 12.05-7.075 12.05-2.742 0-4.667-1.747-5.52-4.353a6.71 6.71 0 0 1 1.244-6.142"/><path d="M491.5 224.79c2.403 1.838 4.1 4.1 3.817 7.775-.307 3.986-1.273 4.947-4.382 7.068m3.745-5.933a5.124 5.124 0 0 1-3.534 4.947" class="B"/></g></g><path d="m432.4 214.49 1.088.777 1.166 1.245.778 1.555.389 1.321.078 1.71-.078 1.167-.389 1.322-.778.932-.933 1.011-1.321.7-1.71.389-1.478.233-1.555-.7-1.399-1.01-.855-1.245-.622-1.555v-.621l7.62-7.231h-.001z" class="J"/><g class="C H"><path d="M430.01 220.57c-.478-2.581-3.496-3.11-4.665-1.586-1.8 2.348-.485 6.257 3.176 7.401a5.89 5.89 0 0 0 5.987-2.177 6.78 6.78 0 0 0-1.587-9.451l-.279-.189c-4.252-3.233-11.118-2.488-13.373 2.954-2.909 7.02 3.42 12.284 9.252 16.25 7.34 4.991 15.705 5.899 22.003 5.83 14.306-.155 25.19-6.997 32.265-10.884 1.648-.905 3.345-.72 4.198.311a3.115 3.115 0 0 1-.389 4.276" class="B K"/><path d="m387.6 414.35-3.188 1.166-3.265 2.488-1.4 1.944-1.788 3.11-.777 2.332-.622 2.877-.311 2.177m29.701-15.784-.233 2.8-.467 1.943-1.4 3.343-2.176 2.877-2.333 1.865-1.71.856-2.41.544" stroke-width="1.057"/><path d="M499.6 489.23c-.58 2.588-3.004 5.548-8.279 6.617l-1.025.212" stroke-width="1.197"/><path d="M631.59 406.57a28.457 28.457 0 0 1 7.488 12.109 26.88 26.88 0 0 1 1.303 9.021c-.14 5.604-1.562 11.73-3.091 14.692-1.334 2.584-4.82 13.994-23.946 21.868-11.161 4.595-28.3 5.654-40.118 6.12-16.022.633-30.822 1.227-39.582 11.517" class="M"/><path d="M605.45 416.95c1.188-1.621 5.517-3.673 9.016-1.73a9.68 9.68 0 0 1 3.714 3.243" stroke-width=".929"/><path d="m627.51 402.79 2.244.767c1.997.635 4.134.685 6.158.142 4.423-1.327 7.261-5.459 4.96-10.83a8.856 8.856 0 0 0-2.717-3.333" class="M"/><path d="M375.44 287.13c-2.969 1.838-5.182 2.273-7.492 4.947a43.944 43.944 0 0 0-4.1 10.65m72.032-80.767c0 2.686-1.98 4.382-4.665 4.947" class="B K"/><path d="M620.49 275.03c7.39-.15 28.859 5.64 29.012 30.876.15 24.925-15.383 28.997-21.607 30.656" stroke-width=".997"/><path d="M622.43 275.03c12.743-.554 25.892 8.826 26.472 32.236.452 18.289-12.517 26.584-18.742 28.243" class="L"/><path d="m615.33 363.16.196-2.502.834-3.974 1.178-3.091 1.324-2.551 1.717-2.06m12.161-5.312-.195 2.449-.7 1.672-1.088 1.594-1.244.933-1.904.7-1.672.116-1.244-.195M602.33 268.42l.544-2.643 1.166-2.45 1.517-2.449 2.604-3.343 2.06-2.293 3.343-3.382 2.877-2.916 1.827-2.099 2.41-2.915 2.138-3.227 1.283-2.643.7-3.421.212-4.242-.388-1.23M605.44 429.44l2.527-.505 1.905-1.011 1.05-1.05.738-1.205.505-1.943.04-1.361M364.94 403.38l1.866.155 2.41-.194 2.41-.855m7.814-57.106-.31 2.177-.506.972-.739.933-1.01.777-1.128.505-1.477.234-1.011.078m15.471-24.406-.544 3.382-.661 1.477-1.36 1.866-1.828 1.4-1.866.932-3.615.894m23.904-62.121-.7 2.021-.855 1.478-1.166 1.632-1.633 1.477-1.943.934-1.633.388-1.01-.078m.59-9.682.04 1.555" stroke-width=".881"/><g class="D"><path d="M397.32 325.09a10.71 10.71 0 0 1-3.265 2.029M629.24 397.16c.134.145.581.217.739.31 2.215 1.323 6.577-.325 5.294-3.746" class="B"/><path d="M621.54 349.38c1.573 2.055 4.538 2.588 6.883 1.976a6.22 6.22 0 0 0 3.895-3.03 7.54 7.54 0 0 0 .61-5.825 7.65 7.65 0 0 0-1.325-2.58 10.59 10.59 0 0 0-2.132-2.23c-.17-.111-.339-.262-.518-.383m10.037 53.152a6.23 6.23 0 0 0-1.906-5.711 7.44 7.44 0 0 0-1.36-1.233m.746.734c-.073-2.912-2.456-4.995-5.41-5.513m-6.52 4.433a20.74 20.74 0 0 1-2.042-1.69 24.55 24.55 0 0 1-6.742-16.677c-.037-6.473 2.566-13.062 5.598-15.627M533.07 481.44l2.799-2.566 1.944-1.477 3.654-2.255 3.42-1.632 2.41-.622 4.821-1.089 5.598-.855M511.61 501.2c-2.022 3.11-6.842 7.775-11.896 9.64-5.054-1.865-9.874-6.53-11.895-9.64"/><path d="M491.28 494.73a15.468 15.468 0 0 1-3.468 6.451" class="B"/><path d="m491.78 491.47-.7 3.42m-3.65 6.53-1.477 1.477-2.644 1.477-3.032.934M471.46 227.45a9.8 9.8 0 0 0 .71-4.014c-.193-6.565-5.06-9.542-7.005-15.606-1.157-3.612-1.618-6.75 1.026-9.316 2.307-2.24 4.981-2.205 7.993-1.025 6.018 2.36 13.308 9.138 26.032 9.326-12.724-.188-20.015-6.967-26.032-9.326-3.012-1.18-5.935-1.525-8.242.714-2.644 2.566-1.934 6.015-.777 9.627 1.944 6.064 6.563 9.041 6.756 15.606a9.61 9.61 0 0 1-.834 4.014m29.093-21.08c12.517-.661 23.245-9.071 26.706-9.757 3.086-.612 4.809-.336 7.072 1.721-2.264-2.057-4.842-1.993-7.77-.845-6.018 2.359-13.246 9.138-25.97 9.326M624.59 383.2a24.286 24.286 0 0 1-9.718-19.274c-.036-6.474 2.565-13.061 5.597-15.627M511.17 500.76c-2.021 3.11-6.842 7.775-11.895 9.64-5.054-1.865-9.874-6.53-11.895-9.64"/><path d="m479.17 230.74 3.624-2.018c1.649-.906 3.63-.716 4.483.316a3.27 3.27 0 0 1-.226 4.416" class="B"/><path d="M460.48 239.49c8.588-1.792 15.585-5.638 20.875-8.597M531.78 487.43a4.15 4.15 0 0 1 1.166 1.493 6.91 6.91 0 0 1 .521 1.326 3.353 3.353 0 0 1-2.533 4.008 3.35 3.35 0 0 1-.55.077 5.26 5.26 0 0 1-5.482-3.17M460.04 239.05c8.588-1.792 15.585-5.638 20.875-8.597M633.38 397.49c-1.633.63-2.526.544-4.557-.358-.834-.37-1.788-.943-2.907-1.578-3.98-2.261-8.708-5.824-13.139-14.143a29.387 29.387 0 0 1-2.672-6.992 25.88 25.88 0 0 1-.78-5.212 40.11 40.11 0 0 1 .964-9.72 31.62 31.62 0 0 1 6.376-14.15c1.795-2.463 3.343-3.966 6.686-4.043M398.83 279.88a11.11 11.11 0 0 1 4.12 8.94c0 4.842-4.05 12.75-14.001 15.55a12.945 12.945 0 0 1-9.87-1.18m21.381-6.91a5.39 5.39 0 0 1 2.488 5.07c0 1.664-1.076 3.822-2.907 5.866a19.31 19.31 0 0 1-13.716 6.26 15.986 15.986 0 0 1-9.422-2.735 14.16 14.16 0 0 1-5.987-8.397"/><path d="M400.3 306.71c2.026 1.862 2.648 4.193 2.648 7.129 0 4.29-1.742 7.6-5.75 11.107a19.69 19.69 0 0 1-3.032 2.178M596.4 292.63v5.519m-.44-6.879v7.774m.44-24.604v10.185m-.44-12.435v13.918m-2.97 128.062a29.244 29.244 0 0 1-6.53 8.863 30.66 30.66 0 0 1-9.097 6.375 38.43 38.43 0 0 1-10.263 3.421 52.465 52.465 0 0 1-10.73 1.322 73.824 73.824 0 0 1-9.909-.255c-4.127-.285-6.417-.86-10.538-1.222a83.08 83.08 0 0 0-8.743-.566 44.835 44.835 0 0 0-8.983.643 34.411 34.411 0 0 0-8.086 2.255c-4.198 1.7-8.941 4.665-9.952 5.987-1.01-1.322-5.754-4.286-9.952-5.987a34.42 34.42 0 0 0-8.085-2.255 44.79 44.79 0 0 0-8.984-.643 82.8 82.8 0 0 0-8.743.566c-4.121.362-6.41.937-10.538 1.222a74.2 74.2 0 0 1-9.91.255 52.169 52.169 0 0 1-10.728-1.322 38.667 38.667 0 0 1-10.263-3.42 30.57 30.57 0 0 1-9.097-6.376l-.948-.953m65.889 83.39 2.799-.35m47.301-3.68 2.825-.269 2.69-1.076 1.884-1.144 2.556-3.027.538-1.144.404-2.623.134-1.21M613.23 277.36c1.213-4.128-.268-8.483-4.266-8.366M402.79 341.75a12.78 12.78 0 0 1-5.62 7.293m5.69-72.993a10.186 10.186 0 0 1-5.724 6.26c-2.886 1.304-6.227.086-8.014-1.292"/><path d="M380.95 291.2c2.392 1.253 4.82-.584 4.322-3.696a4.45 4.45 0 0 0-3.933-3.433" class="B"/><path d="M390.87 422.86c.516.485.626 1.115 1.322 1.244 1.05.194 1.866.583 2.915-.816 1.294-1.725.599-4.409-.747-6.098a7.72 7.72 0 0 0-9.112-1.461 11.606 11.606 0 0 0-3.965 3.265l-1.788 2.488a19.351 19.351 0 0 0-1.704 3.887c-3.2 9.098.6 18.664 6.489 24.493"/><path d="M531.59 487.23a9.19 9.19 0 0 1 1.01 1.244 6.18 6.18 0 0 1 .428 1.327 3.353 3.353 0 0 1-3.083 4.084 4.97 4.97 0 0 1-5.267-3.156" class="B"/><path d="M608.5 216.81a11.565 11.565 0 0 1 9.784 10.992c0 6.92-2.331 9.496-5.974 14.446-3.899 5.297-16.638 15.005-16.638 26.045 0 6.686 1.866 10.962 6.686 13.139 3.108 1.404 6.742-.116 8.397-1.61 4.042-3.655 2.426-10.063-1.788-10.829-5.132-.933-6.096 7.145-1.089 6.609M635.73 383.51a5.72 5.72 0 0 0-11.377.99 5.924 5.924 0 0 0 1.615 4.085M599.79 279.88a11.11 11.11 0 0 0-4.12 8.94c0 4.842 4.05 12.75 14.001 15.55 3.814 1.072 7.458.971 9.74-.417M375.61 287.8a14.64 14.64 0 0 0-7.55 5.395c-1.856 2.63-2.938 6.286-3.608 9.485a31.01 31.01 0 0 0 .252 10.41 24.6 24.6 0 0 0 3.602 8.806 12.38 12.38 0 0 0 1.62 1.932 17.35 17.35 0 0 0 1.774 1.373M471.72 469.02c7.576 3.359 13.13 5.875 17.839 13.31a15.464 15.464 0 0 1 1.866 7.62 15.864 15.864 0 0 1-5.21 11.894 12.946 12.946 0 0 1-10.417 3.188c-3.007-.295-5.831-2.488-6.298-4.043M396.88 325.2c4.276 3.343 6.064 6.586 6.064 11.74a13.056 13.056 0 0 1-6.22 11.662"/><path d="M392.99 344.41c6.375 7.93 9.758 12.637 9.952 22.08.181 8.863-2.644 14.927-7.93 21.303" class="B"/><path d="M515.23 239.57a6.42 6.42 0 0 0 2.497-3.485c.753-2.325.77-4.308-.474-6.096 1.534 2.009 1.675 3.705 1.243 6.142-.274 1.552-1.264 2.369-2.497 3.485M596.4 374.24v25.241h.067a38.529 38.529 0 0 1-.212 3.887l-.429 2.703"/><path d="M595.96 371.81v27.223h.067a38 38 0 0 1-.212 3.887l-.729 4.125m.874-67.105v22.702m.44-20.912v18.463m0-41.943v13.841m-.44-15.471v17.064m.44-29.584v5.37m-.44-6.46v7.776m-2.88 101.864-.53 1.084a29.244 29.244 0 0 1-6.53 8.863 30.67 30.67 0 0 1-9.097 6.376 38.43 38.43 0 0 1-10.263 3.42 52.32 52.32 0 0 1-10.73 1.322c-3.305.135-6.615.05-9.908-.255-4.128-.285-6.417-.86-10.538-1.222a83.226 83.226 0 0 0-8.743-.566 44.767 44.767 0 0 0-8.984.644 34.39 34.39 0 0 0-8.086 2.254c-4.197 1.7-8.94 4.665-9.951 5.987-1.011-1.322-5.754-4.286-9.952-5.987a34.36 34.36 0 0 0-8.086-2.254 44.7 44.7 0 0 0-8.983-.644 82.69 82.69 0 0 0-8.743.566c-4.122.362-6.41.937-10.538 1.222a74.2 74.2 0 0 1-9.91.255 52.24 52.24 0 0 1-10.729-1.321 38.705 38.705 0 0 1-10.263-3.421 30.566 30.566 0 0 1-9.096-6.376 34.17 34.17 0 0 1-3.858-4.355m-3.142-4.982a15.78 15.78 0 0 1-3.523 12.034c-1.321 1.4-4.2 4.074-7.775 4.12-5.908.078-7.672-3.986-8.03-4.975M399.4 410.7a16.05 16.05 0 0 1 2.893 3.965c1.477 2.799 1.022 7.48-.148 9.64a6.86 6.86 0 0 1-.475.749M370.04 453.2c3.514 3.687 8.828 7.692 16.99 11.052 11.161 4.595 28.3 5.654 40.118 6.12 15.715.62 30.193 1.266 39.01 10.998m27.132-6.36c2.598 2.556 5.247 5.295 6.366 8.798M488.18 501.7a13.7 13.7 0 0 1-11.501 4.217 9.657 9.657 0 0 1-6.685-4.025m-8.364-4.542a9.78 9.78 0 0 0 .457.577 11.88 11.88 0 0 0 7.978 3.833m41.985-.12c-2.022 3.11-6.842 7.774-11.895 9.64-5.054-1.866-9.874-6.53-11.896-9.64l-.472-.727m24.343.707a12.76 12.76 0 0 0 1.156 1.109 12.95 12.95 0 0 0 10.418 3.187 8.544 8.544 0 0 0 6.36-4.043c.303-.329.539-.715.692-1.136"/><path d="m529.75 500.99-1.16 1.867-1.766 1.463-2.674 1.11-2.421.1"/><path d="M536.03 483.22a12.03 12.03 0 0 1 3.599 4.534 10.78 10.78 0 0 1 .787 3.698 9.15 9.15 0 0 1-2.222 6.474 11.745 11.745 0 0 1-8.43 3.866h-.734m.29-.442a10.67 10.67 0 0 1-8.092-3.375M620.72 391.93a37.11 37.11 0 0 1-7.507-10.077 29.38 29.38 0 0 1-2.672-6.992 25.85 25.85 0 0 1-.78-5.211 40.13 40.13 0 0 1 .964-9.722 32.63 32.63 0 0 1 6.376-14.15 17.19 17.19 0 0 1 3.25-3.488M618.2 223.83c3.965.31 7.639 4.58 7.59 8.764-.07 6.078-2.108 8.59-6.89 14.545-4.12 5.131-16.482 14.15-16.171 22.78a8.51 8.51 0 0 0 1.802 4.39m-4.941 5.411a10.847 10.847 0 0 0 3.207 2.156 7.846 7.846 0 0 0 6.654-.443M576.37 213.9a9.443 9.443 0 0 1 3.415 4.061c2.908 7.02-3.42 12.284-9.252 16.25a33.35 33.35 0 0 1-12.968 5.128m12.125-11.909a6.53 6.53 0 0 1-4.92-2.34 5.225 5.225 0 0 1-1.106-1.552M540.45 231.2a7.23 7.23 0 0 1-2.063-1.504 6.393 6.393 0 0 1-1.242-6.853c.987-2.963 5.746-11.274 5.98-17.027.356-8.79-3.025-13.977-8.313-16"/><path d="m542.68 203.85-.206 3.305-.895 3.374-1.722 4.613-1.308 2.96-1.377 2.961-.688 2.066-.276 1.515.207 1.446M595.81 423.4a4.77 4.77 0 0 0 .933 1.306c1.01 1.687 4.94 4.655 8.514 4.701 5.91.078 7.312-4.057 7.464-4.975.746-4.509-.796-5.743-3.11-7.013a5.263 5.263 0 0 0-2.994-.433" class="B"/><path d="M370.23 403.67c-1.88.535-3.871.546-5.757.033-4.423-1.326-8.007-5.564-6.18-10.829m20.917-49.724a2.8 2.8 0 0 1 .653 1.67c.683 5.732-4.34 7.402-7.916 6.469a8.8 8.8 0 0 1-4.71-3.56 7.354 7.354 0 0 1-.963-3.6m34.466-36.979a7.546 7.546 0 0 1 1.931 2.757M400.9 296.6a5.98 5.98 0 0 1 1.825 2.042"/><path d="M402.91 303.94a13.23 13.23 0 0 1-2.43 3.718 19.312 19.312 0 0 1-13.716 6.26 15.99 15.99 0 0 1-9.422-2.736 14.897 14.897 0 0 1-6.377-8.715" class="B"/><path d="M399.11 280.13a12.11 12.11 0 0 1 3.698 5.295"/><path d="M402.86 292.56a18.42 18.42 0 0 1-13.473 12.248c-3.804.964-8.702-.241-10.374-1.664" class="B"/><path d="M375.06 291.49c.417 4.12 3.174 7.209 8.401 7.308 7.35.138 11.818-10.574 5.287-18.094"/><path d="M358.52 327.39a25.41 25.41 0 0 0 3.63 3.636 26.228 26.228 0 0 0 9.272 5.153m8.248.771c6.569-.789 10.272-5.684 9.538-11.41-.56-4.363-4.563-7.718-7.285-7.912" class="B"/><path d="M390.39 268.92a4.464 4.464 0 0 1 4.449 4.478l-.005.187"/><path d="M389.72 229.81a17.95 17.95 0 0 0 7.86 9.099m225.28 48.381c2.686 3.679.927 10.932-6.379 11.07a8.102 8.102 0 0 1-6.939-3.924" class="B"/><path d="M596.4 239.25v24.686"/><path d="M380.87 291.14c2.255 1.632 5.15-1.124 4.03-4.05-.757-1.975-3.563-4.106-7.45-1.463-4.294 2.92-3.11 12.13 5.13 12.284 7.35.139 11.819-10.574 5.287-18.093-6.282-7.234-17.727-5.542-25.19.396a33.43 33.43 0 0 0-11.04 18.164 34.314 34.314 0 0 0-.912 7.93 35.44 35.44 0 0 0 5.562 18.276 18.21 18.21 0 0 0 2.037 2.56 39.13 39.13 0 0 0 2.954 3.032c4.223 3.515 9.665 6.27 16.327 5.987 7.308-.311 11.507-5.442 10.729-11.507-.754-5.88-6.69-8.805-10.574-6.064-2.644 1.866-3.584 7.644 1.088 9.018 2.644.778 4.976-2.565 3.11-4.509M584.4 210.68c4.218-2.29 7.47-1.867 9.874 1.47a15.457 15.457 0 0 1 2.41 11.28c-.855 4.199-2.068 5.942-5.407 8.988m3.303-19.868c4.82-3.187 10.041-1.834 12.906 2.41 2.1 3.11 2.636 5.712 2.488 9.563a17.555 17.555 0 0 1-8.941 14.383" class="B"/><path d="M617.28 223.67a8.052 8.052 0 0 1 7.153 8.086c0 5.986-1.671 8.583-6.454 14.539-4.12 5.131-16.482 14.15-16.17 22.78.117 3.263 2.868 6.338 5.241 6.51"/><path d="M617.75 291.14c-2.255 1.632-5.131-1.004-3.887-3.803.859-1.932 3.42-4.353 7.308-1.71 4.293 2.92 3.11 12.13-5.131 12.284-7.35.139-12.317-10.297-5.287-18.093 6.416-7.116 18.315-5.723 25.778.214 3.176 2.527 9.566 9.466 10.936 18.573 1.658 11.02 1.445 24.575-9.937 32.922a26.91 26.91 0 0 1-16.516 4.637c-7.308-.32-11.506-5.443-10.729-11.507.754-5.88 6.416-8.368 10.574-6.065 4.32 2.393 3.565 8.466-1.088 9.019-2.736.325-4.976-2.566-3.11-4.51" class="B"/><path d="M613.86 287.34c1.212-5.454 5.885-5.962 9.658-5.907 10.296.151 17.416 12.364 17.535 24.178.15 14.923-6.334 23.711-17.241 24.178-2.823.121-7.684-1.221-7.768-4.665"/><path d="M620.2 284.9c10.858 2.413 14.67 12.196 14.67 21.532 0 7.616-.754 18.022-15.575 21.682" stroke-linecap="square"/><path d="M638.11 389.58a6.104 6.104 0 1 0-9.789 3.66"/><g class="B"><path d="M616.33 380.33a25.82 25.82 0 0 0 9.74 9.238m-1.96 16.482c-5.12-3.359-14.838-7.761-23.624-3.428-3.259 1.608-5.442 3.597-6.675 6.84a15.52 15.52 0 0 0 2.788 14.949c1.321 1.4 4.2 4.074 7.774 4.12 5.91.079 7.314-4.056 7.464-4.975.7-4.276-1.788-5.987-3.11-6.453-1.014-.358-4.312-.266-5.012 2.065a4.174 4.174 0 0 0 .348 3.144"/><path d="M531.99 488.16c1.633 3.343-.224 5.024-2.488 5.287-3.343.388-5.131-2.255-5.364-4.665a6.87 6.87 0 0 1 6.327-7.366l.515-.02a8.674 8.674 0 0 1 7.764 5.477 10.79 10.79 0 0 1 .788 3.697 9.147 9.147 0 0 1-2.223 6.474 11.745 11.745 0 0 1-8.429 3.866c-6.6.265-11.74-5.908-11.74-12.206 0-12.05 17.872-18.623 24.957-20.314 8.708-2.077 14.006-2.855 27.99-3.632 5.597-.311 9.697-.153 15.86-.792a94.33 94.33 0 0 0 14.072-2.162 42.58 42.58 0 0 0 19.592-9.952c4.55-4.131 7.153-7.075 9.26-12.75 1.817-4.898 2.653-14.596-1.951-21.77a22.4 22.4 0 0 0-16.171-10.565c-5.83-.843-10.942 1.672-13.995 7.456-1.477 2.8-1.022 7.48.148 9.64a9.37 9.37 0 0 0 7.471 4.666c5.909.078 7.313-4.057 7.464-4.976.7-4.276-1.788-5.987-3.11-6.453-1.014-.358-4.312-.266-5.012 2.065a4.18 4.18 0 0 0 .347 3.144M526.9 469.02c-7.576 3.359-13.13 5.875-17.839 13.31a15.464 15.464 0 0 0-1.866 7.62 15.864 15.864 0 0 0 5.21 11.894 12.947 12.947 0 0 0 10.417 3.188c3.007-.295 5.832-2.488 6.298-4.043"/></g><path d="M601.73 325.2c-3.545 1.183-6.064 6.586-6.064 11.74a13.056 13.056 0 0 0 6.22 11.662"/><path d="M605.62 344.41c-6.375 7.93-9.758 12.637-9.952 22.08-.182 8.863 2.644 14.927 7.93 21.303" class="B"/><path d="m571.64 212.58.547-.81c2.644-3.887 7.312-4.911 10.73-2.332 4.12 3.11 5.16 8.402 4.042 13.994a13.57 13.57 0 0 1-6.325 8.521"/><path d="M414.22 210.68c-4.043-1.866-7.371-1.507-9.874 1.47-2.877 3.421-2.986 8.453-2.41 11.28.855 4.199 2.068 5.942 5.407 8.988" class="B"/><path d="M404.03 212.55c-4.82-3.187-10.041-1.834-12.906 2.41-2.1 3.11-2.636 5.712-2.488 9.563a17.555 17.555 0 0 0 8.941 14.383"/><path d="M390.12 216.81a10.65 10.65 0 0 0-9.4 10.433c0 6.92 1.703 9.718 5.59 15.005 3.897 5.299 16.638 15.005 16.638 26.045 0 6.686-1.866 10.962-6.686 13.139-3.108 1.404-6.742-.116-8.397-1.61-4.043-3.655-2.426-10.063 1.788-10.829 5.131-.933 6.096 7.145 1.089 6.609m-9.412-51.932c-3.965.31-7.867 3.723-7.867 7.908 0 5.986 2.385 8.761 7.167 14.716 4.121 5.131 15.762 13.972 15.451 22.602-.117 3.263-2.31 7.253-4.488 6.786"/><path d="M372 343.94c1.866-4.51 6.686-2.488 6.983 0 .683 5.732-4.34 7.464-7.916 6.53a6.218 6.218 0 0 1-3.896-3.03 7.55 7.55 0 0 1-.61-5.824 7.66 7.66 0 0 1 1.326-2.581 7.748 7.748 0 0 1 1.999-1.89c1.375-.878 2.874-.965 5.224-.965 8.708 0 16.327 10.289 18.886 20.977a46.039 46.039 0 0 1 .396 18.815 35.051 35.051 0 0 1-9.16 17.585 39.21 39.21 0 0 1-8.99 6.435 38.76 38.76 0 0 1-6.496 2.683 10.954 10.954 0 0 1-6.158.142c-4.423-1.327-7.262-5.46-4.96-10.83 1.792-4.18 8.397-6.219 11.351-1.088a5.1 5.1 0 0 1 .628 2.411 4.648 4.648 0 0 1-1.561 3.64c-2.246 1.428-5.838 1.024-5.671-2.941" class="B"/><path d="M365.24 397.49c1.633.63 2.526.544 4.557-.358.834-.37 1.789-.943 2.907-1.578 3.98-2.261 8.708-5.824 13.139-14.143a29.38 29.38 0 0 0 2.672-6.992 25.87 25.87 0 0 0 .78-5.212 40.06 40.06 0 0 0-.964-9.72 31.607 31.607 0 0 0-6.376-14.15c-1.795-2.463-3.343-3.966-6.686-4.043M360.51 389.58a6.104 6.104 0 1 1 9.789 3.66m-7.419-9.73a5.72 5.72 0 0 1 11.377.99 5.926 5.926 0 0 1-1.615 4.085"/><path d="M374.02 383.2a24.286 24.286 0 0 0 9.718-19.274c.036-6.474-2.565-13.061-5.597-15.627"/><path d="M382.29 380.33a25.82 25.82 0 0 1-9.74 9.238" class="B"/><path d="M397.81 402.63c-1.449-3.409-4.329-4.985-9.019-5.486-4.662-.497-8.698.784-12.828 3.005-8.06 4.335-12.554 8.995-15.55 17.641a26.88 26.88 0 0 0-1.303 9.021c.14 5.604 1.563 11.73 3.091 14.692 1.334 2.584 4.82 13.994 23.946 21.868 11.161 4.595 28.3 5.654 40.118 6.12 16.256.642 31.255 1.245 39.962 11.973"/><path d="M374.5 406.05c5.12-3.359 14.838-7.761 23.624-3.428 3.259 1.608 5.442 3.597 6.675 6.84a15.52 15.52 0 0 1-2.788 14.949c-1.321 1.4-4.2 4.074-7.775 4.12-5.908.079-7.313-4.056-7.463-4.975-.7-4.276 1.788-5.987 3.11-6.453 1.014-.358 4.312-.266 5.011 2.065a4.174 4.174 0 0 1-.347 3.144" class="B"/><path d="M394.86 421.45a5.27 5.27 0 0 0-1.321-5.209 8.013 8.013 0 0 0-9.175-1.4 11.61 11.61 0 0 0-3.965 3.266l-1.788 2.488a19.351 19.351 0 0 0-1.704 3.887c-3.845 10.928 2.413 22.532 10.256 27.522 6.842 4.354 13.84 5.598 22.47 6.375 3.993.36 6.256.437 10.263.623 3.223.149 6.008.096 8.63.064l6.296-.064a110.46 110.46 0 0 1 11.274.155c4.55.331 7.973.448 11.818 1.089 2.512.418 5.456.822 8.543 1.515.926.207 1.865.377 2.808.661l1.882.575a62.33 62.33 0 0 1 15.257 6.521 23.63 23.63 0 0 1 3.877 2.708c.796.795 1.472 1.256 2.123 1.898 2.99 2.941 6.048 6.126 6.763 10.438.112.831.156 1.669.132 2.507 0 2.798-2.278 6.608-8.42 7.852"/><path d="M466.62 488.16c-1.633 3.343.224 5.024 2.488 5.287 3.343.388 5.131-2.255 5.364-4.665a6.87 6.87 0 0 0-6.327-7.366l-.515-.02a8.674 8.674 0 0 0-7.764 5.477 10.79 10.79 0 0 0-.788 3.697 9.147 9.147 0 0 0 2.223 6.474 11.74 11.74 0 0 0 8.429 3.866c6.6.265 11.74-5.908 11.74-12.206 0-12.05-17.873-18.623-24.957-20.314-8.708-2.077-14.006-2.855-27.99-3.632-5.597-.311-9.697-.153-15.86-.792a94.337 94.337 0 0 1-14.073-2.162 42.58 42.58 0 0 1-19.592-9.952c-4.55-4.131-7.153-7.075-9.26-12.75-1.817-4.898-2.652-14.596 1.951-21.77a22.4 22.4 0 0 1 16.172-10.565c5.83-.843 10.942 1.672 13.995 7.456 1.478 2.8 1.022 7.48-.148 9.64a9.37 9.37 0 0 1-7.471 4.666c-5.909.078-7.313-4.057-7.464-4.976-.7-4.276 1.788-5.987 3.11-6.453 1.014-.358 4.312-.266 5.012 2.065a4.18 4.18 0 0 1-.347 3.144"/><path d="m426.97 212.58-.547-.81c-2.644-3.887-7.312-4.911-10.73-2.332-4.12 3.11-5.16 8.402-4.042 13.994a13.572 13.572 0 0 0 6.324 8.521" class="B"/><path d="M573.04 224.37c-6.298 6.842-12.595 9.026-22.003 9.33-2.938.095-8.552-.933-11.818-3.258-2.098-1.494-4.432-4.05-2.954-8.482.987-2.962 5.746-11.273 5.98-17.027.355-8.79-3.026-13.606-8.313-15.472-9.774-3.45-20.267 6.211-26.589 8.319a21.34 21.34 0 0 1-8.008 1.243 21.63 21.63 0 0 1-8.068-1.243c-6.323-2.108-16.816-11.77-26.59-8.32-5.287 1.867-8.668 6.683-8.312 15.473.234 5.753 4.992 14.064 5.98 17.027 1.477 4.431-.857 6.988-2.955 8.481-3.265 2.326-8.88 3.353-11.818 3.259-9.407-.304-15.705-2.488-22.003-9.33"/><path d="M464.58 466.27c1.246.487.303-.295 8.195 3.203 7.576 3.359 12.954 6.3 17.663 13.736a15.464 15.464 0 0 1 1.866 7.62 16.65 16.65 0 0 1-.459 3.841" class="B"/><path d="M465.09 500.06a12.52 12.52 0 0 0 5.081 1.29c6.6.264 11.74-5.91 11.74-12.207 0-4.366-2.377-8.044-5.706-11"/><path d="M466.52 488.15c-1.594 3.553.677 5.475 2.94 5.738a4.91 4.91 0 0 0 5.432-4.328l.026-.337a6.98 6.98 0 0 0-3.278-6.485" class="B"/><path d="M609.53 216.87c5.018 0 9.394 5.585 9.394 11.317 0 6.605-3.513 10.648-6.087 13.705-2.072 2.46-4.316 4.663-6.982 7.348"/><path d="M603.58 211.58a10.822 10.822 0 0 1 4.346 3.819c2.099 3.11 2.633 5.712 2.487 9.563-.249 6.6-4.998 11.17-9.246 13.959m-7.457-27.341a8.66 8.66 0 0 1 1 1.014c2.877 3.421 3.1 8.478 2.41 11.281-1.035 4.213-2.427 6.029-5.846 8.549m-7.914-22.574c4.12 3.11 5.346 8.489 3.98 14.026-.975 3.957-3.463 6.328-6.565 8.217m17.385 64.187c.493 1.447 1.306 1.949 2.332 3.022a21.14 21.14 0 0 0 9.623 5.504c3.334.979 6.928.482 9.87-1.367M365.29 387.87c1.937-.035 3.869 1.273 5.133 3.468a5.09 5.09 0 0 1 .628 2.41 4.276 4.276 0 0 1-1.593 3.453c-2.245 1.43-6.232.815-6.065-3.15" class="B"/><path d="M377.33 336.4c7.703 1.438 15.119 10.729 17.546 20.865a46.03 46.03 0 0 1 .396 18.815 35.05 35.05 0 0 1-9.16 17.585 25.826 25.826 0 0 1-3.323 2.855l-1.643 1.113M368.76 378.67c3.164 0 5.934 3.032 5.934 6.273a5.926 5.926 0 0 1-1.615 4.085m-6.459-6.678a6.84 6.84 0 0 1 6.433 6.546 6.09 6.09 0 0 1-2.316 4.786"/><path d="M396.84 349.2c3.027 4.063 5.025 7.561 5.954 12.07m-.104 13.26a26.98 26.98 0 0 1-2.264 6.322 27.859 27.859 0 0 1-5.552 7.253" class="B"/><path d="M397.32 325.52a14.58 14.58 0 0 1 5.501 7.469"/><path d="M402.9 317.92c-.767 2.66-2.506 4.674-5.266 7.193M383.33 298.27l3.369-.886 1.994-1.508 1.285-1.817 1.108-2.837.444-2.305" class="B"/><path d="M376.51 286.41a20.24 20.24 0 0 0-3.824 1.333 13.97 13.97 0 0 0-5.506 4.576c-1.856 2.63-2.938 6.286-3.608 9.484a30.98 30.98 0 0 0 .252 10.41 24.628 24.628 0 0 0 3.601 8.807 14.292 14.292 0 0 0 1.621 2.087c2.022 2.021 3.888 3.265 6.997 2.643"/><path d="M395.38 271.58c-.546 2.007-1.625 4.493-4.774 4.221" class="B"/><path d="M383.87 285.2c-3.024-2.956-9.43-3.726-15.798.302a24.12 24.12 0 0 0-2.448 1.859 13.847 13.847 0 0 0-2.25 2.482 28.057 28.057 0 0 0-2.182 3.8 19.629 19.629 0 0 0-1.474 4.142 31.717 31.717 0 0 0-1.02 9.776c.176 1.513.32 2.903.567 4.182a29.13 29.13 0 0 0 3.475 9.656c1.407 2.333 4.906 7.69 12.058 8.397 2.811.278 7.612-1.01 7.768-4.665"/><path d="M568.38 220.42c.478-2.581 3.59-3.08 4.758-1.555 1.8 2.348.61 6.382-3.051 7.526a5.89 5.89 0 0 1-5.987-2.177 6.78 6.78 0 0 1 1.585-9.45l.281-.19c4.251-3.234 11.118-2.488 13.372 2.954 2.909 7.02-3.42 12.284-9.252 16.249-7.34 4.992-15.705 5.9-22.003 5.831-14.306-.156-25.19-6.997-32.265-10.884-1.648-.906-3.345-.72-4.198.31a3.117 3.117 0 0 0 .389 4.277M571.26 218a2.625 2.625 0 0 1 2.387 1.267c1.8 2.348.485 6.383-3.176 7.526m27.869 80.537c-5.45 5.933-.437 16.116 3.636 18.418 1.41 1.097 2.013.515 3.14 1.175" class="B"/><path d="M598.63 295.99c-1.788 1.244-2.418 2.642-2.488 5.07a8.196 8.196 0 0 0 2.203 6.272c2.972 3.092 8.786 5.784 14.42 5.855 3.35.097 6.645-.86 9.422-2.736a14.156 14.156 0 0 0 5.987-8.397M595.58 398.6a38 38 0 0 1-.212 3.887 32.805 32.805 0 0 1-9.795 19.671 30.679 30.679 0 0 1-9.097 6.375 38.43 38.43 0 0 1-10.263 3.42 52.317 52.317 0 0 1-10.73 1.322 74.53 74.53 0 0 1-9.909-.254c-4.127-.286-6.417-.86-10.538-1.223a83.34 83.34 0 0 0-8.743-.566 44.763 44.763 0 0 0-8.983.644 34.33 34.33 0 0 0-8.086 2.255c-4.198 1.7-8.941 4.664-9.952 5.986-1.01-1.322-5.754-4.286-9.952-5.986a34.403 34.403 0 0 0-8.085-2.255 44.767 44.767 0 0 0-8.984-.644 82.69 82.69 0 0 0-8.743.566c-4.121.362-6.41.937-10.538 1.223-3.294.306-6.605.39-9.91.254a52.444 52.444 0 0 1-10.728-1.321 38.43 38.43 0 0 1-10.263-3.421 30.66 30.66 0 0 1-9.097-6.375 32.812 32.812 0 0 1-9.796-19.671 37.952 37.952 0 0 1-.212-3.887V239.58h192.55V398.6h.066z"/></g></g><g class="J"><path d="M387.41 421.32a3.91 3.91 0 0 1 3.903-3.911 3.91 3.91 0 0 1 3.911 3.903v.009a3.91 3.91 0 0 1-3.911 3.903 3.91 3.91 0 0 1-3.903-3.903zm-23.99-27.61c0-1.932 1.236-3.499 2.76-3.499s2.76 1.567 2.76 3.499-1.236 3.499-2.76 3.499-2.76-1.567-2.76-3.499z" stroke="#c7b37f" class="E"/><path d="M377.05 324.36a2.674 2.674 0 0 1 5.33.4 2.673 2.673 0 0 1-2.665 2.472 2.775 2.775 0 0 1-2.665-2.873zm47.86-102.55a2.49 2.49 0 0 1 2.636-2.329 2.49 2.49 0 0 1 2.329 2.636 2.488 2.488 0 0 1-2.221 2.32 2.7 2.7 0 0 1-2.744-2.627z"/></g><g stroke="#c7b37f" class="C D"><path d="M373.92 340.54a3.884 3.884 0 0 0-2.138 2.208 6.36 6.36 0 0 0-.381 1.858m7.369 41.794 1.391-1.687a16.95 16.95 0 0 0 1.073-1.47c.344-.539.498-.867.801-1.43l1.05-2.06m-1.975 21.777-2.371 1.088-1.71 1.003-1.945 1.307-1.904 1.523m23.38-59.201-1.283-1.321-1.4-1.322c-.556-.469-.91-.683-1.492-1.12" class="B"/><path d="M397.17 326.47c-.618.319-1.254.602-1.905.848-.751.278-1.54.44-2.34.482"/><path d="M371 300.68c.173.787.391 1.563.653 2.325a12.18 12.18 0 0 0 1.446 2.666 13.05 13.05 0 0 0 1.99 2.457c.655.658 1.383 1.24 2.17 1.734.753.455 1.529.87 2.325 1.244m-1.544-9.156a19.32 19.32 0 0 0 1.944 1.042c.614.261 1.251.461 1.904.598a11.49 11.49 0 0 0 2.683.32 12.09 12.09 0 0 0 2.916-.234m11.203-63.526-3.196-1.866a19.074 19.074 0 0 1-2.923-2.371 14.607 14.607 0 0 1-1.811-2.022c-.563-.76-.778-1.257-1.275-2.06m11.715-7.111c.278.914.613 1.81 1.003 2.682a12.19 12.19 0 0 0 2.224 3.188c1.414 1.552 2.613 1.992 4.283 3.265m2.27-9.245c.28.824.612 1.629.995 2.41.364.68.799 1.318 1.299 1.905a11.468 11.468 0 0 0 2.099 2.06 22.796 22.796 0 0 0 2.939 1.75" class="B"/></g><g fill="#713f2a"><path d="M520.78 211.91c-.08-2.649-2.69-2.924-3.69-2.924-2.885 0-3.666 1.8-7.265 3.732-4.512 2.424-6.455 2.962-10.466 2.998-4.01-.036-6.005-.575-10.517-2.998-3.6-1.932-4.205-3.674-7.091-3.674a3.64 3.64 0 0 0-3.516 3.757l.003.075a6.48 6.48 0 0 0 .093 1.347c.047.204.296.14.374.32a3.64 3.64 0 0 1 .8-2.633 3.415 3.415 0 0 1 2.54-1.313c2.885 0 3.953 1.851 7.553 3.784 4.512 2.423 6.453 2.962 10.464 2.998 4.01-.036 6.007-.575 10.519-2.998 3.6-1.933 4.634-3.938 7.52-3.938a2.12 2.12 0 0 1 2.032 1.667 4.96 4.96 0 0 1 .14 1.293c.026.121.174.109.207.24a4.08 4.08 0 0 0 .3-1.733z" stroke-width=".277" class="H"/><path d="M413.12 434.42c.81-.872 1.423-.544 1.573-.946.11-.297-.13-.327-.46-.45-.44-.165-.906-.26-1.346-.424-.457-.17-.87-.405-1.327-.576-.189-.07-.625-.293-.75.04-.228.61 1.602.558.988 2.2a5.79 5.79 0 0 1-1.274 1.875l-4.141 4.507c-.093.104-.248.326-.342.29s-.082-.309-.083-.45l.06-6.39a8.468 8.468 0 0 1 .303-2.636c.275-.734 1.12-.119 1.297-.59.111-.298.026-.31-.477-.498-.252-.094-.734-.195-1.74-.571l-1.563-.664c-.236-.088-.672-.41-.828.01-.046.123.119.304.16.339.524.294.816.876.74 1.472l.114 11.635c.009.84.1 1.073.258 1.132.173.065.29-.011.633-.4l8.205-8.904v-.001z"/><path d="M417.95 436.22c.533-1.69 1.532-.671 1.723-1.276.067-.214-.001-.275-.482-.426l-2.088-.58-1.788-.642c-.144-.046-.527-.225-.623.077-.196.623 1.77.695 1.26 2.314l-2.693 8.542c-.533 1.69-1.54.864-1.736 1.486-.028.09-.036.224.109.27l1.816.494 2.412.839c.368.116.534.09.596-.106.18-.57-1.872-.316-1.182-2.505l2.676-8.487zm5.78 1.71c.318-1.073.817-.926 1.413-.75 1.626.483 2.135 2.073 1.616 3.827-.313 1.055-.706 2.028-3.153 1.303-.483-.143-1.079-.32-.946-.766l1.07-3.614zm-4.434 7.696c-.667 2.254-1.797 1.278-1.966 1.85-.106.358.248.404.425.457l2.5.663c.677.2 1.09.4 1.364.481.37.11.53.04.579-.12.19-.644-1.621-.383-1.054-2.297l.917-3.095c.185-.626.126-.78.979-.527.805.238 1.047.485 1.184 1.382l.515 3.227c.192 1.186.374 2.465 1.645 2.842.644.19 1.824.112 1.988-.443a.248.248 0 0 0-.149-.316c-.179-.054-.372.005-.533-.042a.617.617 0 0 1-.495-.458l-1.06-5.704c.053-.179.568-.201 1.156-.475a2.963 2.963 0 0 0 1.596-1.959c.244-.823.67-3.44-2.856-4.485l-3.274-.892-1.862-.63c-.193-.056-.381-.015-.434.164-.19.644 1.76.502 1.167 2.505l-2.332 7.872zm13.164 3.854c-.518 2.159-2.154.845-2.324 1.552-.096.4.186.448.48.519l2.303.476 2.269.622c.473.113.787.246.891-.19.122-.507-2.094-.483-1.558-2.715l1.968-8.2c.21-.87.395-.922 1.064-.761l1.388.333c1.895.378.889 2.267 1.542 2.423.425.102.415-.648.435-.874l.22-1.712c.028-.185.089-.44-.156-.498l-5.014-1.127-4.978-1.272c-.245-.06-.306.195-.366.372l-.836 2.332c-.09.228-.283.604.06.686.734.176.815-2.318 2.66-1.875l1.372.33c.669.16.81.29.601 1.161l-2.02 8.418h-.001zm19.84-5.06c.646-1 1.306-.782 1.385-1.204.057-.312-.184-.3-.53-.364-.463-.086-.939-.098-1.401-.184-.479-.089-.928-.248-1.406-.337-.198-.037-.667-.18-.732.168-.119.643 1.675.273 1.355 1.997a5.75 5.75 0 0 1-.93 2.067l-3.295 5.158c-.073.119-.187.364-.286.345s-.134-.29-.16-.428l-1.052-6.305a8.5 8.5 0 0 1-.158-2.648c.143-.77 1.083-.311 1.175-.807.057-.312-.029-.309-.557-.407-.264-.049-.756-.064-1.813-.26l-1.654-.382c-.248-.046-.732-.288-.814.152-.024.129.17.279.217.306.566.199.955.722.984 1.321l2.132 11.44c.155.825.286 1.039.451 1.07.182.034.285-.061.555-.505l6.534-10.193zm.93 10.51c.009.456-.032.6.363.78.848.496 1.756.884 2.702 1.152 2.169.362 3.967-1.02 4.37-3.43.391-2.338-.57-3.312-2.197-4.473-2.037-1.457-2.908-1.85-2.702-3.082a1.774 1.774 0 0 1 2.162-1.624c2.849.476 2.524 3.94 2.905 4.004.364.061.45-.151.486-.562l.23-2.496c.038-.429.134-.697-.115-.738-.215-.036-.679.19-.894.153-.496-.083-1.072-.917-2.43-1.144-1.938-.325-3.521 1-3.875 3.116-.324 1.932.533 2.813 1.84 3.75 2.448 1.753 3.452 2.167 3.19 3.731a2.235 2.235 0 0 1-2.68 1.973c-1.838-.308-2.585-2.154-2.82-4.01-.025-.25-.03-.42-.296-.465-.414-.069-.337.492-.33.758l.091 2.607zm24.72-6.97c.538-1.062 1.217-.915 1.251-1.343.025-.316-.214-.279-.566-.306-.468-.037-.943 0-1.412-.036-.485-.038-.948-.15-1.433-.188-.201-.016-.682-.11-.71.243-.051.651 1.694.096 1.556 1.845a5.77 5.77 0 0 1-.708 2.152l-2.739 5.474c-.06.126-.148.381-.248.374s-.164-.275-.204-.41l-1.704-6.16a8.466 8.466 0 0 1-.435-2.617c.062-.78 1.044-.423 1.084-.925.024-.316-.06-.304-.596-.346-.268-.02-.76.016-1.83-.07l-1.685-.207c-.251-.02-.759-.21-.794.237-.011.13.199.26.247.282a1.476 1.476 0 0 1 1.118 1.21l3.316 11.154c.24.805.393 1.004.56 1.017.184.014.277-.091.499-.56l5.433-10.82z"/><path d="M480.6 457c-.016 1.903-1.626 1.553-1.632 2.3-.002.317.334.226.519.228l1.444-.062 1.98.092c.22 0 .639.024.64-.237.008-.877-2.152.373-2.12-3.21l.055-6.342c0-.168.036-.299.137-.298.084 0 .183.095.3.245l7.992 9.772a.493.493 0 0 0 .434.265c.202 0 .203-.147.206-.558l.092-10.466c.015-1.958 1.44-1.498 1.445-2.058 0-.056.002-.243-.317-.245-.15 0-.74.068-1.797.059l-1.914-.091c-.218 0-.27.184-.271.314-.005.616 2.046.298 2.03 1.996l-.053 6.213c-.005.466-.04.69-.14.689s-.3-.227-.517-.49l-6.678-8.286c-.3-.358-.097-.486-.634-.491-.89-.01-1.327.063-1.764.059-.319 0-.62-.08-.94-.083a.282.282 0 0 0-.29.274c0 .014 0 .027.002.041-.009.895 1.884-.301 1.852 3.281l-.061 7.09V457zm16.26-8.4c.016-1.772 1.27-1.09 1.274-1.724.002-.224-.08-.262-.585-.267-.957-.01-1.562.061-2.166.056-.588 0-1.242-.086-1.897-.09-.151-.002-.57-.062-.573.256-.005.653 1.802.147 1.788 1.845l.015 8.955c-.015 1.772-1.22 1.277-1.225 1.93-.001.093.031.224.182.225.437.01 1.16-.064 1.882-.058l2.55.097c.387 0 .539-.07.54-.275.006-.597-1.882.245-1.862-2.05l.077-8.9zm7.04 8.67c.02 2.22-1.886 1.341-1.88 2.069.006.41.29.39.592.386l2.35-.095 2.351.054c.487 0 .824.05.82-.399-.005-.522-2.15.037-2.17-2.257l-.073-8.433c-.007-.895.16-.99.848-.996l1.427-.011c1.93-.091 1.411 1.984 2.083 1.978.436 0 .245-.73.21-.953l-.2-1.715c-.018-.187-.02-.448-.273-.446l-5.137.12c-2.452.02-3.577-.044-5.139-.03-.252 0-.25.263-.265.45l-.247 2.465c-.031.243-.128.654.224.651.756-.01.231-2.446 2.128-2.462l1.41-.014c.69-.01.858.086.866.98l.075 8.658zm9.78-3.53c-.301.024-.534.061-.549-.125a1.91 1.91 0 0 1 .13-.703l1.03-3.393c.067-.212.133-.236.166-.238.084-.01.034 0 .146.138l1.638 3.259a1.92 1.92 0 0 1 .238.673c.013.186-.221.186-.523.21l-2.276.179zm2.874.784c.436-.034.534.146 1.2 1.553a3.5 3.5 0 0 1 .4 1.222c.09 1.135-1.115 1.024-1.073 1.563.02.26.236.206.537.183l1.835-.22 2.166-.096c.452-.035.605-.01.58-.326-.048-.614-.895.183-1.535-1.096l-5.415-11.028c-.262-.54-.298-.575-.449-.563-.217.018-.273.377-.367.684l-3.651 11.61c-.336 1.074-1.199 1.03-1.165 1.458.02.242.284.183.518.165.485-.038.965-.151 1.467-.19l1.58-.05c.351-.028.88.062.85-.329-.04-.502-1.824-.062-1.93-1.401.013-.507.093-1.01.236-1.497.288-1.258.634-1.36.919-1.382l3.298-.26h-.001zm12.976-7.734c-.168-1.276-.104-1.304 1.91-1.569 3.213-.423 2.2 1.912 2.982 1.81.383-.05.22-.65.171-.889l-.307-1.822a.343.343 0 0 0-.373-.309l-3.793.575-4.438.509a.332.332 0 0 0-.326.337l.001.026c.098.74 1.901-.1 2.12 1.564l1.14 8.658c.297 2.256-1.1 1.424-.988 2.275.016.111.127.19.343.162l2.122-.355 1.99-.186c.417-.055.776-.027.727-.397-.065-.5-1.885.21-2.156-1.843l-.36-2.738c-.142-1.073-.237-1.286.528-1.387l1.232-.162c1.732-.228 1.524 1.795 2.056 1.724.4-.053.212-.705.164-.943l-.55-3.277c-.082-.498-.26-.437-.377-.421-.333.044-.159 1.752-1.59 1.94l-1.05.139c-.715.094-.732-.035-.837-.831l-.34-2.59h-.001zm6.14 4.24c.69 3.724 3.378 5.787 6.697 5.172 5.267-.976 5.44-5.657 4.965-8.225-.721-3.89-3.62-5.8-6.833-5.166-3.939.767-5.574 4.201-4.829 8.219zm1.837-1.422c-.493-2.66-.137-5.345 2.643-5.917 2.123-.431 4.532 1.323 5.283 5.378.565 3.045.096 5.675-2.734 6.256-2.945.603-4.696-3.039-5.192-5.717zm13.023-6.498c-.261-1.089.245-1.21.849-1.355 1.65-.396 2.886.727 3.313 2.505.257 1.07.403 2.11-2.08 2.705-.49.118-1.093.263-1.202-.19l-.88-3.665zm.009 8.882c.549 2.286-.917 2.004-.778 2.585.087.363.417.226.596.183l2.498-.676c.685-.165 1.143-.198 1.421-.265.376-.09.48-.23.44-.393-.156-.654-1.594.478-2.06-1.463l-.753-3.138c-.153-.635-.281-.739.584-.947a1.356 1.356 0 0 1 1.717.605l2.06 2.537c.758.931 1.555 1.949 2.845 1.64.653-.158 1.635-.816 1.5-1.378a.246.246 0 0 0-.286-.199l-.02.004c-.163.039-.3.187-.464.226a.62.62 0 0 1-.657-.149l-3.77-4.41c-.044-.181.39-.458.764-.99a2.96 2.96 0 0 0 .403-2.494c-.2-.835-1.141-3.314-4.717-2.456l-3.281.864-1.928.386c-.196.047-.337.177-.294.359.157.653 1.776-.446 2.264 1.586l1.916 7.983zm13.471-3.012c.556 2.15-1.505 1.758-1.323 2.462.102.398.374.308.667.232l2.257-.66 2.295-.517c.471-.122.81-.152.698-.585-.13-.506-2.076.556-2.65-1.666l-2.112-8.164c-.224-.867-.085-1 .581-1.172l1.382-.358c1.851-.555 1.85 1.584 2.5 1.416.422-.11.061-.767-.027-.976l-.609-1.615c-.063-.177-.128-.43-.372-.367l-4.956 1.36-4.993 1.214c-.244.063-.179.316-.148.5l.356 2.452c.029.243.034.666.375.577.732-.189-.368-2.429 1.469-2.904l1.365-.353c.667-.172.853-.124 1.077.743l2.168 8.381zm8.59-11.46c-.474-1.708.92-1.397.75-2.009-.06-.215-.15-.229-.636-.095l-2.068.651-1.848.435c-.146.04-.565.098-.48.405.174.629 1.863-.382 2.316 1.254l2.394 8.63c.474 1.708-.821 1.564-.647 2.193.025.09.093.207.238.167l1.793-.575 2.48-.61c.371-.103.497-.215.442-.413-.16-.576-1.742.754-2.356-1.458l-2.378-8.575zm3.58 4.17c1.202 3.592 4.15 5.261 7.352 4.19 5.08-1.7 4.6-6.36 3.771-8.836-1.255-3.751-4.391-5.24-7.485-4.166-3.793 1.31-4.934 4.937-3.638 8.812zm1.621-1.664c-.858-2.565-.879-5.273 1.794-6.227 2.043-.723 4.672.68 5.98 4.59.983 2.937.885 5.606-1.836 6.576-2.833 1.006-5.074-2.356-5.938-4.939zm11.919-8.466c-.41-1.041.074-1.232.652-1.46 1.578-.622 2.96.318 3.63 2.02.403 1.024.692 2.033-1.683 2.968-.469.185-1.047.412-1.218-.023l-1.381-3.506v.001zm1.245 8.794c.861 2.187-.63 2.113-.411 2.669.136.347.444.166.616.098l2.378-1.017c.657-.259 1.106-.355 1.371-.46.36-.142.444-.295.382-.452-.246-.625-1.512.697-2.244-1.16l-1.183-3.004c-.24-.608-.38-.692.447-1.018a1.354 1.354 0 0 1 1.784.36l2.393 2.225c.881.816 1.812 1.713 3.046 1.227.625-.246 1.506-1.034 1.294-1.572a.246.246 0 0 0-.31-.158l-.02.007c-.157.062-.272.227-.428.289a.62.62 0 0 1-.672-.056l-4.347-3.843c-.068-.173.323-.508.62-1.085.392-.793.41-1.719.05-2.527-.314-.8-1.59-3.123-5.012-1.776l-3.129 1.313-1.855.65c-.188.075-.31.222-.241.396.246.625 1.696-.688 2.462 1.256l3.009 7.638z"/></g><path d="M412.66 249.25h82.179v82.023H412.66V249.25z" class="G"/><path d="M451.2 313.83a20.15 20.15 0 0 1-.855 5.287c-.933 2.721-.94 2.721-1.796 4.043a13.133 13.133 0 0 1-3.81 3.887 9.42 9.42 0 0 1-5.948 1.71c-5.49-.486-8.038-6.44-9.283-11.273-1.321-5.13-5.073-7.923-7.463-6.064-1.4 1.089-1.479 2.914-.311 4.665a9.01 9.01 0 0 0 4.099 2.8l-2.933 3.731a9.18 9.18 0 0 1-7.535-7.393c-.466-2.488.742-7.134 4.891-8.522 5.297-1.774 8.686 2.004 10.318 5.191 2.246 4.384 3.21 12.434 9.43 11.19 3.384-.677 4.976-5.598 4.976-7.852l2.467-2.644 3.654 1.167.099.078v-.001zm5.12 0a20.15 20.15 0 0 0 .855 5.287c.933 2.721.94 2.721 1.796 4.043a13.133 13.133 0 0 0 3.81 3.887 9.42 9.42 0 0 0 5.948 1.71c5.49-.486 8.038-6.44 9.283-11.273 1.321-5.13 5.073-7.923 7.463-6.064 1.4 1.089 1.479 2.914.311 4.665a9.01 9.01 0 0 1-4.099 2.8l2.933 3.731a9.18 9.18 0 0 0 7.535-7.393c.466-2.488-.742-7.134-4.891-8.522-5.297-1.774-8.686 2.004-10.318 5.191-2.246 4.384-3.21 12.434-9.43 11.19-3.384-.677-4.976-5.598-4.976-7.852l-2.467-2.644-3.654 1.167-.099.078v-.001z" fill="#fff"/><path d="m461.12 278.95 10.76-11.643a4.69 4.69 0 0 0 1.61-3.401l-2.219.345-.497-1.142-.11-1.147 2.981-.63c.048-.484.007-.85.092-1.384.08-.494.19-.76.311-1.244l-3.265.218c.166-.571.128-.875.31-1.406a4.04 4.04 0 0 1 .504-1.103l1.907-.304c.728-.073 1.143-.04 1.873-.085 1.781-3.321 9.19-6.373 14.454-.904 3.81 3.958 2.988 11.219-1.95 13.139a6.32 6.32 0 0 1-6.862-1.11l1.97-3.866c2.722 1.625 4.976-.396 4.821-2.495a4.58 4.58 0 0 0-4.354-4.51c-2.254-.197-3.872 1.093-4.898 3.11-.626 1.231-.336 2.134-.544 3.5a23.92 23.92 0 0 1-.537 3.809 8.76 8.76 0 0 1-2.37 3.592l-11.03 11.935-42.941 46.445-3.227-2.983 43.211-46.737v.001z" class="F"/><path d="M429.51 283.04s2.7 13.372 11.874 33.431c4.665-1.71 7.42-2.8 12.362-2.8s7.697.934 12.362 2.8c9.174-20.059 11.874-33.431 11.874-33.431l-24.236-31.177-24.236 31.177z" fill="#fff"/><path d="m456.12 262.41 16.82 21.637s-2.243 10.52-9.078 26.354a47.33 47.33 0 0 0-7.733-1.32l-.009-46.67v-.001zm-4.74 0-16.82 21.637s2.243 10.52 9.078 26.354a47.33 47.33 0 0 1 7.733-1.32l.009-46.67v-.001zm52.22-13.16h82.179v82.023H503.6V249.25z" class="F"/><path d="M515.11 249.25h12.253v82.023H515.11V249.25zm23.48 0h12.253v82.023H538.59V249.25zm23.48 0h12.253v82.023H562.07V249.25z" class="G"/><path d="M412.97 402.41a20.76 20.76 0 0 0 2.163 6.609c1.477 2.332.932 2.269 4.276 6a23.918 23.918 0 0 0 6.227 4.495 26.955 26.955 0 0 0 6.842 2.496 50.943 50.943 0 0 0 16.574 1.598 98.46 98.46 0 0 0 10.249-1.062 108.8 108.8 0 0 1 11.118-1.01c2.133-.09 4.149-.11 6.142 0 2.457.162 4.899.499 7.308 1.01a79.67 79.67 0 0 1 10.962 3.188l.014-85.655-82.193-.023V398.6s.168 2.86.318 3.81z" class="F"/><path d="m422.51 417.43 3.852 2.241 5.278 1.9-.005-81.528h-9.126l.001 77.387zm45.66 3.71.011-81.099h-9.143v82.396l9.131-.988.001-.309zm18.24-81.09h-9.113v81.381a60.43 60.43 0 0 1 9.13 1.683l-.017-83.064zm-36.49 0v83.331a80.663 80.663 0 0 1-9.173-.003l.002-83.314 9.171-.014z" stroke="#d52b1e" class="E G"/><path d="M585.48 402.39a20.728 20.728 0 0 1-2.163 6.608c-1.477 2.333-.932 2.27-4.275 6.001a23.963 23.963 0 0 1-6.228 4.495 26.91 26.91 0 0 1-6.841 2.495 50.95 50.95 0 0 1-16.574 1.599 98.69 98.69 0 0 1-10.25-1.062 108.633 108.633 0 0 0-11.117-1.01c-2.133-.09-4.15-.11-6.142 0a51.47 51.47 0 0 0-7.309 1.01 82.42 82.42 0 0 0-11.033 3.188l.057-85.655 82.193-.023v58.543s-.168 2.86-.318 3.81v.001z" class="F"/><use xlink:href="#B" class="G"/><g stroke="#fedf00"><use xlink:href="#C" class="B C D"/><use xlink:href="#D" class="E I"/><g class="C D"><use xlink:href="#E" class="B"/><path d="m560.12 369.78.384-.249a8.149 8.149 0 0 0 2.686-1.79"/><g class="B"><path d="M552.38 368.02h.007c3.533-.883 5.885-2.648 7.579-2.869"/><use xlink:href="#F"/></g></g><use xlink:href="#G" class="E I"/></g><path d="M525.13 364.17a15.473 15.473 0 0 1-1.966-.826c.323-.25.587-.265.863-.555.39-.408.373-.788.593-1.319.215-.52.184-.954.671-1.343.329-.22.74-.281 1.118-.165.389.106.703.39.848.766.137.561-.16.886-.246 1.454-.155.47-.221.965-.195 1.46a6.07 6.07 0 0 0 .354.907 15.3 15.3 0 0 1-2.04-.38v.001zm-.99.95a.625.625 0 1 1 1.252-.014.626.626 0 0 1-1.252.018v-.004zm-1.76-16.51-.144-.104c-.383-.31-.42-.653-.601-1.11a4.093 4.093 0 0 1-.315-1.154 7.331 7.331 0 0 1 0-1.048c.02-.314.02-.63 0-.944a2.172 2.172 0 0 0-.21-.944c-.097-.18-.394-.337-.314-.42.094-.096.257-.02.42 0a1.64 1.64 0 0 1 .943.42c.338.262.576.632.672 1.049l.407 1.468c.058.257.154.505.284.734a4.27 4.27 0 0 0 .524.629l-.011.023a9.012 9.012 0 0 1-.777.834c-.261.22-.544.412-.846.573l-.033-.01.001.004zm3.6 10.64 2.23 1.031a9.23 9.23 0 0 0 3.497-3.919 13.839 13.839 0 0 0 1.364-4.313l-1.789-.581-.357.073a15.655 15.655 0 0 1-1.618 4.192 11.63 11.63 0 0 1-2.649 3.034l-.678.483zm4.94 18.12c.282-.439.59-.861.922-1.264a12.73 12.73 0 0 1 1.312-1.15c.163-.011.327.014.48.071a8.677 8.677 0 0 1-.526 2.751 3.48 3.48 0 0 1-.39.979 4.15 4.15 0 0 1-.476.518c-.51-.742-1.33-1.297-1.322-1.906v.001zm33.01 1.85a7.51 7.51 0 0 1 2.936 1.482c.055.155.076.319.063.483a9.05 9.05 0 0 1-1.53.251 8.39 8.39 0 0 1-1.259 0 3.46 3.46 0 0 1-1.048-.105 4.3 4.3 0 0 1-.63-.314c.573-.696.88-1.637 1.468-1.797zm-9.76-2.04a7.53 7.53 0 0 1 2.936 1.482 1.16 1.16 0 0 1 .063.482 8.95 8.95 0 0 1-1.53.252 8.4 8.4 0 0 1-1.259 0 3.46 3.46 0 0 1-1.048-.105 4.3 4.3 0 0 1-.63-.314c.573-.696.88-1.637 1.468-1.797zm-17.34 2.13a13.02 13.02 0 0 1 1.469.538 13.16 13.16 0 0 1 1.468.944 1.2 1.2 0 0 1 .063.483 9.08 9.08 0 0 1-1.531.251 8.38 8.38 0 0 1-1.258 0 3.433 3.433 0 0 1-1.049-.105 4.252 4.252 0 0 1-.63-.314c.573-.696.88-1.637 1.468-1.797zm-8.98-29.8c-.613-.278-1.05-1.045-.66-1.594.155-.22.412-.174.565-.395.144-.254.192-.552.136-.839a5.22 5.22 0 0 0-.21-.944 5.007 5.007 0 0 1-.135-1.048 2.25 2.25 0 0 1 .345-1.573c.211-.279.497-.491.825-.612.147.136-.057.502-.033.822a3.83 3.83 0 0 0 .288 1.153c.202.563.479.809.703 1.363a3.58 3.58 0 0 1 .42 1.363 2.29 2.29 0 0 1-.21 1.154 2.007 2.007 0 0 1-.61.839 1.85 1.85 0 0 1-.796.419 1.15 1.15 0 0 1-.628-.108z" fill="#005eb8"/><use xlink:href="#B" y="36.591" class="G"/><g stroke="#fedf00"><use xlink:href="#C" y="36.591" class="B C D"/><use xlink:href="#D" y="36.591" class="E I"/><g class="C D"><use xlink:href="#E" y="36.591" class="B"/><path d="m560.12 406.371.384-.249a8.149 8.149 0 0 0 2.686-1.79"/><g class="B"><path d="M552.38 404.611h.007c3.533-.883 5.885-2.648 7.579-2.869"/><use xlink:href="#F" y="36.591"/></g></g><use xlink:href="#G" y="36.591" class="E I"/></g><path d="M525.13 400.761a15.473 15.473 0 0 1-1.966-.826c.323-.25.587-.265.863-.555.39-.408.373-.788.593-1.319.215-.52.184-.954.671-1.343.329-.22.74-.281 1.118-.165.389.106.703.39.848.766.137.561-.16.886-.246 1.454-.155.47-.221.965-.195 1.46a6.07 6.07 0 0 0 .354.907 15.3 15.3 0 0 1-2.04-.38v.001zm-.99.95a.625.625 0 1 1 1.252-.014.626.626 0 0 1-1.252.018v-.004zm-1.76-16.51-.144-.104c-.383-.31-.42-.653-.601-1.11a4.093 4.093 0 0 1-.315-1.154 7.331 7.331 0 0 1 0-1.048c.02-.314.02-.63 0-.944a2.172 2.172 0 0 0-.21-.944c-.097-.18-.394-.337-.314-.42.094-.096.257-.02.42 0a1.64 1.64 0 0 1 .943.42c.338.262.576.632.672 1.049l.407 1.468c.058.257.154.505.284.734a4.27 4.27 0 0 0 .524.629l-.011.023a9.012 9.012 0 0 1-.777.834c-.261.22-.544.412-.846.573l-.033-.01.001.004zm3.6 10.64 2.23 1.031a9.23 9.23 0 0 0 3.497-3.919 13.839 13.839 0 0 0 1.364-4.313l-1.789-.581-.357.073a15.655 15.655 0 0 1-1.618 4.192 11.63 11.63 0 0 1-2.649 3.034l-.678.483zm4.94 18.12c.282-.439.59-.861.922-1.264a12.73 12.73 0 0 1 1.312-1.15c.163-.011.327.014.48.071a8.677 8.677 0 0 1-.526 2.751 3.48 3.48 0 0 1-.39.979 4.15 4.15 0 0 1-.476.518c-.51-.742-1.33-1.297-1.322-1.906v.001zm33.01 1.85a7.51 7.51 0 0 1 2.936 1.482c.055.155.076.319.063.483a9.05 9.05 0 0 1-1.53.251 8.39 8.39 0 0 1-1.259 0 3.46 3.46 0 0 1-1.048-.105 4.3 4.3 0 0 1-.63-.314c.573-.696.88-1.637 1.468-1.797zm-9.76-2.04a7.53 7.53 0 0 1 2.936 1.482 1.16 1.16 0 0 1 .063.482 8.95 8.95 0 0 1-1.53.252 8.4 8.4 0 0 1-1.259 0 3.46 3.46 0 0 1-1.048-.105 4.3 4.3 0 0 1-.63-.314c.573-.696.88-1.637 1.468-1.797zm-17.34 2.13a13.02 13.02 0 0 1 1.469.538 13.16 13.16 0 0 1 1.468.944 1.2 1.2 0 0 1 .063.483 9.08 9.08 0 0 1-1.531.251 8.38 8.38 0 0 1-1.258 0 3.433 3.433 0 0 1-1.049-.105 4.252 4.252 0 0 1-.63-.314c.573-.696.88-1.637 1.468-1.797zm-8.98-29.8c-.613-.278-1.05-1.045-.66-1.594.155-.22.412-.174.565-.395.144-.254.192-.552.136-.839a5.22 5.22 0 0 0-.21-.944 5.007 5.007 0 0 1-.135-1.048 2.25 2.25 0 0 1 .345-1.573c.211-.279.497-.491.825-.612.147.136-.057.502-.033.822a3.83 3.83 0 0 0 .288 1.153c.202.563.479.809.703 1.363a3.58 3.58 0 0 1 .42 1.363 2.29 2.29 0 0 1-.21 1.154 2.007 2.007 0 0 1-.61.839 1.85 1.85 0 0 1-.796.419 1.15 1.15 0 0 1-.628-.108z" fill="#005eb8"/><path d="M412.66 249.25h82.179v82.023H412.66V249.25zm90.94 0h82.179v82.023H503.6V249.25zm-90.63 153.16a20.76 20.76 0 0 0 2.163 6.609c1.477 2.332.932 2.269 4.276 6a23.918 23.918 0 0 0 6.227 4.495 26.955 26.955 0 0 0 6.842 2.496 50.943 50.943 0 0 0 16.574 1.598 98.46 98.46 0 0 0 10.249-1.062 108.8 108.8 0 0 1 11.118-1.01c2.133-.09 4.149-.11 6.142 0 2.457.162 4.899.499 7.308 1.01a79.67 79.67 0 0 1 10.962 3.188l.014-85.655-82.193-.023V398.6s.168 2.86.318 3.81zm172.51-.02a20.728 20.728 0 0 1-2.163 6.608c-1.477 2.333-.932 2.27-4.275 6.001a23.963 23.963 0 0 1-6.228 4.495 26.91 26.91 0 0 1-6.841 2.495 50.95 50.95 0 0 1-16.574 1.599 98.69 98.69 0 0 1-10.25-1.062 108.633 108.633 0 0 0-11.117-1.01c-2.133-.09-4.15-.11-6.142 0a51.47 51.47 0 0 0-7.309 1.01 82.42 82.42 0 0 0-11.033 3.188l.057-85.655 82.193-.023v58.543s-.168 2.86-.318 3.81v.001z" stroke-width=".797" class="C H"/><defs><path id="B" d="m524.62 346.91-.594.281a8.45 8.45 0 0 1-.781.813 12.25 12.25 0 0 1-1.25.843c-.22.113-.421.261-.594.438-.252.32-.079.63-.25 1a3.68 3.68 0 0 1-.656.938c-.332.356-.687.69-1.063 1a4.973 4.973 0 0 1-1.093 1 1.77 1.77 0 0 1-.344.187c-.216.067-.35-.011-.563.062-.388.134-.51.563-.78.719.111.218.106.372.218.594.158.323.705 1.215.812 1.437.21.305.27.7.532.781a3.1 3.1 0 0 0 1.312.125 10.76 10.76 0 0 1 2.031.469c.613.254.863.575 1.47.844.406.201.836.348 1.28.437.326.087.664.119 1 .094.25-.024.377-.12.625-.156a.52.52 0 0 1 .125 0l-.03.375c-.006 0 .004.028 0 .031v.062h.062l2.062.906c-.24.358-.33.796-.25 1.219.63 1.888 1.16 3.069 1.469 3.188.615.236.806.865 1.156 1.5-.123.132-.227.2-.344.312a8.998 8.998 0 0 0-1.656 1.813c-.745 1.188-1.248 1.203-.312 2.78.549.926.814 1.1 1.53 2.407a8.16 8.16 0 0 1 .782 1.969 7.64 7.64 0 0 1 .313 1.969l.968.375.657-.657.625-1.187.03-.906a.775.775 0 0 1-.25-.782c.07-.368.515-.29.72-.625.283-.461-.332-.734-.657-1.093-.605-.67-1.43-.833-1.625-1.844-.052-.273.078-.427.375-.719l1.97-1.812a1.46 1.46 0 0 0 .968.125c.28-.053.53.125 1.406.375a2.21 2.21 0 0 0 1.219.03l.375-.093a3.5 3.5 0 0 1 .125.687c.053 1.06-.155 2.995.156 3.5a3.29 3.29 0 0 1 .281.563 1.69 1.69 0 0 1 .22.656v1.875a15.2 15.2 0 0 1-.22 1.75 2.02 2.02 0 0 1-.437 1.062c-.283.364-.595.418-.969.688l-.093 1 1.125.469 1.28.312.688-.281a1.18 1.18 0 0 1 .156-.625c.128-.247.232-.439.47-.531.362-.143.759.129.905-.094.16-.242.06-.338.032-.75-.046-.662-.184-.99-.282-1.657a11.8 11.8 0 0 1-.156-2.75 9.4 9.4 0 0 1 .156-1.562c.172-.883.486-1.311.688-2.188a21.53 21.53 0 0 0 .375-2.468c3.11.48 6.283.353 9.344-.375.169-.037.75-.25.75-.25a8.64 8.64 0 0 0 2.718 1.625c-.006.101-.015.845 0 .968.037.288-.04.482.125.72a.583.583 0 0 0 .375.28.66.66 0 0 0 .657-.156c.226-.201.184-.454.25-.75a3.94 3.94 0 0 0 0-.687c.289.049.582.069.875.062.292.012.585.002.875-.031l.03.468c.028.245-.075.435.032.657.082.215.273.37.5.406a.66.66 0 0 0 .531-.094c.296-.185.264-.498.313-.844.015-.11.011-.692 0-.781l1.031-.375a5.12 5.12 0 0 1-.094.812 5.01 5.01 0 0 1-.25.938 7.2 7.2 0 0 1-.75 1.375c-.301.547-.646 1.07-1.03 1.562l-.563.657c-.256.337-.342.566-.594.906a4.67 4.67 0 0 1-.938 1.062c-.693.55-1.15.11-2.093.844l-.22 1.031 1.438.532 1.282.25.437-.25a1.01 1.01 0 0 1 .219-.75c.191-.24.475-.388.781-.407.361-.059.747.034 1.031-.218.35-.311.349-.914.625-1.47a12.671 12.671 0 0 1 3-3.905c.613-.597 1.138-.758 1.657-1.438.246-.322.52-.469.53-.875.009-.283-.143-.415-.218-.687a9.62 9.62 0 0 1-.187-1c1.521.744.97.646 1.25 1.406.225.615-.033 1.04.062 1.687.111.756.466 1.114.531 1.875a7.42 7.42 0 0 1-.312 2.313 7.14 7.14 0 0 1-.469 2 3.84 3.84 0 0 1-1.156 1.562c-.211.175-.369.25-.594.407l-.125 1.03 1.125.376 1.625.437.375-.343c.164-.655-.055-1.617.406-1.688.406-.062.693 0 .782-.312a5.01 5.01 0 0 0 .093-.625l.625-4.5.407-1.907c.06-.578.197-1.145.406-1.687.734-2.097-.208-2.375-1.063-3.656a2.992 2.992 0 0 1-.687-1.5c-.097-.817.164-1.495.125-2.75v-2.875c.115-.053.222-.121.344-.188a4.08 4.08 0 0 0 2.375-2.469 3.43 3.43 0 0 0 .312-1.468c-.005-.332-.065-.652-.094-1.032a2.76 2.76 0 0 0-.312-.937 3.192 3.192 0 0 0-.563-.844 5.443 5.443 0 0 0-2.718-1.469 13.91 13.91 0 0 0-4.125-.562 26.85 26.85 0 0 0-4.282-.062c-2.006.114-3.128.519-5.125.75a43.35 43.35 0 0 1-4.906.406c-2.26.042-4.42-.46-5.781-.344-2.451.21-2.493.762-6.188 1.063l-3.843.187-2.157-.687a2.425 2.425 0 0 0 1.47-1.031c.271-.366.232-.679.562-1.063.266-.312.443-.622.78-.969a2.2 2.2 0 0 0-.937-.437 2.502 2.502 0 0 0-.937 0c-.425.031-.84.148-1.219.344a2.77 2.77 0 0 0-.844.593 19.624 19.624 0 0 0-2.187-1.218 9.178 9.178 0 0 0-3-.907v.002zm1.969 11.906h.062c-.012.01-.019.022-.03.031l-.032-.031z"/><path id="C" d="m568.77 359.52-.763.244a6.792 6.792 0 0 1-2.6.496c-2.644.202-4.272-1.057-6.998-.847-1.404.108-2.025 1.19-3.46 1.548a9.237 9.237 0 0 1-1.701.282l.512-1.034c-.697.143-1.404.231-2.115.264a7.55 7.55 0 0 1-1.523-.13l1.018-.95a7.219 7.219 0 0 1-1.294-.336 3.923 3.923 0 0 1-1.06-.63l1.69-.353c1.556-.385 2.04-1.147 3.89-1.325 1.15-.111 3.032-.046 7.643.717 3.036.502 4.382.267 5.536-.258a2 2 0 0 0 1.103-1.788 2.14 2.14 0 0 0-.874-1.81 1.74 1.74 0 0 0-1.113-.363"/><path id="D" d="M524.8 350.61a1.84 1.84 0 0 0-1.34.291c-.48.296-.541.697-.888 1.142.445.1.699.361 1.142.254.306-.074.575-.253.761-.507a1.55 1.55 0 0 0 .428-1.156l-.103-.024z"/><path id="E" d="m536.04 363.79.407.8c.224.47.4.961.524 1.467.117.695.197 1.395.24 2.098l.077.376-.05 1.129m6.802-6.95-.354 1.333-.944 3.46-.103.644m-10.859-3.977c.79.176.544 3.36 1.789 4.09"/><path id="F" d="M555.97 363.61a8.14 8.14 0 0 0 .83-.068c1.467-.21 1.703.687 2.725 1.258 1.857 1.039 2.098 2.307 4.3 3.356l.32.155.848.429"/><path id="G" d="M517.7 354.53c.23.064.47.083.707.054.332-.031.484-.238.817-.249a.965.965 0 0 1 .684.125.83.83 0 0 1 .28.342c.101.133.145.3.124.466a.576.576 0 0 1-.614.42.55.55 0 0 1-.544-.272.47.47 0 0 1-.039-.389 1.167 1.167 0 0 1-1.415-.497z"/></defs></svg>'
]

{ #category : #accessing }
ToSandBox class >> pathPendingWorkSVG [

	<sampleInstance>
	^ '<?xml version="1.0" encoding="utf-8"?><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 122.88 122.77" xml:space="preserve"><g><path class="st0" d="M92.45,8.98c-1.35-0.94-2.88-1.35-4.44-1.04c-1.56,0.31-2.88,1.15-3.82,2.46l-5.27,7.43 c-1.87-0.83-3.82-1.46-5.9-1.98s-4.03-0.94-6.11-1.25l-1.67-9.72C64.94,3.21,64.09,2,62.89,1.06c-1.35-0.94-2.78-1.25-4.44-0.94 L46.26,2.31c-1.56,0.31-2.78,1.04-3.82,2.39c-0.94,1.35-1.35,2.78-1.04,4.44l1.56,8.88c-1.98,0.83-3.82,1.77-5.59,2.88 c-1.77,1.04-3.5,2.29-5.07,3.5l-8.26-5.69c-1.35-0.94-2.78-1.35-4.34-1.04c-1.56,0.31-2.88,1.15-3.82,2.5L8.85,30.22 c-0.94,1.35-1.35,2.88-1.04,4.44c0.31,1.67,1.15,2.88,2.5,3.82l7.43,5.27c-0.83,1.87-1.46,3.82-1.98,5.9 c-0.52,2.08-0.94,4.03-1.25,6.11L4.8,57.42c-8.24,1.55-3.58,13.36-2.57,18.98c0.31,1.56,1.04,2.78,2.36,3.82 c1.35,0.94,2.78,1.35,4.44,1.04l8.88-1.56c0.83,1.98,1.77,3.82,2.88,5.59c1.04,1.77,2.29,3.5,3.5,5.17l-5.69,8.16 c-0.94,1.35-1.35,2.78-1.04,4.34c0.31,1.56,1.14,2.88,2.46,3.82l10.13,7.11c1.35,0.94,2.88,1.25,4.44,0.94 c1.56-0.31,2.88-1.04,3.92-2.36l5.28-7.53c1.87,0.83,3.82,1.46,5.9,1.98c2.08,0.52,4.02,0.94,6.11,1.25l1.67,9.72 c0.31,1.67,1.15,2.88,2.36,3.82c1.35,0.94,2.78,1.25,4.44,0.94l12.18-2.19c1.56-0.31,2.78-1.04,3.82-2.36 c0.94-1.35,1.35-2.78,1.04-4.44l-1.56-8.88c1.98-0.83,3.82-1.77,5.59-2.88c1.77-1.04,3.51-2.26,5.17-3.5l8.16,5.69 c1.35,0.94,2.78,1.35,4.44,1.04c1.67-0.31,2.88-1.15,3.82-2.46l7.11-10.14c0.94-1.35,1.25-2.88,0.94-4.44s-1.04-2.88-2.39-3.92 L105.05,79c0.83-1.87,1.46-3.82,1.98-5.9c0.52-2.08,0.94-4.03,1.25-6.11l9.72-1.67c1.67-0.31,2.88-1.15,3.82-2.39 c0.94-1.35,1.25-2.78,0.94-4.44l-2.19-12.18c-0.31-1.56-1.04-2.78-2.36-3.82c-1.35-0.94-2.78-1.35-4.44-1.04l-8.88,1.56 c-0.83-1.87-1.77-3.71-2.88-5.59c-1.04-1.87-2.29-3.5-3.5-5.07l5.69-8.26c0.94-1.35,1.35-2.78,1.04-4.34 c-0.31-1.56-1.15-2.88-2.46-3.82L92.73,8.87L92.45,8.98L92.45,8.98L92.45,8.98L92.45,8.98z M53.18,69.19h16.34 C65.97,60.85,56.73,60.85,53.18,69.19L53.18,69.19z M43.34,78.99v-3.07h4.63c0.11-6.15,3.1-13,9.04-15.57 c-5.92-2.56-8.91-9.39-9.04-15.54h-4.63v-3.07h36.2v3.07l-4.8,0c-0.12,6.14-3.11,12.98-9.04,15.54c5.93,2.56,8.92,9.41,9.04,15.57 h4.8v3.07H43.34L43.34,78.99z M70.92,45.47H51.78C52.39,61.7,70.31,61.72,70.92,45.47L70.92,45.47z M55.41,28.79 c4.39-0.72,8.84-0.72,13.23,0.29c4.25,1,8.12,2.72,11.65,5.11c3.39,2.44,6.4,5.54,8.84,9.26c2.44,3.68,3.97,7.84,4.68,12.23 c0.72,4.39,0.72,8.84-0.29,13.23c-1,4.25-2.72,8.12-5.11,11.65c-2.44,3.39-5.54,6.4-9.27,8.84c-3.68,2.44-7.84,3.97-12.23,4.68 c-4.39,0.72-8.84,0.72-13.23-0.29c-4.25-1-8.12-2.72-11.65-5.11c-3.39-2.44-6.4-5.54-8.84-9.26c-2.44-3.68-3.97-7.84-4.68-12.23 c-0.72-4.39-0.72-8.84,0.29-13.23c1-4.25,2.72-8.12,5.11-11.65c2.44-3.39,5.54-6.4,9.27-8.84C46.91,31.08,51.01,29.5,55.41,28.79 L55.41,28.79L55.41,28.79L55.41,28.79z"/></g></svg>'
]

{ #category : #accessing }
ToSandBox class >> path_draghorizontal [

	<sampleInstance>
	^ '<svg xmlns="http://www.w3.org/2000/svg" id="mdi-drag-horizontal" viewBox="0 0 24 24"><path d="M3,15V13H5V15H3M3,11V9H5V11H3M7,15V13H9V15H7M7,11V9H9V11H7M11,15V13H13V15H11M11,11V9H13V11H11M15,15V13H17V15H15M15,11V9H17V11H15M19,15V13H21V15H19M19,11V9H21V11H19Z" /></svg>'
]

{ #category : #accessing }
ToSandBox class >> path_dragvertical [

	<sampleInstance>
	^ '<svg xmlns="http://www.w3.org/2000/svg" id="mdi-drag-vertical" viewBox="0 0 24 24"><path d="M9,3H11V5H9V3M13,3H15V5H13V3M9,7H11V9H9V7M13,7H15V9H13V7M9,11H11V13H9V11M13,11H15V13H13V11M9,15H11V17H9V15M13,15H15V17H13V15M9,19H11V21H9V19M13,19H15V21H13V19Z" /></svg>'
]

{ #category : #accessing }
ToSandBox class >> path_sharp_electric_bike_SVG [

	<sampleInstance>
	^ '<svg xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" height="24" viewBox="0 0 24 24" width="24"><g><rect fill="none" height="24" width="24"/></g><g><g><path d="M19,7h-0.82L16,1h-4v2h2.6l1.46,4h-4.81l-0.36-1H12V4H7v2h1.75l1.82,5H9.9C9.46,8.77,7.59,7.12,5.25,7.01 C2.45,6.87,0,9.2,0,12c0,2.8,2.2,5,5,5c2.46,0,4.45-1.69,4.9-4h4.2c0.44,2.23,2.31,3.88,4.65,3.99c2.8,0.13,5.25-2.19,5.25-5 C24,9.2,21.8,7,19,7z M7.82,13c-0.4,1.17-1.49,2-2.82,2c-1.68,0-3-1.32-3-3s1.32-3,3-3c1.33,0,2.42,0.83,2.82,2H5v2H7.82z M14.1,11h-1.4l-0.73-2H15C14.56,9.58,14.24,10.25,14.1,11z M19,15c-1.68,0-3-1.32-3-3c0-0.93,0.41-1.73,1.05-2.28l0.96,2.64 l1.88-0.68l-0.97-2.67C18.94,9.01,18.97,9,19,9c1.68,0,3,1.32,3,3S20.68,15,19,15z"/><polygon points="11,20 7,20 13,23 13,21 17,21 11,18"/></g></g></svg>'
]

{ #category : #'finite list' }
ToSandBox class >> resizerBoardFor: aBar [

	| pane group container |
	pane := ToPane horizontal.
	{ #Horizontal. #Vertical } do: [ :dir |
			| sizeInputPane sizeInput |
			sizeInputPane := ToPane horizontal.
			sizeInputPane layout cellSpacing: 5.
			sizeInputPane childrenDo: [ :child |
				child constraints linear vertical alignCenter ].
			sizeInputPane addChild: (ToLabel text: 'Size:').
			sizeInput := ToTextField new
				             withoutLineWrapping;
				             withSaveCapability;
				             yourself.

			aBar addEventHandlerOn: BlElementExtentChangedEvent do: [ :event |
					dir = #Horizontal
						ifTrue: [ sizeInput text: aBar width asString ]
						ifFalse: [ sizeInput text: aBar height asString ] ].

			sizeInput whenSaveRequestedDo: [ :saveRequested |
					| size |
					size := saveRequested editorElement text asString asInteger.
					size ifNotNil: [
							saveRequested accepted: true.
							dir = #Horizontal
								ifTrue: [ aBar hExact: size ]
								ifFalse: [ aBar vExact: size ] ] ].

			sizeInputPane addChild: sizeInput.
			sizeInputPane childrenDo: [ :child |
				child constraints linear vertical alignCenter ].

			group := ToCheckableGroupPane vertical.

			{ #MatchParent. #FitContent. #Exact } do: [ :mode |
					| cbox |
					cbox := ToRadioButton new
						        labelText: mode asString;
						        yourself.
					group addChild: cbox.
					cbox
						checkAction: [ :evt  |
								| policy value |
								value := evt currentTarget isChecked.
								value ifTrue: [
										mode = #Exact
											ifTrue: [ sizeInputPane enabled: true ]
											ifFalse: [
													sizeInputPane enabled: false.
													policy := dir = #Horizontal
														          ifTrue: [ ('h' , mode) asSymbol ]
														          ifFalse: [ ('v' , mode) asSymbol ].
													aBar perform: policy ] ] ] ].

			group registeredCheckables second checked: true.
			container := ToPane vertical.
			container padding: (BlInsets all: 2).
			container hMatchParent.
			container vFitContent.
			container addChild: (ToLabel text: dir asString).
			container addChild: group.
			container addChild: sizeInputPane.
			pane addChild: container ].
	^ pane
]

{ #category : #segmented }
ToSandBox class >> segmentedDashBoardFor: aSegmentedElement [

	| mainPane barPane confPane checkingStrategyPane |
	mainPane := ToPane horizontal.
	mainPane matchParent.

	confPane := self listConfigurationBoardFor: aSegmentedElement.
	(confPane childWithId: #selectOnPressedSwitch ifFound: [:child | child disable]).
	(confPane childWithId: #deselectOnPressedSwitch ifFound: [:child | child disable]).
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
	select manager minHeight: 35.

	select popupListElement placeholderBuilder: [ :placeholder :e |
		| lab |
		placeholder layout alignCenter.
		lab := ToAttributedLabel text: phtext.
		placeholder addChild: lab ].

	"select whenSaveAcceptedDo: [ :event |
		| d |
		d := event client text asString asSymbol.
		event client text: ''.
		event currentTarget data add: d.
		event currentTarget mode selectIndex: event currentTarget data size ].

	select whenSaveRequestedDo: [ :event |
		| target idx |
		target := event currentTarget.
		idx := target data indexOf: event client text asString asSymbol.
		event accepted: idx isZero.
		idx > 0 ifTrue: [
			event client text: ''.
			target listElement selection selectIndex: idx ] ]."
	^ select
]

{ #category : #'labeled icon' }
ToSandBox class >> selectableLabeledIconlWithIconAndText [

	| but |
	but := ToLabeledIcon new.
	but label: (ToSelectableLabel new text: 'Selectable Labeled icon').
	but icon: (ToImage inner: (BlElement new
				  extent: 60 @ 60;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	^ but
]

{ #category : #tree }
ToSandBox class >> selectionChangedEvent: anEvent [

	"anEvent traceCr."
]

{ #category : #'finite list' }
ToSandBox class >> selectionModeChooserFor: aBar [

	| selectionModeGroup selectionModeContainer |
	selectionModeGroup := ToCheckableGroupPane vertical.
	{
		(#Multiple -> #multiple:).
		(#Single -> #single:).
		(#Disabled -> nil) } do: [ :modeAssoc |
		| chb |
		chb := ToRadioButton new
			       labelText: modeAssoc key asString;
			       yourself.
		selectionModeGroup addChild: chb.
		chb
			checkAction: [ :evt | 
				| value |
				value := evt currentTarget isChecked.
				value ifTrue: [ | chosen selMode |
					chosen := modeAssoc key.
					selMode := aBar primarySelectionMode.
					selMode enabled: chosen ~= #Disabled.
					modeAssoc value ifNotNil: [ :message |
						selMode perform: message asSymbol with: true ] ] ] ].

	selectionModeGroup registeredCheckables first checked: true.
	selectionModeContainer := ToPane vertical.
	selectionModeContainer padding: (BlInsets all: 2).
	selectionModeContainer hMatchParent.
	selectionModeContainer addChild: (ToLabel text: 'Selection mode').
	selectionModeContainer addChild: selectionModeGroup.
	^ selectionModeContainer
]

{ #category : #accessing }
ToSandBox class >> statesOfAmerica [

	^ { #Alabama. #Alaska. #Arizona. #Arkansas. #California. #Colorado.
		#Connecticut. #Delaware. #Florida. #Georgia. #Hawaii. #Idaho. #Illinois. #Indiana.
		#Iowa. #Kansas. #Kentucky. #Louisiana. #Maine. #Maryland. #Massachusetts.
		#Michigan. #Minnesota. #Mississippi. #Missouri. #Montana. #Nebraska.
		#Nevada. #'New Hampshire'. #'New Jersey'. #'New Mexico'.
		#'New York'. #'North Carolina'. #'North Dakota'. #Ohio. #Oklahoma.
		#Oregon. #'Pennsylvania Rhode Island'. #'South Carolina'.
		#'South Dakota'. #Tennessee. #Texas. #Utah. #Vermont. #Virginia.
		#Washington. #'West Virginia'. #Wisconsin. #Wyoming }.
]

{ #category : #accessing }
ToSandBox class >> statesOfAmericaWithColor [

	| colorStrings states |
	colorStrings := { #'1677FF'. #'722ED1'. #'13C2C2'. #'52C41A'.
	                #EB2F96. #EB2F96. #F5222D. #FA8C16. #FADB14. #FA541C.
	                #'2F54EB'. #FAAD14. #A0D911 }.
	states := self statesOfAmerica.

	^ Array streamContents: [ :stream |
		  | p |
		  p := 0.
		  states do: [ :s |
			  p := p + 1 \\ colorStrings size + 1.
			  stream nextPut: s -> (Color fromString: (colorStrings at: p)) ] ]
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

{ #category : #tabPane }
ToSandBox class >> tabBarElementDashBoardFor: aTabBarElement [

	| confPane barPane mainPane |
	confPane := self listConfigurationBoardFor: aTabBarElement.
	barPane := ToPane vertical.
	barPane matchParent.
	barPane addChild: aTabBarElement.

	mainPane := ToPane horizontal.
	mainPane matchParent.
	mainPane addChildren: {
			confPane.
			barPane }.
	^ mainPane
]

{ #category : #tabPane }
ToSandBox class >> tabGroupElementDashBoardFor: aTabGroupElement [

	| mainPane barPane confPane startToEndSwitch addTabItemButtonSwicth menu animSwitch itemList |
	itemList := aTabGroupElement itemList.
	mainPane := ToPane horizontal.
	mainPane matchParent.

	confPane := ToPane vertical.
	confPane id: #configurationPane.
	confPane matchParent.
	confPane padding: (BlInsets all: 5).

	menu := ToMenu new.
	menu icon: (ToImage inner: (self iconNamed: #solidMenu)).
	menu addItem: (ToRadioMenuItem new
			 label: (ToLabel text: 'Dark theme');
			 checkAction: [ :evt |
					 evt currentTarget space toTheme: (evt target isChecked
								  ifTrue: [ ToRawDarkTheme new ]
								  ifFalse: [ ToRawTheme new ]) ];
			 in: [ :rad |
				 rad checked: Toplo defaultThemeClass = ToRawDarkTheme ];
			 yourself).
	menu addItem: (ToMenuItem new
			 label: (ToLabel text: 'Space statistics');
			 clickAction: [ aTabGroupElement space showStatisticsWindow ];
			 yourself).
	menu addItem: (ToMenuItem new
			 label: (ToLabel text: 'Inspect');
			 clickAction: [ aTabGroupElement space root inspect ];
			 yourself).
	menu addItem: (ToRadioMenuItem new
			 label: (ToLabel text: 'Disabled bar');
			 checkAction: [ :evt |
				 aTabGroupElement disabled: evt target isChecked ];
			 yourself).
	confPane addChild: menu.

	itemList toConfigurationDo: [ :conf |
			{
				([ aTabGroupElement isVertical ]
				 -> [ :v | aTabGroupElement isVertical: v ] -> 'Vertical').
				([ conf isFlowable ] -> [ :v | conf isFlowable: v ] -> 'Flowable').
				([ conf isScrollable ] -> [ :v | conf isScrollable: v ]
				 -> 'Scrollable').
				([ conf autoDistribute ] -> [ :v | conf autoDistribute: v ]
				 -> 'Auto-distribute').
				([ aTabGroupElement selectionMode selectOnPressed ]
				 -> [ :v | aTabGroupElement selectionMode selectOnPressed: v ]
				 -> 'Select on pressed').
				([ aTabGroupElement selectionMode deselectOnPressed ]
				 -> [ :v | aTabGroupElement selectionMode deselectOnPressed: v ]
				 -> 'Deselect on pressed').
				([ aTabGroupElement selectionMode makeDisabledUnselectable ]
				 -> [ :v |
				 aTabGroupElement selectionMode makeDisabledUnselectable: v ]
				 -> 'Disabled items are unselectable') } do: [ :assoc |
					| switch |
					switch := ToSwitchButton new labelText: assoc value value.
					switch checkAction: [ :evt |
						assoc key value value: evt target isChecked ].

					switch startFlexible: true.
					switch hMatchParent.
					confPane addChild: switch.

					aTabGroupElement whenConfigurationAppliedDo: [
						switch checked: assoc key key value ] ] ].

	animSwitch := ToSwitchButton new labelText: 'Animate transition'.
	animSwitch checkAction: [ :evt |
			| d |
			d := evt target isChecked
				     ifTrue: [ 200 milliSeconds ]
				     ifFalse: [ 0 milliSeconds ].
			aTabGroupElement selectionOption animationDuration: d.
			aTabGroupElement secondarySelectionOption animationDuration: d ].

	animSwitch startFlexible: true.
	animSwitch hMatchParent.
	confPane addChild: animSwitch.
	confPane addChild: (self resizerBoardFor: aTabGroupElement).
	startToEndSwitch := ToSwitchButton new labelText: 'At start'.
	startToEndSwitch checkAction: [ :evt |
		aTabGroupElement atStartSide: evt target isChecked ].

	startToEndSwitch startFlexible: true.
	startToEndSwitch hMatchParent.
	confPane addChild: startToEndSwitch.

	addTabItemButtonSwicth := ToSwitchButton new labelText:
		                          'Show new tab button'.
	addTabItemButtonSwicth checkAction: [ :evt |
		aTabGroupElement showAddTabItemButton: evt target isChecked ].

	addTabItemButtonSwicth startFlexible: true.
	addTabItemButtonSwicth hMatchParent.
	confPane addChild: addTabItemButtonSwicth.

	aTabGroupElement whenConfigurationAppliedDo: [
			startToEndSwitch checked: aTabGroupElement atStartSide.
			addTabItemButtonSwicth checked:
				aTabGroupElement showAddTabItemButton ].

	confPane padding: (BlInsets all: 5).

	barPane := ToPane vertical.
	barPane matchParent.
	barPane addChild: aTabGroupElement.

	confPane addChild:
		(self checkingStrategyChooserFor: aTabGroupElement).

	mainPane addChildren: {
			confPane.
			barPane }.
	mainPane addDividers.
	mainPane matchParent.

	^ mainPane
]

{ #category : #tabPane }
ToSandBox class >> tabPaneElementDashBoardFor: aTabPaneElement [

	| mainPane confPane hideParlyVisibleNodesSwitch layoutModeSwitch alignmentGroup paneDestroySwith |
	mainPane := self tabGroupElementDashBoardFor: aTabPaneElement.
	confPane := mainPane childWithId: #configurationPane.

	paneDestroySwith := ToSwitchButton new labelText: 'Destroy pane when deselected'.
	paneDestroySwith checkAction: [ :evt |
			aTabPaneElement destroyPaneWhenDeselected: evt target isChecked ].
	paneDestroySwith startFlexible: true.
	paneDestroySwith hMatchParent.
	confPane addChild: paneDestroySwith.

	confPane addChild: (ToLabel new text: 'Alignment').
	alignmentGroup := ToCheckableGroupPane vertical.
	alignmentGroup fitContent.
	{
		('No alignment' -> BlElementAlignment null).
		('Start' -> BlElementAlignment start).
		('Middle' -> BlElementAlignment middle).
		('End' -> BlElementAlignment end) } do: [ :assoc |
			| rad |
			rad := ToRadioButton new
				       labelText: assoc key;
				       id: assoc key asSymbol.
			rad userData at: #align put: assoc value.
			rad checked: aTabPaneElement headerAlignment = assoc value.
			alignmentGroup addChild: rad ].

	alignmentGroup groupCheckAction: [ :evt |
			| align |
			align := evt checkedList anyOne userData at: #align.
			aTabPaneElement headerAlignment: align ].

	confPane addChild: alignmentGroup.

	layoutModeSwitch := ToSwitchButton new labelText:
		                    'Compact layout mode'.
	layoutModeSwitch checkAction: [ :evt |
		aTabPaneElement header compactLayoutMode: evt target isChecked ].

	layoutModeSwitch startFlexible: true.
	layoutModeSwitch hMatchParent.
	confPane addChild: layoutModeSwitch.

	hideParlyVisibleNodesSwitch := ToSwitchButton new labelText:
		                               'Hide partly visible modes'.
	hideParlyVisibleNodesSwitch checkAction: [ :evt |
		aTabPaneElement hidePartlyVisibleNodes: evt target isChecked ].

	hideParlyVisibleNodesSwitch startFlexible: true.
	hideParlyVisibleNodesSwitch hMatchParent.
	confPane addChild: hideParlyVisibleNodesSwitch.


	^ mainPane
]

{ #category : #tabPane }
ToSandBox class >> tabPaneElementWithUSStates [

	| tpane |
	tpane := ToTabPaneElement new.
	tpane addTabItemDataFactory: [ 'My new tab' ].
	tpane itemBuilder: [ :tabButton :aData :holder |
			| lab |
			lab := ToLabel text: aData asString.
			lab enableShrinkLayer: true.
			lab shrinkTolerance: 2.0.
			lab width: 70.
			lab beEditable.

			lab whenEditorOpenedDo: [ :editorEvent |
					editorEvent editorElement whenSaveRequestedDo: [ :request |
						request accepted: true ].
					editorEvent editorElement whenSaveAcceptedDo: [ :acceptedEvent |
							editorEvent target text: acceptedEvent target text.
							holder listElement selecter
								scrollTowardEndToDataSourcePosition: holder position ] ].
			tabButton destroyPaneWhenDeselected: false.
			tabButton
				label: lab;
				tooltipString: aData asString;
				removable: true;
				paneFactory: [
						| c |
						c := Color random.
						BlElement new
							border: c;
							background: (c alpha: 0.1);
							yourself ];
				paneBuilder: [ :pane :button :bholder |
						pane userData at: #placeholder ifAbsent: [
								| emptyPh |
								emptyPh := (ToEmptyPlaceholderLayer withEmpty:
									            (ToEmpty waiting labelText: 'waiting...'))
									           attachToParent: pane.
								pane userData at: #placeholder put: emptyPh ] ];
				paneDestroyer: [ :pane :button :bholder |  ];
				yourself ].
	(self statesOfAmerica copyFrom: 1 to: 20) do: [ :l |
		tpane addTabItemData: l ].
	tpane isFlowable: false.
	tpane isScrollable: true.
	^ tpane
]

{ #category : #select }
ToSandBox class >> themeSelect [

	| select themes |
	select := ToSingleSelectElement new.
	themes := {
		          ('Bee Light' -> ToBeeTheme new).
		          ('Bee Dark' -> ToBeeDarkTheme new).
		          ('Raw Light' -> ToRawTheme new).
		          ('Raw Dark' -> ToRawDarkTheme new) }.

	select dataViewBuilder: [ :dataItemView :themeAssoc |
		dataItemView addChild: (ToLabel text: themeAssoc key) ].

	select popupListElement nodeBuilder: [ :node :themeAssoc :holder |
		node addChild: (ToLabel text: themeAssoc key) ].

	select sieve filter: [ :themeAssoc :pattern |
		themeAssoc key beginsWith: pattern caseSensitive: true ].

	select popupListElement dataAccessor addAll: themes.
	^ select
]

{ #category : #select }
ToSandBox class >> themeSelectNoDeselectionPopupOnTop [

	| select |
	select := self themeSelect.
	select placeholderString: 'Select a Toplo theme'.
	select
		addEventHandlerOn: ToSelectChangedEvent
		do: [ :event | event selectedData asString traceCr ].
	select selecter selectIndex: 4.
	select allowDeselection: false.
	select position: 210 @ 150.
	select width: 200.
	"select manager measurement:
		(ToActionMeasurement new action: [ :w :evt |
			 w root hFitContent ])."
	select popupWindowPlacement: ToAnchoredTopCenterPlacement new.
	^ select
]

{ #category : #triplet }
ToSandBox class >> tripletWith2IconsAnd1Label [

	| but |
	but := ToTripletElement new.
	but startElement: (BlElement new
			 extent: 25 asPoint;
			 background: Color red;
			 yourself).
	but middleElement: (ToLabel text: 'Middle').
	but endElement: (BlElement new
			 extent: 25 asPoint;
			 background: Color red;
			 yourself).
	^ but
]

{ #category : #triplet }
ToSandBox class >> tripletWith2Labels [

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
