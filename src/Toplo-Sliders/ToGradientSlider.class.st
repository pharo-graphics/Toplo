Class {
	#name : #ToGradientSlider,
	#superclass : #ToDesignSlider,
	#category : #'Toplo-Sliders-Core'
}

{ #category : #accessing }
ToGradientSlider >> coloredBarDefaultColor [
	"^ Color green alpha: 0.4"
	|direc|
	direc:= self 
		ifHorizontal: [ 1 @ 0 ]
		ifVertical: [ 0 @ -1 ].
	^ ((BlLinearGradientPaint direction:direc ) from: Color
	blue to: (Color green)).
]

{ #category : #initialization }
ToGradientSlider >> initializeParts [

	self bar: self defaultBar.
	self positionDefaultBar: self bar.
	self addChild: self bar.
	

	self coloredBar: self defaultColoredBar.
	self positionDefaultBar: self coloredBar.
	self addChild: self coloredBar.
	
	self overlayer: self overLayer.
	self addChild: self overlayer.
	self positionDefaultBar: self overlayer. 
	
	self handle: self defaultHandle.
	self positionDefaultHandle.
	self addChild: self handle.

	"initialize segments if segmented"
	
	"self initializeButtons"
]

{ #category : #'api - bounds' }
ToGradientSlider >> overLayer [
	"additional layer on top"
	|size container direc num width|
	size := self 
		        ifHorizontal: [ self defaultBarLength @ self defaultBarThickness ]
		        ifVertical: [ self defaultBarThickness @ self defaultBarLength ].
	
	direc:= self direction.
	num:= self defaultBarLength / 20.
	width:= self defaultBarThickness / 12. 
	container:=  BlElement new
		  	geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
			background: (Color red alpha:0.0);
			border: (BlBorder paint: (Color r:42  g:42  b:42  range:255 ) width: width);
		  	size: size;
			layout: (BlGridLayout new
			columnCount: 2);
		  	yourself.
			
	2 timesRepeat: [ 
		|div|
		div:= BlElement new
		constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent.
		direc ifTrue: [ c grid horizontal span: 2  ]
			 	ifFalse: [ c grid vertical span: 2  ].
		];
		background: (Color purple alpha: 0.0);
		constraintsDo: [ :c |
		c horizontal matchParent .
		c vertical matchParent ];
		layout: BlFlowLayout horizontal;
		border: (BlBorder paint: (Color r:42  g:42  b:42  range:255 ) width: width / 2).
		
		
		container addChild: div. 
	].

	^ container.
]

{ #category : #accessing }
ToGradientSlider >> overlayer [
	^ overlayer 
]

{ #category : #accessing }
ToGradientSlider >> overlayer: aBlElement [ 
	overlayer := aBlElement
]
