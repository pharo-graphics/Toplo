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
		  self interspace.
		  aPair second } select: #notNil
]

{ #category : #initialization }
ToPairWithInterspaceStrategy >> initialize [

	super initialize.
	interspace := BlElement new
		              constraintsDo: [ :c | 
			              c horizontal exact: 0.
			              c vertical exact: 0 ];
		              background: Color red;
		              yourself
]

{ #category : #accessing }
ToPairWithInterspaceStrategy >> interspace [

	^ interspace
]
