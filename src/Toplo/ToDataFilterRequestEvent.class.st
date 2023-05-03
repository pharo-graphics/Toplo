Class {
	#name : #ToDataFilterRequestEvent,
	#superclass : #BlEvent,
	#instVars : [
		'pattern'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToDataFilterRequestEvent >> pattern [

	^ pattern
]

{ #category : #accessing }
ToDataFilterRequestEvent >> pattern: anObject [

	pattern := anObject
]
