Class {
	#name : #ToListSelectAllEvent,
	#superclass : #ToListWholeSelectionEvent,
	#category : #'Toplo-Widget-List-Selection-Deprecated'
}

{ #category : #testing }
ToListSelectAllEvent class >> isDeprecated [

	^ true
]

{ #category : #sending }
ToListSelectAllEvent >> sendTo: anObject [

	anObject listSelectAllEvent: self
]
