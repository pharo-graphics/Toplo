Class {
	#name : #ToListElement2,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator2 + TToElementWithPlaceholder',
	#classTraits : 'TToListElementDecorator2 classTrait + TToElementWithPlaceholder classTrait',
	#instVars : [
		'selectionElements',
		'sharedDistributor',
		'selectionModel',
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
ToListElement2 >> defaultSelectionManager [

	^ ToListMultiSelectionManager new.
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

	self next: self defaultInfiniteElement.
	self next elevation: (BlRelativeElevation elevation: 10).
	self installSelectionModel: self defaultSelectionModel.
	
	selectionElements := #(  ).
	self layout: self defaultLayout.
	
	self installSelectionManager: self defaultSelectionManager.
	self addEventHandler: ToListElementEventHandler2 new.
	self installSharedEventDistributor.

	self addChild: self next.
	self contextMenuWindowManagerClass: ToListElementContextMenuWindowManager.
	self addEventHandler: ToListSelectionElementEventHandler2 new.
	self addEventHandler: ToListElementContextMenuSelectionEventHandler new.
	self matchParent
]

{ #category : #accessing }
ToListElement2 >> installSelectionManager: aSelectionManager [

	selectionManager ifNotNil: [ selectionManager onUninstalledIn: self ].
	selectionManager := aSelectionManager.
	selectionManager ifNotNil: [ selectionManager onInstalledIn: self ]

]

{ #category : #'accessing - selection model' }
ToListElement2 >> installSelectionModel: aSelectionModel [

	selectionModel ifNotNil: [ selectionModel onUninstalledIn: self ].
	selectionModel := aSelectionModel.
	selectionModel ifNotNil: [selectionModel onInstalledIn: self ].
	self infinite selectionModel: selectionModel.
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

{ #category : #accessing }
ToListElement2 >> itemCount [

	^ self dataSource itemCount
]

{ #category : #skin }
ToListElement2 >> newRawSkin [ 

	^ ToListElementSkin new
]

{ #category : #'t - element with placeholder' }
ToListElement2 >> placeholderElevation [

	^ self infinite elevation
]

{ #category : #accessing }
ToListElement2 >> selecter [ 

	^ self selectionManager selecter
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
ToListElement2 >> selectionModel [

	^ selectionModel
]

{ #category : #initialization }
ToListElement2 >> selectionStrategySharedEvents [

	^ {
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
