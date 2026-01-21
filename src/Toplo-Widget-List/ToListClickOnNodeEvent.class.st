Class {
	#name : #ToListClickOnNodeEvent,
	#superclass : #ToListClickEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListClickOnNodeEvent >> sendTo: anObject [

	anObject listClickOnNodeEvent: self

	
]
