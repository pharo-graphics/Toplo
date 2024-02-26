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
ToListSecondarySelectionElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent currentTarget spaceDo: [ :sp | 
		" to ensure that the ListSecondaryChangedEvent is sent "
		anEvent currentTarget secondarySelectionModel deselectAll.
		sp mouseProcessor handleLastMouseMove ]
]

{ #category : #'api - accessing' }
ToListSecondarySelectionElementEventHandler >> eventsToHandle [

	^ {
		  ToListSecondarySelectionChangedEvent.
		  BlMouseLeaveEvent.
		  BlElementScrolledEvent.
		  BlMouseMoveEvent }
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> listSecondarySelectionChangedEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> mouseLeaveEvent: anEvent [

	anEvent currentTarget secondarySelecter deselectAll.

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
		             node containsGlobalPoint: globalPosition ]
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
ToListSecondarySelectionElementEventHandler >> updateSelectionFromEvent: anEvent [

	| target infinite childNodes |
	target := anEvent currentTarget.
	infinite := target infinite.
	target secondarySelectionElements do: [ :s | s removeFromParent ].
	anEvent selectionModel ifEmpty: [ ^ self ].
	childNodes := infinite children
		             select: [ :node |
			             target secondarySelectionModel containsIndex:
				             node holder position ].
	childNodes ifEmpty: [ ^ self ].
	self addSecondarySelectionIn: target onNodes: childNodes
]
