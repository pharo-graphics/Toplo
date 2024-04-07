Class {
	#name : #ToSwitchIconSkin,
	#superclass : #ToRawSkin,
	#instVars : [
		'justInstalled'
	],
	#category : #'Toplo-Widget-Button-Switch'
}

{ #category : #'event handling' }
ToSwitchIconSkin >> checkedLookEvent: anEvent [

	super checkedLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e updateHandleContent.
		self switch: true withAnimationIn: e ]
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

	justInstalled := true.
	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e whenLayoutedDoOnce: [ e switch: e isChecked ] ]
]

{ #category : #'event handling' }
ToSwitchIconSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		 ]
]

{ #category : #'event handling' }
ToSwitchIconSkin >> switch: aBoolean withAnimationIn: aSwitchButton [

	| anim posAnim colorAnim color background toPos |
	background := (aBoolean
		ifTrue: [ aSwitchButton valueOfTokenNamed: #'switch-checked-background' ]
		ifFalse: [ aSwitchButton valueOfTokenNamed: #'switch-unchecked-background' ]) asBlBackground.
	justInstalled ifTrue: [ 
		justInstalled := false.
		aSwitchButton background: background.
		^ aSwitchButton switch: aBoolean ].
	color := background paint color.
	toPos := aBoolean
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
			       from: (aSwitchButton background paint color);
			       to: color;
			       duration: 300 milliSeconds;
			       onStepDo: [ :c :anElement  | anElement background: c ].
	colorAnim onFinishedDo: [ aSwitchButton background: background ].
	
	anim := BlParallelAnimation new addAll: { posAnim. colorAnim }; yourself.
	aSwitchButton addAnimation: anim
]

{ #category : #'event handling' }
ToSwitchIconSkin >> uncheckedLookEvent: anEvent [

	super uncheckedLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e updateHandleContent.
		self switch: false withAnimationIn: e ]
]
