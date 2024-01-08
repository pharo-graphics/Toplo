Class {
	#name : #ToListSelectAllEvent,
	#superclass : #ToListWholeSelectionEvent,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #sending }
ToListSelectAllEvent >> sendTo: anObject [

	anObject listSelectAllEvent: self
]
