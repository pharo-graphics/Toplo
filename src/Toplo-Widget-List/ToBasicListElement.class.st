Class {
	#name : #ToBasicListElement,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator + TToElementWithPlaceholder',
	#classTraits : 'TToListElementDecorator classTrait + TToElementWithPlaceholder classTrait',
	#instVars : [
		'nodeBuilder',
		'nodeReleaser',
		'selectionModel',
		'selectionMode',
		'sharedEventDistributors',
		'disabledSelecter',
		'disabledSelectionModel'
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
ToBasicListElement >> defaultNodeBuilder [

	^ [ :node :holder |
	  node addChild: (ToLabel text: holder dataItem asString) hMatchParent ]
]

{ #category : #initialization }
ToBasicListElement >> defaultNodeReleaser [

	^ [ :node :holder | node removeChildren ]
]

{ #category : #initialization }
ToBasicListElement >> defaultSelectionMode [

	^ ToListMultipleSelectionMode new operator:
		  (ToPrimarySelectionModelOperator new selectionModel:
			   self selectionModel)
]

{ #category : #accessing }
ToBasicListElement >> disabledSelecter [ 

	^ disabledSelecter
]

{ #category : #accessing }
ToBasicListElement >> disabledSelectionModel [

	^ disabledSelectionModel
]

{ #category : #accessing }
ToBasicListElement >> disabledSelectionModel: aSelectionModel [

	disabledSelectionModel ifNotNil: [ disabledSelectionModel onUninstalledIn: self ].
	disabledSelectionModel := aSelectionModel.
	disabledSelectionModel ifNotNil: [disabledSelectionModel onInstalledIn: self ]
]

{ #category : #orientation }
ToBasicListElement >> horizontal: aBoolean [

	self vertical: aBoolean not
]

{ #category : #initialization }
ToBasicListElement >> infiniteSharedEvents [

	^ {
		  ToObservableCollectionEvent.
		  BlInfiniteDataSourceEvent.
		  BlInfiniteElementAttachedEvent.
		  BlInfiniteElementDetachedEvent.
		  BlElementScrolledEvent }
]

{ #category : #initialization }
ToBasicListElement >> initialize [

	| operatorForDisabledItems |
	super initialize.
	
	self nodeBuilder: self defaultNodeBuilder.
	self nodeReleaser: self defaultNodeReleaser.
	
	self next: self defaultInfiniteElement.
	self next elevation: (BlRelativeElevation elevation: 10).

	self selectionModel: self newSelectionModel.
	self layout: self defaultLayout.

	self selectionMode: self defaultSelectionMode.
	self addEventHandler: self defaultEventHandler.
	self installSharedEventDistributors.

	self addChild: self next.
	self contextMenuWindowManagerClass:
		ToListElementContextMenuWindowManager.
	self addEventHandler: ToListPrimarySelectionElementEventHandler new.
	self addEventHandler:
		ToListElementContextMenuSelectionEventHandler new.
	self addEventHandler: ToCommandEventHandler new.

	disabledSelectionModel := self newSelectionModel.
	disabledSelecter := ToMultiSelectionModelSelecter new.
	operatorForDisabledItems := ToDisabledSelectionModelOperator new
		                            selectionModel: disabledSelectionModel;
		                            yourself.
	operatorForDisabledItems onInstalledIn: self.
	disabledSelecter operator: operatorForDisabledItems.
	disabledSelecter onInstalledIn: self.
	self addEventHandler: ToListDisabledSelectionEventHandler new.

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

{ #category : #accessing }
ToBasicListElement >> nodeBuilder [

	"aValuable takes 2 args: first, the ToNode to build and second, its holder in the list element "
	^ nodeBuilder
]

{ #category : #accessing }
ToBasicListElement >> nodeBuilder: aValuable [

	"aValuable takes 2 args: first, the ToNode to build and second, its holder in the list element "
	nodeBuilder := aValuable
]

{ #category : #accessing }
ToBasicListElement >> nodeReleaser [

	"aValuable takes 2 args: first, the ToNode to release and second, its holder in the list element "
	^ nodeReleaser
]

{ #category : #accessing }
ToBasicListElement >> nodeReleaser: aValuable [

	"aValuable takes 2 args: first, the ToNode to release and second, its holder in the list element "
	nodeReleaser := aValuable
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
ToBasicListElement >> notifyDisabledSelectionChanged: aSelectionChangedEvent [

	self dispatchEvent: aSelectionChangedEvent
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
ToBasicListElement >> notifyPrimarySelectionDirty [

	self dispatchEvent: ToListPrimarySelectionDirtyEvent new
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
