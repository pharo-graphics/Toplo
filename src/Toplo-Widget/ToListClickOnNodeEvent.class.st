Class {
	#name : #ToListClickOnNodeEvent,
	#superclass : #ToListClickEvent,
	#category : #'Toplo-Widget-List'
}

{ #category : #sending }
ToListClickOnNodeEvent >> sendTo: anObject [

	anObject listClickOnNodeEvent: self

	
]
