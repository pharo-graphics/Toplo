Class {
	#name : #ToListNode,
	#superclass : #ToElement,
	#category : 'Toplo-Widget-List-Node'
}

{ #category : #initialization }
ToListNode >> defaultEventHandler [

	^ ToListNodeEventHandler new
]

{ #category : #initialization }
ToListNode >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToListNode >> defaultMargin [

	^ BlInsets empty
]

{ #category : #initialization }
ToListNode >> defaultPadding [

	^ BlInsets empty
]

{ #category : #initialization }
ToListNode >> initialize [

	super initialize.
	self
		hMatchParent;
		vFitContent;
		geometry: self defaultGeometry;
		padding: self defaultPadding;
		margin: self defaultMargin;
		addEventHandler: self defaultEventHandler
]
