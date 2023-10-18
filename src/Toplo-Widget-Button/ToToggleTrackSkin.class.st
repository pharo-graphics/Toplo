Class {
	#name : #ToToggleTrackSkin,
	#superclass : #Object,
	#category : 'Toplo-Widget-Button-Toggle'
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
	self addLookUpdater: ((self forProperty: (ToFeatureProperty new name: #background; yourself))
			when: ToDisabledLookEvent value: [ :e | e stampValue: #'color-bg-container-disabled'  ];
			when: ToInitialLookEvent value: [  :e | e isChecked
					 ifTrue: [ e toTheme colorPrimary ]
					 ifFalse: [ e toTheme colorBgContainer  ] ];
			when: ToPressedLookEvent value: [ :e | e isChecked
					 ifTrue: [ e toTheme colorPrimary ]
					 ifFalse: [ e toTheme colorBgContainer ] ];
			when: ToHoveredLookEvent value: [ :e | e isChecked
					 ifTrue: [ e toTheme colorPrimaryHover ]
					 ifFalse: [ e toTheme colorBgContainer ] ] ).
	self addLookUpdater: (ToToggleTrackLook new
			 animate: true;
			 yourself).

]
