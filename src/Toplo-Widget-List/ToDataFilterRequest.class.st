Class {
	#name : #ToDataFilterRequest,
	#superclass : #BlEvent,
	#instVars : [
		'pattern'
	],
	#category : 'Toplo-Widget-List-Filter'
}

{ #category : #accessing }
ToDataFilterRequest >> pattern [

	^ pattern
]

{ #category : #accessing }
ToDataFilterRequest >> pattern: anObject [

	pattern := anObject
]

{ #category : #sending }
ToDataFilterRequest >> sendTo: anObject [

	anObject dataFilterRequest: self
]
