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

{ #category : #layout }
ToTripletWithoutInterspaceStrategy >> onMeasure: anExtentMeasurementSpec in: aTriplet [

	" Nothing to do "
	^ true
]
