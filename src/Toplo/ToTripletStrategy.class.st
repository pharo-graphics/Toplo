Class {
	#name : #ToTripletStrategy,
	#superclass : #Object,
	#category : #'Toplo-Core-Triplet'
}

{ #category : #layout }
ToTripletStrategy >> childrenIn: aTriplet [

	^ {
		  aTriplet first.
		  aTriplet second.
		  aTriplet third } select: #notNil
]

{ #category : #accessing }
ToTripletStrategy >> columnWidth [

	^ 0
]

{ #category : #accessing }
ToTripletStrategy >> isJustified [

	^ false
]

{ #category : #'api - install/uninstall  hook' }
ToTripletStrategy >> onInstalledIn: aTriplet [
]

{ #category : #layout }
ToTripletStrategy >> onMeasure: anExtentMeasurementSpec in: aTriplet [

	self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToTripletStrategy >> onUninstalledIn: aTriplet [
]
