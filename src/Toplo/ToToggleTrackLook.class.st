Class {
	#name : #ToToggleTrackLook,
	#superclass : #ToDefaultElementLook,
	#instVars : [
		'animate'
	],
	#category : #'Toplo-Widget-Toggle-Skins'
}

{ #category : #accessing }
ToToggleTrackLook >> animate [

	^ animate 
]

{ #category : #accessing }
ToToggleTrackLook >> animate: aBoolean [

	animate := aBoolean
]

{ #category : #sliding }
ToToggleTrackLook >> animationDeltaIn: anElement [

	^ anElement deltaToLeft negated
]

{ #category : #accessing }
ToToggleTrackLook >> animationDuration [

	^ 200 milliSeconds 
]

{ #category : #'event handling' }
ToToggleTrackLook >> clickLookEvent: anEvent [

	super clickLookEvent: anEvent.
	anEvent elementDo: [ :e | self syncAppearanceIn: e ]
]

{ #category : #'event handling' }
ToToggleTrackLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self withoutAnimationWhile: [
			self syncAppearanceIn: e ]  ]
]

{ #category : #sliding }
ToToggleTrackLook >> slideToLeftWithAnimationIn: anElement [
	
	| anim x |
	x := self animationDeltaIn: anElement.
	anim := BlTransformAnimation new
		        duration: self animationDuration;
		        transformDo: [ :b | b translateBy: x negated @ 0 ].
	anim onFinishedDo: [anElement slideToLeft].
	anElement switchBar addAnimation: anim
]

{ #category : #sliding }
ToToggleTrackLook >> slideToRightWithAnimationIn: anElement [
	
	| anim x |
	x := self animationDeltaIn: anElement.
	anim := BlTransformAnimation new
		        duration: self animationDuration;
		        transformDo: [ :b | b translateBy: x @ 0 ].
	anim onFinishedDo: [anElement slideToRight].
	anElement switchBar addAnimation: anim
]

{ #category : #sliding }
ToToggleTrackLook >> switchOffIn: anElement [

	anElement switchBar switchOff.
	self animate ifTrue: [ ^ self slideToLeftWithAnimationIn: anElement ].
	anElement slideToLeft 
]

{ #category : #sliding }
ToToggleTrackLook >> switchOnIn: anElement [

	anElement switchBar switchOn.
	self animate ifTrue: [ ^ self slideToRightWithAnimationIn: anElement ].
	anElement slideToRight 
]

{ #category : #sliding }
ToToggleTrackLook >> syncAppearanceIn: anElement [

	anElement isChecked
		ifTrue: [ self switchOnIn: anElement ]
		ifFalse: [ self switchOffIn: anElement ]
]

{ #category : #'event handling' }
ToToggleTrackLook >> withoutAnimationWhile: aBlock [

	| prev |
	prev := animate.
	animate := false.
	aBlock ensure: [ animate := prev ]
]
