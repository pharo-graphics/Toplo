Class {
	#name : #ToListElement,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator + TToElementWithPlaceholder',
	#classTraits : 'TToListElementDecorator classTrait + TToElementWithPlaceholder classTrait',
	#instVars : [
		'selectionElements'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #orientation }
ToListElement >> beHorizontal [

	self infinite layout beHorizontal
]

{ #category : #orientation }
ToListElement >> beVertical [

	self infinite layout beVertical
]

{ #category : #initialization }
ToListElement >> dataSharedEvents [

	^ {
		  ToCollectionAddEvent.
		  ToCollectionRemoveRequest.
		  ToCollectionRemoveEvent.
		  ToCollectionUpdateEvent }
]

{ #category : #initialization }
ToListElement >> dataSourceSharedEvents [

	^ { ToDataEmptinessChangeEvent }
]

{ #category : #initialization }
ToListElement >> defaultInfiniteElement [ 

	^ ToInfiniteElement new
]

{ #category : #initialization }
ToListElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToListElement >> defaultSelectionStrategy [

	^ ToStandardListSelectionStrategy new
]

{ #category : #orientation }
ToListElement >> horizontal: aBoolean [

	self vertical: aBoolean not
]

{ #category : #initialization }
ToListElement >> infiniteElementSharedEvents [

	^ {
		  BlInfiniteElementAttachedEvent.
		  BlInfiniteElementDetachedEvent.
		  ToListSelectionActionEvent.
		  ToStrongSelectionEvent.
		  ToInfiniteSelectionDirtyEvent.
		  ToInfiniteSelectionChangedEvent.
		  BlElementScrolledEvent.
		  BlElementExtentChangedEvent.
		  BlBlurEvent.
		  BlFocusEvent }
]

{ #category : #initialization }
ToListElement >> initialize [

	| sharedDistributor |
	super initialize.

	selectionElements := #(  ).
	self layout: self defaultLayout.
	self next: self defaultInfiniteElement.

	self addEventHandler: ToListElementEventHandler new.

	"Also installs shared event distributors between the list element, 
	the infinite, the data and the data source. 
	This gives the possibility to directly add event handlers on shared events :
		self when: ToInfiniteSelectionChangedEvent do: [ bla bla ] 
		instead of 
		self infinite when: ToInfiniteSelectionChangedEvent do: [ bla bla ] "
	sharedDistributor := BlSharedEventDistributor new shareEvents:
		                     self sharedEvents yourself.
	self addEventHandler: sharedDistributor.
	self data addEventHandler: sharedDistributor.
	self dataSource addEventHandler: sharedDistributor.
	self infinite addEventHandler: sharedDistributor.

	self addChild: self next.
	self infinite elevation: (BlRelativeElevation elevation: 10).
	self contextMenuWindowManagerClass:
		ToListElementContextMenuWindowManager.
	self addEventHandler: ToListSelectionEventHandler new.
	self addEventHandler:
		ToListElementContextMenuSelectionEventHandler new.
	self matchParent.
	self selectionStrategy: self defaultSelectionStrategy
]

{ #category : #orientation }
ToListElement >> isHorizontal [

	^ self infinite layout isHorizontal
]

{ #category : #orientation }
ToListElement >> isVertical [

	^ self infinite layout isVertical
]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]

{ #category : #'t - element with placeholder' }
ToListElement >> placeholderElevation [

	^ self infinite elevation
]

{ #category : #'focus requesting' }
ToListElement >> requestFocus [

	self infinite requestFocus
]

{ #category : #accessing }
ToListElement >> selectionElements [

	^ selectionElements
]

{ #category : #accessing }
ToListElement >> selectionElements: aListElementSelectionCollection [

	selectionElements := aListElementSelectionCollection
]

{ #category : #initialization }
ToListElement >> sharedEvents [

	^ self dataSourceSharedEvents , self dataSharedEvents , self infiniteElementSharedEvents
]

{ #category : #orientation }
ToListElement >> vertical: aBoolean [

	aBoolean
		ifTrue: [ self beVertical ]
		ifFalse: [ self beHorizontal ]
]
