Trait {
	#name : #TToReshapeableWidgetSkin,
	#instVars : [
		'sizing',
		'shaping'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #'t - reshapeable - private - shaping/sizing' }
TToReshapeableWidgetSkin >> applyCircleShaping: aShaping on: anElement [

	self explicitRequirement 
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
TToReshapeableWidgetSkin >> applyDefaultShaping: aShaping on: anElement [

	self explicitRequirement 
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
TToReshapeableWidgetSkin >> applyLargeSizing: aSizing on: anElement [

	self explicitRequirement 
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
TToReshapeableWidgetSkin >> applyMiddleSizing: aSizing on: anElement [

	self explicitRequirement 
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
TToReshapeableWidgetSkin >> applyRoundShaping: aShaping on: anElement [

	self explicitRequirement 
]

{ #category : #'t - reshapeable - api - install/uninstall  hook' }
TToReshapeableWidgetSkin >> applySizingAndShapingOn: anElement [

	" shape depends on the size so sizing is applied first "

	self sizing applyOn: anElement.
	self shaping applyOn: anElement

]

{ #category : #'t - reshapeable - private - shaping/sizing' }
TToReshapeableWidgetSkin >> applySmallSizing: aSizing on: anElement [

	self explicitRequirement 
]

{ #category : #'t - reshapeable  - accessing' }
TToReshapeableWidgetSkin >> changeShapingWith: aControlShaping in: anElement [

	self shaping: aControlShaping.
	self dispatchChangedEventIn: anElement
]

{ #category : #'t - reshapeable  - accessing' }
TToReshapeableWidgetSkin >> changeSizingWith: aControlSizing in: anElement [

	self sizing: aControlSizing.
	self dispatchChangedEventIn: anElement
]

{ #category : #'t - reshapeable - initialization' }
TToReshapeableWidgetSkin >> defaultShaping [

	" as an example: ToDefaultShaping new "
	self explicitRequirement 
]

{ #category : #'t - reshapeable - initialization' }
TToReshapeableWidgetSkin >> defaultSizing [

	" as an example: ToMiddleSizing new"
	^ self explicitRequirement 
]

{ #category : #'t - reshapeable - initialization' }
TToReshapeableWidgetSkin >> intializeShapingSkin [

	" initialize sizing first since shaping depends on sizing "
	self sizing: self defaultSizing.
	self shaping:  self defaultShaping
]

{ #category : #'t - reshapeable - api - install/uninstall  hook' }
TToReshapeableWidgetSkin >> onShapingSkinInstalledIn: anElement [

	self applySizingAndShapingOn: anElement

]

{ #category : #'t - reshapeable - api - install/uninstall  hook' }
TToReshapeableWidgetSkin >> onShapingSkinUninstalledIn: anElement [


]

{ #category : #'t - reshapeable  - accessing' }
TToReshapeableWidgetSkin >> shaping [
	" CircleShaping | RoundShaping | DefaultShaping "

	^ shaping 
]

{ #category : #'t - reshapeable  - accessing' }
TToReshapeableWidgetSkin >> shaping: aControlShaping [

	" CircleShaping | RoundShaping | DefaultShaping "
	shaping := aControlShaping.
	shaping sizing: self sizing
]

{ #category : #'t - reshapeable  - accessing' }
TToReshapeableWidgetSkin >> sizing [
	" LargeSizing | MiddleSizing (default) | SmallSizing "

	^ sizing 
]

{ #category : #'t - reshapeable  - accessing' }
TToReshapeableWidgetSkin >> sizing: aSizing [

	" LargeSizing | MiddleSizing (default) | SmallSizing "
	sizing := aSizing.
	self shaping ifNotNil: [:sh | sh sizing: aSizing ]
]
