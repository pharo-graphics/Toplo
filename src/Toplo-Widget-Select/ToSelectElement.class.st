Class {
	#name : #ToSelectElement,
	#superclass : #ToTripletElement,
	#traits : 'TToElementWithPlaceholder',
	#classTraits : 'TToElementWithPlaceholder classTrait',
	#instVars : [
		'filtrable',
		'windowManager'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'accessing - window' }
ToSelectElement >> closeWindow [

	^ self windowManager closeWindow
]

{ #category : #'accessing - window' }
ToSelectElement >> currentWindow [ 

	^ self windowManager currentWindow
]

{ #category : #'accessing - list' }
ToSelectElement >> dataAccessor [

	^ self listElement dataAccessor
]

{ #category : #accessing }
ToSelectElement >> filterString [ 

	^ self textInputElement filterString
]

{ #category : #'accessing - selection' }
ToSelectElement >> filterStringChanged [

	self pattern: self filterString
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

	^ self endElement
]

{ #category : #accessing }
ToSelectElement >> iconContainer: anIconContainer [

	self endElement: anIconContainer
]

{ #category : #initialization }
ToSelectElement >> initialize [

	super initialize.
	filtrable := true.
		
	" for the popup "
	windowManager := self newWindowManager.
	windowManager onInstalledIn: self.
	
	self iconContainer: self newIconContainer.
	self installInnerContainer.
	
	self addEventHandlerOn: ToPlaceholderShownEvent do: [ :event |
		self flag: 'The width of 16???. Why ? Anyway, it should be handled via a skin'.
		event placeholder padding: (BlInsets left: 16).
		event placeholder layout alignCenterLeft ]
]

{ #category : #accessing }
ToSelectElement >> innerContainer [

	^ self middleElement 
]

{ #category : #'instance creation' }
ToSelectElement >> innerContainerClass [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToSelectElement >> inputTextField [ 

	^ self innerContainer inputTextField
]

{ #category : #initialization }
ToSelectElement >> installInnerContainer [

	self innerContainer ifNotNil: [ BlImmutableObjectChangeError signal ].
	self middleElement: self newInnerContainer.
	self middleContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	self requestNewSkin
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
ToSelectElement >> listDataNodeBuilder: aBuilder [

	self windowManager listDataNodeBuilder: aBuilder
]

{ #category : #'accessing - list' }
ToSelectElement >> listElement [

	^ self windowManager listElement
]

{ #category : #'accessing - list' }
ToSelectElement >> listNodeBuilder: aValuable [

	self listElement nodeBuilder: aValuable
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

{ #category : #skin }
ToSelectElement >> newRawSkin [ 

	^ ToSelectElementSkin new
]

{ #category : #'instance creation' }
ToSelectElement >> newShortcutsStore [ 

	^ ToSelectShortcutsStore new
]

{ #category : #'instance creation' }
ToSelectElement >> newWindowManager [

	^ ToSelectListWindowManager new
]

{ #category : #layout }
ToSelectElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	"self class name trace. ' ' trace. 'onLayout: context:' traceCr"
]

{ #category : #'accessing - selection' }
ToSelectElement >> onSelectionChangedInListElement: anEvent [

	self innerContainer onSelectionChangedInSelectElement: anEvent
]

{ #category : #window }
ToSelectElement >> onWindowClosed [

	self textInputElement onWindowClosed
]

{ #category : #window }
ToSelectElement >> onWindowOpened [

	self textInputElement onWindowOpened
]

{ #category : #accessing }
ToSelectElement >> pattern [

	^ self sieve pattern
]

{ #category : #accessing }
ToSelectElement >> pattern: aPattern [

	self sieve pattern: aPattern
]

{ #category : #'accessing - list' }
ToSelectElement >> popupMaxHeight: aNumber [

	self windowManager maxHeight: aNumber
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
ToSelectElement >> refresh [

	self innerContainer refresh
]

{ #category : #layout }
ToSelectElement >> requestLayout: x [

	super requestLayout: x.
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

	self selectionModel ifEmpty: [
		self inputTextField text ifEmpty: [
			^ self showPlaceholder ] ].
	self hidePlaceholder
]

{ #category : #accessing }
ToSelectElement >> sieve [

	^ windowManager sieve
]

{ #category : #accessing }
ToSelectElement >> textInputElement [ 

	^ self innerContainer textInputElement
]

{ #category : #accessing }
ToSelectElement >> windowManager [

	^ windowManager
]

{ #category : #accessing }
ToSelectElement >> windowManager: aSelectWindowManager [

	windowManager := aSelectWindowManager 
]
