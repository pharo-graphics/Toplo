Class {
	#name : #ToBinarySelector,
	#superclass : #ToElementSelector,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #converting }
ToBinarySelector >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	^ self left = anObject left and: [ self right = anObject right ]
]

{ #category : #comparing }
ToBinarySelector >> hash [

	^ super hash bitXor: (left hash bitXor: right hash)
]

{ #category : #accessing }
ToBinarySelector >> left [

	^ left
]

{ #category : #accessing }
ToBinarySelector >> left: aSelector [

	left := aSelector
]

{ #category : #accessing }
ToBinarySelector >> right [

	^ right
]

{ #category : #accessing }
ToBinarySelector >> right: aSelector [

	right := aSelector
]
