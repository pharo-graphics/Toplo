Class {
	#name : #ToToggleTrackSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Toggle-Skins'
}

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToToggleTrackSkin >> applyLargeSizing: aSizing on: anElement [

	
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToToggleTrackSkin >> applyMiddleSizing: aSizing on: anElement [

	
]

{ #category : #'private - shaping/sizing' }
ToToggleTrackSkin >> applyQuadShaping: aShaping on: anElement [

	anElement layout: BlLinearLayout new.
	anElement hFitContent.
	anElement padding: (BlInsets
			 top: 2
			 left: 2
			 bottom: 2
			 right: 2).
	anElement innerButton size: (aShaping sizing heightOn: anElement) asPoint.
	anElement innerButton background: Color white.
	anElement innerButton margin: (BlInsets
			 top: 1
			 left: 4
			 bottom: 1
			 right: 4).
	anElement updateWidth
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToToggleTrackSkin >> applyRectangleShaping: aShaping on: anElement [

	| radius |
	self applyQuadShaping: aShaping on: anElement.
	radius := aShaping sizing shapingRadiusIn: anElement.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: radius)
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToToggleTrackSkin >> applyRoundShaping: aShaping on: anElement [

	| radius |
	self applyQuadShaping: aShaping on: anElement.	
	radius := anElement requestedHeight / 2.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: radius)
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToToggleTrackSkin >> applySmallSizing: aSizing on: anElement [

	
]

{ #category : #'event handling' }
ToToggleTrackSkin >> innerButtonSizeIn: anElement [

	^ 16 asPoint
]

{ #category : #'api - install/uninstall  hook' }
ToToggleTrackSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLook: (ToBackgroundLook new
			 disabledBg: [ :e | e toTheme colorBgContainerDisabled ];
			 initialBg: [ :e |
				 anElement isChecked
					 ifTrue: [ e toTheme colorBgContainerChecked ]
					 ifFalse: [ e toTheme colorBgContainerUnchecked  ] ];
			 pressedBg: [ :e |
				 anElement isChecked
					 ifTrue: [ e toTheme colorBgContainerCheckedPressed ]
					 ifFalse: [ e toTheme colorBgContainerUnchecked ] ];
			 hoverBg: [ :e |
				 anElement isChecked
					 ifTrue: [ e toTheme colorBgContainerCheckedHover ]
					 ifFalse: [ e toTheme colorBgContainerUncheckedHover ] ];
			 yourself).
	self addLook: (ToToogleTrackLook new
			 animate: true;
			 yourself).

]
