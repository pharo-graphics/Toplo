Class {
	#name : #ToTableHeaderNode,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #initialization }
ToTableHeaderNode >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToTableHeaderNode >> initialize [

	super initialize.
	self hMatchParent.
	self vFitContent
]
