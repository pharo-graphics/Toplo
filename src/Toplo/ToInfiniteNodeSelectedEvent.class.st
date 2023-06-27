Class {
	#name : #ToInfiniteNodeSelectedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #accessing }
ToInfiniteNodeSelectedEvent >> index [

	^ index
]

{ #category : #accessing }
ToInfiniteNodeSelectedEvent >> index: anInteger [

	index := anInteger
]
