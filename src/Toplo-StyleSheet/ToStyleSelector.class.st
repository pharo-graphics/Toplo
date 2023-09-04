Class {
	#name : #ToStyleSelector,
	#superclass : #Object,
	#instVars : [
		'next'
	],
	#category : #'Toplo-StyleSheet-Model'
}

{ #category : #accessing }
ToStyleSelector >> and: aStyleSelector [

	self next: aStyleSelector
]

{ #category : #accessing }
ToStyleSelector >> next [

	^ next
]

{ #category : #accessing }
ToStyleSelector >> next: aStyleSelector [

	next := aStyleSelector
]
