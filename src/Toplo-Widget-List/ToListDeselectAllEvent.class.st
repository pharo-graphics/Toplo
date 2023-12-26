Class {
	#name : #ToListDeselectAllEvent,
	#superclass : #ToListWholeSelectionEvent,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #sending }
ToListDeselectAllEvent >> sendTo: anObject [

	anObject listDeselectAllEvent: self
]
