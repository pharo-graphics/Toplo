Class {
	#name : #ToListFilterRequest,
	#superclass : #BlEvent,
	#instVars : [
		'pattern'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #accessing }
ToListFilterRequest >> pattern [

	^ pattern
]

{ #category : #accessing }
ToListFilterRequest >> pattern: anObject [

	pattern := anObject
]

{ #category : #sending }
ToListFilterRequest >> sendTo: anObject [

	anObject listFilterRequest: self
]
