Class {
	#name : 'ToSwitchButtonSkin',
	#superclass : 'ToRawSkin',
	#instVars : [
		'justInstalled'
	],
	#category : 'Toplo-Widget-Button-Switch',
	#package : 'Toplo-Widget-Button',
	#tag : 'Switch'
}

{ #category : 'event handling' }
ToSwitchButtonSkin >> checkedLookEvent: anEvent [

	super checkedLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e updateHandleContent.
		self switch: true withAnimationIn: e ]
]

{ #category : 'event handling' }
ToSwitchButtonSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e updateHandleContent.
		e background: (e tokenValueNamed: #'switch-disabled-background').
		e handle background: (e tokenValueNamed: #'switch-handle-disabled-background') ]
]

{ #category : 'event handling' }
ToSwitchButtonSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e handle background: (e tokenValueNamed: #'switch-handle-enabled-background') ]
]

{ #category : 'event handling' }
ToSwitchButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor hand ]
]

{ #category : 'event handling' }
ToSwitchButtonSkin >> installLookEvent: anEvent [

	justInstalled  := true.
	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e whenLayoutedDoOnce: [ e switch: e isChecked ].
		e handle background: (e tokenValueNamed: #'switch-handle-enabled-background') ]
]

{ #category : 'event handling' }
ToSwitchButtonSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor default ]
]

{ #category : 'event handling' }
ToSwitchButtonSkin >> switch: aBoolean withAnimationIn: aSwitchButton [

	| anim posAnim colorAnim color background toPos |
	background := (aBoolean
		ifTrue: [ aSwitchButton tokenValueNamed: #'switch-checked-background' ]
		ifFalse: [ aSwitchButton tokenValueNamed: #'switch-unchecked-background' ]) asBlBackground.
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

{ #category : 'event handling' }
ToSwitchButtonSkin >> uncheckedLookEvent: anEvent [

	super uncheckedLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e updateHandleContent.
		self switch: false withAnimationIn: e ]
]
