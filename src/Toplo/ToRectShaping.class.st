Class {
	#name : #ToRectShaping,
	#superclass : #ToControlShaping,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'private children updating' }
ToRectShaping >> adaptNextChildrenArray: anArray in: anElement [

	| subs |
	subs := super adaptNextChildrenArray: anArray in: anElement.
	(anElement verticalRequested and: [ anElement isLabelFirst  ])
		ifTrue: [ ^ subs reversed ].
	^ subs

]
