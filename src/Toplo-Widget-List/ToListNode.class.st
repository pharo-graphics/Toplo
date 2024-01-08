Class {
	#name : #ToListNode,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #initialization }
ToListNode >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToListNode >> initialize [

	super initialize.
	self
		hMatchParent;
		vFitContent
]
