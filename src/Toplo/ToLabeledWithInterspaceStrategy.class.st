Class {
	#name : #ToLabeledWithInterspaceStrategy,
	#superclass : #ToLabeledStrategy,
	#instVars : [
		'interspace'
	],
	#category : #'Toplo-Core-Labeled'
}

{ #category : #layout }
ToLabeledWithInterspaceStrategy >> childrenIn: aLabeled [

	^ (aLabeled isLabelFirst
		   ifTrue: [ 
			   { 
				   aLabeled label.
				   self interspace.
				   aLabeled element } ]
		   ifFalse: [ 
			   { 
				   aLabeled element.
				   self interspace.
				   aLabeled label } ]) select: #notNil
]

{ #category : #initialization }
ToLabeledWithInterspaceStrategy >> initialize [

	super initialize.
	interspace := BlElement new constraintsDo: [ :c | 
		              c horizontal exact: 0.
		              c vertical exact: 0 ]
]

{ #category : #accessing }
ToLabeledWithInterspaceStrategy >> interspace [

	^ interspace
]
