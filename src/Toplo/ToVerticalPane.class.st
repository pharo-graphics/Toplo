Class {
	#name : #ToVerticalPane,
	#superclass : #ToPane,
	#category : #'Toplo-Widget-Pane'
}

{ #category : #layout }
ToVerticalPane >> defaultLayout [

	^ BlLinearLayout vertical 
]

{ #category : #initialization }
ToVerticalPane >> initialize [ 

	super initialize.
	self vMatchParent.
	self hFitContent 
]
