Class {
	#name : #ToNode,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #initialization }
ToNode >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToNode >> initialize [

	super initialize.
	self
		hMatchParent;
		vFitContent
]
