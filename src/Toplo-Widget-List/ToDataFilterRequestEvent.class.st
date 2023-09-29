Class {
	#name : #ToDataFilterRequestEvent,
	#superclass : #BlEvent,
	#instVars : [
		'pattern'
	],
	#category : #'Toplo-Widget-List-filter'
}

{ #category : #accessing }
ToDataFilterRequestEvent >> pattern [

	^ pattern
]

{ #category : #accessing }
ToDataFilterRequestEvent >> pattern: anObject [

	pattern := anObject
]
