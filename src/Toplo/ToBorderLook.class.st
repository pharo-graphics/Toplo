Class {
	#name : #ToBorderLook,
	#superclass : #ToElementLook,
	#instVars : [
		'builder',
		'pressedPaint',
		'hoverPaint',
		'initialPaint'
	],
	#category : #'Toplo-Core-Theme-Skins'
}

{ #category : #accessing }
ToBorderLook >> builder [

	^ builder
]

{ #category : #accessing }
ToBorderLook >> builder: aBuilder [

	builder := aBuilder
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
ToBorderLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	self initialPaint ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		e border: (self builder
				 paint: self initialPaint;
				 build) ]
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
