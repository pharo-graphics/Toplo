Class {
	#name : #ToTripletWithInterspaceStrategy,
	#superclass : #ToTripletStrategy,
	#instVars : [
		'interspace'
	],
	#category : #'Toplo-Core-Triplet'
}

{ #category : #accessing }
ToTripletWithInterspaceStrategy >> canHaveInterspaceAsChildIn: aTriplet [

	^ aTriplet first notNil and: [ aTriplet second notNil ]
]

{ #category : #layout }
ToTripletWithInterspaceStrategy >> childrenIn: aTriplet [

	^ {
		  aTriplet first.
		  (self interspaceIn: aTriplet).
		  aTriplet second.
		  aTriplet third } select: #notNil
]

{ #category : #initialization }
ToTripletWithInterspaceStrategy >> initialize [

	super initialize.
	interspace := BlElement new
		              constraintsDo: [ :c |
			              c horizontal exact: 0.
			              c vertical exact: 0 ];
		              yourself
]

{ #category : #accessing }
ToTripletWithInterspaceStrategy >> interspace [

	^ interspace
]

{ #category : #accessing }
ToTripletWithInterspaceStrategy >> interspaceIn: aTriplet [

	^ (self canHaveInterspaceAsChildIn: aTriplet)
		  ifTrue: [ self interspace ]
		  ifFalse: [ nil ]
]
