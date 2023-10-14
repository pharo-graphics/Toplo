Class {
	#name : 'ToCheckedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToCheckedLookEvent >> sendTo: anObject [

	anObject checkedLookEvent: self
]
