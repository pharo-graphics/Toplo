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

{ #category : #converting }
ToBinarySelector >> asSourceCode [

	^ '(' , self left asSourceCode , ') && ('
	  , self right asSourceCode , ')'
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
