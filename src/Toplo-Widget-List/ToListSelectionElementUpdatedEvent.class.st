Class {
	#name : 'ToListSelectionElementUpdatedEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Widget-List-core',
	#package : 'Toplo-Widget-List',
	#tag : 'core'
}

{ #category : 'sending' }
ToListSelectionElementUpdatedEvent >> sendTo: anObject [

	anObject listSelectionElementUpdatedEvent: self
]
