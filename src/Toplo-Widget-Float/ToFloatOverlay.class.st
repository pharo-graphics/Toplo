Class {
	#name : #ToFloatOverlay,
	#superclass : #ToOverlayElement,
	#instVars : [
		'margin',
		'northWest',
		'northEast',
		'southWest',
		'southEast'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToFloatOverlay >> defaultLayout [

	^ BlProportionalLayout new
]

{ #category : #initialization }
ToFloatOverlay >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	self initializeParts
	
]

{ #category : #initialization }
ToFloatOverlay >> initializeParts [

	margin := 10.
	northWest := ToFloatOverlayQuarter new
		             id: #northWest;
		             constraintsDo: [ :c |
				             c proportional horizontal right: 0.5.
				             c proportional vertical bottom: 0.5.
				             c margin: (BlInsets
							              top: margin
							              left: margin
							              bottom: 0
							              right: 0) ];
		             yourself.
	northEast := ToFloatOverlayQuarter new
		             id: #northEast;
		             constraintsDo: [ :c |
				             c proportional horizontal left: 0.5.
				             c proportional vertical bottom: 0.5.
				             c margin: (BlInsets
							              top: margin
							              left: 0
							              bottom: 0
							              right: margin) ];
		             yourself.
	southWest := ToFloatOverlayQuarter new
		             id: #southWest;
		             constraintsDo: [ :c |
				             c proportional horizontal right: 0.5.
				             c proportional vertical top: 0.5.
				             c margin: (BlInsets
							              top: 0
							              left: margin
							              bottom: margin
							              right: 0) ];
		             yourself.
	southEast := ToFloatOverlayQuarter new
		             id: #southEast;
		             constraintsDo: [ :c |
				             c proportional horizontal left: 0.5.
				             c proportional vertical top: 0.5.
				             c margin: (BlInsets
							              top: 0
							              left: 0
							              bottom: margin
							              right: margin) ];
		             yourself.
	self addChildren: {
			northWest.
			northEast.
			southWest.
			southEast }
]

{ #category : #accessing }
ToFloatOverlay >> northEast [

	^ northEast
]

{ #category : #accessing }
ToFloatOverlay >> northWest [

	^ northWest
]

{ #category : #accessing }
ToFloatOverlay >> southEast [

	^ southEast
]

{ #category : #accessing }
ToFloatOverlay >> southWest [

	^ southWest
]
