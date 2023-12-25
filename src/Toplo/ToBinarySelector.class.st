Class {
	#name : #ToBinarySelector,
	#superclass : #ToElementSelector,
	#instVars : [
		'left',
		'right'
	],
	#category : 'Toplo-Core-Selectors'
}

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
