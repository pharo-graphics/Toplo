Class {
	#name : #ToFloatOverlay,
	#superclass : #ToOverlayElement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToFloatOverlay >> defaultElevation [

	^ BlRelativeElevation elevation: 20
]

{ #category : #initialization }
ToFloatOverlay >> defaultLayout [

	^ BlAnchorLayout new
]

{ #category : #'t - overlay element - geometry' }
ToFloatOverlay >> extentFrom: anExtent [

	^ super extentFrom: anExtent - self padding extent
]

{ #category : #initialization }
ToFloatOverlay >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	self elevation: self defaultElevation
]

{ #category : #'t - overlay element - geometry' }
ToFloatOverlay >> positionFrom: aPoint [

	^ super positionFrom: aPoint + self padding topLeft
]
