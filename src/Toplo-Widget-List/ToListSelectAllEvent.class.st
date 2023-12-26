Class {
	#name : #ToListSelectAllEvent,
	#superclass : #ToListWholeSelectionEvent,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #sending }
ToListSelectAllEvent >> sendTo: anObject [

	anObject listSelectAllEvent: self
]
