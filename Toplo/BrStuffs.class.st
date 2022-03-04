Class {
	#name : #BrStuffs,
	#superclass : #Object,
	#category : #'Toplo-Stuffs'
}

{ #category : #examples }
BrStuffs class >> exampleForceLayoutOfMatchParent [
	| anElement |
	anElement := BlElement new.
	anElement border: (BlBorder paint: Color gray width: 5).
	anElement background: Color lightGray.
	anElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	anElement forceLayout.
	anElement openInNewSpace.
]

{ #category : #examples }
BrStuffs class >> exampleLabelOnly [ 
| aLabel space |
	
	aLabel := BrLabel new.
	aLabel aptitude: BrTextLabelAptitude new.
	aLabel text: 'Label'.

space := BlSpace new.
space root addChild: aLabel.
space title: 'editor'.
space show.
^aLabel
]

{ #category : #examples }
BrStuffs class >> exampleParentWithChild [
	<gtExample>
	| child parent |
	child := BlElement new.
	child layout: BlBasicLayout uniqueInstance.
	"The default layout of an element is already such instance so
	the expression is not needed."
	child background: (Color red alpha: 0.3).
	child border: (BlBorder paint: Color red width: 1).
	child
		constraintsDo: [ :c | 
			c horizontal exact: 100.
			c vertical exact: 100 ].
	parent := BlElement new.
	parent layout: BlBasicLayout uniqueInstance.
	"The default layout of an element is already such instance so
	the expression is not needed."
	parent background: (Color gray alpha: 0.3).
	parent padding: (BlInsets all: 25).
	parent
		constraintsDo: [ :c | 
			c horizontal exact: 300.
			c vertical exact: 300 ].
	parent addChild: child.
	parent forceLayout.
	
	^ parent
]

{ #category : #examples }
BrStuffs class >> exampleParentWithChildExactSize [
	<gtExample>
	| parent |
	parent := self exampleParentWithChild.
	^ parent
]

{ #category : #examples }
BrStuffs class >> exampleParentWithChildFitContent [
	<gtExample>
	| child parent |
	parent := self exampleParentWithChildExactSize.
	child := parent children first.
	child
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
	parent forceLayout.
	parent openInNewSpace.
	^ parent
]

{ #category : #examples }
BrStuffs class >> exampleParentWithChildWithInsets [
	<gtExample>
	| child parent |
	parent := self exampleParentWithChildExactSize.
	"parent layout: BlFlowLayout new horizontal."
	child := parent children first.
	parent
		constraintsDo: [ :c |
			"c flow float."
			c
		padding:
			(BlInsets
				top: 10
				right: 20
				bottom: 30
				left: 0).
			"c margin: (BlInsets top: 10 right: 0 bottom: 0 left: 0)" ].
	parent forceLayout.
	parent openInNewSpace.
	^ parent
]
