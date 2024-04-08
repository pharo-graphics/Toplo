Class {
	#name : #ToElementWithLabeledIconForTest,
	#superclass : #ToElement,
	#traits : 'TToElementWithLabeledIcon',
	#classTraits : 'TToElementWithLabeledIcon classTrait',
	#instVars : [
		'labeledIcon'
	],
	#category : #'Toplo-Tests-Core'
}

{ #category : #'t - element with labeled icon - accessing' }
ToElementWithLabeledIconForTest >> filler [ 

	^ self labeledIcon startFiller
]

{ #category : #'as yet unclassified' }
ToElementWithLabeledIconForTest >> flexible [

	^ self labeledIcon startFlexible
]

{ #category : #'t - element with labeled icon - accessing' }
ToElementWithLabeledIconForTest >> flexible: aBoolean [

	self labeledIcon startFlexible: aBoolean
]

{ #category : #initialization }
ToElementWithLabeledIconForTest >> initialize [ 

	super initialize.
	labeledIcon := ToLabeledIcon new.
	self addChild: labeledIcon.
	self beStartToEnd.
	self fitContent.
]

{ #category : #accessing }
ToElementWithLabeledIconForTest >> labeledIcon [

	^ labeledIcon 
]
