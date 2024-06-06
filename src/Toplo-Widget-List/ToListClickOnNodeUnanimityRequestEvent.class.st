Class {
	#name : #ToListClickOnNodeUnanimityRequestEvent,
	#superclass : #ToUnanimityRequestEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListClickOnNodeUnanimityRequestEvent >> sendTo: anObject [

	anObject listClickOnNodeUnanimityRequestEvent: self
]
