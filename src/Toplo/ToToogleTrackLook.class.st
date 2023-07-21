Class {
	#name : #ToToogleTrackLook,
	#superclass : #ToElementLook,
	#instVars : [
		'toggleButton',
		'animationDuration',
		'animate'
	],
	#category : #'Toplo-Widget-Button-Toggle-Skins'
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

	^ 150 milliSeconds 
]

{ #category : #'event handling' }
ToToogleTrackLook >> barWidthFromTrack: aToggleTrack [


	| but onw offw bw |
	
	self flag: 'The commented version should work and it does not. Have to understand whyl!'.

 	"onw := 0.
	offw := 0.
	but := aToggleTrack switchButton.
	bw := but width + but margin left + but margin right.
	aToggleTrack switchBarOnElement ifNotNil: [ :o | onw := o width ].
	aToggleTrack switchBarOffElement ifNotNil: [ :o | offw := o width ].
	^ bw + (onw max: offw) max: bw * 1.6"
	^ 35
]

{ #category : #'event handling' }
ToToogleTrackLook >> clickLookEvent: anEvent [

	super clickLookEvent: anEvent.
	anEvent elementDo: [ :e | self syncAppearanceIn: e ]
]

{ #category : #'event handling' }
ToToogleTrackLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		self withoutAnimationWhile: [
			e slideToLeft.
			self syncAppearanceIn: e ] ]
]

{ #category : #initialization }
ToToogleTrackLook >> initialize [ 

	super initialize
]

{ #category : #'event handling' }
ToToogleTrackLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e switchButton size: (self switchButtonSizeIn: e).
		e switchButton background: Color white.
		e switchButton margin: (BlInsets
				 top: 1
				 left: 3
				 bottom: 1
				 right: 3).
		e geometry: (BlRoundedRectangleGeometry cornerRadius: (self trackBorderRadiusIn: e)).
		e padding: (BlInsets all: 1).
		e width: (self barWidthFromTrack: e) ]
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

	^ 14 asPoint
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
