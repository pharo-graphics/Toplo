Class {
	#name : #ToAbstractMenuItem,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
ToAbstractMenuItem >> addedInMenu: aMenu [
	
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	

]

{ #category : #initialization }
ToAbstractMenuItem >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.

]

{ #category : #initialization }
ToAbstractMenuItem >> removedFromMenu: aMenu [

]
