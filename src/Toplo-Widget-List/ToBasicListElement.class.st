Class {
	#name : #ToBasicListElement,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator + TToElementWithPlaceholder',
	#classTraits : 'TToListElementDecorator classTrait + TToElementWithPlaceholder classTrait',
	#instVars : [
		'selectionModel',
		'selectionMode',
		'sharedEventDistributors'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #orientation }
ToBasicListElement >> beHorizontal [

	self infinite layout beHorizontal
]

{ #category : #orientation }
ToBasicListElement >> beVertical [

	self infinite layout beVertical
]

{ #category : #accessing }
ToBasicListElement >> contextMenuSelectionElements [

	^ Array streamContents: [ :stream |
		  self childrenDo: [ :child |
			  (child isKindOf: ToListContextMenuSelectionElement) ifTrue: [
				  stream nextPut: child ] ] ]
]

{ #category : #accessing }
ToBasicListElement >> data [

	self
		deprecated: 'Please use dataAccessor instead.'
		transformWith:
			'`@receiver data'
				-> '`@receiver dataAccessor'.
	^ self dataAccessor
]

{ #category : #accessing }
ToBasicListElement >> dataUpdater [

	self
		deprecated: 'Please use dataAccessor instead.'
		transformWith:
			'`@receiver dataUpdater'
				-> '`@receiver dataAccessor'.
	^ self dataAccessor
]

{ #category : #initialization }
ToBasicListElement >> defaultEventHandler [

	^ ToBasicListElementEventHandler new
]

{ #category : #initialization }
ToBasicListElement >> defaultInfiniteElement [ 

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToBasicListElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToBasicListElement >> defaultSelectionMode [

	^ ToListMultipleSelectionMode new operator:
		  (ToPrimarySelectionModelOperator new selectionModel:
			   self selectionModel)
]

{ #category : #orientation }
ToBasicListElement >> horizontal: aBoolean [

	self vertical: aBoolean not
]

{ #category : #initialization }
ToBasicListElement >> infiniteSharedEvents [

	^ {
		  BlInfiniteDataSourceEvent.
		  BlInfiniteElementAttachedEvent.
		  BlInfiniteElementDetachedEvent.
		  BlElementScrolledEvent }
]

{ #category : #initialization }
ToBasicListElement >> initialize [

	super initialize.
	
	self next: self defaultInfiniteElement.
	self next elevation: (BlRelativeElevation elevation: 10).

	self selectionModel: self newSelectionModel.
	self layout: self defaultLayout.
	
	self selectionMode: self defaultSelectionMode.
	self addEventHandler: self defaultEventHandler.
	self installSharedEventDistributors.

	self addChild: self next.
	self contextMenuWindowManagerClass: ToListElementContextMenuWindowManager.
	self addEventHandler: ToListPrimarySelectionElementEventHandler new.
	self addEventHandler: ToListElementContextMenuSelectionEventHandler new.
	self addEventHandler: ToCommandEventHandler new.
	self matchParent
]

{ #category : #initialization }
ToBasicListElement >> installSharedEventDistributors [
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
	sharedEventDistributors := { infiniteSharedHandler }.
	sharedEventDistributors do: [ :handler | self addEventHandler: handler ].
	self infinite addEventHandler: infiniteSharedHandler
]

{ #category : #orientation }
ToBasicListElement >> isHorizontal [

	^ self infinite layout isHorizontal
]

{ #category : #testing }
ToBasicListElement >> isMultipleSelection [

	^ self selectionMode isMultipleSelection
]

{ #category : #orientation }
ToBasicListElement >> isVertical [

	^ self infinite layout isVertical
]

{ #category : #accessing }
ToBasicListElement >> itemCount [

	^ self dataSource itemCount
]

{ #category : #skin }
ToBasicListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]

{ #category : #initialization }
ToBasicListElement >> newSelectionModel [

	^ ToSelectionModel new
		  itemCountGetter: [ self dataSource itemCount ];
		  yourself
]

{ #category : #'event firing' }
ToBasicListElement >> notifyDataSourceItemsChanged: aDataSourceEvent [

	| preNotification |
	preNotification := ToListDataSourceItemsChangePreNotificationEvent new
		                   sourceEvent: aDataSourceEvent;
		                   yourself.
	self dispatchEvent: preNotification.
	preNotification sourceEvent ifNil: [ ^ self ].
	self dispatchEvent: preNotification sourceEvent
]

{ #category : #'event firing' }
ToBasicListElement >> notifyPrimarySelectionChanged: aSelectionChangedEvent [

	| preNotification |
	preNotification := ToListPrimarySelectionChangePreNotificationEvent new
		                   sourceEvent: aSelectionChangedEvent;
		                   yourself.
	self dispatchEvent: preNotification.
	preNotification sourceEvent ifNil: [ ^ self ].
	self dispatchEvent: preNotification sourceEvent
]

{ #category : #'event firing' }
ToBasicListElement >> notifySecondarySelectionChanged: aSelectionChangedEvent [

	self dispatchEvent: aSelectionChangedEvent
]

{ #category : #'t - element with placeholder' }
ToBasicListElement >> placeholderElevation [

	^ self infinite elevation
]

{ #category : #accessing }
ToBasicListElement >> primarySelectionElements [

	^ Array streamContents: [ :stream |
		  self childrenDo: [ :child |
			  (child isKindOf: ToListPrimarySelectionElement) ifTrue: [
				  stream nextPut: child ] ] ]
]

{ #category : #accessing }
ToBasicListElement >> secondarySelectionElements [

	^ Array streamContents: [ :stream |
		  self childrenDo: [ :child |
			  (child isKindOf: ToListSecondarySelectionElement) ifTrue: [
				  stream nextPut: child ] ] ]
]

{ #category : #accessing }
ToBasicListElement >> selecter [ 

	^ self selectionMode selecter
]

{ #category : #accessing }
ToBasicListElement >> selectionMode [

	^ selectionMode
]

{ #category : #accessing }
ToBasicListElement >> selectionMode: aSelectionMode [

	selectionMode ifNotNil: [
		selectionMode onUninstalledIn: self ].
	selectionMode := aSelectionMode.
	selectionMode ifNotNil: [
		selectionMode onInstalledIn: self ].
	self dispatchEvent: ToListPrimarySelectionModeChangedEvent new.
	self requestNewSkin
]

{ #category : #accessing }
ToBasicListElement >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToBasicListElement >> selectionModel: aSelectionModel [

	selectionModel ifNotNil: [ selectionModel onUninstalledIn: self ].
	selectionModel := aSelectionModel.
	selectionModel ifNotNil: [selectionModel onInstalledIn: self ]
]

{ #category : #initialization }
ToBasicListElement >> uninstallSharedEventDistributors [
	" see installSharedEventDistributor "

	sharedEventDistributors ifNil: [ ^ self ].

	sharedEventDistributors do: [ :handler |
		self removeEventHandler: handler.
		self infinite removeEventHandlersSuchThat: [ :h | handler = h ] ].

	sharedEventDistributors := nil
]

{ #category : #orientation }
ToBasicListElement >> vertical: aBoolean [

	aBoolean
		ifTrue: [ self beVertical ]
		ifFalse: [ self beHorizontal ]
]
