Class {
	#name : #ToInfiniteClickOnDataEvent,
	#superclass : #BlEvent,
	#instVars : [
		'index',
		'event'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #accessing }
ToInfiniteClickOnDataEvent >> event [

	^ event
]

{ #category : #accessing }
ToInfiniteClickOnDataEvent >> event: anEvent [

	event := anEvent
]

{ #category : #accessing }
ToInfiniteClickOnDataEvent >> index [

	^ index
]

{ #category : #accessing }
ToInfiniteClickOnDataEvent >> index: anInteger [

	index := anInteger
]
