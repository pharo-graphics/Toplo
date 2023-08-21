Class {
	#name : #ToQuadShaping,
	#superclass : #ToControlShaping,
	#instVars : [
		'radius'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #'private children updating' }
ToQuadShaping >> adaptNextChildrenArray: anArray in: anElement [

	| subs |
	subs := super adaptNextChildrenArray: anArray in: anElement.
	(anElement verticalRequested and: [ anElement isLabelFirst  ])
		ifTrue: [ ^ subs reversed ].
	^ subs

]

{ #category : #accessing }
ToQuadShaping >> radius [

	^ radius
]

{ #category : #accessing }
ToQuadShaping >> radius: anObject [

	radius := anObject
]
