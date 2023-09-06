Class {
	#name : #ToBackgroundColorLook,
	#superclass : #ToElementLook,
	#instVars : [
		'initialBg',
		'hoverBg',
		'pressedBg',
		'disabledBg',
		'selectedBg',
		'duration',
		'animation'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #private }
ToBackgroundColorLook >> cleanUpIn: anElement [

	animation ifNotNil: [
		anElement dequeueTask: animation.
		animation := nil ]
]

{ #category : #'event handling' }
ToBackgroundColorLook >> clickLookEvent: anEvent [ 

	super clickLookEvent: anEvent .
	anEvent elementDo: [ :e |
		self hoverColor ifNotNil: [ :bg | e background: (bg value: e)] ]
]

{ #category : #accessing }
ToBackgroundColorLook >> disabledColor [

	^ disabledBg
]

{ #category : #accessing }
ToBackgroundColorLook >> disabledColor: aValuable [

	disabledBg := aValuable
]

{ #category : #'event handling' }
ToBackgroundColorLook >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.		
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self disabledColor ifNotNil: [ :bg | e background: (bg value: e)] ]
]

{ #category : #accessing }
ToBackgroundColorLook >> duration [

	^ duration ifNil: [ duration := 0 milliSeconds ]
]

{ #category : #accessing }
ToBackgroundColorLook >> duration: aDuration [

	duration := aDuration
]

{ #category : #accessing }
ToBackgroundColorLook >> hoverColor [

	^ hoverBg
]

{ #category : #accessing }
ToBackgroundColorLook >> hoverColor: aValuable [

	hoverBg := aValuable
]

{ #category : #'event handling' }
ToBackgroundColorLook >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self hoverColor ifNotNil: [ :bg | self switchToBackground: (bg value: e) asBlBackground in: e] ]
]

{ #category : #accessing }
ToBackgroundColorLook >> initialColor [

	^ initialBg ifNil: [ initialBg := [ :e | Color transparent ] ]
]

{ #category : #accessing }
ToBackgroundColorLook >> initialColor: aValuable [

	initialBg := aValuable
]

{ #category : #'event handling' }
ToBackgroundColorLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self initialColor ifNotNil: [ :bg | self switchToBackground: (bg value: e) asBlBackground in: e ] ]
]

{ #category : #accessing }
ToBackgroundColorLook >> pressedColor [

	^ pressedBg
]

{ #category : #accessing }
ToBackgroundColorLook >> pressedColor: aValuable [

	pressedBg := aValuable
]

{ #category : #'event handling' }
ToBackgroundColorLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self pressedColor ifNotNil: [ :bg | e background: (bg value: e)] ]
]

{ #category : #accessing }
ToBackgroundColorLook >> selectedColor [

	^ selectedBg
]

{ #category : #accessing }
ToBackgroundColorLook >> selectedColor: aValuable [

	selectedBg := aValuable
]

{ #category : #'event handling' }
ToBackgroundColorLook >> selectedLookEvent: anEvent [

	super selectedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self selectedColor ifNotNil: [ :bg | e background: (bg value: e)] ]
]

{ #category : #private }
ToBackgroundColorLook >> switchToBackground: aBackground in: anElement [

	| currentColor newColor currentBackground |
	
	self cleanUpIn: anElement.
	(self duration isZero or: [ aBackground isColorBackground not ])
		ifTrue: [ ^ anElement background: aBackground ].
	anElement isDisabled ifTrue: [ ^ anElement switchToSkinState: ToDisabledState new ]. 
	currentBackground := anElement background.
	currentBackground isColorBackground ifFalse: [ ^ anElement background: aBackground ].
	currentColor := currentBackground paint color.
	newColor := aBackground paint color.
	animation := BlColorTransition new
		             duration: self duration;
		             from: currentColor;
		             to: newColor;
		             onStepDo: [ :aColor :e | e background: aColor ].
	animation onFinishedDo: [
		anElement background: aBackground.
		animation := nil ].
	anElement addAnimation: animation
]
