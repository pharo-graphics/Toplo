Class {
	#name : #ToListDeselectAllEvent,
	#superclass : #ToListWholeSelectionEvent,
	#category : #'Toplo-Widget-List-Selection-Deprecated'
}

{ #category : #testing }
ToListDeselectAllEvent class >> isDeprecated [

	^ true
]

{ #category : #sending }
ToListDeselectAllEvent >> sendTo: anObject [

	anObject listDeselectAllEvent: self
]
