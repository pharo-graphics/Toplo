Class {
	#name : #ToToggleButtonSkin,
	#superclass : #ToClickableSkin,
	#category : #'Toplo-Widget-Toggle-Skins'
}

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToToggleButtonSkin >> applyCircleShaping: aShaping on: anElement [

	Error signal: 'Circle shaping makes no sense for a toggle button '
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

{ #category : #'api - install/uninstall  hook' }
ToToggleButtonSkin >> backgroundLookIn: anElement [

	^ self type toggleButtonBackgroundLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToToggleButtonSkin >> borderLookIn: anElement [

	^ self type toggleButtonBorderLookIn: anElement
]

{ #category : #'t - reshapeable - initialization' }
ToToggleButtonSkin >> defaultShaping [

	^ ToRoundShaping new 
]

{ #category : #accessing }
ToToggleButtonSkin >> defaultType [

	^ ToButtonDefaultType new
]

{ #category : #accessing }
ToToggleButtonSkin >> iconSkinIn: aButton [

	^ self type toggleButtonIconSkinIn: aButton
]

{ #category : #accessing }
ToToggleButtonSkin >> labelSkinIn: aButton [

	^ self type toggleButtonLabelSkinIn: aButton
]
