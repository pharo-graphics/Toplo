Class {
	#name : #ToDataFilterResultEvent,
	#superclass : #BlEvent,
	#instVars : [
		'pattern',
		'data',
		'indexes'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #accessing }
ToDataFilterResultEvent >> data [

	^ data
]

{ #category : #accessing }
ToDataFilterResultEvent >> data: aCollection [

	data := aCollection
]

{ #category : #accessing }
ToDataFilterResultEvent >> indexes [

	^ indexes
]

{ #category : #accessing }
ToDataFilterResultEvent >> indexes: aCollection [

	indexes := aCollection
]

{ #category : #accessing }
ToDataFilterResultEvent >> pattern [

	^ pattern
]

{ #category : #accessing }
ToDataFilterResultEvent >> pattern: anObject [

	pattern := anObject
]

{ #category : #sending }
ToDataFilterResultEvent >> sendTo: anObject [

	anObject dataFilterResultEvent: self
]
