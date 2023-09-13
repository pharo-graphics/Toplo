Class {
	#name : #ToBinarySelector,
	#superclass : #ToStyleSelector,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Toplo-Theme-StyleSheet'
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
