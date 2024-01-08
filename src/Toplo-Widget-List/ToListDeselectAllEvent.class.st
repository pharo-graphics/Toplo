Class {
	#name : #ToListDeselectAllEvent,
	#superclass : #ToListWholeSelectionEvent,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #sending }
ToListDeselectAllEvent >> sendTo: anObject [

	anObject listDeselectAllEvent: self
]
