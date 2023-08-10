Class {
	#name : #ToBorderLook,
	#superclass : #ToDefaultElementLook,
	#instVars : [
		'builder',
		'pressedPaint',
		'hoverPaint',
		'initialPaint',
		'width',
		'dashArray',
		'disabledPaint'
	],
	#category : #'Toplo-Core-Theme-Looks'
}

{ #category : #accessing }
ToBorderLook >> builder [

	^ builder
]

{ #category : #accessing }
ToBorderLook >> builder: aBuilder [

	builder := aBuilder
]

{ #category : #'event handling' }
ToBorderLook >> clickLookEvent: anEvent [

	super clickLookEvent: anEvent.
	self pressedPaint ifNil: [ ^ self ].

	anEvent elementDo: [ :e |
		| anim |
		anim := BlGaussianEffectOpacityAnimation new
			        color: (self pressedPaint value: e);
			        width: 4;
			        opacity: 0;
			        duration: 500 milliSeconds;
			        yourself.
		anim onFinishedDo: [ e effect: BlNullEffect new].
		e addAnimation: anim ]
]

{ #category : #accessing }
ToBorderLook >> dashArray [

	^ dashArray
]

{ #category : #accessing }
ToBorderLook >> dashArray: aValuable [

	dashArray := aValuable
]

{ #category : #initialization }
ToBorderLook >> defaultBuilder [

	^ BlBorderBuilder new
		  lineCap: BlStrokeLineCap butt;
		  lineJoin: BlStrokeLineJoin miter;
		  miterLimit: 4.0;
		  dashOffset: 0;
		  yourself
]

{ #category : #'event handling' }
ToBorderLook >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	self disabledPaint ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		e border: (self builder
				 dashArray: (self dashArray value: e);
				 width: (self width value: e);
				 paint: (self disabledPaint value: e);
				 build) ]
]

{ #category : #accessing }
ToBorderLook >> disabledPaint [

	^ disabledPaint
]

{ #category : #accessing }
ToBorderLook >> disabledPaint: aValuable [

	disabledPaint := aValuable
]

{ #category : #accessing }
ToBorderLook >> hoverPaint [

	^ hoverPaint
]

{ #category : #accessing }
ToBorderLook >> hoverPaint: aValuable [

	hoverPaint := aValuable
]

{ #category : #'event handling' }
ToBorderLook >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	self hoverPaint ifNil: [ ^ self ].

	anEvent elementDo: [ :e | 
		e border: (self builder
				 dashArray: (self dashArray value: e);
				 width: (self width value: e);
				 paint: (self hoverPaint value: e);
				 build) ]
]

{ #category : #'event handling' }
ToBorderLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	self initialPaint ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		e border: (self builder
				 dashArray: (self dashArray value: e);
				 width: (self width value: e);
				 paint: (self initialPaint value: e);
				 build) ]
]

{ #category : #accessing }
ToBorderLook >> initialPaint [

	^ initialPaint
]

{ #category : #accessing }
ToBorderLook >> initialPaint: aValuable [

	initialPaint := aValuable
]

{ #category : #initialization }
ToBorderLook >> initialize [ 
	
	super initialize.
	builder := self defaultBuilder.
	dashArray := [ :e | #() ].
	width := [ :e | 0 ]
]

{ #category : #'event handling' }
ToBorderLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	self pressedPaint ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		e border: (self builder
				 dashArray: (self dashArray value: e);
				 width: (self width value: e);
				 paint: (self pressedPaint value: e);
				 build) ]
]

{ #category : #accessing }
ToBorderLook >> pressedPaint [

	^ pressedPaint
]

{ #category : #accessing }
ToBorderLook >> pressedPaint: aValuable [

	pressedPaint := aValuable
]

{ #category : #accessing }
ToBorderLook >> width [

	^ width
]

{ #category : #accessing }
ToBorderLook >> width: aValuable [
	
	width := aValuable
]
