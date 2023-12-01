Class {
	#name : 'ToListElement',
	#superclass : 'ToElement',
	#traits : 'TToListElementDecorator',
	#classTraits : 'TToListElementDecorator classTrait',
	#category : 'Toplo-Widget-List-core',
	#package : 'Toplo-Widget-List',
	#tag : 'core'
}

{ #category : 'orientation' }
ToListElement >> beHorizontal [

	self infinite layout beHorizontal
]

{ #category : 'orientation' }
ToListElement >> beVertical [

	self infinite layout beVertical
]

{ #category : 'initialization' }
ToListElement >> dataSharedEvents [

	^ {
		  ToCollectionAddEvent.
		  ToCollectionRemoveEvent.
		  ToCollectionUpdateEvent }
]

{ #category : 'initialization' }
ToListElement >> dataSourceSharedEvents [

	^ {
		  ToDataEmptinessChangeEvent.
		  ToDataFilterRequest }
]

{ #category : 'initialization' }
ToListElement >> defaultBackground [

	^ BlBackground paint: Color white
]

{ #category : 'initialization' }
ToListElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : 'initialization' }
ToListElement >> defaultMargin [

	^ BlInsets all: 0
]

{ #category : 'initialization' }
ToListElement >> defaultPadding [

	" Must be 1 to see the focus frame AND to draw selection decoration correctly (not outside infinite bounds)  "
	^ BlInsets all: 1

]

{ #category : 'orientation' }
ToListElement >> horizontal: aBoolean [

	self vertical: aBoolean not
]

{ #category : 'initialization' }
ToListElement >> infiniteElementSharedEvents [

	^ {
		  ToListStrongSelectionEvent.
		  BlElementScrolledEvent.
		  BlElementExtentChangedEvent.
		  ToInfiniteSelectionChangedEvent.
		  BlBlurEvent.
		  BlFocusEvent }
]

{ #category : 'initialization' }
ToListElement >> initialize [

	| sharedDistributor |
	super initialize.

	self layout: self defaultLayout.
	self next: ToListInfiniteElement new.
	self next padding: (BlInsets top: 1 left: 4 bottom: 1 right: 4).
	self addEventHandler: ToListElementEventHandler new.
	
	"Also installs shared event distributors between the list element, 
	the infinite, the data and the data source. 
	This gives the possibility to directly add event handlers on shared events :
		self when: ToInfiniteSelectionChangedEvent do: [ bla bla ] 
		instead of 
		self infinite when: ToInfiniteSelectionChangedEvent do: [ bla bla ] "
	sharedDistributor := BlSharedEventDistributor new
		                     shareEvents: self sharedEvents
		                     yourself.
	self addEventHandler: sharedDistributor.
	self data addEventHandler: sharedDistributor.
	self dataSource addEventHandler: sharedDistributor.
	self infinite addEventHandler: sharedDistributor.

	self addChild: self next.
	self infinite elevation: (BlRelativeElevation elevation: 10).

	self matchParent.
	self background: self defaultBackground.
	self margin: self defaultMargin.
	self padding: self defaultPadding.

]

{ #category : 'orientation' }
ToListElement >> isHorizontal [

	^ self infinite layout isHorizontal
]

{ #category : 'orientation' }
ToListElement >> isVertical [

	^ self infinite layout isVertical
]

{ #category : 't - element with placeholder' }
ToListElement >> placeholderElevation [

	^ self infinite elevation
]

{ #category : 'initialization' }
ToListElement >> sharedEvents [

	^ self dataSourceSharedEvents , self dataSharedEvents , self infiniteElementSharedEvents
]

{ #category : 'orientation' }
ToListElement >> vertical: aBoolean [

	aBoolean
		ifTrue: [ self beVertical ]
		ifFalse: [ self beHorizontal ]
]
