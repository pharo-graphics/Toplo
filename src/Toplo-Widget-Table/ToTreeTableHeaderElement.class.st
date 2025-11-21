Class {
	#name : #ToTreeTableHeaderElement,
	#superclass : #ToTableHeaderElement,
	#instVars : [
		'first'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #initialization }
ToTreeTableHeaderElement >> initialize [ 

	super initialize.
	first := ToElement new.
	first extent: 26 asPoint.
	first padding: (BlInsets horizontal: 2).
	self padding: (BlInsets horizontal: 6).
	self addChild: first at: 1
]
