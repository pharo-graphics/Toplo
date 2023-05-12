Class {
	#name : #ToListPrimarySelectionUpdater,
	#superclass : #Object,
	#instVars : [
		'extentChangeHandler',
		'scrollHandler',
		'decorations',
		'listElement',
		'fillingHandler',
		'selectionModelHandler',
		'primarySelectionUpdateHandler',
		'decorationFactory',
		'updateTask'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #private }
ToListPrimarySelectionUpdater >> adjacentSelectedNodesGroupsIn: aListElement [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	^ Array streamContents: [ :stream |
		  | g |
		  g := OrderedCollection new.
		  aListElement infinite childrenDo: [ :node |
			  (self includesNode: node)
				  ifTrue: [ g add: node ]
				  ifFalse: [
					  g ifNotEmpty: [
						  stream nextPut: g.
						  g := OrderedCollection new ] ] ].
		  g ifNotEmpty: [ stream nextPut: g ] ]
]

{ #category : #accessing }
ToListPrimarySelectionUpdater >> decorationFactory [

	^ decorationFactory
]

{ #category : #accessing }
ToListPrimarySelectionUpdater >> decorationFactory: aValuable [

	decorationFactory := aValuable
]

{ #category : #accessing }
ToListPrimarySelectionUpdater >> decorationOn: aNode [

	self decorations do: [ :d |
		(d nodes includes: aNode) ifTrue: [ ^ d ] ].
	^ nil
]

{ #category : #accessing }
ToListPrimarySelectionUpdater >> decorations [ 

	^ decorations
]

{ #category : #initialization }
ToListPrimarySelectionUpdater >> defaultDecorationFactory [

	^ [ ToListPrimarySelectionElement new ]
]

{ #category : #'infinite element changes' }
ToListPrimarySelectionUpdater >> extentChangedIn: anInfiniteElement [

	self updateDecorationsIn: anInfiniteElement
]

{ #category : #testing }
ToListPrimarySelectionUpdater >> includesNode: aNode [

	^ aNode holder isSelected
]

{ #category : #initialization }
ToListPrimarySelectionUpdater >> initialize [ 

	super initialize.
	decorations := ToObservableCollection new.
	decorations whenAddChangeDo: [ :ann | self notifyDecorationsAdded: ann ].
	decorations whenBeforeRemoveChangeDo: [ :ann | self notifyDecorationsRemoved: ann ].

	decorationFactory := self defaultDecorationFactory
]

{ #category : #'instance creation' }
ToListPrimarySelectionUpdater >> newDecorationElement [

	^ self decorationFactory value
]

{ #category : #'decorations add/remove' }
ToListPrimarySelectionUpdater >> notifyDecorationsAdded: aCollectionChangedAnnouncement [

	self decorations do: [ :d | d dispatchEvent: ToListPrimarySelectionAddedEvent new ]
]

{ #category : #'decorations add/remove' }
ToListPrimarySelectionUpdater >> notifyDecorationsRemoved: aCollectionChangedAnnouncement [

	self decorations do: [ :d | d dispatchEvent: ToListPrimarySelectionRemovedEvent new ]
]

{ #category : #'api - install/uninstall  hook' }
ToListPrimarySelectionUpdater >> onInstalledIn: aListElement [

	listElement := aListElement.

	extentChangeHandler := BlEventHandler
		                       on: BlElementExtentChangedEvent
		                       do: [ :evt |
		                       self extentChangedIn: aListElement ].

	scrollHandler := BlEventHandler
		                 on: BlElementScrolledEvent
		                 do: [ :evt | self scrollEventIn: aListElement ].

	fillingHandler := BlEventHandler
		                  on: OBlInfiniteScrolledWhileFilling
		                  do: [ :evt | self scrollEventIn: aListElement ].

	aListElement infinite addEventHandler: fillingHandler.
	aListElement infinite addEventHandler: extentChangeHandler.
	aListElement infinite addEventHandler: scrollHandler.
	
	aListElement when: ToListSelectionUpdaterStopEvent do: [ :event | listElement = event target ifTrue: [ self onUninstalledIn: listElement ] ].

	primarySelectionUpdateHandler := BlEventHandler
		                                 on: ToListPrimarySelectionUpdatedEvent
		                                 do: [ :event | self selectionChangedIn: aListElement ].

	selectionModelHandler := BlEventHandler
		                         on: ToInfiniteSelectionChangedEvent
		                         do: [ self selectionChangedIn: aListElement ].

	aListElement addEventHandler: primarySelectionUpdateHandler.
	aListElement infinite addEventHandler: selectionModelHandler.
]

{ #category : #'api - install/uninstall  hook' }
ToListPrimarySelectionUpdater >> onUninstalledIn: aListElement [

	aListElement infinite removeEventHandler: extentChangeHandler.
	aListElement infinite removeEventHandler: scrollHandler.
	aListElement infinite removeEventHandler: fillingHandler.
	
	aListElement removeEventHandler: primarySelectionUpdateHandler.
	aListElement infinite removeEventHandler: selectionModelHandler.

	listElement := nil
]

{ #category : #private }
ToListPrimarySelectionUpdater >> resetDecorations [

	decorations do: [ :d | d removeFromParent ].
	decorations removeAll
]

{ #category : #'infinite element changes' }
ToListPrimarySelectionUpdater >> scrollEventIn: anInfiniteElement [

	self updateDecorationsIn: anInfiniteElement
]

{ #category : #'infinite element changes' }
ToListPrimarySelectionUpdater >> selectionChangedIn: anInfiniteElement [

	self updateDecorationsIn: anInfiniteElement
]

{ #category : #private }
ToListPrimarySelectionUpdater >> selectionDecorationElementsIn: aListElement [
	" return a collection with instances of ListSelectionDecorationElement "

	^ (self adjacentSelectedNodesGroupsIn: aListElement) collect: [ :g |
		  self newDecorationElement
			  listElement: aListElement;
			  nodes: g;
			  yourself ]
]

{ #category : #'infinite element changes' }
ToListPrimarySelectionUpdater >> updateDecorationsIn: aListElement [
	"add a ListDecorationElement for each group of adjacent selected nodes "

	"A task must be used here to avoid the children updating during layouting (because during layouting children are temporarily detached)
	(which leads to errors related to children adding and which are difficult to understand)"
	updateTask ifNotNil: [ aListElement dequeueTask: updateTask ].
	updateTask := BlTaskAction new action: [
		              self resetDecorations.
		              decorations addAll: (self selectionDecorationElementsIn: aListElement).
		              aListElement addChildren: decorations.
		              updateTask := nil ].
	aListElement enqueueTask: updateTask
]
