Class {
	#name : #ToListElement2,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator2 + TToElementWithPlaceholder',
	#classTraits : 'TToListElementDecorator2 classTrait + TToElementWithPlaceholder classTrait',
	#instVars : [
		'selectionElements',
		'sharedDistributor',
		'selectionManager'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #orientation }
ToListElement2 >> beHorizontal [

	self infinite layout beHorizontal
]

{ #category : #orientation }
ToListElement2 >> beVertical [

	self infinite layout beVertical
]

{ #category : #initialization }
ToListElement2 >> dataSharedEvents [

	^ { ToCollectionEmptinessEvent }
]

{ #category : #initialization }
ToListElement2 >> defaultInfiniteElement [ 

	^ ToInfiniteElement2 new
]

{ #category : #initialization }
ToListElement2 >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToListElement2 >> defaultSelectionMode [

	^ ToListMultiSelectionMode new
]

{ #category : #initialization }
ToListElement2 >> defaultSelectionModel [

	^ ToListSelectionModel new
]

{ #category : #orientation }
ToListElement2 >> horizontal: aBoolean [

	self vertical: aBoolean not
]

{ #category : #initialization }
ToListElement2 >> infiniteElementSharedEvents [

	^ {
		  BlInfiniteElementAttachedEvent.
		  BlInfiniteElementDetachedEvent.
		  ToDataSourceAttachedEvent.
		  ToDataSourceDetachedEvent.
		  BlElementScrolledEvent.
		  BlElementExtentChangedEvent.
		  BlBlurEvent.
		  BlFocusEvent }
]

{ #category : #initialization }
ToListElement2 >> initialize [

	super initialize.

	selectionElements := #(  ).

	self layout: self defaultLayout.
	self next: self defaultInfiniteElement.

	selectionManager := ToListSelectionManager new.
	self addEventHandler: ToListElementEventHandler2 new.
	self selectionMode: self defaultSelectionMode.
	self selectionModel: self defaultSelectionModel.
	self addEventHandler: ToSelectionRequestEventHandler new.

	self installSharedEventDistributor.

	self addChild: self next.
	self infinite elevation: (BlRelativeElevation elevation: 10).
	self contextMenuWindowManagerClass:
		ToListElementContextMenuWindowManager.
	self addEventHandler: ToListSelectionElementEventHandler2 new.
	self addEventHandler:
		ToListElementContextMenuSelectionEventHandler new.
	self matchParent
]

{ #category : #initialization }
ToListElement2 >> installSharedEventDistributor [
	"installs shared event distributors between the list element, the selection strategy,
	the infinite, the data and the data source. 
	This gives the possibility to directly add event handlers on shared events :
		self when: ToInfiniteSelectionChangedEvent do: [ bla bla ] 
		instead of 
		self infinite when: ToInfiniteSelectionChangedEvent do: [ bla bla ] "

	sharedDistributor := ToSharedEventDistributor new
		                     shareEvents: self sharedEvents;
		                     yourself.
	self addEventHandler: sharedDistributor.
	self data addEventHandler: sharedDistributor.
	self infinite addEventHandler: sharedDistributor
]

{ #category : #orientation }
ToListElement2 >> isHorizontal [

	^ self infinite layout isHorizontal
]

{ #category : #orientation }
ToListElement2 >> isVertical [

	^ self infinite layout isVertical
]

{ #category : #skin }
ToListElement2 >> newRawSkin [ 

	^ ToListElementSkin new
]

{ #category : #'t - element with placeholder' }
ToListElement2 >> placeholderElevation [

	^ self infinite elevation
]

{ #category : #'focus requesting' }
ToListElement2 >> requestFocus [

	self infinite requestFocus
]

{ #category : #accessing }
ToListElement2 >> selectionElements [

	^ selectionElements
]

{ #category : #accessing }
ToListElement2 >> selectionElements: aListElementSelectionCollection [

	selectionElements := aListElementSelectionCollection
]

{ #category : #accessing }
ToListElement2 >> selectionManager [

	^ selectionManager
]

{ #category : #accessing }
ToListElement2 >> selectionMode [

	^ self selectionManager selectionMode
]

{ #category : #accessing }
ToListElement2 >> selectionMode: aSelectionMode [

	self selectionManager mode: aSelectionMode
]

{ #category : #accessing }
ToListElement2 >> selectionModel [

	^ self selectionManager selectionModel
]

{ #category : #accessing }
ToListElement2 >> selectionModel: aSelectionModel [

	self selectionManager selectionModel: aSelectionModel
]

{ #category : #initialization }
ToListElement2 >> selectionStrategySharedEvents [

	^ {
		  ToListClickOnNodeEvent.
		  ToListSelectionActionEvent.
		  ToListSelectionDirtyEvent.
		  ToListSelectionChangedEvent.
		  ToListStrongSelectionEvent.
		  ToListSelectionModeChangedEvent }
]

{ #category : #initialization }
ToListElement2 >> sharedEvents [

	^ Array streamContents: [ :stream |
		  stream nextPutAll: self dataSharedEvents.
		  stream nextPutAll: self infiniteElementSharedEvents.
		  stream nextPutAll: self selectionStrategySharedEvents ]
]

{ #category : #initialization }
ToListElement2 >> uninstallSharedEventDistributor [
	" see uninstallSharedEventDistributor "

	sharedDistributor ifNil: [ ^ self ].
	self removeEventHandler: sharedDistributor.
	self data removeEventHandler: sharedDistributor.
	self infinite removeEventHandler: sharedDistributor.
	self selectionStrategy removeEventHandler: sharedDistributor.
	sharedDistributor := nil
]

{ #category : #orientation }
ToListElement2 >> vertical: aBoolean [

	aBoolean
		ifTrue: [ self beVertical ]
		ifFalse: [ self beHorizontal ]
]
