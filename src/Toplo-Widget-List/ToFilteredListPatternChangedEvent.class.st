Class {
	#name : #ToFilteredListPatternChangedEvent,
	#superclass : #ToSelectedListPatternChangedEvent,
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #sending }
ToFilteredListPatternChangedEvent >> sendTo: anObject [

	anObject filteredListPatternChangedEvent: self
]
