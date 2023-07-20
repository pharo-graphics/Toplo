Class {
	#name : #ToToogleTrackLook,
	#superclass : #ToElementLook,
	#instVars : [
		'toggleButton',
		'animationDuration',
		'installed',
		'animate'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToToogleTrackLook >> animate [

	^ animate 
]

{ #category : #accessing }
ToToogleTrackLook >> animate: aBoolean [

	animate := aBoolean
]

{ #category : #sliding }
ToToogleTrackLook >> animationDeltaIn: anElement [

	^ anElement width - anElement switchButton width - anElement padding left - anElement padding right
]

{ #category : #accessing }
ToToogleTrackLook >> animationDuration [

	^ 250 milliSeconds 
]

{ #category : #'event handling' }
ToToogleTrackLook >> clickLookEvent: anEvent [

	super clickLookEvent: anEvent.
	anEvent elementDo: [ :e | self syncAppearanceIn: e ]
]

{ #category : #initialization }
ToToogleTrackLook >> initialize [ 

	super initialize.
	installed := false.
]

{ #category : #'event handling' }
ToToogleTrackLook >> installAppearanceIn: anElement [

	toggleButton track slideToLeft.
	self withoutAnimationWhile: [ self syncAppearanceIn: anElement ]
]

{ #category : #'event handling' }
ToToogleTrackLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	installed ifTrue: [ ^ self ].
	installed := true.

	anEvent elementDo: [ :e |
		" Have to wait for the next layout to install the appearance  "
		toggleButton whenLayoutedDoOnce: [ self installAppearanceIn: e ] ]
]

{ #category : #sliding }
ToToogleTrackLook >> slideToLeftWithAnimationIn: anElement [
	
	| anim x |
	x := self animationDeltaIn: anElement.
	anim := BlTransformAnimation new
		        duration: self animationDuration;
		        transformDo: [ :b | b translateBy: x negated @ 0 ].
	anim onFinishedDo: [anElement slideToLeft].
	anElement switchBar addAnimation: anim
]

{ #category : #sliding }
ToToogleTrackLook >> slideToRightWithAnimationIn: anElement [
	
	| anim x |
	x := self animationDeltaIn: anElement.
	anim := BlTransformAnimation new
		        duration: self animationDuration;
		        transformDo: [ :b | b translateBy: x @ 0 ].
	anim onFinishedDo: [anElement slideToRight].
	anElement switchBar addAnimation: anim
]

{ #category : #sliding }
ToToogleTrackLook >> switchOffIn: anElement [

	anElement switchBar switchOff.
	self animate ifTrue: [ ^ self slideToLeftWithAnimationIn: anElement ].
	anElement slideToLeft 
]

{ #category : #sliding }
ToToogleTrackLook >> switchOnIn: anElement [

	anElement switchBar switchOn.
	self animate ifTrue: [ ^ self slideToRightWithAnimationIn: anElement ].
	anElement slideToRight 
]

{ #category : #sliding }
ToToogleTrackLook >> syncAppearanceIn: anElement [

	toggleButton isChecked
		ifTrue: [ self switchOnIn: anElement ]
		ifFalse: [ self switchOffIn: anElement ]
]

{ #category : #accessing }
ToToogleTrackLook >> toggleButton: aToggleButton [

	toggleButton := aToggleButton
]

{ #category : #'event handling' }
ToToogleTrackLook >> withoutAnimationWhile: aBlock [

	| prev |
	prev := animate.
	animate := false.
	aBlock ensure: [ animate := prev ]
]
