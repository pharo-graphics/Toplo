Class {
	#name : #ToAbstractButtonSkinDep,
	#superclass : #ToAbstractSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Button'
}

{ #category : #testing }
ToAbstractButtonSkinDep class >> isAbstract [

	^ self = ToAbstractButtonSkinDep
]

{ #category : #testing }
ToAbstractButtonSkinDep class >> isDeprecated [ 

	^ true
]

{ #category : #tokens }
ToAbstractButtonSkinDep >> background [

	^ self token: #background
]

{ #category : #tokens }
ToAbstractButtonSkinDep >> backgroundHover [

	^ self token: #backgroundHover
]

{ #category : #tokens }
ToAbstractButtonSkinDep >> backgroundPressed [

	^ self token: #backgroundPressed
]

{ #category : #tokens }
ToAbstractButtonSkinDep >> border [

	^ self token: #border
]

{ #category : #tokens }
ToAbstractButtonSkinDep >> borderHover [

	^ self token: #borderHover
]

{ #category : #tokens }
ToAbstractButtonSkinDep >> borderPressed [

	^ self token: #borderPressed
]

{ #category : #built }
ToAbstractButtonSkinDep >> buildTokens [	
	
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
ToAbstractButtonSkinDep >> builtBackground [ 

	^ self subclassResponsibility 
]

{ #category : #built }
ToAbstractButtonSkinDep >> builtBackgroundHover [ 

	^ self subclassResponsibility 
]

{ #category : #built }
ToAbstractButtonSkinDep >> builtBackgroundPressed [ 

	^ self subclassResponsibility
]

{ #category : #built }
ToAbstractButtonSkinDep >> builtBorder [

	^ self builtBorderBuilder ifNotNil:[ :e | e build ]
]

{ #category : #built }
ToAbstractButtonSkinDep >> builtBorderBuilder [

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
ToAbstractButtonSkinDep >> builtBorderHover [

	^ self builtBorderHoverBuilder ifNotNil:[ :e | e build ]
]

{ #category : #built }
ToAbstractButtonSkinDep >> builtBorderHoverBuilder [

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
ToAbstractButtonSkinDep >> builtBorderPressed [

	^ self builtBorderPressedBuilder ifNotNil:[ :e | e build ]
]

{ #category : #built }
ToAbstractButtonSkinDep >> builtBorderPressedBuilder [

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
ToAbstractButtonSkinDep >> builtGeometry [

	^ self subclassResponsibility 
]

{ #category : #built }
ToAbstractButtonSkinDep >> builtPadding [ 

	^ self subclassResponsibility 
]

{ #category : #built }
ToAbstractButtonSkinDep >> builtShadow [

	^ self subclassResponsibility 
]

{ #category : #tokens }
ToAbstractButtonSkinDep >> geometry [

	^ self token: #geometry
]

{ #category : #built }
ToAbstractButtonSkinDep >> imageSkinType [

	^ ToAbstractSkin defaultType
]

{ #category : #built }
ToAbstractButtonSkinDep >> labelSkinType [

	^ ToAbstractSkin defaultType
]

{ #category : #tokens }
ToAbstractButtonSkinDep >> padding [

	^ self token: #padding
]

{ #category : #tokens }
ToAbstractButtonSkinDep >> shadow [

	^ self token: #shadow
]
