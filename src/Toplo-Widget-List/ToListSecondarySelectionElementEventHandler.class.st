Class {
	#name : #ToListSecondarySelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'selection managing' }
ToListSecondarySelectionElementEventHandler >> addNewSelectionElementsFrom: target [

	| infinite childNodes |
	infinite := target infinite.

	childNodes := infinite children select: [ :node |
		              target secondarySelectionModel containsIndex:
			              node holder position ].
	childNodes ifEmpty: [ ^ self ].
	(self newSelectionElementsFromSelectedNodes: childNodes in: target)
		do: [ :s | target addChild: s ]
]

{ #category : #'selection managing' }
ToListSecondarySelectionElementEventHandler >> differUpdateSelectionFrom: anElement [
]

{ #category : #'element handlers' }
ToListSecondarySelectionElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent currentTarget spaceDo: [ :sp | 
		sp mouseProcessor handleLastMouseMove ].
	super elementScrolledEvent: anEvent
]

{ #category : #'api - accessing' }
ToListSecondarySelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle, {
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

{ #category : #'selection managing' }
ToListSecondarySelectionElementEventHandler >> newSelectionElementsFrom: target [

	| infinite childNodes adjacentNodeGroups |
	infinite := target infinite.
	childNodes := infinite children select: [ :node |
		              target secondarySelectionModel containsIndex:
			              node holder position ].
	adjacentNodeGroups := infinite nodeGroupsSatisfying: [ :n |
		                      childNodes includes: n ].
	^ adjacentNodeGroups collect: [ :g |
		  ToListSecondarySelectionElement new
			  listElement: target;
			  nodes: g;
			  yourself ]
]

{ #category : #'selection managing' }
ToListSecondarySelectionElementEventHandler >> newSelectionElementsFromSelectedNodes: aCollection in: aListElement [
	" return a collection with instances of ToListSecondarySelectionElement "

	| adjacentNodeGroups |
	adjacentNodeGroups := aListElement infinite nodeGroupsSatisfying: [
		                      :n | aCollection includes: n ].
	^ adjacentNodeGroups collect: [ :g |
		  ToListSecondarySelectionElement new
			  listElement: aListElement;
			  nodes: g;
			  yourself ]
]

{ #category : #'selection managing' }
ToListSecondarySelectionElementEventHandler >> previousSelectionElementsFrom: aTarget [
	
	^ aTarget secondarySelectionElements
]

{ #category : #'selection managing' }
ToListSecondarySelectionElementEventHandler >> selectionModelFrom: target [

	^ target secondarySelectionModel
]
