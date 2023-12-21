Class {
	#name : 'ToNode',
	#superclass : 'ToElement',
	#category : 'Toplo-Widget-List-Node',
	#package : 'Toplo-Widget-List',
	#tag : 'Node'
}

{ #category : 'initialization' }
ToNode >> defaultEventHandler [

	^ ToNodeEventHandler new
]

{ #category : 'initialization' }
ToNode >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : 'initialization' }
ToNode >> defaultMargin [

	^ BlInsets empty
]

{ #category : 'initialization' }
ToNode >> defaultPadding [

	^ BlInsets empty
]

{ #category : 'initialization' }
ToNode >> initialize [

	super initialize.
	self
		hMatchParent;
		vFitContent;
		geometry: self defaultGeometry;
		padding: self defaultPadding;
		margin: self defaultMargin;
		addEventHandler: self defaultEventHandler
]
