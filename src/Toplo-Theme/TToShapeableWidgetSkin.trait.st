Trait {
	#name : #TToShapeableWidgetSkin,
	#instVars : [
		'sizing',
		'shaping'
	],
	#category : #'Toplo-Theme-Skin-dep'
}

{ #category : #'t - shapeable - private - shaping/sizing' }
TToShapeableWidgetSkin >> applyCircleShaping: aShaping on: anElement [

	self explicitRequirement 
]

{ #category : #'t - shapeable - private - shaping/sizing' }
TToShapeableWidgetSkin >> applyLargeSizing: aSizing on: anElement [

	self explicitRequirement 
]

{ #category : #'t - shapeable - private - shaping/sizing' }
TToShapeableWidgetSkin >> applyMiddleSizing: aSizing on: anElement [

	self explicitRequirement 
]

{ #category : #'t - shapeable - private - shaping/sizing' }
TToShapeableWidgetSkin >> applyRectangleShaping: aShaping on: anElement [

	self explicitRequirement 
]

{ #category : #'t - shapeable - private - shaping/sizing' }
TToShapeableWidgetSkin >> applyRoundShaping: aShaping on: anElement [

	self explicitRequirement 
]

{ #category : #'t - shapeable - install/uninstall  hook' }
TToShapeableWidgetSkin >> applySizingAndShapingOn: anElement [

	" shape depends on the size so sizing is applied first "

	self sizing applyOn: anElement.
	self shaping applyOn: anElement

]

{ #category : #'t - shapeable - private - shaping/sizing' }
TToShapeableWidgetSkin >> applySmallSizing: aSizing on: anElement [

	self explicitRequirement 
]

{ #category : #'t - shapeable  - accessing' }
TToShapeableWidgetSkin >> changeShapingWith: aControlShaping in: anElement [

	self shaping: aControlShaping.
	self forceInstallationIn: anElement
]

{ #category : #'t - shapeable  - accessing' }
TToShapeableWidgetSkin >> changeSizingWith: aControlSizing in: anElement [

	self sizing: aControlSizing.
	self forceInstallationIn: anElement
]

{ #category : #'t - shapeable - initialization' }
TToShapeableWidgetSkin >> defaultShaping [

	" as an example: ToDefaultShaping new "
	self explicitRequirement 
]

{ #category : #'t - shapeable - initialization' }
TToShapeableWidgetSkin >> defaultSizing [

	" as an example: ToMiddleSizing new"
	^ self explicitRequirement 
]

{ #category : #'t - shapeable - initialization' }
TToShapeableWidgetSkin >> intializeShapingSkin [

	" initialize sizing first since shaping depends on sizing "
	self sizing: self defaultSizing.
	self shaping:  self defaultShaping
]

{ #category : #'t - shapeable - install/uninstall  hook' }
TToShapeableWidgetSkin >> onShapingSkinInstalledIn: anElement [

	self applySizingAndShapingOn: anElement

]

{ #category : #'t - shapeable - install/uninstall  hook' }
TToShapeableWidgetSkin >> onShapingSkinUninstalledIn: anElement [


]

{ #category : #'t - shapeable  - accessing' }
TToShapeableWidgetSkin >> shaping [
	" CircleShaping | RoundShaping | DefaultShaping "

	^ shaping 
]

{ #category : #'t - shapeable  - accessing' }
TToShapeableWidgetSkin >> shaping: aControlShaping [

	" CircleShaping | RoundShaping | DefaultShaping "
	shaping := aControlShaping.
	shaping sizing: self sizing
]

{ #category : #'t - shapeable  - accessing' }
TToShapeableWidgetSkin >> sizing [
	" LargeSizing | MiddleSizing (default) | SmallSizing "

	^ sizing 
]

{ #category : #'t - shapeable  - accessing' }
TToShapeableWidgetSkin >> sizing: aSizing [

	" LargeSizing | MiddleSizing (default) | SmallSizing "
	sizing := aSizing.
	self shaping ifNotNil: [:sh | sh sizing: aSizing ]
]
