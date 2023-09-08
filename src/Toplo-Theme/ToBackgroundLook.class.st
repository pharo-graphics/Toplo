Class {
	#name : #ToBackgroundLook,
	#superclass : #ToMultiStateLook,
	#category : #'Toplo-Theme-Look'
}

{ #category : #testing }
ToBackgroundLook class >> isDeprecated [ 

	^ true
]

{ #category : #private }
ToBackgroundLook >> apply: aStateValue on: anElement [

	| currentColor newColor currentBackground bg bgv |
	
	bgv := aStateValue valueIn: anElement.
	bgv ifNil: [ ^ self ].
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

{ #category : #'deprecated accessing' }
ToBackgroundLook >> disabledColor [

	self deprecatedInsteadOf: 'disabledColor' use: 'disabledStateValue'.
	^ self disabledValue
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> disabledColor: aValuable [

	self deprecatedInsteadOf: 'disabledColor:' use: 'disabledStateValue:'.
	self disabledValue: aValuable
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> duration: aNumber [

	self deprecated: 'Set duration with a ' , ToStateValue name , ' instead '
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> hoverColor [

	self deprecatedInsteadOf: 'hoverColor' use: 'hoveredStateValue'.

	^ self hoveredValue
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> hoverColor: aValuable [

	self deprecatedInsteadOf: 'hoverColor:' use: 'hoveredStateValue:'.
	self hoveredValue: aValuable
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> initialColor [

	self deprecatedInsteadOf: 'initialColor' use: 'initialStateValue'.
	^ self initialValue
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> initialColor: aValuable [

	self deprecatedInsteadOf: 'initialColor:' use: 'initialStateValue:'.
	self initialValue: aValuable
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> pressedColor [

	self deprecatedInsteadOf: 'pressedColor' use: 'pressedStateValue'.
	^ self pressedValue
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> pressedColor: aValuable [

	self deprecatedInsteadOf: 'pressedColor:' use: 'pressedStateValue:'.
	self pressedValue: aValuable
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> selectedColor [

	self deprecatedInsteadOf: 'selectedColor' use: 'selectedStateValue'.
	^ self selectedValue
]

{ #category : #'deprecated accessing' }
ToBackgroundLook >> selectedColor: anObject [

	self deprecatedInsteadOf: 'selectedColor:' use: 'selectedStateValue:'.
	self selectedValue: anObject
]
