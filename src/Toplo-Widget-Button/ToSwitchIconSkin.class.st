Class {
	#name : #ToSwitchIconSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Button-Switch'
}

{ #category : #'event handling' }
ToSwitchIconSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e updateHandleContent.
		e background: (e valueOfTokenNamed: #'switch-checked-background').
		" don't animate if the first measure is not done since the animation depends on size"
		(e firstMeasureDone and: [ e isEnabled ]) ifTrue: [
			self switchWithAnimation: e ] ]
]

{ #category : #'event handling' }
ToSwitchIconSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.

	anEvent elementDo: [ :e |
		e updateHandleContent.
		e background: (e valueOfTokenNamed: #'switch-disabled-background').
		e handle background:
			(e valueOfTokenNamed: #'switch-handle-disabled-background') ]
]

{ #category : #'event handling' }
ToSwitchIconSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e handle background: (e valueOfTokenNamed: #'switch-handle-enabled-background') ]
]

{ #category : #'event handling' }
ToSwitchIconSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]

{ #category : #'event handling' }
ToSwitchIconSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e size: (e valueOfTokenNamed: #'switch-icon-size') ]
]

{ #category : #'event handling' }
ToSwitchIconSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]

{ #category : #'event handling' }
ToSwitchIconSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]

{ #category : #'event handling' }
ToSwitchIconSkin >> switchWithAnimation: aSwitchButton [

	| anim posAnim colorAnim color toPos |
	color := aSwitchButton background paint color.
	aSwitchButton showSide.
	toPos := aSwitchButton isChecked
		         ifTrue: [ aSwitchButton trackOnExpectedPosition ]
		         ifFalse: [ aSwitchButton trackOffExpectedPosition ].
	posAnim := BlNumberTransition new
		           duration: 200 milliSeconds;
		           from: aSwitchButton track position x;
		           to: toPos x;
		           onStepDo: [ :number :anElement |
			           anElement track position: number @ 0 ].
	posAnim onFinishedDo: [ aSwitchButton track position: toPos ].
	colorAnim := BlColorTransition new
		             from: aSwitchButton background paint color;
		             to: color;
		             duration: 300 milliSeconds;
		             onStepDo: [ :c :anElement | anElement background: c ].
	colorAnim onFinishedDo: [ aSwitchButton background: aSwitchButton background ].

	anim := BlParallelAnimation new
		        addAll: {
				        posAnim.
				        colorAnim };
		        yourself.
	aSwitchButton addAnimation: anim
]

{ #category : #'event handling' }
ToSwitchIconSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e updateHandleContent.
		e background: (e valueOfTokenNamed: #'switch-unchecked-background').
		" don't animate if the first measure is not done since the animation depends on size"
		e firstMeasureDone ifTrue: [ self switchWithAnimation: e ] ]
]
