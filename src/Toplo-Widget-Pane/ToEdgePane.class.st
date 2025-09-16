Class {
	#name : #ToEdgePane,
	#superclass : #ToPane,
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #initialization }
ToEdgePane >> initialize [

	super initialize.
	self width: 100.
	self vMatchParent
]

{ #category : #'instance creation' }
ToEdgePane >> newRawSkin [ 

	^ ToEdgePaneSkin new
]
