Class {
	#name : #ToListFilterResultEvent,
	#superclass : #BlEvent,
	#instVars : [
		'pattern',
		'indexedData'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #accessing }
ToListFilterResultEvent >> indexedData [

	^ indexedData
]

{ #category : #accessing }
ToListFilterResultEvent >> indexedData: aListElementFilterDataCollection [

	indexedData := aListElementFilterDataCollection
]

{ #category : #accessing }
ToListFilterResultEvent >> pattern [

	^ pattern
]

{ #category : #accessing }
ToListFilterResultEvent >> pattern: anObject [

	pattern := anObject
]

{ #category : #sending }
ToListFilterResultEvent >> sendTo: anObject [

	anObject listFilterResultEvent: self
]
