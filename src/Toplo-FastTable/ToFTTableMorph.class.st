"
I'm an implementation of a table, in a not-naive way. 

I assume I can have many rows, then I do not try to show all of them at once. Instead, I keep a datasource and I demand rows when needed (datasource implements a flyweight to fill the visible rows).

I should not be subclasse. An extension of FastTable should happen on a data source an not here. Extend me ONLY if it is impossible to do what you want on the data source.

Examples: 
-------------
ToFTTableMorph new
	extent: 200@400;
	dataSource: (ToFTSimpleDataSource elements: (1 to: 10000));
	openInWindow
	
You can check better examples in ToFTExamples

A FastTable have the possibility to be searchable, this is activate by default. 
You can disable this with the method #disableSearch.
But you also have the possibility to make your FastTable filterable with the method #enableFilter. But search and filter cannot be use in the same time.

I manage different kind of selections through a strategy design pattern. For example I have a strategy to manage simple or multiple selection and I have a strategy to manage cell or row selection.

Horizontal scrolling being a new feature is not enabled by default. Use #newWithHorizontalScrollBar or set horizontalScrollBar var to anything at early initialization stage (before #initializeScrollBars where it is being checked)



"
Class {
	#name : #ToFTTableMorph,
	#superclass : #Morph,
	#instVars : [
		'container',
		'verticalScrollBar',
		'horizontalScrollBar',
		'selectionColor',
		'selectedIndexes',
		'highlightedIndexes',
		'showIndex',
		'dataSource',
		'intercellSpacing',
		'rowHeight',
		'selectionStrategy',
		'columns',
		'secondarySelectionColor',
		'headerColor',
		'showColumnHeaders',
		'allowsDeselection',
		'needToggleAtMouseUp',
		'function',
		'resizable',
		'selectionModeStrategy'
	],
	#category : #'Toplo-FastTable-Base'
}

{ #category : #accessing }
ToFTTableMorph class >> defaultAllowsDeselection [
	^ false
]

{ #category : #accessing }
ToFTTableMorph class >> defaultBackgroundColor [
	^ self theme listBackgroundColor
]

{ #category : #accessing }
ToFTTableMorph class >> defaultColumn [
	^ ToFTColumn new
]

{ #category : #accessing }
ToFTTableMorph class >> defaultHeaderColor [
	self flag: #pharoFixMe.	"I think we should deprecate all this headerColor stuff. This is
	responsibility of data source, after all.

	Cyril: I added a deprecation on #headerColor: explaining how to update the users of this method. In Pharo 9 we can remove all this."
	^ self theme fastTableHeaderColor
]

{ #category : #accessing }
ToFTTableMorph class >> defaultIntercellSpacing [
	^ 0@0
]

{ #category : #accessing }
ToFTTableMorph class >> defaultRowHeight [
	^ StandardFonts defaultFont pixelSize + 7
]

{ #category : #accessing }
ToFTTableMorph class >> defaultSecondarySelectionColor [
	^ self theme secondarySelectionColor
]

{ #category : #accessing }
ToFTTableMorph class >> defaultSelectionColor [
	^ self theme selectionColor
]

{ #category : #temporary }
ToFTTableMorph class >> newWithHorizontalScrollBar [
	"This method is temporary to introduce horisontal scrolling gradually"
	"See GTExamples class >> exampleTableHorizontalScroll"
	^self basicNew initializeWithHorizontalScrollBar
]

{ #category : #'drag and drop' }
ToFTTableMorph >> acceptDroppingMorph: aMorph event: event [
	self dataSource dropElements: aMorph passenger index: ((self container rowIndexContainingPoint: event position) ifNil: [ 0 ]).
	self basicHighlightIndexes: #().
	self refresh
]

{ #category : #accessing }
ToFTTableMorph >> addColumn: aColumn [
	columns := columns copyWith: aColumn
]

{ #category : #accessing }
ToFTTableMorph >> allowDeselection [
	self allowsDeselection: true
]

{ #category : #testing }
ToFTTableMorph >> allowsDeselection [
	^ allowsDeselection ifNil: [ self class defaultAllowsDeselection ]
]

{ #category : #accessing }
ToFTTableMorph >> allowsDeselection: aBoolean [
	allowsDeselection := aBoolean
]

{ #category : #configuring }
ToFTTableMorph >> alternateRowsColor: shouldAlternate [
	shouldAlternate ifFalse: [ ^ self ].

	self container alternateRowsColor
]

{ #category : #private }
ToFTTableMorph >> announceScrollChangedFrom: oldIndex to: newIndex [
	"If the index did not change, do nothing"
	oldIndex = newIndex ifTrue: [ ^ self ].
	self
		doAnnounce:
			((ToFTScrollingChanged from: oldIndex to: newIndex)
				fastTable: self;
				yourself)
]

{ #category : #updating }
ToFTTableMorph >> autoScrollHeightLimit [

	^20
]

{ #category : #private }
ToFTTableMorph >> basicHighlightIndexes: anArray [
	highlightedIndexes := anArray asArray
]

{ #category : #private }
ToFTTableMorph >> basicMoveShowIndexTo: aNumber [

	showIndex := aNumber
]

{ #category : #private }
ToFTTableMorph >> basicSelectIndexes: anArray [
	selectedIndexes := anArray asArray
]

{ #category : #accessing }
ToFTTableMorph >> beCellSelection [
	self selectionModeStrategy: (ToFTCellSelectionModeStrategy table: self)
]

{ #category : #accessing }
ToFTTableMorph >> beMultipleSelection [
	selectionStrategy := ToFTMultipleSelectionStrategy table: self
]

{ #category : #accessing }
ToFTTableMorph >> beNotResizable [
	resizable := false
]

{ #category : #accessing }
ToFTTableMorph >> beResizable [
	resizable := true
]

{ #category : #accessing }
ToFTTableMorph >> beRowNotHomogeneous [
	"by default, tables have homogeneous row heigths, taken from rowHeight variable.
	 We can switch to variable size by sending this message.
	 The resulting table will be less effcicient than the first, but probably not in a way users
	 can notice"
	| oldContainer |

	oldContainer := container.
	container := ToFTTableContainerRowNotHomogeneousMorph new.
	self replaceSubmorph: oldContainer by: container.
	self resizeAllSubviews
]

{ #category : #accessing }
ToFTTableMorph >> beRowSelection [
	self selectionModeStrategy: (ToFTRowSelectionModeStrategy table: self)
]

{ #category : #accessing }
ToFTTableMorph >> beSingleSelection [
	selectionStrategy := ToFTSimpleSelectionStrategy table: self
]

{ #category : #'event handling' }
ToFTTableMorph >> click: event [
	"check for right click (menu)"

	(self isYellowButtonReallyPressed: event)
		ifTrue: [ self showMenuForPosition: event cursorPoint ]
]

{ #category : #'accessing - colors' }
ToFTTableMorph >> colorForSelection: primarySelection [

	^primarySelection
		ifTrue: [ self selectionColor ]
		ifFalse: [ self secondarySelectionColor ]
]

{ #category : #accessing }
ToFTTableMorph >> columns [
	^ columns
]

{ #category : #accessing }
ToFTTableMorph >> columns: aCollection [
	columns := aCollection asArray
]

{ #category : #private }
ToFTTableMorph >> container [
	^ container
]

{ #category : #accessing }
ToFTTableMorph >> dataSource [
	"Answers a dataSource: the component responsible of providing data to the table.
	 Check ToFTDataSource and subclasses as reference."
	^ dataSource
]

{ #category : #accessing }
ToFTTableMorph >> dataSource: anObject [
	dataSource := anObject.
	dataSource table: self.
	dataSource readyToBeDisplayed.
	self resetPosition.
	self refresh
]

{ #category : #initialization }
ToFTTableMorph >> defaultColor [

	^self class defaultBackgroundColor
]

{ #category : #accessing }
ToFTTableMorph >> defaultContainer [
	^ ToFTTableContainerMorph new
]

{ #category : #accessing }
ToFTTableMorph >> denyDeselection [
	self allowsDeselection: false
]

{ #category : #'accessing - selection' }
ToFTTableMorph >> deselectAll [
	self selectIndexes: #()
]

{ #category : #accessing }
ToFTTableMorph >> disableFunction [
	"Disabling it just sets the funtion to nil, so I can safely skip it in #keyStrokeSearch:"

	function isExplicit
		ifTrue: [ function disable.
			self resizeAllSubviews	"This is call because now the container will take all the available space." ].
	function := ToFTNilFunction table: self
]

{ #category : #'event handling' }
ToFTTableMorph >> doubleClick: event [
	(self selectionModeStrategy selectableIndexContainingPoint: event cursorPoint) ifNotNil: [ :index | self doAnnounce: (ToFTStrongSelectionChanged index: index event: event) ]
]

{ #category : #drawing }
ToFTTableMorph >> drawSubmorphsOn: aCanvas [
	"Draw the focus here since we are using inset bounds
	for the focus rectangle."
	"1haltOnce."
	super drawSubmorphsOn: aCanvas.
	self hasKeyboardFocus ifTrue: [ self drawKeyboardFocusOn: aCanvas ]
]

{ #category : #accessing }
ToFTTableMorph >> enableFilter [
	"Enables filtering. Not compatible with the search."

	function := ToFTFilterFunction table: self
]

{ #category : #accessing }
ToFTTableMorph >> enableFilter: aToFTFilterClass [
	"Enables filtering. Not compatible with the search."

	self enableFilter.
	function filterClass: aToFTFilterClass
]

{ #category : #accessing }
ToFTTableMorph >> enableFilterWithAction: aBlock [
	"Enables filtering and add an Action button. Not compatible with the search."

	self enableFilterWithAction: aBlock named: 'Validate.'
]

{ #category : #accessing }
ToFTTableMorph >> enableFilterWithAction: aBlock named: aString [
	"Enables filtering and add an Action button. Not compatible with the search. If I am use, the function must be explicit."

	function := ToFTActionFilterFunction table: self action: aBlock named: aString.
	self explicitFunction
]

{ #category : #accessing }
ToFTTableMorph >> enableSearch [
	"Enables search (this is the default option). Not compatible with the filter function.	"

	function := ToFTSearchFunction table: self
]

{ #category : #private }
ToFTTableMorph >> ensureAtLeastOneColumn [
	self columns ifNotEmpty: [ ^ self ].
	self addColumn: self class defaultColumn
]

{ #category : #private }
ToFTTableMorph >> ensureVisibleFirstSelection [
	| rowIndex |
	(self hasSelection not or: [ self container isRowIndexFullyVisible: (rowIndex := self selectionModeStrategy selectedRowIndex) ]) ifTrue: [ ^ self ].

	rowIndex < self showIndex
		ifTrue: [ self moveShowIndexTo: self selectedIndex ]
		ifFalse: [ self moveShowIndexTo: (self selectionModeStrategy indexForRow: rowIndex - self container calculateMinVisibleRows + 1) ]
]

{ #category : #accessing }
ToFTTableMorph >> explicitFunction [
	function showWidget
]

{ #category : #geometry }
ToFTTableMorph >> extent: aPoint [
	super extent: aPoint.
	container extent: aPoint.
	self resizeAllSubviews
]

{ #category : #accessing }
ToFTTableMorph >> firstVisibleRowIndex [

	^ self container firstVisibleRowIndex
]

{ #category : #'event handling' }
ToFTTableMorph >> handleMouseMove: anEvent [
	"Reimplemented because we really want #mouseMove when a morph is dragged around"
	anEvent wasHandled ifTrue:[^self]. "not interested"
	(anEvent anyButtonPressed) ifFalse:[^self].
	anEvent wasHandled: true.
	self mouseMove: anEvent
]

{ #category : #'event testing' }
ToFTTableMorph >> handlesKeyboard: event [
	^ true
]

{ #category : #'event testing' }
ToFTTableMorph >> handlesMouseDown: event [
	^ true
]

{ #category : #'event testing' }
ToFTTableMorph >> handlesMouseOverDragging: event [
	"Yes, for mouse down highlight."
	^true
]

{ #category : #'event testing' }
ToFTTableMorph >> handlesMouseWheel: event [
	^self isVerticalScrollBarVisible and: [ self hasDataSource ]
]

{ #category : #testing }
ToFTTableMorph >> hasDataSource [
	^ self dataSource notNil
]

{ #category : #testing }
ToFTTableMorph >> hasHighlighted [
	^ self highlightedIndexes notEmpty
]

{ #category : #testing }
ToFTTableMorph >> hasSelection [
	^ self selectedIndexes isNotEmpty
]

{ #category : #'accessing - colors' }
ToFTTableMorph >> headerColor [
	^ headerColor ifNil: [ self class defaultHeaderColor ]
]

{ #category : #accessing }
ToFTTableMorph >> hideColumnHeaders [
	showColumnHeaders ifFalse: [ ^ self ].
	showColumnHeaders := false.
	self refresh
]

{ #category : #'accessing - selection' }
ToFTTableMorph >> highlightIndex: aNumber [
	self highlightIndexes: { aNumber }
]

{ #category : #'accessing - selection' }
ToFTTableMorph >> highlightIndexes: anArray [
	anArray = self highlightedIndexes ifTrue: [ ^ self ].

	self basicHighlightIndexes: anArray.

	(self hasHighlighted and: [ (self isIndexVisible: self highlightedIndex) not ])
		ifTrue: [ self moveShowIndexTo: self highlightedIndexes first.
			^ self ].

	(self hasSelection and: [ (self isIndexVisible: self selectedIndex) not ])
		ifTrue: [ self moveShowIndexTo: self selectedIndex.
			^ self ].

	self refresh
]

{ #category : #'accessing - selection' }
ToFTTableMorph >> highlightedIndex [
	^ self highlightedIndexes ifNotEmpty: #first ifEmpty: [ 0 ]
]

{ #category : #'accessing - selection' }
ToFTTableMorph >> highlightedIndexes [
	^ highlightedIndexes
]

{ #category : #private }
ToFTTableMorph >> horizontalScrollBar [
	^ horizontalScrollBar
]

{ #category : #private }
ToFTTableMorph >> horizontalScrollBarHeight [
	^horizontalScrollBar
		ifNil: [ 0 ]
		ifNotNil: [
			self isHorizontalScrollBarVisible ifFalse: [ ^ 0 ].
			self scrollBarThickness
			]
]

{ #category : #private }
ToFTTableMorph >> horizontalScrollBarValue: aNumber [
	horizontalScrollBar ifNotNil: [
	self container adjustToHorizontalScrollBarValue: aNumber.
	]
]

{ #category : #initialization }
ToFTTableMorph >> initialize [
	super initialize.
	showIndex := 0.
	showColumnHeaders := true.
	columns := #().
	needToggleAtMouseUp := false.
	self beRowSelection.
	self beNotResizable.
	self beSingleSelection.
	self enableSearch.
	self initializeScrollBars.
	self initializeContainer.
	self initializeKeyBindings.

	self resizeAllSubviews
]

{ #category : #initialization }
ToFTTableMorph >> initializeContainer [
	container := self defaultContainer.
	self addMorph: container
]

{ #category : #initialization }
ToFTTableMorph >> initializeKeyBindings [
	"add keybindings used by table"

	self
		bindKeyCombination: Character arrowUp shift | Character arrowUp asKeyCombination
		toAction: [ :target :morph :event | self keyStrokeArrowUp: event ].
	self
		bindKeyCombination: Character arrowDown shift | Character arrowDown asKeyCombination
		toAction: [ :target :morph :event | self keyStrokeArrowDown: event ].
	self
		bindKeyCombination: Character arrowLeft shift | Character arrowLeft asKeyCombination
		toAction: [ :target :morph :event |
			self filterFieldHasKeyboardFocus
				ifTrue: [ self filterField moveCursorBy: -1 ]
				ifFalse: [ self keyStrokeArrowLeft: event ]
		].
	self
		bindKeyCombination: Character arrowRight shift | Character arrowRight asKeyCombination
		toAction: [ :target :morph :event |
			self filterFieldHasKeyboardFocus
				ifTrue: [ self filterField moveCursorBy: 1 ]
				ifFalse: [ self keyStrokeArrowRight: event ]
		].
	self
		bindKeyCombination: Character home asKeyCombination
		toAction: [
			self filterFieldHasKeyboardFocus
				ifTrue: [ self filterField moveCursorToIndex: 0 ]
				ifFalse: [ self selectFirst ]
			].
	self
		bindKeyCombination: Character end asKeyCombination
		toAction: [
			self filterFieldHasKeyboardFocus
				ifTrue: [ self filterField moveCursorToIndex: #last ]
				ifFalse: [ self selectLast ]
		].
	self
		bindKeyCombination: self shortcutProvider selectAllShortcut
		toAction: [ self selectAll ]
]

{ #category : #initialization }
ToFTTableMorph >> initializeScrollBars [
	verticalScrollBar := ScrollBarMorph new
		model: self;
		setValueSelector: #verticalScrollBarValue:;
		yourself.
	self addMorph: verticalScrollBar.

	"introducing horizontal scrolling gradually:
	enable the feature only when the var is set during initialization"
	horizontalScrollBar ifNotNil: [
		horizontalScrollBar := ScrollBarMorph new
			model: self;
			setValueSelector: #horizontalScrollBarValue:;
			yourself.
		self addMorph: horizontalScrollBar
		]
]

{ #category : #initialization }
ToFTTableMorph >> initializeSelectedIndexes [
	selectedIndexes := #().
	highlightedIndexes := #()
]

{ #category : #initialization }
ToFTTableMorph >> initializeWithHorizontalScrollBar [
	horizontalScrollBar := true.
	self initialize
]

{ #category : #accessing }
ToFTTableMorph >> intercellSpacing [
	^ intercellSpacing ifNil: [ self class defaultIntercellSpacing ]
]

{ #category : #accessing }
ToFTTableMorph >> intercellSpacing: aNumberOrPoint [
	"Determines cell spacing
		x: space between cells
		y: space between rows"
	intercellSpacing := aNumberOrPoint asPoint
]

{ #category : #private }
ToFTTableMorph >> isHorizontalScrollBarVisible [
	^horizontalScrollBar
		ifNil: [ false ]
		ifNotNil: [
			self horizontalScrollBar owner isNotNil.
			]
]

{ #category : #testing }
ToFTTableMorph >> isIndexSelected: rowIndex [
	^ self selectedIndexes includes: rowIndex
]

{ #category : #testing }
ToFTTableMorph >> isIndexVisible: anIndex [
	^ self container isRowIndexVisible: anIndex
]

{ #category : #testing }
ToFTTableMorph >> isMultipleSelection [
	^ self selectionStrategy isMultiple
]

{ #category : #testing }
ToFTTableMorph >> isResizable [
	^ resizable
]

{ #category : #testing }
ToFTTableMorph >> isRowIndexVisible: rowIndex [
	self deprecated: 'Use #isIndexVisible: instead' transformWith: '`@receiver isRowIndexVisible: `@statements1' -> '`@receiver isIndexVisible: `@statements1'.
	^ self isIndexVisible: rowIndex
]

{ #category : #testing }
ToFTTableMorph >> isShowColumnHeaders [
	^ showColumnHeaders
]

{ #category : #private }
ToFTTableMorph >> isVerticalScrollBarVisible [
	^ self verticalScrollBar owner isNotNil
]

{ #category : #private }
ToFTTableMorph >> isYellowButtonReallyPressed: anEvent [
	anEvent yellowButtonPressed ifFalse: [ ^false ].
	"this is shitty fix for VM bug.
	Now if you will press left mouse button together with pressed cmd (on Mac)
	then you will got right mouse button event.
	Interesting that it is not a problem in case of external SDL2 window.
	Try check it from OSWindowWorldMorph new open"
	^ (Smalltalk os isMacOS)
		ifTrue: [ anEvent commandKeyPressed not]
		ifFalse: [ anEvent controlKeyPressed not]
]

{ #category : #'event handling' }
ToFTTableMorph >> keyDown: event [
	self flag: #pharoTodo. "If the function is explicit this should be redirect to the function widget."
	((super keyDown: event) or: [ self navigationKey: event ])
		ifTrue: [ ^ true ].

	^ self keyDownSearch: event
]

{ #category : #'event handling' }
ToFTTableMorph >> keyDownSearch: event [
	^ function keyDown: event
]

{ #category : #'event handling' }
ToFTTableMorph >> keyStroke: event [
	self flag: #pharoTodo. "If the function is explicit this should be redirect to the function widget."
	((super keyStroke: event) or: [ self navigationKey: event ])
		ifTrue: [ ^ true ].

	^ self keyStrokeSearch: event
]

{ #category : #'event handling' }
ToFTTableMorph >> keyStrokeArrowDown: event [
	(self selectionModeStrategy is: self selectedIndex aboveRow: self numberOfRows) ifFalse: [ ^ self ].
	self resetFunction.
	self selectIndex: (self selectionModeStrategy selectableIndexBellow: self selectedIndex) event: event
]

{ #category : #'event handling' }
ToFTTableMorph >> keyStrokeArrowLeft: event [
	(self selectionModeStrategy is: self selectedIndex afterColumn: 1) ifFalse: [
		self announcer announce: (ToFTSelectionRejected withDirection: #left).
		^ self
	].
	self resetFunction.
	self selectIndex: (self selectionModeStrategy selectableIndexBefore: self selectedIndex) event: event
]

{ #category : #'event handling' }
ToFTTableMorph >> keyStrokeArrowRight: event [
	(self selectionModeStrategy is: self selectedIndex beforeColumn: self numberOfColumns) ifFalse: [
		self announcer announce: (ToFTSelectionRejected withDirection: #right).
		^ self
	].
	self resetFunction.
	self selectIndex: (self selectionModeStrategy selectableIndexAfter: self selectedIndex) event: event
]

{ #category : #'event handling' }
ToFTTableMorph >> keyStrokeArrowUp: event [
	(self selectionModeStrategy is: self selectedIndex bellowRow: 1) ifFalse: [ ^ self ].
	self resetFunction.
	self selectIndex: (self selectionModeStrategy selectableIndexAbove: self selectedIndex) event: event
]

{ #category : #'event handling' }
ToFTTableMorph >> keyStrokeSearch: event [
	^ function keyStroke: event
]

{ #category : #'event handling' }
ToFTTableMorph >> keyUpSearch: event [
	^ function keyStroke: event
]

{ #category : #'event handling' }
ToFTTableMorph >> keyboardFocusChange: aBoolean [
	"The message is sent to a morph when its keyboard focus changes.
	Update for focus feedback."
	super keyboardFocusChange: aBoolean.
	self focusChanged
]

{ #category : #accessing }
ToFTTableMorph >> lastVisibleRowIndex [

	^ self container lastVisibleRowIndex
]

{ #category : #layout }
ToFTTableMorph >> minHeight [
	"Ceiling is required because there is strange behavior when this method return float.
	In that case table stop respond to any events like clicks"

	^ self
		valueOfProperty: #minHeight
		ifAbsent:[ self class defaultRowHeight ceiling ]
]

{ #category : #layout }
ToFTTableMorph >> minWidth [

	^ 100
]

{ #category : #'event handling' }
ToFTTableMorph >> mouseDown: event [
	"perform the click"

	needToggleAtMouseUp ifTrue: [ ^ self ].

	(self selectionModeStrategy selectableIndexContainingPoint: event cursorPoint)
		ifNotNil: [ :index |
			"If the cell is selected we let the mouse up toggle to avoid any problem with
			 the drag and drop"
			(self selectedIndexes includes: index)
				ifFalse: [ self selectIndex: index event: event ]
				ifTrue: [ needToggleAtMouseUp := true ] ].

	self wantsKeyboardFocus ifTrue: [ self takeKeyboardFocus ].
	event hand waitForClicksOrDrag: self event: event
]

{ #category : #'event handling' }
ToFTTableMorph >> mouseEnterDragging: event [
	self enabled ifFalse: [ ^ self ].
	(event hand hasSubmorphs and: [ self dropEnabled ])
		ifFalse: [ "no d&d" ^ super mouseEnterDragging: event ]
]

{ #category : #'event handling' }
ToFTTableMorph >> mouseLeaveDragging: event [
	"The mouse has left with a button down."

	(self dropEnabled and: [ event hand hasSubmorphs ]) ifFalse: [ "no d&d" ^ super mouseLeaveDragging: event ].

	self basicHighlightIndexes: #().
	self refresh
]

{ #category : #'event handling' }
ToFTTableMorph >> mouseMove: event [
	event isDraggingEvent ifFalse: [ ^ self ].
	event hand hasSubmorphs ifFalse: [ ^ self ].

	(self wantsDroppedMorph: event hand submorphs first event: event) ifFalse: [ ^ self ].

	(self container rowIndexContainingPoint: event position)
		ifNotNil: [ :rowIndex |
			self basicHighlightIndexes: {rowIndex}.
			self refresh ].

	(self container bounds containsPoint: event position) ifFalse: [ ^ self ].

	event position y <= (self container top + self autoScrollHeightLimit) ifTrue: [ ^ self verticalScrollBar scrollUp: 1 ].
	event position y >= (self container bottom - self autoScrollHeightLimit) ifTrue: [ ^ self verticalScrollBar scrollDown: 1 ]
]

{ #category : #'event handling' }
ToFTTableMorph >> mouseUp: event [
	needToggleAtMouseUp ifFalse: [ ^ self ].

	"perform the click if the mouse down didn't do it."
	(self selectionModeStrategy selectableIndexContainingPoint: event cursorPoint) ifNotNil: [ :index | self selectIndex: index event: event ].

	needToggleAtMouseUp := false
]

{ #category : #'event handling' }
ToFTTableMorph >> mouseWheel: event [

	"I tried scrolling up/down with a calculated value (check #scrollUpByPageDelta implementor)
	 but the scrollbar proved been more intelligent than me... looks like hardcoded values
	 work better :/"
	event isUp ifTrue: [
		self verticalScrollBar scrollRestrictedUp: 3.
		^ self
	].
	event isDown ifTrue: [
		self verticalScrollBar scrollRestrictedDown: 3.
		^ self
	].

	super mouseWheel: event
]

{ #category : #private }
ToFTTableMorph >> moveShowIndexTo: arg [
	"I move the showing index to a specific row, and perform a refresh of subviews.
	 I should not be used directly, and most methods that need to move the
	 showing pointer should do it directly.
	 Use me just in case you need to force a refresh after settign the index"

	| index oldIndex |
	index := self selectionModeStrategy rowIndexFrom: arg.
	oldIndex := showIndex.
	self basicMoveShowIndexTo: index.
	self verticalScrollBar value: (self rowIndexToVerticalScrollBarValue: index).
	self refresh.

	self announceScrollChangedFrom: oldIndex to: index
]

{ #category : #accessing }
ToFTTableMorph >> numberOfColumns [
	^ columns size
]

{ #category : #accessing }
ToFTTableMorph >> numberOfRows [
	self hasDataSource ifFalse: [ ^ 0 ].
	^ self dataSource numberOfRows
]

{ #category : #private }
ToFTTableMorph >> recalculateVerticalScrollBar [
	| interval delta pageDelta visibleRows numberOfRows |

	self hasDataSource ifFalse: [ ^ self ].

	self recalculateVerticalScrollBarVisibilityIfHidden: [ ^ self ].

	visibleRows := self container calculateExactVisibleRows.
	numberOfRows := self dataSource numberOfRows.
	numberOfRows = 0 ifTrue: [ ^self ].
	interval := (visibleRows / numberOfRows) asFloat.
	delta := 1/numberOfRows.
	pageDelta := ((visibleRows-1) floor)*delta.
	self verticalScrollBar
		scrollDelta: delta pageDelta: pageDelta;
		interval: interval
]

{ #category : #private }
ToFTTableMorph >> recalculateVerticalScrollBarVisibilityIfHidden: aBlock [
	self container calculateExactVisibleRows >= self dataSource numberOfRows
		ifTrue: [
			(self isVerticalScrollBarVisible)
				ifTrue: [ self removeMorph: self verticalScrollBar ].
			self resizeContainer. "it changed... I need to resize it immediately because
			otherwise it does not work fine with first show... this can cause two sends to
			#resizeContainer but the case is minimal and not expensive, so we can ignore it"
			aBlock value ]
		ifFalse: [
			(self isVerticalScrollBarVisible)
				ifFalse: [
					self resizeVerticalScrollBar.
					self addMorph: self verticalScrollBar ] ]
]

{ #category : #updating }
ToFTTableMorph >> refresh [
	"Refreshes all internal values (forces an invalidate of all subviews)"
	self ensureAtLeastOneColumn.
	self recalculateVerticalScrollBar.
	self verticalScrollBar changed.
	horizontalScrollBar ifNotNil: [ self horizontalScrollBar changed ].
	self container changed
]

{ #category : #accessing }
ToFTTableMorph >> resetFunction [
	function reset
]

{ #category : #private }
ToFTTableMorph >> resetPosition [
	"Resets all values to original value"
	showIndex := 0.
	self verticalScrollBar value: 0.
	horizontalScrollBar ifNotNil: [	self horizontalScrollBar value: 0 ].
	self container setNeedsRefreshExposedRows.
	self container updateExposedRows
]

{ #category : #private }
ToFTTableMorph >> resizeAllSubviews [
	self resizeVerticalScrollBar.
	horizontalScrollBar ifNotNil: [ self resizeHorizontalScrollBar ].
	"if we resized scrollbar, we need to recalculate it because values change (and now visibility
	 can be toggled, shown items can change, etc.)"
	self recalculateVerticalScrollBar.
	self resizeContainer.
	self container setNeedsRefreshExposedRows.
	self container updateExposedRows.
	self verticalScrollBar value: (self rowIndexToVerticalScrollBarValue: showIndex).
	function isExplicit
		ifTrue: [ function resizeWidget ]
]

{ #category : #private }
ToFTTableMorph >> resizeContainer [
	| topLeft bottomRight |
	topLeft := (self bounds left - self borderWidth) @ self bounds top - self borderWidth.
	bottomRight := (self bounds right  - self verticalScrollBarWidth    - self borderWidth)
					 @ (self bounds bottom - self horizontalScrollBarHeight - self borderWidth).
	self container
		bounds:
			(function isExplicit
				ifTrue: [ function resizeContainerFrom: topLeft to: bottomRight ]
				ifFalse: [ topLeft corner: bottomRight ])
]

{ #category : #private }
ToFTTableMorph >> resizeHorizontalScrollBar [
	| width height corner |
	horizontalScrollBar ifNotNil: [
		width := self bounds width - (self borderWidth * 2) - self verticalScrollBarWidth.
		height := self scrollBarThickness.
		corner := self bounds bottomLeft - ((width + self borderWidth)@(0 - self borderWidth)).
		corner := self bounds bottomLeft - ((0 - self borderWidth)@(height+self borderWidth)).
		self horizontalScrollBar bounds: (corner extent: width@height).
		]
]

{ #category : #private }
ToFTTableMorph >> resizeVerticalScrollBar [
	| width height corner |
	width := self scrollBarThickness.
	height := self bounds height - (self borderWidth * 2) - self horizontalScrollBarHeight.
	corner := self bounds topRight - ((width + self borderWidth)@(0 - self borderWidth)).
	self verticalScrollBar bounds: (corner extent: width@height)
]

{ #category : #accessing }
ToFTTableMorph >> rowHeight [
	"This is the row height your rows will have. Cells answered in dataSource will be forced to have
	 this height number... We force it instead allowing lists to have any height because the logic to
	 calculate rows becomes complicated. Possible, but complicated :)"
	^ rowHeight ifNil: [ rowHeight := self class defaultRowHeight ]
]

{ #category : #accessing }
ToFTTableMorph >> rowHeight: aNumber [
	rowHeight := aNumber
]

{ #category : #private }
ToFTTableMorph >> rowIndexToVerticalScrollBarValue: aNumber [
	| numberOfRows |
	numberOfRows := self numberOfRows - self container calculateMinVisibleRows.
	^ (numberOfRows = 0 or: [ aNumber <= 1 ])
		ifTrue: [ 0.0 ]
		ifFalse: [ ((aNumber / numberOfRows) asFloat max: 0.0) min: 1.0 ]
]

{ #category : #private }
ToFTTableMorph >> scrollBarThickness [
	^ self theme scrollbarThickness
]

{ #category : #private }
ToFTTableMorph >> scrollToIndex: anIndex [
	(self container isRowIndexFullyVisible: anIndex) ifTrue: [ ^ self ].

	anIndex <= self showIndex
		ifTrue: [ self moveShowIndexTo: anIndex ]
		ifFalse: [ self moveShowIndexTo: (self selectionModeStrategy indexForRow: anIndex - self container calculateMinVisibleRows + 1) ]
]

{ #category : #'accessing - colors' }
ToFTTableMorph >> secondarySelectionColor [
	^ secondarySelectionColor ifNil: [ self class defaultSecondarySelectionColor ]
]

{ #category : #'accessing - colors' }
ToFTTableMorph >> secondarySelectionColor: aColor [
	secondarySelectionColor := aColor
]

{ #category : #'accessing - selection' }
ToFTTableMorph >> selectAll [
	self isMultipleSelection ifFalse: [ ^ self ].

	self selectionModeStrategy selectAll
]

{ #category : #'accessing - selection' }
ToFTTableMorph >> selectFirst [
	self selectionModeStrategy selectFirst
]

{ #category : #'accessing - selection' }
ToFTTableMorph >> selectIndex: anArray [
	self selectIndexes: {anArray}
]

{ #category : #private }
ToFTTableMorph >> selectIndex: index event: event [
	index
		ifNotNil: [ self selectionStrategy selectIndex: index event: event ]
		ifNil: [ self deselectAll ]
]

{ #category : #'accessing - selection' }
ToFTTableMorph >> selectIndexes: anArray [
	self selectIndexes: anArray andMakeVisibleIf: true
]

{ #category : #'accessing - selection' }
ToFTTableMorph >> selectIndexes: anArray andMakeVisibleIf: shouldEnsureVisibleSelection [
	| oldSelectedIndexes |
	anArray = self selectedIndexes ifTrue: [ ^ self ].
	oldSelectedIndexes := self selectedIndexes.
	self basicSelectIndexes: anArray.
	shouldEnsureVisibleSelection ifTrue: [ self ensureVisibleFirstSelection ].
	self refresh.
	self
		doAnnounce:
			((ToFTSelectionChanged from: oldSelectedIndexes to: self selectedIndexes)
				fastTable: self;
				yourself)
]

{ #category : #'accessing - selection' }
ToFTTableMorph >> selectLast [
	self selectionModeStrategy selectLast
]

{ #category : #'accessing - selection' }
ToFTTableMorph >> selectRowIndex: aNumber [
	self deprecated: 'Use #selectIndex: instead' transformWith: '`@receiver selectRowIndex: `@statements1' -> '`@receiver selectIndex: `@statements1'.
	self selectIndex: aNumber
]

{ #category : #'accessing - selection' }
ToFTTableMorph >> selectedIndex [
	^ self selectedIndexes ifNotEmpty: #first ifEmpty: [ self selectionModeStrategy nullIndex ]
]

{ #category : #'accessing - selection' }
ToFTTableMorph >> selectedIndexes [
	^ selectedIndexes
]

{ #category : #'accessing - colors' }
ToFTTableMorph >> selectionColor [
	^ selectionColor ifNil: [ self class defaultSelectionColor ]
]

{ #category : #'accessing - colors' }
ToFTTableMorph >> selectionColor: aColor [
	selectionColor := aColor
]

{ #category : #accessing }
ToFTTableMorph >> selectionModeStrategy [
	^ selectionModeStrategy
]

{ #category : #accessing }
ToFTTableMorph >> selectionModeStrategy: aStrategy [
	(selectionModeStrategy = aStrategy) ifTrue: [ ^ self ].

	selectionModeStrategy := aStrategy.
	self initializeSelectedIndexes
]

{ #category : #private }
ToFTTableMorph >> selectionStrategy [
	^ selectionStrategy
]

{ #category : #accessing }
ToFTTableMorph >> setMultipleSelection: aBoolean [

	aBoolean
		ifTrue: [ self beMultipleSelection ]
		ifFalse: [ self beSingleSelection ]
]

{ #category : #accessing }
ToFTTableMorph >> shortcutProvider [
	^ PharoShortcuts current
]

{ #category : #accessing }
ToFTTableMorph >> showColumnHeaders [
	"Indicates table will show column headers.
	 See #hideColumnHeaders"
	showColumnHeaders ifTrue: [ ^ self ].
	showColumnHeaders := true.
	self refresh
]

{ #category : #accessing }
ToFTTableMorph >> showFirstSelection [
	self hasSelection ifFalse: [ ^ self ].
	self moveShowIndexTo: self selectedIndex
]

{ #category : #private }
ToFTTableMorph >> showIndex [
	^ showIndex
]

{ #category : #menu }
ToFTTableMorph >> showMenuForIndex: aTuple [
	| menu rowIndex columnIndex |

	rowIndex := aTuple first.
	columnIndex := aTuple second.

	(rowIndex notNil and: [ (self isIndexSelected: rowIndex) not ]) ifTrue: [
		self selectIndex: (self selectionModeStrategy indexFromPosition: aTuple) ].

	menu := self dataSource
		menuColumn: (columnIndex ifNotNil: [self columns at: columnIndex])
		row: (rowIndex ifNil: [0]).

	(menu isNil or: [ menu isInWorld ]) ifTrue: [ ^ self ].

	menu popUpInWorld: self currentWorld
]

{ #category : #menu }
ToFTTableMorph >> showMenuForPosition: aPoint [
	| tuple |
	tuple := self container rowAndColumnIndexContainingPoint: aPoint.
	self showMenuForIndex: tuple
]

{ #category : #'drag and drop' }
ToFTTableMorph >> startDrag: event [

	| passengers transferMorph |

	event hand hasSubmorphs ifTrue: [^ self].
	self dragEnabled ifFalse: [^ self].
	"Here I ensure at least one element is selected "
	event hand anyButtonPressed ifFalse: [ ^self ].
	self hasSelection ifFalse: [ ^ self ].

	passengers := self selectedIndexes collect: [ :each | self dataSource passengerAt: each ].
	transferMorph := self dataSource transferFor: passengers from: self.
	transferMorph align: transferMorph draggedMorph topLeft with: event position.
	transferMorph dragTransferType: self dataSource dragTransferType.

	event hand grabMorph: transferMorph
]

{ #category : #'event testing' }
ToFTTableMorph >> takesKeyboardFocus [
	^ self enabled
]

{ #category : #updating }
ToFTTableMorph >> themeChanged [
	self color: self defaultColor.
	super themeChanged.
	self refresh
]

{ #category : #updating }
ToFTTableMorph >> update: symbol [
	symbol == #refresh ifTrue: [ ^ self refresh ].
	^ super update: symbol
]

{ #category : #private }
ToFTTableMorph >> verticalScrollBar [
	^ verticalScrollBar
]

{ #category : #private }
ToFTTableMorph >> verticalScrollBarValue: aNumber [

	self hasDataSource ifFalse: [ ^ self ].

	showIndex := self verticalScrollBarValueToRowIndex: aNumber.

	self container changed
]

{ #category : #private }
ToFTTableMorph >> verticalScrollBarValueToRowIndex: aNumber [
	| startingIndex |
	startingIndex := self dataSource numberOfRows - self container calculateMinVisibleRows + 1.
	^ (startingIndex * aNumber) asInteger
]

{ #category : #private }
ToFTTableMorph >> verticalScrollBarWidth [
	self isVerticalScrollBarVisible ifFalse: [  ^ 0 ].
	^ self scrollBarThickness
]

{ #category : #accessing }
ToFTTableMorph >> visibleRowMorphAtIndex: index [
	^ container visibleRowMorphAtIndex: index
]

{ #category : #'drag and drop' }
ToFTTableMorph >> wantsDroppedMorph: aMorph event: event [
	aMorph isTransferable ifFalse: [ ^false ].
	^ self dataSource
		wantsDropElements: aMorph passenger
		type: aMorph dragTransferType
		index: ((self container rowIndexContainingPoint: event position) ifNil: [ 0 ])
]
