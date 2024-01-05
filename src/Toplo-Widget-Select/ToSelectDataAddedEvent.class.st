Class {
	#name : #ToSelectDataAddedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Widget-Select'
}

{ #category : #accessing }
ToSelectDataAddedEvent >> index [

	^ index
]

{ #category : #accessing }
ToSelectDataAddedEvent >> index: anInteger [

	index := anInteger
]

{ #category : #sending }
ToSelectDataAddedEvent >> sendTo: anObject [

	anObject selectDataAddedEvent: self
]
