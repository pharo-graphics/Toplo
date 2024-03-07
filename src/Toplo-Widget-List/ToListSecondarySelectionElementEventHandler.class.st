Class {
	#name : #ToListSecondarySelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> addSecondarySelectionIn: aListElement onNodes: aNodeCollection [
	" update selection decoration to show the secondary selection on which the popup is opened"

	(self
		 newSelectionElementsFromSelectedNodes: aNodeCollection
		 in: aListElement) do: [ :s | aListElement addChild: s ]
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> criticalUpdateSelectionFromEvent: anEvent [

	anEvent currentTarget critical: [self updateSelectionFromEvent: anEvent ]
]

{ #category : #'element handlers' }
ToListSecondarySelectionElementEventHandler >> elementExtentChangedEvent: anEvent [

	self criticalUpdateSelectionFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent currentTarget spaceDo: [ :sp | 
		sp mouseProcessor handleLastMouseMove ].
	self criticalUpdateSelectionFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToListSecondarySelectionElementEventHandler >> eventsToHandle [

	^ {
		  BlElementExtentChangedEvent.
		  BlElementScrolledEvent.
		  ToInfiniteScrollFinishedEvent.
		  ToListSecondarySelectionChangedEvent.
		  BlMouseMoveEvent }
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> infiniteScrollFinishedEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> listSecondarySelectionChangedEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> mouseMoveEvent: anEvent [

	| target infinite globalPosition childNode |
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	target := anEvent currentTarget.
	infinite := target infinite.
	globalPosition := anEvent position.
	childNode := infinite children
		             detect: [ :node |
			             node holder isSelectable and: [
				             node containsGlobalPoint: globalPosition ] ]
		             ifNone: [  ].
	childNode ifNil: [
		target secondarySelecter deselectAll.
		^ self ].
	target secondarySelecter selectOnlyIndex: childNode holder position
]

{ #category : #'instance creation' }
ToListSecondarySelectionElementEventHandler >> newSelectionElementsFromSelectedNodes: aCollection in: aListElement [
	" return a collection with instances of ToListSecondarySelectionElement "

	| adjacentNodeGroups |
	adjacentNodeGroups := aListElement infinite nodeGroupsSatisfying: [ :n | aCollection includes: n ].
	^ adjacentNodeGroups collect: [ :g |
		  ToListSecondarySelectionElement new
			  listElement: aListElement;
			  nodes: g;
			  yourself ]
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> postponeSelectionElementUpdateFromEvent: anEvent in: anElement [

	anElement enqueueTask: (BlTaskAction new action: [
			 anElement dispatchEvent: anEvent ])
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> updateSelectionFromEvent: anEvent [

	| target infinite childNodes previous |
	target := anEvent currentTarget.
	infinite := target infinite.
	previous := target secondarySelectionElements.

	previous do: [ :s |
		s skinManagerDo: [ :sm |
			sm isInstallingSkin ifTrue: [
				self postponeSelectionElementUpdateFromEvent: anEvent in: target.
				^ self ] ] ].

	previous do: [ :s | s removeFromParent ].
	target secondarySelectionModel ifEmpty: [ ^ self ].
	childNodes := infinite children select: [ :node |
		              node holder isSelectable and: [
			              target secondarySelectionModel containsIndex:
				              node holder position ] ].
	childNodes ifEmpty: [ ^ self ].
	self addSecondarySelectionIn: target onNodes: childNodes
]
