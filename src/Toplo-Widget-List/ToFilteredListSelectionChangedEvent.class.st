Class {
	#name : #ToFilteredListSelectionChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'selection'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #accessing }
ToFilteredListSelectionChangedEvent >> selection [

	^ selection
]

{ #category : #accessing }
ToFilteredListSelectionChangedEvent >> selection: aSelectionModel [

	selection := aSelectionModel
]

{ #category : #sending }
ToFilteredListSelectionChangedEvent >> sendTo: anObject [

	anObject filteredListSelectionChangedEvent: self
]
