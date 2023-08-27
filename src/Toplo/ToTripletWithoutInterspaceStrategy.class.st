Class {
	#name : #ToTripletWithoutInterspaceStrategy,
	#superclass : #ToTripletStrategy,
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'api - install/uninstall  hook' }
ToTripletWithoutInterspaceStrategy >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement fitContent
]
