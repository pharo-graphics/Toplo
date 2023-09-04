Class {
	#name : #ToStyleElementTypeSelector,
	#superclass : #ToStyleSelector,
	#instVars : [
		'type'
	],
	#category : #'Toplo-StyleSheet-Model'
}

{ #category : #accessing }
ToStyleElementTypeSelector >> type [

	^ type
]

{ #category : #accessing }
ToStyleElementTypeSelector >> type: aClass [

	type := aClass
]
