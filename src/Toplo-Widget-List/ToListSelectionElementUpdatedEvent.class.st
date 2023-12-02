Class {
	#name : 'ToListSelectionElementUpdatedEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Widget-List-Selection',
	#package : 'Toplo-Widget-List',
	#tag : 'Selection'
}

{ #category : 'sending' }
ToListSelectionElementUpdatedEvent >> sendTo: anObject [

	anObject listSelectionElementUpdatedEvent: self
]
