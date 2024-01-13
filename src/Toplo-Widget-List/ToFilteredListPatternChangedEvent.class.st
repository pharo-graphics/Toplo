Class {
	#name : #ToFilteredListPatternChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'pattern'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #accessing }
ToFilteredListPatternChangedEvent >> pattern [

	^ pattern
]

{ #category : #accessing }
ToFilteredListPatternChangedEvent >> pattern: anObject [

	pattern := anObject
]
