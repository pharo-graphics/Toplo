Class {
	#name : #ToSelectElement,
	#superclass : #ToTripletElement,
	#traits : 'TToElementWithPlaceholder',
	#classTraits : 'TToElementWithPlaceholder classTrait',
	#instVars : [
		'filtrable',
		'windowManager'
	],
	#category : #'Toplo-Widget-Select-Single'
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

	^ self nodeContainer filterString
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
	aBoolean
		ifTrue: [ self textInputElement beEditable ]
		ifFalse: [ self textInputElement beReadonly ].
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
	self installNodeContainerAndRefresh.
	self iconContainer: self newIconContainer.
	
	self addEventHandlerOn: ToPlaceholderShownEvent do: [ :event |
		self flag: 'The width of 16???. Why ? Anyway, it should be handled via a skin'.
		event placeholder padding: (BlInsets left: 16).
		event placeholder layout alignCenterLeft ]
]

{ #category : #accessing }
ToSelectElement >> inputTextField [ 

	^ self nodeContainer inputTextField
]

{ #category : #initialization }
ToSelectElement >> installNodeContainer [

	self nodeContainer ifNotNil: [
		self nodeContainer onUninstalledIn: self ].
	self middleElement: self newNodeContainer.
	self middleContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	self nodeContainer onInstalledIn: self.
	self listElement selectionMode multiple: false.
	self requestNewSkin
]

{ #category : #initialization }
ToSelectElement >> installNodeContainerAndRefresh [

	self installNodeContainer.
	self refresh
]

{ #category : #testing }
ToSelectElement >> isFiltrable [ 

	^ filtrable
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
ToSelectElement >> newNodeContainer [

	| container |
	container := self nodeContainerClass new.
	container id: #nodeContainer.
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

	| wm |
	wm := ToSelectListWindowManager new.
	wm onInstalledIn: self.
	^ wm
]

{ #category : #accessing }
ToSelectElement >> nodeBuilder: aValuable [

	self nodeContainer nodeBuilder: aValuable
]

{ #category : #accessing }
ToSelectElement >> nodeContainer [

	^ self middleElement 
]

{ #category : #'instance creation' }
ToSelectElement >> nodeContainerClass [

	^ ToSelectNodeContainerElement
]

{ #category : #accessing }
ToSelectElement >> nodeFactory: aValuable [

	self nodeContainer nodeFactory: aValuable
]

{ #category : #'accessing - selection' }
ToSelectElement >> onSelectionChangedInListElement [

	self showHidePlaceholder.
	self nodeContainer refresh.
	self listElement notifyPrimarySelectionDirty.
	self nodeContainer requestLayout
]

{ #category : #window }
ToSelectElement >> onWindowClosed [

	self nodeContainer onWindowClosed
]

{ #category : #window }
ToSelectElement >> onWindowOpened [

	self nodeContainer onWindowOpened
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

	"self nodeContainer refresh"
]

{ #category : #'accessing - selection' }
ToSelectElement >> selecter [

	^ self listElement selecter
]

{ #category : #'accessing - selection' }
ToSelectElement >> selectionModel [

	^ self listElement selectionModel
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

	^ self nodeContainer textInputElement
]

{ #category : #accessing }
ToSelectElement >> windowManager [

	^ windowManager
]

{ #category : #accessing }
ToSelectElement >> windowManager: aSelectWindowManager [

	windowManager := aSelectWindowManager 
]
