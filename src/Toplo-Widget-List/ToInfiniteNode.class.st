Class {
	#name : #ToInfiniteNode,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #initialization }
ToInfiniteNode >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToInfiniteNode >> initialize [

	super initialize.
	self
		hMatchParent;
		vFitContent
]
