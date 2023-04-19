Class {
	#name : #ToListSelectionUpdater,
	#superclass : #Object,
	#instVars : [
		'extentChangeHandler',
		'scrollHandler',
		'decorations',
		'listElement',
		'fillingHandler',
		'selectionModelHandler',
		'primarySelectionUpdateHandler',
		'decorationFactory'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #private }
ToListSelectionUpdater >> adjacentSelectedNodesGroupsIn: aListElement [
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
ToListSelectionUpdater >> decorationFactory [

	^ decorationFactory
]

{ #category : #accessing }
ToListSelectionUpdater >> decorationFactory: aValuable [

	decorationFactory := aValuable
]

{ #category : #accessing }
ToListSelectionUpdater >> decorationOn: aNode [

	self decorations do: [ :d |
		(d nodes includes: aNode) ifTrue: [ ^ d ] ].
	^ nil
]

{ #category : #accessing }
ToListSelectionUpdater >> decorations [ 

	^ decorations
]

{ #category : #initialization }
ToListSelectionUpdater >> defaultDecorationFactory [

	^ [ ToListPrimarySelectionElement new ]
]

{ #category : #'infinite element changes' }
ToListSelectionUpdater >> extentChangedIn: anInfiniteElement [

	self updateDecorationsIn: anInfiniteElement
]

{ #category : #testing }
ToListSelectionUpdater >> includesNode: aNode [

	^ aNode holder isSelected
]

{ #category : #initialization }
ToListSelectionUpdater >> initialize [ 

	super initialize.
	decorations := ToObservableCollection new.
	decorations whenAddChangeDo: [ :ann | self notifyDecorationsAdded: ann ].
	decorations whenBeforeRemoveChangeDo: [ :ann | self notifyDecorationsRemoved: ann ].

	decorationFactory := self defaultDecorationFactory
]

{ #category : #'instance creation' }
ToListSelectionUpdater >> newDecorationElement [

	^ self decorationFactory value
]

{ #category : #'decorations add/remove' }
ToListSelectionUpdater >> notifyDecorationsAdded: aCollectionChangedAnnouncement [

	self decorations do: [ :d | d dispatchEvent: ToListPrimarySelectionAddedEvent new ]
]

{ #category : #'decorations add/remove' }
ToListSelectionUpdater >> notifyDecorationsRemoved: aCollectionChangedAnnouncement [

	self decorations do: [ :d | d dispatchEvent: ToListPrimarySelectionRemovedEvent new ]
]

{ #category : #'api - install/uninstall  hook' }
ToListSelectionUpdater >> onInstalledIn: aListElement [

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
ToListSelectionUpdater >> onUninstalledIn: aListElement [

	aListElement infinite removeEventHandler: extentChangeHandler.
	aListElement infinite removeEventHandler: scrollHandler.
	aListElement infinite removeEventHandler: fillingHandler.
	
	aListElement removeEventHandler: primarySelectionUpdateHandler.
	aListElement infinite removeEventHandler: selectionModelHandler.

	listElement := nil
]

{ #category : #private }
ToListSelectionUpdater >> resetDecorations [

	decorations do: #removeFromParent.
	decorations removeAll
]

{ #category : #'infinite element changes' }
ToListSelectionUpdater >> scrollEventIn: anInfiniteElement [

	self updateDecorationsIn: anInfiniteElement
]

{ #category : #'infinite element changes' }
ToListSelectionUpdater >> selectionChangedIn: anInfiniteElement [

	self updateDecorationsIn: anInfiniteElement
]

{ #category : #private }
ToListSelectionUpdater >> selectionDecorationElementsIn: aListElement [
	" return a collection with instances of ListSelectionDecorationElement "

	^ (self adjacentSelectedNodesGroupsIn: aListElement) collect: [ :g |
		  self newDecorationElement
			  listElement: aListElement;
			  nodes: g;
			  yourself ]
]

{ #category : #'infinite element changes' }
ToListSelectionUpdater >> updateDecorationsIn: aListElement [
	"add a ListDecorationElement for each group of adjacent selected nodes "

	self resetDecorations.	
	decorations addAll: (self selectionDecorationElementsIn: aListElement).
	aListElement addChildren: decorations.

]
