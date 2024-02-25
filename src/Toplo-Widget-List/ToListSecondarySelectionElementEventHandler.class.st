Class {
	#name : #ToListSecondarySelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'prevNode'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> addSecondarySelectionIn: aListElement onNode: aChildNode [
	" update selection decoration to show the secondary selection on which the popup is opened"

	| deco |
	deco := ToListSecondarySelectionElement new
		        listElement: aListElement;
		        nodes: (Array with: aChildNode);
		        yourself.
	aListElement addChild: deco
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent currentTarget spaceDo: [ :sp | sp mouseProcessor handleLastMouseMove ]
]

{ #category : #'api - accessing' }
ToListSecondarySelectionElementEventHandler >> eventsToHandle [

	^ {
		  BlMouseLeaveEvent.
		  BlElementScrolledEvent.
		  BlMouseMoveEvent }
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> mouseLeaveEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target secondarySelectionElements do: [ :s | s removeFromParent ]
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> mouseMoveEvent: anEvent [

	| target infinite globalPosition childNode |
	target := anEvent currentTarget.
	infinite := target infinite.
	globalPosition := anEvent position.
	childNode := infinite children
		             detect: [ :node |
		             node containsGlobalPoint: globalPosition ]
		             ifNone: [  ].
	target secondarySelectionElements do: [ :s | s removeFromParent ].
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	prevNode := childNode.
	childNode ifNil: [ ^ self ].
	self addSecondarySelectionIn: target onNode: childNode
]
