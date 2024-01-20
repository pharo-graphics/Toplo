Class {
	#name : #ToSelectedListPatternChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'pattern'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #accessing }
ToSelectedListPatternChangedEvent >> pattern [

	^ pattern
]

{ #category : #accessing }
ToSelectedListPatternChangedEvent >> pattern: anObject [

	pattern := anObject
]

{ #category : #sending }
ToSelectedListPatternChangedEvent >> sendTo: anObject [

	anObject selectedListPatternChangedEvent: self
]
