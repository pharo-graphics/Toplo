Class {
	#name : 'ToUncheckedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToUncheckedLookEvent >> sendTo: anObject [

	anObject uncheckedLookEvent: self
]
