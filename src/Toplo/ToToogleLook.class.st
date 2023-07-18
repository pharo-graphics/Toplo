Class {
	#name : #ToToogleLook,
	#superclass : #ToElementLook,
	#instVars : [
		'animationDuration'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'event handling' }
ToToogleLook >> animSlideWidthFromTrack: aToggleButton [

	| base onWidth offWidth track pointer |
	track := aToggleButton track.
	pointer := track pusher.
	track onElement
		ifNil: [
			onWidth := 0]
		ifNotNil: [
			onWidth := track onElement width].
	track offElement
		ifNil: [ offWidth := 0 ]
		ifNotNil: [ offWidth := track offElement width ].
	base := track width - pointer width - "track padding right -" track padding left.
	^ base
]

{ #category : #'event handling' }
ToToogleLook >> animateBulletIn: anElement [

	| anim slide final l |
	l := self animSlideWidthFromTrack: anElement.
	slide := anElement isChecked
		         ifTrue: [ l ]
		         ifFalse: [ l negated ].
	final := anElement isChecked
		         ifTrue: [ l ]
		         ifFalse: [ 0 ].
	anim := BlTransformAnimation new
		        duration: self animationDuration;
		        transformDo: [ :b | b translateBy: slide @ 0 ].
	anim onFinishedDo: [
		anElement track background: (anElement isChecked
				 ifTrue: [ anElement toTheme colorPrimary ]
				 ifFalse: [ anElement toTheme colorBgTextActive ]).
		anElement isChecked ifTrue: [
			l := self initialSlideWidthFromTrack: anElement.
			anElement track bulletElement transformDo: [ :aTransform |
				aTransform translateBy: l @ 0 ] ] ].
	anElement track bulletElement addAnimation: anim
]

{ #category : #accessing }
ToToogleLook >> animationDuration [

	^ animationDuration ifNil: [ animationDuration := 200 milliSeconds ]
]

{ #category : #accessing }
ToToogleLook >> animationDuration: aDuration [

	animationDuration := aDuration
]

{ #category : #'event handling' }
ToToogleLook >> clickLookEvent: anEvent [

	super clickLookEvent: anEvent.
	anEvent elementDo: [ :e | self animateBulletIn: e ]
]

{ #category : #'event handling' }
ToToogleLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e | ]
]

{ #category : #'event handling' }
ToToogleLook >> initialSlideWidthFromTrack: aToggleButton [

	| base onWidth offWidth track pusher |
	track := aToggleButton track.
	pusher := track pusher.
	track onElement
		ifNil: [
			onWidth := 0]
		ifNotNil: [
			onWidth := track onElement width].
	track offElement
		ifNil: [ offWidth := 0 ]
		ifNotNil: [ offWidth := track offElement width ].
	base := track width - pusher width "- track padding right"
	        - track padding left.
	base := aToggleButton isChecked
		ifTrue: [ base - onWidth ]
		ifFalse: [ base - offWidth].
	^ base
]

{ #category : #'event handling' }
ToToogleLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | | x l |
		l := self initialSlideWidthFromTrack: e.
		x := e isChecked ifTrue: [l] ifFalse: [0].
		e track bulletElement transformDo: [ :aTransform | aTransform translateBy: x @ 0 ].
		e track vFitContent]
]
