Class {
	#name : #ToAbstractButtonSkin,
	#superclass : #ToAbstractSkin,
	#category : #'Toplo-LookAndFeel-Core'
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
ToAbstractButtonSkin >> backgroundHover [

	^ self token: #backgroundHover
]

{ #category : #tokens }
ToAbstractButtonSkin >> backgroundPressed [

	^ self token: #backgroundPressed
]

{ #category : #tokens }
ToAbstractButtonSkin >> border [

	^ self token: #border
]

{ #category : #tokens }
ToAbstractButtonSkin >> borderHover [

	^ self token: #borderHover
]

{ #category : #tokens }
ToAbstractButtonSkin >> borderPressed [

	^ self token: #borderPressed
]

{ #category : #built }
ToAbstractButtonSkin >> buildTokens [	
	
	super buildTokens.
	
	"active state"
	self token: #background value: self builtBackground.
	self token: #border value: self builtBorder.
	self token: #padding value: self builtPadding.
	self token: #shadow value: self builtShadow.
	
	"hover state"
	self token: #backgroundHover value: self builtBackgroundHover.
	self token: #borderHover value: self builtBorderHover.
	
	"background state"
	self token: #backgroundPressed value: self builtBackgroundPressed.
	self token: #borderPressed value: self builtBorderPressed.
]

{ #category : #built }
ToAbstractButtonSkin >> builtBackground [ 

	^ self subclassResponsibility 
]

{ #category : #built }
ToAbstractButtonSkin >> builtBackgroundHover [ 

	^ self subclassResponsibility 
]

{ #category : #built }
ToAbstractButtonSkin >> builtBackgroundPressed [ 

	^ self subclassResponsibility
]

{ #category : #built }
ToAbstractButtonSkin >> builtBorder [

	^ self builtBorderBuilder ifNotNil:[ :e | e build ]
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
	self theme lineType = #dashed ifTrue:[builder dashArray: self theme dashed].

	^ builder
]

{ #category : #built }
ToAbstractButtonSkin >> builtBorderHover [

	^ self builtBorderHoverBuilder ifNotNil:[ :e | e build ]
]

{ #category : #built }
ToAbstractButtonSkin >> builtBorderHoverBuilder [

	| builder |
	builder := BlBorderBuilder new
		           paint: self theme colorBorder;
		           width: self theme lineWidth;
		           lineCap: BlStrokeLineCap butt;
		           lineJoin: BlStrokeLineJoin miter;
		           miterLimit: 4.0;
		           dashOffset: 0.

	self theme lineType = #solid ifTrue:[builder dashArray: #()].
	self theme lineType = #dashed ifTrue:[builder dashArray: self theme dashed].

	^ builder
]

{ #category : #built }
ToAbstractButtonSkin >> builtBorderPressed [

	^ self builtBorderPressedBuilder ifNotNil:[ :e | e build ]
]

{ #category : #built }
ToAbstractButtonSkin >> builtBorderPressedBuilder [

	| builder |
	builder := BlBorderBuilder new
		           paint: self theme colorBorder;
		           width: self theme lineWidth;
		           lineCap: BlStrokeLineCap butt;
		           lineJoin: BlStrokeLineJoin miter;
		           miterLimit: 4.0;
		           dashOffset: 0.

	self theme lineType = #solid ifTrue:[builder dashArray: #()].
	self theme lineType = #dashed ifTrue:[builder dashArray: self theme dashed].

	^ builder
]

{ #category : #built }
ToAbstractButtonSkin >> builtGeometry [

	^ self subclassResponsibility 
]

{ #category : #built }
ToAbstractButtonSkin >> builtPadding [ 

	^ self subclassResponsibility 
]

{ #category : #built }
ToAbstractButtonSkin >> builtShadow [

	^ self subclassResponsibility 
]

{ #category : #tokens }
ToAbstractButtonSkin >> geometry [

	^ self token: #geometry
]

{ #category : #built }
ToAbstractButtonSkin >> imageSkinType [

	^ ToAbstractSkin defaultType
]

{ #category : #built }
ToAbstractButtonSkin >> labelSkinType [

	^ ToAbstractSkin defaultType
]

{ #category : #tokens }
ToAbstractButtonSkin >> padding [

	^ self token: #padding
]

{ #category : #tokens }
ToAbstractButtonSkin >> shadow [

	^ self token: #shadow
]
