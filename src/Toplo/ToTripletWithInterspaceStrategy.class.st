Class {
	#name : #ToTripletWithInterspaceStrategy,
	#superclass : #ToTripletStrategy,
	#instVars : [
		'interspace'
	],
	#category : #'Toplo-Core-Triplet'
}

{ #category : #layout }
ToTripletWithInterspaceStrategy >> childrenIn: aPair [

	^ {
		  aPair first.
		  (self interspaceIn: aPair).
		  aPair second.
		  aPair third } select: #notNil
]

{ #category : #accessing }
ToTripletWithInterspaceStrategy >> hasInterspaceIn: anElement [

	^ anElement first notNil and: [ anElement second notNil ]
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
ToTripletWithInterspaceStrategy >> interspaceIn: anElement [

	^ (self hasInterspaceIn: anElement)
		  ifTrue: [ self interspace ]
		  ifFalse: [ nil ]
]
