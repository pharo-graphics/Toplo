Class {
	#name : #ToBasicListElement,
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
ToBasicListElement >> beHorizontal [

	self infinite layout beHorizontal
]

{ #category : #orientation }
ToBasicListElement >> beVertical [

	self infinite layout beVertical
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

	^ ToListMultiSelectionMode new.
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
	
	selectionElements := #(  ).
	self layout: self defaultLayout.
	
	self selectionMode: self defaultSelectionMode.
	self addEventHandler: self defaultEventHandler.
	self installSharedEventDistributors.

	self addChild: self next.
	self contextMenuWindowManagerClass: ToListElementContextMenuWindowManager.
	self addEventHandler: ToListSelectionElementEventHandler new.
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
	sharedDistributors := { infiniteSharedHandler }.
	sharedDistributors do: [ :handler | self addEventHandler: handler ].
	self infinite addEventHandler: infiniteSharedHandler
]

{ #category : #orientation }
ToBasicListElement >> isHorizontal [

	^ self infinite layout isHorizontal
]

{ #category : #orientation }
ToBasicListElement >> isVertical [

	^ self infinite layout isVertical
]

{ #category : #accessing }
ToBasicListElement >> itemCount [

	^ self dataSource itemCount
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
ToBasicListElement >> notifySelectionChanged: aSelectionChangedEvent [

	| preNotification |
	preNotification := ToListSelectionChangePreNotificationEvent new
		                   sourceEvent: aSelectionChangedEvent;
		                   yourself.
	self dispatchEvent: preNotification.
	preNotification sourceEvent ifNil: [ ^ self ].
	self dispatchEvent: preNotification sourceEvent
]

{ #category : #'t - element with placeholder' }
ToBasicListElement >> placeholderElevation [

	^ self infinite elevation
]

{ #category : #accessing }
ToBasicListElement >> selecter [ 

	^ self selectionMode selecter
]

{ #category : #accessing }
ToBasicListElement >> selectionElements [

	^ selectionElements
]

{ #category : #accessing }
ToBasicListElement >> selectionElements: aListElementSelectionCollection [

	selectionElements := aListElementSelectionCollection
]

{ #category : #accessing }
ToBasicListElement >> selectionMode [

	^ selectionMode
]

{ #category : #accessing }
ToBasicListElement >> selectionMode: aSelectionManager [

	selectionMode ifNotNil: [ selectionMode onUninstalledIn: self ].
	selectionMode := aSelectionManager.
	selectionMode ifNotNil: [ selectionMode onInstalledIn: self ].
	self dispatchEvent: ToListSelectionModeChangedEvent new
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

	sharedDistributors ifNil: [ ^ self ].

	sharedDistributors do: [ :handler |
		self removeEventHandler: handler.
		self infinite removeEventHandlersSuchThat: [ :h | handler = h ] ].

	sharedDistributors := nil
]

{ #category : #orientation }
ToBasicListElement >> vertical: aBoolean [

	aBoolean
		ifTrue: [ self beVertical ]
		ifFalse: [ self beHorizontal ]
]
