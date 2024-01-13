Class {
	#name : #ToFilteredListSelectionModelChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'selection'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #accessing }
ToFilteredListSelectionModelChangedEvent >> selection [

	^ selection
]

{ #category : #accessing }
ToFilteredListSelectionModelChangedEvent >> selection: aSelectionModel [

	selection := aSelectionModel
]

{ #category : #sending }
ToFilteredListSelectionModelChangedEvent >> sendTo: anObject [

	anObject filteredListSelectionModelChangedEvent: self
]
