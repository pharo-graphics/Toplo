Class {
	#name : #ToTripletLinearStrategy,
	#superclass : #ToTripletWithoutInterspaceStrategy,
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'api - install/uninstall  hook' }
ToTripletLinearStrategy >> onInstalledIn: aTriplet [

	super onInstalledIn: aTriplet.
	(aTriplet layout isKindOf: BlLinearLayout) ifTrue: [ ^ self ].
	aTriplet layout: BlLinearLayout new.
]
