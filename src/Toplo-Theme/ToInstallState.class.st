Class {
	#name : #ToInstallState,
	#superclass : #ToElementState,
	#category : 'Toplo-Theme-State'
}

{ #category : #'look event sending' }
ToInstallState >> applyOn: anElement [

	anElement dispatchLookEvent: ToInstallLookEvent new
]
