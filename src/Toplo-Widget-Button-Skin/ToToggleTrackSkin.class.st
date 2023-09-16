Class {
	#name : #ToToggleTrackSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToToggleTrackSkin >> applyLargeSizing: aSizing on: anElement [

	
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToToggleTrackSkin >> applyMiddleSizing: aSizing on: anElement [

	
]

{ #category : #'private - shaping/sizing' }
ToToggleTrackSkin >> applyQuadShaping: aShaping on: anElement [

	(anElement layout isKindOf: BlLinearLayout) ifFalse: [ 
		anElement layout: BlLinearLayout new]. 
	anElement padding: (self defaultPaddingIn: anElement).
	anElement innerButton size: (aShaping sizing heightOn: anElement) asPoint.
	anElement innerButton background: Color white.
	anElement innerButton margin: (BlInsets
			 left: anElement toTheme paddingXS
			 right: anElement toTheme paddingXS).
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

{ #category : #'private - shaping/sizing' }
ToToggleTrackSkin >> defaultPaddingIn: anElement [

	^ BlInsets
		  top: 2
		  left: 2
		  bottom: 2
		  right: 2
]

{ #category : #'event handling' }
ToToggleTrackSkin >> innerButtonSizeIn: anElement [

	^ 16 asPoint
]

{ #category : #'api - install/uninstall  hook' }
ToToggleTrackSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLookUpdater: ((ToLookUpdater forProperty: (ToFeatureProperty new name: #background; yourself))
			when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled  ];
			when: ToInitialLookEvent value: [  :e | e isChecked
					 ifTrue: [ e toTheme colorBgContainerChecked ]
					 ifFalse: [ e toTheme colorBgContainerUnchecked  ] ];
			when: ToPressedLookEvent value: [ :e | e isChecked
					 ifTrue: [ e toTheme colorBgContainerCheckedPressed ]
					 ifFalse: [ e toTheme colorBgContainerUnchecked ] ];
			when: ToHoveredLookEvent value: [ :e | e isChecked
					 ifTrue: [ e toTheme colorBgContainerCheckedHover ]
					 ifFalse: [ e toTheme colorBgContainerUncheckedHover ] ] ).
	self addLookUpdater: (ToToggleTrackLook new
			 animate: true;
			 yourself).

]
