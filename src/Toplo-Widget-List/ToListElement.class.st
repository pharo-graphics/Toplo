Class {
	#name : #ToListElement,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator + TToElementWithPlaceholder',
	#classTraits : 'TToListElementDecorator classTrait + TToElementWithPlaceholder classTrait',
	#instVars : [
		'selectionElements',
		'selectionModel',
		'selectionMode',
		'sharedDistributors'
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

{ #category : #accessing }
ToListElement >> data [

	self
		deprecated: 'Please use dataAccessor instead.'
		transformWith:
			'`@receiver data'
				-> '`@receiver dataAccessor'.
	^ self dataAccessor
]

{ #category : #accessing }
ToListElement >> dataUpdater [

	self
		deprecated: 'Please use dataAccessor instead.'
		transformWith:
			'`@receiver dataUpdater'
				-> '`@receiver dataAccessor'.
	^ self dataAccessor
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
ToListElement >> defaultSelectionMode [

	^ ToListMultiSelectionMode new.
]

{ #category : #orientation }
ToListElement >> horizontal: aBoolean [

	self vertical: aBoolean not
]

{ #category : #initialization }
ToListElement >> infiniteSharedEvents [

	^ {
		  ToDataSourceEmptinessEvent.
		  ToDataSourceAttachedEvent.
		  ToDataSourceDetachedEvent.
		  BlInfiniteDataSourceItemRangeInserted.
		  BlInfiniteDataSourceItemRangeRemoved.
		  BlInfiniteElementAttachedEvent.
		  BlInfiniteElementDetachedEvent.
		  BlElementScrolledEvent }
]

{ #category : #initialization }
ToListElement >> initialize [

	super initialize.

	self next: self defaultInfiniteElement.
	self next elevation: (BlRelativeElevation elevation: 10).

	self selectionModel: self newSelectionModel.
	
	selectionElements := #(  ).
	self layout: self defaultLayout.
	
	self selectionMode: self defaultSelectionMode.
	self addEventHandler: ToListElementEventHandler new.
	self installSharedEventDistributors.

	self addChild: self next.
	self contextMenuWindowManagerClass: ToListElementContextMenuWindowManager.
	self addEventHandler: ToListSelectionElementEventHandler new.
	self addEventHandler: ToListElementContextMenuSelectionEventHandler new.
	self addEventHandler: ToCommandEventHandler new.
	self matchParent
]

{ #category : #initialization }
ToListElement >> installSharedEventDistributors [
	"installs shared event distributors between the list element, the selection strategy,
	the infinite, the data and the data source. 
	This gives the possibility to directly add event handlers on shared events :
		self when: ToInfiniteSelectionChangedEvent do: [ bla bla ] 
		instead of 
		self infinite when: ToSelectionChangedEvent do: [ bla bla ] "

	| infiniteSharedHandler |
	infiniteSharedHandler := BlSharedEventDistributor new
		                         shareEvents: self infiniteSharedEvents;
		                         yourself.
	sharedDistributors := { infiniteSharedHandler }.
	sharedDistributors do: [ :handler | self addEventHandler: handler ].
	self infinite addEventHandler: infiniteSharedHandler
]

{ #category : #orientation }
ToListElement >> isHorizontal [

	^ self infinite layout isHorizontal
]

{ #category : #orientation }
ToListElement >> isVertical [

	^ self infinite layout isVertical
]

{ #category : #accessing }
ToListElement >> itemCount [

	^ self dataSource itemCount
]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]

{ #category : #initialization }
ToListElement >> newSelectionModel [

	^ ToSelectionModel new
		  itemCountGetter: [ self dataSource itemCount ];
		  yourself
]

{ #category : #'t - element with placeholder' }
ToListElement >> placeholderElevation [

	^ self infinite elevation
]

{ #category : #accessing }
ToListElement >> selecter [ 

	^ self selectionMode selecter
]

{ #category : #accessing }
ToListElement >> selectionElements [

	^ selectionElements
]

{ #category : #accessing }
ToListElement >> selectionElements: aListElementSelectionCollection [

	selectionElements := aListElementSelectionCollection
]

{ #category : #accessing }
ToListElement >> selectionMode [

	^ selectionMode
]

{ #category : #accessing }
ToListElement >> selectionMode: aSelectionManager [

	selectionMode ifNotNil: [ selectionMode onUninstalledIn: self ].
	selectionMode := aSelectionManager.
	selectionMode ifNotNil: [ selectionMode onInstalledIn: self ]

]

{ #category : #accessing }
ToListElement >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListElement >> selectionModel: aSelectionModel [

	selectionModel ifNotNil: [ selectionModel onUninstalledIn: self ].
	selectionModel := aSelectionModel.
	selectionModel ifNotNil: [selectionModel onInstalledIn: self ]
]

{ #category : #accessing }
ToListElement >> selectionStrategy [

	self
		deprecated: 'Use selecter instead'
		transformWith: '`@receiver selectionStrategy' -> '`@receiver selecter'.

	^ self selecter
]

{ #category : #initialization }
ToListElement >> selectionStrategySharedEvents [

	^ {
		  ToListSelectionDirtyEvent.
		  ToListSelectionChangedEvent.
		  ToListStrongSelectionEvent.
		  ToListSelectionModeChangedEvent }
]

{ #category : #initialization }
ToListElement >> uninstallSharedEventDistributors [
	" see installSharedEventDistributor "

	sharedDistributors ifNil: [ ^ self ].

	sharedDistributors do: [ :handler |
		self removeEventHandler: handler.
		self infinite removeEventHandlersSuchThat: [ :h | handler = h ] ].

	sharedDistributors := nil
]

{ #category : #orientation }
ToListElement >> vertical: aBoolean [

	aBoolean
		ifTrue: [ self beVertical ]
		ifFalse: [ self beHorizontal ]
]
