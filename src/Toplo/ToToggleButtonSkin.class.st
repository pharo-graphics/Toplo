Class {
	#name : #ToToggleButtonSkin,
	#superclass : #ToAbstractButtonSkin,
	#classTraits : 'TToReshapeableWidgetSkin classTrait',
	#category : #'Toplo-Widget-Toggle-Skins'
}

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToToggleButtonSkin >> applyCircleShaping: aShaping on: anElement [

	Error signal: 'Circle shaping is not useable for a toggle button '
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToToggleButtonSkin >> applyDefaultShaping: aShaping on: anElement [

	super applyDefaultShaping: aShaping on: anElement.
	aShaping applyOn: anElement track
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToToggleButtonSkin >> applyLargeSizing: aSizing on: anElement [

	super applyLargeSizing: aSizing on: anElement.
	aSizing applyOn: anElement track
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToToggleButtonSkin >> applyMiddleSizing: aSizing on: anElement [

	super applyMiddleSizing: aSizing on: anElement.
	aSizing applyOn: anElement track
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToToggleButtonSkin >> applyRoundShaping: aShaping on: anElement [

	super applyRoundShaping: aShaping on: anElement.
	aShaping applyOn: anElement track
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToToggleButtonSkin >> applySmallSizing: aSizing on: anElement [

	super applySmallSizing: aSizing on: anElement.
	aSizing applyOn: anElement track
]

{ #category : #'t - reshapeable - initialization' }
ToToggleButtonSkin >> defaultShaping [

	^ ToRoundShaping new 
]

{ #category : #accessing }
ToToggleButtonSkin >> defaultType [

	^ ToToggleButtonDefaultType new
]

{ #category : #accessing }
ToToggleButtonSkin >> iconSkinIn: aButton [

	^ ToToggleTrackSkin new
]

{ #category : #accessing }
ToToggleButtonSkin >> labelLookIn: anElement [

	^ (super labelLookIn: anElement)
		  initialColor: [ :e | e toTheme colorTextLightSolid ];
		  hoverColor: [ :e | e toTheme colorTextLightSolid ];
		  pressedColor: [ :e | e toTheme colorTextLightSolid ];
		  yourself
]

{ #category : #accessing }
ToToggleButtonSkin >> labelSkinIn: aButton [

	^ ToLabelSkin new type: ToLabelDefaultType new.
]
