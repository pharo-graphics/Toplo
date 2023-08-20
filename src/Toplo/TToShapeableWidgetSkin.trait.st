Trait {
	#name : #TToShapeableWidgetSkin,
	#instVars : [
		'sizing',
		'shaping'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #'t - reshapeable - private - shaping/sizing' }
TToShapeableWidgetSkin >> applyCircleShaping: aShaping on: anElement [

	self explicitRequirement 
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
TToShapeableWidgetSkin >> applyDefaultShaping: aShaping on: anElement [

	self explicitRequirement 
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
TToShapeableWidgetSkin >> applyLargeSizing: aSizing on: anElement [

	self explicitRequirement 
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
TToShapeableWidgetSkin >> applyMiddleSizing: aSizing on: anElement [

	self explicitRequirement 
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
TToShapeableWidgetSkin >> applyRoundShaping: aShaping on: anElement [

	self explicitRequirement 
]

{ #category : #'t - reshapeable - api - install/uninstall  hook' }
TToShapeableWidgetSkin >> applySizingAndShapingOn: anElement [

	" shape depends on the size so sizing is applied first "

	self sizing applyOn: anElement.
	self shaping applyOn: anElement

]

{ #category : #'t - reshapeable - private - shaping/sizing' }
TToShapeableWidgetSkin >> applySmallSizing: aSizing on: anElement [

	self explicitRequirement 
]

{ #category : #'t - reshapeable  - accessing' }
TToShapeableWidgetSkin >> changeShapingWith: aControlShaping in: anElement [

	self shaping: aControlShaping.
	self dispatchChangedEventIn: anElement
]

{ #category : #'t - reshapeable  - accessing' }
TToShapeableWidgetSkin >> changeSizingWith: aControlSizing in: anElement [

	self sizing: aControlSizing.
	self dispatchChangedEventIn: anElement
]

{ #category : #'t - reshapeable - initialization' }
TToShapeableWidgetSkin >> defaultShaping [

	" as an example: ToDefaultShaping new "
	self explicitRequirement 
]

{ #category : #'t - reshapeable - initialization' }
TToShapeableWidgetSkin >> defaultSizing [

	" as an example: ToMiddleSizing new"
	^ self explicitRequirement 
]

{ #category : #'t - reshapeable - initialization' }
TToShapeableWidgetSkin >> intializeShapingSkin [

	" initialize sizing first since shaping depends on sizing "
	self sizing: self defaultSizing.
	self shaping:  self defaultShaping
]

{ #category : #'t - reshapeable - api - install/uninstall  hook' }
TToShapeableWidgetSkin >> onShapingSkinInstalledIn: anElement [

	self applySizingAndShapingOn: anElement

]

{ #category : #'t - reshapeable - api - install/uninstall  hook' }
TToShapeableWidgetSkin >> onShapingSkinUninstalledIn: anElement [


]

{ #category : #'t - reshapeable  - accessing' }
TToShapeableWidgetSkin >> shaping [
	" CircleShaping | RoundShaping | DefaultShaping "

	^ shaping 
]

{ #category : #'t - reshapeable  - accessing' }
TToShapeableWidgetSkin >> shaping: aControlShaping [

	" CircleShaping | RoundShaping | DefaultShaping "
	shaping := aControlShaping.
	shaping sizing: self sizing
]

{ #category : #'t - reshapeable  - accessing' }
TToShapeableWidgetSkin >> sizing [
	" LargeSizing | MiddleSizing (default) | SmallSizing "

	^ sizing 
]

{ #category : #'t - reshapeable  - accessing' }
TToShapeableWidgetSkin >> sizing: aSizing [

	" LargeSizing | MiddleSizing (default) | SmallSizing "
	sizing := aSizing.
	self shaping ifNotNil: [:sh | sh sizing: aSizing ]
]
