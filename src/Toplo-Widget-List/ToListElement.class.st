Class {
	#name : #ToListElement,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator + TToElementWithPlaceholder',
	#classTraits : 'TToListElementDecorator classTrait + TToElementWithPlaceholder classTrait',
	#instVars : [
		'selectionElements',
		'sharedDistributor',
		'selectionModel',
		'selectionMode'
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

	^ { ToCollectionEmptinessEvent }
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
ToListElement >> defaultSelecter [

	^ ToListElementSelecter new.
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
ToListElement >> infiniteElementSharedEvents [

	^ {
		  BlInfiniteDataSourceItemRangeInserted.
		  BlInfiniteDataSourceItemRangeRemoved.
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
ToListElement >> initialize [

	super initialize.

	self next: self defaultInfiniteElement.
	self next elevation: (BlRelativeElevation elevation: 10).
	self selectionModel: self newSelectionModel.
	
	selectionElements := #(  ).
	self layout: self defaultLayout.
	
	self selectionMode: self defaultSelectionMode.
	self addEventHandler: ToListElementEventHandler new.
	self installSharedEventDistributor.

	self addChild: self next.
	self contextMenuWindowManagerClass: ToListElementContextMenuWindowManager.
	self addEventHandler: ToListSelectionElementEventHandler new.
	self addEventHandler: ToListElementContextMenuSelectionEventHandler new.
	self matchParent
]

{ #category : #initialization }
ToListElement >> installSharedEventDistributor [
	"installs shared event distributors between the list element, the selection strategy,
	the infinite, the data and the data source. 
	This gives the possibility to directly add event handlers on shared events :
		self when: ToInfiniteSelectionChangedEvent do: [ bla bla ] 
		instead of 
		self infinite when: ToInfiniteSelectionChangedEvent do: [ bla bla ] "

	sharedDistributor := BlSharedEventDistributor new
		                     shareEvents: self sharedEvents;
		                     yourself.
	self addEventHandler: sharedDistributor.
	self data addEventHandler: sharedDistributor.
	self dataSource addEventHandler: sharedDistributor.
	self infinite addEventHandler: sharedDistributor
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
ToListElement >> sharedEvents [

	^ Array streamContents: [ :stream |
		  stream nextPutAll: self dataSharedEvents.
		  stream nextPutAll: self infiniteElementSharedEvents.
		  stream nextPutAll: self selectionStrategySharedEvents ]
]

{ #category : #initialization }
ToListElement >> uninstallSharedEventDistributor [
	" see uninstallSharedEventDistributor "

	sharedDistributor ifNil: [ ^ self ].
	self removeEventHandler: sharedDistributor.
	self data removeEventHandler: sharedDistributor.
	self infinite removeEventHandler: sharedDistributor.
	self dataSource removeEventHandler: sharedDistributor.
	self selectionStrategy removeEventHandler: sharedDistributor.
	sharedDistributor := nil
]

{ #category : #orientation }
ToListElement >> vertical: aBoolean [

	aBoolean
		ifTrue: [ self beVertical ]
		ifFalse: [ self beHorizontal ]
]
