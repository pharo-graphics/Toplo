Class {
	#name : #ToBackgroundLook,
	#superclass : #ToDefaultElementLook,
	#instVars : [
		'initialBg',
		'hoverBg',
		'pressedBg',
		'disabledBg',
		'selectedBg',
		'duration',
		'animation'
	],
	#category : #'Toplo-Core-Theme-Looks'
}

{ #category : #private }
ToBackgroundLook >> cleanUpIn: anElement [

	animation ifNotNil: [
		anElement dequeueTask: animation.
		animation := nil ]
]

{ #category : #'event handling' }
ToBackgroundLook >> clickLookEvent: anEvent [ 

	super clickLookEvent: anEvent .
	anEvent elementDo: [ :e |
		self hoverBg ifNotNil: [ :bg | e background: (bg value: e)] ]
]

{ #category : #accessing }
ToBackgroundLook >> disabledBg [

	^ disabledBg
]

{ #category : #accessing }
ToBackgroundLook >> disabledBg: aValuable [

	disabledBg := aValuable
]

{ #category : #'event handling' }
ToBackgroundLook >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.		
	anEvent elementDo: [ :e |
		self cleanUpIn: e.
		self disabledBg ifNotNil: [ :bg | e background: (bg value: e)] ]
]

{ #category : #accessing }
ToBackgroundLook >> duration [

	^ duration ifNil: [ duration := 0 milliSeconds ]
]

{ #category : #accessing }
ToBackgroundLook >> duration: aDuration [

	duration := aDuration
]

{ #category : #accessing }
ToBackgroundLook >> hoverBg [

	^ hoverBg
]

{ #category : #accessing }
ToBackgroundLook >> hoverBg: aValuable [

	hoverBg := aValuable
]

{ #category : #'event handling' }
ToBackgroundLook >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self hoverBg ifNotNil: [ :bg | self switchToBackground: (bg value: e) asBlBackground in: e] ]
]

{ #category : #accessing }
ToBackgroundLook >> initialBg [

	^ initialBg
]

{ #category : #accessing }
ToBackgroundLook >> initialBg: aValuable [

	initialBg := aValuable
]

{ #category : #'event handling' }
ToBackgroundLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self initialBg ifNotNil: [ :bg | self switchToBackground: (bg value: e) asBlBackground in: e ] ]
]

{ #category : #accessing }
ToBackgroundLook >> pressedBg [

	^ pressedBg
]

{ #category : #accessing }
ToBackgroundLook >> pressedBg: aValuable [

	pressedBg := aValuable
]

{ #category : #'event handling' }
ToBackgroundLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self pressedBg ifNotNil: [ :bg | e background: (bg value: e)] ]
]

{ #category : #accessing }
ToBackgroundLook >> selectedBg [

	^ selectedBg
]

{ #category : #accessing }
ToBackgroundLook >> selectedBg: aValuable [

	selectedBg := aValuable
]

{ #category : #'event handling' }
ToBackgroundLook >> selectedLookEvent: anEvent [

	super selectedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self selectedBg ifNotNil: [ :bg | e background: (bg value: e)] ]
]

{ #category : #private }
ToBackgroundLook >> switchToBackground: aBackground in: anElement [

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
