Class {
	#name : #ToSelectElement,
	#superclass : #ToElement,
	#traits : 'TToElementWithPlaceholder',
	#classTraits : 'TToElementWithPlaceholder classTrait',
	#instVars : [
		'filtrable',
		'iconContainer',
		'popupWindowManager',
		'innerElement'
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

	^ self filterTextField text asString
]

{ #category : #'accessing - selection' }
ToSelectElement >> filterStringChanged [

	self pattern: self filterString
]

{ #category : #accessing }
ToSelectElement >> filterTextField [ 

	^ self innerElement filterTextField
]

{ #category : #accessing }
ToSelectElement >> filtrable [

	^ filtrable
]

{ #category : #accessing }
ToSelectElement >> filtrable: aBoolean [

	filtrable := aBoolean.
	self filterTextField selectFiltrable: aBoolean
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
	self innerElement: self newInnerElement.
	self addChildren: {
			self innerElement.
			self iconContainer }.

	self addEventHandlerOn: ToPlaceholderShownEvent do: [ :event |
		self flag:
			'The width of 16???. Why ? Anyway, it should be handled via a skin'.
		event placeholder padding: (BlInsets left: (self valueOfTokenNamed: #'padding-XS')).
		event placeholder layout alignCenterLeft ].

	" a select is made to be horizontal. the following constraints 
	must be set here to initialize the resizers properly "
	self vFitContent.
	self hMatchParent
]

{ #category : #accessing }
ToSelectElement >> innerElement [

	^ innerElement
]

{ #category : #accessing }
ToSelectElement >> innerElement: anInnerContainerElement [

	innerElement := anInnerContainerElement.
	innerElement constraintsDo: [ :c |
		c linear vertical alignCenter.
		c horizontal matchParent.
		c vertical fitContent ]
]

{ #category : #'instance creation' }
ToSelectElement >> innerElementClass [

	^ self subclassResponsibility 
]

{ #category : #testing }
ToSelectElement >> isFiltrable [ 

	^ filtrable
]

{ #category : #testing }
ToSelectElement >> isMultipleSelection [ 

	^ self innerElement isMultipleSelection
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
ToSelectElement >> newInnerElement [

	| container |
	container := self innerElementClass onSelectElement: self.
	container id: #innerElement.
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

	self filterTextField requestFocus
]

{ #category : #window }
ToSelectElement >> onPopupWindowOpened [

	self filterTextField requestFocus
]

{ #category : #'accessing - selection' }
ToSelectElement >> onSelectionChangedInPopupListElement: anEvent [

	self innerElement onSelectionChangedInPopupListElement: anEvent
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
ToSelectElement >> pattern: aPattern [

	self sieve pattern: aPattern
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

{ #category : #'accessing - selection' }
ToSelectElement >> popupListSelectionModel [


	self
		deprecated: 'Use #selectionModel'
		transformWith: '`@rcvr popupListSelectionModel' -> '`@rcvr selectionModel'.

	^ self selectionModel
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

	^ self popupWindowManager popupWindowEvent: anEvent
]

{ #category : #accessing }
ToSelectElement >> popupWindowManager [


	^ popupWindowManager
]

{ #category : #accessing }
ToSelectElement >> refresh [

	self innerElement refreshFromPopupListSelection
]

{ #category : #layout }
ToSelectElement >> requestLayout: x [

	super requestLayout: x.
]

{ #category : #accessing }
ToSelectElement >> sample: aDataItem [

	self innerElement sample: aDataItem
]

{ #category : #accessing }
ToSelectElement >> selecter [ 

	^ self sieve selecter
]

{ #category : #'accessing - selection' }
ToSelectElement >> selectionModel [


	^ self sieve selectionModel
]

{ #category : #private }
ToSelectElement >> showHidePlaceholder [
	" show the placeholder in case no item is selected and nothing 
	is entered in the input text field "

	self selectionModel ifEmpty: [
		^ self showPlaceholder ].
	self hidePlaceholder
]

{ #category : #accessing }
ToSelectElement >> sieve [

	^ popupWindowManager sieve
]

{ #category : #accessing }
ToSelectElement >> windowManager [

	self
		deprecated: 'Use #popupWindowManager'
		transformWith: '`@rcvr windowManager' -> '`@rcvr popupWindowManager'.

	^ self popupWindowManager
]
