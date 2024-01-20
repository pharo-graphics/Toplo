Class {
	#name : #ToListSelectorResultEvent,
	#superclass : #BlEvent,
	#instVars : [
		'pattern',
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #accessing }
ToListSelectorResultEvent >> pattern [

	^ pattern
]

{ #category : #accessing }
ToListSelectorResultEvent >> pattern: anObject [

	pattern := anObject
]

{ #category : #accessing }
ToListSelectorResultEvent >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListSelectorResultEvent >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #sending }
ToListSelectorResultEvent >> sendTo: anObject [

	anObject listSelectorResultEvent: self
]
