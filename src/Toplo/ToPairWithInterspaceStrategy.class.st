Class {
	#name : #ToPairWithInterspaceStrategy,
	#superclass : #ToPairStrategy,
	#instVars : [
		'interspace'
	],
	#category : #'Toplo-Core-Pair'
}

{ #category : #layout }
ToPairWithInterspaceStrategy >> childrenIn: aPair [
 	
	^ {
		  aPair first.
		  self interspaceIn: aPair.
		  aPair second } select: #notNil
]

{ #category : #accessing }
ToPairWithInterspaceStrategy >> hasInterspaceIn: anElement [

	^ anElement first notNil and: [ anElement second notNil ]
]

{ #category : #initialization }
ToPairWithInterspaceStrategy >> initialize [

	super initialize.
	interspace := BlElement new
		              constraintsDo: [ :c | 
			              c horizontal exact: 0.
			              c vertical exact: 0 ];
		              yourself
]

{ #category : #accessing }
ToPairWithInterspaceStrategy >> interspace [

	^ interspace
]

{ #category : #accessing }
ToPairWithInterspaceStrategy >> interspaceIn: anElement [

	^ (self hasInterspaceIn: anElement)
		  ifTrue: [ self interspace ]
		  ifFalse: [ nil ]
]
