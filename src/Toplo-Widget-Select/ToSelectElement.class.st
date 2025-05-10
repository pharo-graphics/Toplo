"
Conceptually I'm a kind of abstract combox where one or several elements are selected from a list.
 
There are two main kind of select: 
- single where only one element from the list can be selected
- multiple where multiple elements from the list can be selected

My innerElement reflects this difference: it will be either a single element or a list of elements. 
In addition the contents of my list can be filtered.
The header can be composed of the selected elements and an icon.

See https://ant.design/components/select for a functional reference. 

"
Class {
	#name : #ToSelectElement,
	#superclass : #ToElement,
	#traits : 'TToElementWithPlaceholder',
	#classTraits : 'TToElementWithPlaceholder classTrait',
	#instVars : [
		'filtrable',
		'iconContainer',
		'innerElement',
		'windowManager',
		'sample'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #testing }
ToSelectElement >> allowDeselection [

	^ true
]

{ #category : #configuration }
ToSelectElement >> applyWidgetConfiguration [ 

	super applyWidgetConfiguration.
	self filterTextField selectFiltrable: filtrable.
	filtrable ifTrue: [ self filterTextField requestFocus ].
	sample ifNotNil: [ self innerElement sample: sample ]
]

{ #category : #'accessing - window' }
ToSelectElement >> closeOnPicking: aBoolean [

	self manager closeOnPicking: aBoolean
]

{ #category : #'accessing - window' }
ToSelectElement >> currentPopupWindow [

	^ self manager currentWindow
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
ToSelectElement >> defaultEventHandler [

	^ ToSelectEventHandler new
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
	self requestNewConfiguration
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
	windowManager := self newPopupWindowManager.
	self addEventHandler: windowManager.

	self iconContainer: self newIconContainer.
	self innerElement: self newInnerElement.
	self addChildren: {
			self innerElement.
			self iconContainer }.
			
	self addEventHandler: self defaultEventHandler.

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

{ #category : #accessing }
ToSelectElement >> manager [

	^ windowManager 
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

	^ ToSelectPopupManager new
]

{ #category : #skin }
ToSelectElement >> newRawSkin [ 

	^ ToSelectElementSkin new
]

{ #category : #'instance creation' }
ToSelectElement >> newShortcutsStore [ 

	^ ToSelectShortcutsStore new
]

{ #category : #window }
ToSelectElement >> onClosed [
	self
		deprecated: 'Use #onPopupWindowClosed'
		transformWith: '`@rcvr onWindowClosed' -> '`@rcvr onPopupWindowClosed'.
	self onPopupWindowClosed
]

{ #category : #layout }
ToSelectElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	"self class name trace. ' ' trace. 'onLayout: context:' traceCr"
]

{ #category : #window }
ToSelectElement >> onOpened [
	self
		deprecated: 'Use #onPopupWindowOpened'
		transformWith: '`@rcvr onWindowOpened' -> '`@rcvr onPopupWindowOpened'.
	self onPopupWindowOpened
]

{ #category : #window }
ToSelectElement >> onPopupWindowClosed [

	self filterTextField infinite requestFocus
]

{ #category : #window }
ToSelectElement >> onPopupWindowOpened [

	self filterTextField infinite requestFocus
]

{ #category : #'accessing - selection' }
ToSelectElement >> onSelectionChangedInPopupListElement: anEvent [

	self innerElement onSelectionChangedInPopupListElement: anEvent
]

{ #category : #accessing }
ToSelectElement >> pattern: aPattern [

	self sieve pattern: aPattern
]

{ #category : #'accessing - list' }
ToSelectElement >> popupDataAccessor [

	^ self popupListElement dataAccessor
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

	^ self manager listElement
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

	self manager maxHeight: aNumber
]

{ #category : #'accessing - list' }
ToSelectElement >> popupMinHeight: aNumber [

	self windowManager minHeight: aNumber
]

{ #category : #accessing }
ToSelectElement >> popupWindowManager [

	self
		deprecated: 'Use #windowManager'
		transformWith: '`@rcvr popupWindowManager' -> '`@rcvr windowManager'.

	^ self windowManager 
]

{ #category : #'accessing - window' }
ToSelectElement >> popupWindowPlacement: aPlacement [

	self manager placement: aPlacement
]

{ #category : #accessing }
ToSelectElement >> refresh [

	self innerElement refreshFromPopupListSelection
]

{ #category : #accessing }
ToSelectElement >> sample: aDataItem [

	sample := aDataItem.
	self requestNewConfiguration
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

	^ self manager sieve
]

{ #category : #accessing }
ToSelectElement >> windowManager [

	self
		deprecated: 'Use #manager instead'
		transformWith: '`@rcvr windowManager' -> '`@rcvr manager'.
	^ self manager
]
