Class {
	#name : #ToToggleButtonSkin,
	#superclass : #ToAbstractButtonSkinNew,
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

	^ ToButtonDefaultType new
		  showBorder: false;
		  yourself
]

{ #category : #accessing }
ToToggleButtonSkin >> iconSkinIn: aButton [

	^ self type toggleButtonIconSkinIn: aButton
]

{ #category : #accessing }
ToToggleButtonSkin >> labelSkinIn: aButton [

	^ self type toggleButtonLabelSkinIn: aButton
]
