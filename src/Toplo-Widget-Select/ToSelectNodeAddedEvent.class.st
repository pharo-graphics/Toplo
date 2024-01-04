Class {
	#name : #ToSelectNodeAddedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Widget-Select'
}

{ #category : #accessing }
ToSelectNodeAddedEvent >> index [

	^ index
]

{ #category : #accessing }
ToSelectNodeAddedEvent >> index: anInteger [

	index := anInteger
]

{ #category : #sending }
ToSelectNodeAddedEvent >> sendTo: anObject [

	anObject selectNodeAddedEvent: self
]
