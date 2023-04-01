Class {
	#name : #ToAbstractButtonSkin,
	#superclass : #ToAbstractSkin,
	#category : #'Toplo-LookAndFeel-Skins'
}

{ #category : #testing }
ToAbstractButtonSkin class >> isAbstract [

	^ self = ToAbstractButtonSkin
]

{ #category : #tokens }
ToAbstractButtonSkin >> background [

	^ self token: #background
]

{ #category : #tokens }
ToAbstractButtonSkin >> border [

	^ self token: #border
]

{ #category : #built }
ToAbstractButtonSkin >> buildTokens [

	super buildTokens.
	
	self tokens at: #background put: self builtBackground.
	self tokens at: #border put: self builtBorder.
]

{ #category : #built }
ToAbstractButtonSkin >> builtBackground [ 

	^ self subclassResponsibility 
]

{ #category : #built }
ToAbstractButtonSkin >> builtBorder [

	^ self builtBorderBuilder build
]

{ #category : #built }
ToAbstractButtonSkin >> builtBorderBuilder [

	| builder |
	builder := BlBorderBuilder new
		           paint: self theme colorBorder;
		           width: self theme lineWidth;
		           lineCap: BlStrokeLineCap butt;
		           lineJoin: BlStrokeLineJoin miter;
		           miterLimit: 4.0;
		           dashOffset: 0.

	self theme lineType = #solid ifTrue:[builder dashArray: #()].
	self theme lineType = #dashed ifTrue:[builder dashArray: #( 6 4.2 )].

	^ builder
]

{ #category : #built }
ToAbstractButtonSkin >> builtGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: self theme borderRadius
]

{ #category : #tokens }
ToAbstractButtonSkin >> geometry [

	^ self token: #geometry
]

{ #category : #built }
ToAbstractButtonSkin >> labelSkinType [

	^ ToAbstractSkin defaultType
]
