Class {
	#name : #ToMenuBarSeparator,
	#superclass : #ToElement,
	#category : 'Toplo-Widget-Menu-Bar'
}

{ #category : #orientation }
ToMenuBarSeparator >> beHorizontal [

	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical exact: 1 ]
]

{ #category : #orientation }
ToMenuBarSeparator >> beVertical [

	self constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal exact: 1 ]
]

{ #category : #orientation }
ToMenuBarSeparator >> horizontal: aBoolean [

	aBoolean
		ifTrue: [ self beHorizontal ]
		ifFalse: [ self beVertical ]
]

{ #category : #initialization }
ToMenuBarSeparator >> initialize [

	super initialize.
	self background: Color lightGray
]
