Class {
	#name : #ToTripletLinearStrategy,
	#superclass : #ToTripletWithoutInterspaceStrategy,
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'api - install/uninstall  hook' }
ToTripletLinearStrategy >> onInstalledIn: aTriplet [

	super onInstalledIn: aTriplet.
	(aTriplet innerElement layout isKindOf: BlLinearLayout) ifTrue: [ ^ self ].
	aTriplet innerElement layout: BlLinearLayout new.
]
