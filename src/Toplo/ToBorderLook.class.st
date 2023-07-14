Class {
	#name : #ToBorderLook,
	#superclass : #ToElementLook,
	#instVars : [
		'builder',
		'pressedPaint',
		'hoverPaint',
		'initialPaint'
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
		anim := ToGaussianEffectAnimation new
			        color: self pressedPaint;
			        width: 4;
			        opacity: 0;
			        duration: 500 milliSeconds;
			        yourself.
		anim onFinishedDo: [ e effect: BlNullEffect new].
		e addAnimation: anim ]
]

{ #category : #accessing }
ToBorderLook >> dashArray: anArray [

	self builder dashArray: anArray
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

{ #category : #accessing }
ToBorderLook >> hoverPaint [

	^ hoverPaint
]

{ #category : #accessing }
ToBorderLook >> hoverPaint: aPaint [

	hoverPaint := aPaint
]

{ #category : #'event handling' }
ToBorderLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	self initialPaint ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		e border: (self builder
				 paint: self initialPaint;
				 build) ]
]

{ #category : #accessing }
ToBorderLook >> initialPaint [

	^ initialPaint
]

{ #category : #accessing }
ToBorderLook >> initialPaint: aPaint [

	initialPaint := aPaint
]

{ #category : #initialization }
ToBorderLook >> initialize [ 
	
	super initialize.
	builder := self defaultBuilder
]

{ #category : #'event handling' }
ToBorderLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	self hoverPaint ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		e border: (self builder
				 paint: self hoverPaint;
				 build) ]
]

{ #category : #'event handling' }
ToBorderLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	self pressedPaint ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		e border: (self builder
				 paint: self pressedPaint;
				 build) ]
]

{ #category : #accessing }
ToBorderLook >> pressedPaint [

	^ pressedPaint
]

{ #category : #accessing }
ToBorderLook >> pressedPaint: aPaint [

	pressedPaint := aPaint
]

{ #category : #accessing }
ToBorderLook >> width: aNumber [

	self builder width: aNumber
]
