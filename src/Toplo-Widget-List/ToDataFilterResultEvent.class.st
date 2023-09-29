Class {
	#name : #ToDataFilterResultEvent,
	#superclass : #BlEvent,
	#instVars : [
		'data',
		'indexes',
		'selectionUpdated'
	],
	#category : #'Toplo-Widget-List-filter'
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

{ #category : #sending }
ToDataFilterResultEvent >> sendTo: anObject [

	anObject dataFilterResultEvent: self
]
