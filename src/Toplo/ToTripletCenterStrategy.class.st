Class {
	#name : #ToTripletCenterStrategy,
	#superclass : #ToTripletWithoutInterspaceStrategy,
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'api - install/uninstall  hook' }
ToTripletCenterStrategy >> onInstalledIn: aTriplet [

	super onInstalledIn: aTriplet.
	(aTriplet innerElement layout isKindOf: BlFrameLayout) ifTrue: [ ^ self ].
	aTriplet innerElement layout: BlFrameLayout new.
]
