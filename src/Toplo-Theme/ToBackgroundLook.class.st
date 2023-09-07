Class {
	#name : #ToBackgroundLook,
	#superclass : #ToSinglePropertyLook,
	#category : #'Toplo-Theme-Look'
}

{ #category : #'deprecated accessing' }
ToBackgroundLook >> disabledColor [

	self deprecatedInsteadOf: 'disabledColor' use: 'disabledStateValue'.
	^ self disabledStateValue
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> disabledColor: aValuable [

	self deprecatedInsteadOf: 'disabledColor:' use: 'disabledStateValue:'.
	self disabledStateValue: aValuable
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> duration: aNumber [

	self deprecated: 'Set duration with a ' , ToStateValue name , ' instead '
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> hoverColor [

	self deprecatedInsteadOf: 'hoverColor' use: 'hoverStateValue'.

	^ self hoverStateValue
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> hoverColor: aValuable [

	self deprecatedInsteadOf: 'hoverColor:' use: 'hoverStateValue:'.
	self hoverStateValue: aValuable
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> initialColor [

	self deprecatedInsteadOf: 'initialColor' use: 'initialStateValue'.
	^ self initialStateValue
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> initialColor: aValuable [

	self deprecatedInsteadOf: 'initialColor:' use: 'initialStateValue:'.
	self initialStateValue: aValuable
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> pressedColor [

	self deprecatedInsteadOf: 'pressedColor' use: 'pressedStateValue'.
	^ self pressedStateValue
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> pressedColor: aValuable [

	self deprecatedInsteadOf: 'pressedColor:' use: 'pressedStateValue:'.
	self pressedStateValue: aValuable
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> selectedColor [

	self deprecatedInsteadOf: 'selectedColor' use: 'selectedStateValue'.
	^ self selectedStateValue
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> selectedColor: anObject [

	self deprecatedInsteadOf: 'selectedColor:' use: 'selectedStateValue:'.
	self selectedStateValue: anObject
]

{ #category : #private }
ToBackgroundLook >> switchToNewValue: aStateValue in: anElement [

	| currentColor newColor currentBackground bg |
	
	bg := (aStateValue valueIn: anElement) asBlBackground.
	(aStateValue animationDuration isZero or: [ bg isColorBackground not ])
		ifTrue: [ ^ anElement background: bg ].
	anElement isDisabled ifTrue: [ ^ anElement switchToSkinState: ToDisabledState new ]. 
	currentBackground := anElement background.
	currentBackground isColorBackground ifFalse: [ ^ anElement background: bg ].
	currentColor := currentBackground paint color.
	newColor := bg paint color.
	animation := BlColorTransition new
		             duration: aStateValue animationDuration;
		             from: currentColor;
		             to: newColor;
		             onStepDo: [ :aColor :e | e background: aColor ].
	animation onFinishedDo: [
		anElement background: bg.
		animation := nil ].
	anElement addAnimation: animation
]
