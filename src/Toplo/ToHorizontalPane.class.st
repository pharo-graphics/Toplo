Class {
	#name : #ToHorizontalPane,
	#superclass : #ToPane,
	#category : #'Toplo-Widget-Pane'
}

{ #category : #layout }
ToHorizontalPane >> defaultLayout [

	^ BlLinearLayout horizontal 
]

{ #category : #initialization }
ToHorizontalPane >> initialize [ 

	super initialize.
	self hMatchParent.
	self vFitContent 
]
