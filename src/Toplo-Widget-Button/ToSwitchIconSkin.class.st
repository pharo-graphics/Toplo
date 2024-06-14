Class {
	#name : #ToSwitchIconSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Button-Switch'
}

{ #category : #'event handling' }
ToSwitchIconSkin >> checkedLookEvent: anEvent [

	super checkedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e updateHandleContent.
		e background: (e valueOfTokenNamed: #'switch-checked-background').
		" don't animate if the first measure is not done since the animation depends on size"
		e firstMeasureDone ifTrue: [ self switchWithAnimation: e ] ]
]

{ #category : #'event handling' }
ToSwitchIconSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e updateHandleContent.
		e background: (e valueOfTokenNamed: #'switch-disabled-background').
		e handle background: (e valueOfTokenNamed: #'switch-handle-disabled-background') ]
]

{ #category : #'event handling' }
ToSwitchIconSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e handle background: (e valueOfTokenNamed: #'switch-handle-enabled-background') ]
]

{ #category : #'event handling' }
ToSwitchIconSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]

{ #category : #'event handling' }
ToSwitchIconSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | ]
]

{ #category : #'event handling' }
ToSwitchIconSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		 ]
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
ToSwitchIconSkin >> uncheckedLookEvent: anEvent [

	super uncheckedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e updateHandleContent.
		e background: (e valueOfTokenNamed: #'switch-unchecked-background').
		" don't animate if the first measure is not done since the animation depends on size"
		e firstMeasureDone ifTrue: [ self switchWithAnimation: e ] ]
]
