Class {
	#name : #ToBadgeOverlay,
	#superclass : #ToOverlayElement,
	#instVars : [
		'lag'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToBadgeOverlay >> defaultElevation [

	^ BlRelativeElevation elevation: 20
]

{ #category : #initialization }
ToBadgeOverlay >> defaultLayout [

	^ BlAnchorLayout new
]

{ #category : #'t - overlay element - geometry' }
ToBadgeOverlay >> extentFrom: anExtent [

	^ super extentFrom: anExtent + (lag * 2) asPoint
]

{ #category : #initialization }
ToBadgeOverlay >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	self elevation: self defaultElevation.
	lag := 0
]

{ #category : #skin }
ToBadgeOverlay >> installRawStyle [

	super installRawStyle.
	self lag: (self valueOfTokenNamed: #'badge-lag')
]

{ #category : #accessing }
ToBadgeOverlay >> lag: aNumber [

	lag := aNumber.
	overlayReferenceElement ifNotNil: [ :e | e requestLayout ]
]

{ #category : #'t - overlay element - geometry' }
ToBadgeOverlay >> positionFrom: aPosition [

	^ super positionFrom: aPosition - lag asPoint
]
