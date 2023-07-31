Class {
	#name : #ToToogleTrackLook,
	#superclass : #ToDefaultElementLook,
	#instVars : [
		'toggleButton',
		'animationDuration',
		'animate'
	],
	#category : #'Toplo-Widget-Toggle-Skins'
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

	^ anElement deltaToLeft negated
]

{ #category : #accessing }
ToToogleTrackLook >> animationDuration [

	^ 200 milliSeconds 
]

{ #category : #'event handling' }
ToToogleTrackLook >> clickLookEvent: anEvent [

	super clickLookEvent: anEvent.
	anEvent elementDo: [ :e | self syncAppearanceIn: e ]
]

{ #category : #'event handling' }
ToToogleTrackLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]

{ #category : #'event handling' }
ToToogleTrackLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e switchButton size: (self switchButtonSizeIn: e).
		e switchButton background: Color white.
		e switchButton margin: (BlInsets
				 top: 1
				 left: 4
				 bottom: 1
				 right: 4).		
		e geometry: (BlRoundedRectangleGeometry cornerRadius: (self trackBorderRadiusIn: e)).
		e padding: (BlInsets top: 2
				 left: 2
				 bottom: 2
				 right: 2).
		e updateWidth.
		self withoutAnimationWhile: [
			self syncAppearanceIn: e ]  ]
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

{ #category : #'event handling' }
ToToogleTrackLook >> switchButtonSizeIn: anElement [

	^ 16 asPoint
]

{ #category : #sliding }
ToToogleTrackLook >> switchOffIn: anElement [

	anElement switchBar switchOff.
	anElement switchButton border: (BlBorder paint: Color gray).
	self animate ifTrue: [ ^ self slideToLeftWithAnimationIn: anElement ].
	anElement slideToLeft 
]

{ #category : #sliding }
ToToogleTrackLook >> switchOnIn: anElement [

	anElement switchBar switchOn.
	anElement switchButton border: (BlBorder empty).
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
ToToogleTrackLook >> trackBorderRadiusIn: anElement [

	^ 26
]

{ #category : #'event handling' }
ToToogleTrackLook >> withoutAnimationWhile: aBlock [

	| prev |
	prev := animate.
	animate := false.
	aBlock ensure: [ animate := prev ]
]
