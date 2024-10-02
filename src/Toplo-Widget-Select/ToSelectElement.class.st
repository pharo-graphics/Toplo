Class {
	#name : #ToSelectElement,
	#superclass : #ToElement,
	#traits : 'TToElementWithPlaceholder',
	#classTraits : 'TToElementWithPlaceholder classTrait',
	#instVars : [
		'filtrable',
		'iconContainer',
		'innerContainer',
		'popupWindowManager'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #testing }
ToSelectElement >> allowDeselection [

	^ true
]

{ #category : #'accessing - window' }
ToSelectElement >> closePopupWindow [

	^ self popupWindowManager closeWindow
]

{ #category : #'accessing - window' }
ToSelectElement >> currentPopupWindow [ 

	^ self popupWindowManager currentWindow
]

{ #category : #'accessing - list' }
ToSelectElement >> dataAccessor [

	self
		deprecated: 'Use #popupListDataAccessor'
		transformWith:
		'`@rcvr dataAccessor' -> '`@rcvr popupListDataAccessor'.

	^ self popupListElement dataAccessor
]

{ #category : #initialization }
ToSelectElement >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #accessing }
ToSelectElement >> filterString [

	^ self textInputElement filterString
]

{ #category : #'accessing - selection' }
ToSelectElement >> filterStringChanged [

	self popupListPattern: self filterString
]

{ #category : #accessing }
ToSelectElement >> filtrable [

	^ filtrable
]

{ #category : #accessing }
ToSelectElement >> filtrable: aBoolean [

	filtrable := aBoolean.
	self textInputElement selectFiltrable: aBoolean
]

{ #category : #accessing }
ToSelectElement >> iconContainer [

	^ iconContainer
]

{ #category : #accessing }
ToSelectElement >> iconContainer: anIconContainer [

	iconContainer := anIconContainer.
	iconContainer constraintsDo: [ :c | c linear vertical alignCenter ]
]

{ #category : #initialization }
ToSelectElement >> initialize [

	super initialize.
	filtrable := false.

	" for the popup "
	popupWindowManager := self newPopupWindowManager.
	popupWindowManager onInstalledIn: self.

	self iconContainer: self newIconContainer.
	self innerContainer: self newInnerContainer.
	self addChildren: {
			self innerContainer.
			self iconContainer }.

	self addEventHandlerOn: ToPlaceholderShownEvent do: [ :event |
		self flag:
			'The width of 16???. Why ? Anyway, it should be handled via a skin'.
		event placeholder padding: (BlInsets left: 16).
		event placeholder layout alignCenterLeft ].

	" a select is made to be horizontal. the following constraints 
	must be set here to initialize the resizers properly "
	self vFitContent.
	self hMatchParent
]

{ #category : #accessing }
ToSelectElement >> innerContainer [

	^ innerContainer
]

{ #category : #accessing }
ToSelectElement >> innerContainer: anInnerContainerElement [

	innerContainer := anInnerContainerElement.
	innerContainer constraintsDo: [ :c |
		c linear vertical alignCenter.
		c horizontal matchParent.
		c vertical fitContent ]
]

{ #category : #'instance creation' }
ToSelectElement >> innerContainerClass [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToSelectElement >> inputTextField [ 

	^ self innerContainer inputTextField
]

{ #category : #testing }
ToSelectElement >> isFiltrable [ 

	^ filtrable
]

{ #category : #testing }
ToSelectElement >> isMultipleSelection [ 

	^ self innerContainer isMultipleSelection
]

{ #category : #'accessing - list' }
ToSelectElement >> listElement [

	self
		deprecated: 'Use #popupListElement'
		transformWith: '`@rcvr listElement' -> '`@rcvr popupListElement'.

	^ self popupListElement
]

{ #category : #'instance creation' }
ToSelectElement >> newIconContainer [

	^ ToSelectIconContainer new forFiltering: self isFiltrable 
]

{ #category : #'instance creation' }
ToSelectElement >> newInnerContainer [

	| container |
	container := self innerContainerClass onSelectElement: self.
	container id: #innerContainer.
	^ container
]

{ #category : #'instance creation' }
ToSelectElement >> newPopupWindowManager [

	^ ToSelectPopupWindowManager new
]

{ #category : #skin }
ToSelectElement >> newRawSkin [ 

	^ ToSelectElementSkin new
]

{ #category : #'instance creation' }
ToSelectElement >> newShortcutsStore [ 

	^ ToSelectShortcutsStore new
]

{ #category : #layout }
ToSelectElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	"self class name trace. ' ' trace. 'onLayout: context:' traceCr"
]

{ #category : #window }
ToSelectElement >> onPopupWindowClosed [

	self textInputElement onPopupWindowClosed
]

{ #category : #window }
ToSelectElement >> onPopupWindowOpened [

	self textInputElement onPopupWindowOpened
]

{ #category : #'accessing - selection' }
ToSelectElement >> onSelectionChangedInPopupListElement: anEvent [

	self innerContainer onSelectionChangedInPopupListElement: anEvent
]

{ #category : #window }
ToSelectElement >> onWindowClosed [
	self
		deprecated: 'Use #onPopupWindowClosed'
		transformWith: '`@rcvr onWindowClosed' -> '`@rcvr onPopupWindowClosed'.
	self onPopupWindowClosed
]

{ #category : #window }
ToSelectElement >> onWindowOpened [
	self
		deprecated: 'Use #onPopupWindowOpened'
		transformWith: '`@rcvr onWindowOpened' -> '`@rcvr onPopupWindowOpened'.
	self onPopupWindowOpened
]

{ #category : #accessing }
ToSelectElement >> pattern [
	self
		deprecated: 'Use #popupListPattern'
		transformWith: '`@rcvr pattern' -> '`@rcvr popupListPattern'.

	^ self popupListPattern
]

{ #category : #accessing }
ToSelectElement >> pattern: aPattern [


	self
		deprecated: 'Use #popupListPattern: '
		transformWith: '`@rcvr pattern: `@arg' -> '`@rcvr popupListPattern: `@arg'.

	self popupListPattern: aPattern
]

{ #category : #'accessing - list' }
ToSelectElement >> popupListDataAccessor [

	self
		deprecated: 'Use #popupListElement dataAccessor'
		transformWith: '`@rcvr popupListDataAccessor' -> '`@rcvr popupListElement dataAccessor'.

	^ self popupListElement dataAccessor
]

{ #category : #'accessing - list' }
ToSelectElement >> popupListElement [

	^ self popupWindowManager listElement
]

{ #category : #'accessing - list' }
ToSelectElement >> popupListPattern [

	^ self sieve pattern
]

{ #category : #'accessing - list' }
ToSelectElement >> popupListPattern: aPattern [

	self popupListSieve pattern: aPattern
]

{ #category : #'accessing - list' }
ToSelectElement >> popupListSelecter [

	^ self popupListSieve selecter
]

{ #category : #'accessing - selection' }
ToSelectElement >> popupListSelectionModel [

	^ self popupListSieve selectionModel
]

{ #category : #'accessing - list' }
ToSelectElement >> popupListSieve [

	^ popupWindowManager sieve
]

{ #category : #'accessing - list' }
ToSelectElement >> popupMaxHeight: aNumber [

	self popupWindowManager maxHeight: aNumber
]

{ #category : #'accessing - list' }
ToSelectElement >> popupMinHeight: aNumber [

	self windowManager minHeight: aNumber
]

{ #category : #'accessing - list' }
ToSelectElement >> popupPositionHook: aValuable [

	self windowManager positionHook: aValuable
]

{ #category : #'accessing - list' }
ToSelectElement >> popupSizeHook: aValuable [

	self windowManager sizeHook: aValuable
]

{ #category : #'accessing - window' }
ToSelectElement >> popupWindowEvent: anEvent [ 

	^ self windowManager popupWindowEvent: anEvent 
]

{ #category : #accessing }
ToSelectElement >> popupWindowManager [


	^ popupWindowManager
]

{ #category : #accessing }
ToSelectElement >> refresh [

	self innerContainer refresh
]

{ #category : #layout }
ToSelectElement >> requestLayout: x [

	super requestLayout: x.
]

{ #category : #accessing }
ToSelectElement >> sample: aDataItem [

	self innerContainer sample: aDataItem
]

{ #category : #accessing }
ToSelectElement >> selecter [ 

	self
		deprecated: 'Use #popupListSelecter'
		transformWith: '`@rcvr selecter' -> '`@rcvr popupListSelecter'.

	^ self popupListSelecter
]

{ #category : #'accessing - selection' }
ToSelectElement >> selectionModel [


	self
		deprecated: 'Use #popupListSelectionModel'
		transformWith: '`@rcvr selectionModel' -> '`@rcvr popupListSelectionModel'.

	^ self popupListSelectionModel
]

{ #category : #private }
ToSelectElement >> showHidePlaceholder [
	" show the placeholder in case no item is selected and nothing 
	is entered in the input text field "

	self popupListSelectionModel ifEmpty: [
		self inputTextField text ifEmpty: [ ^ self showPlaceholder ] ].
	self hidePlaceholder
]

{ #category : #accessing }
ToSelectElement >> sieve [
	self
		deprecated: 'Use #popupListSieve'
		transformWith: '`@rcvr sieve' -> '`@rcvr popupListSieve'.

	^ self popupListSieve
]

{ #category : #accessing }
ToSelectElement >> textInputElement [ 

	^ self innerContainer textInputElement
]

{ #category : #accessing }
ToSelectElement >> windowManager [

	self
		deprecated: 'Use #popupWindowManager'
		transformWith: '`@rcvr windowManager' -> '`@rcvr popupWindowManager'.

	^ self popupWindowManager
]
